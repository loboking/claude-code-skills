---
allowed-tools: Bash, Grep, Glob, Read
description: 메모리 누수 탐지 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /mem-check 사용 가이드

용도: 메모리 누수 탐지

사용법:
  /mem-check                    # 현재 프로젝트 메모리 검사
  /mem-check --live <pid>      # 실행 중인 프로세스 검사
  /mem-check --heap            # 힙 덤프 분석
  /mem-check --leaks          # 누수만 탐지

지원 언어/도구:
  Python    tracemalloc, memory_profiler, memray
  Node.js   clinic-memory, heapdump
  Go        pprof (heap profiling)
  Rust     valgrind, heaptrack

탐지 항목:
  Memory Leaks              누수
  High Memory Usage        과도한 메모리 사용
  Unbounded Growth        제한 없는 증가
  Large Allocations       큰 메모리 할당
  GC Pressure              GC 빈도

옵션:
  --live <pid>       실행 중인 프로세스 검사
  --heap             힙 덤프 분석
  --leaks           누수만 탐지
  --threshold <MB>   경고 임계값
  --trace            호출 스택 추적

예시:
  /mem-check                    # 전체 검사
  /mem-check --live 1234       # PID 1234 검사
  /mem-check --heap             # 힙 분석

언제 사용:
  ✅ 메모리 사용량이 급증할 때
  ✅ OOM (Out of Memory) 발생 후
  ✅ 장기 실행 서비스 점검
  ✅ 누수 의심될 때

워크플로우:
  프로젝트 감지 → 분석工具 선택 → 스캔 → 결과 정리
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--live <pid>`: Analyze running process
- `--heap`: Heap dump analysis
- `--leaks`: Leak detection only
- `--threshold <MB>`: Warning threshold
- `--trace`: Include call stack

## 2. Project Detection & Tool Selection

```bash
# Python
if [ -f "requirements.txt" ]; then
    # Static analysis
    grep -r "unclosed\|detached\|global" --include="*.py"

    # Runtime analysis
    python -m memory_profiler script.py
fi

# Node.js
if [ -f "package.json" ]; then
    npx clinic-memory -- node script.js
    node --heap-prof --heapsnapshot-signal=SIGUSR2 script.js
fi

# Go
if [ -f "go.mod" ]; then
    go tool pprof -heap <heapfile>
fi
```

## 3. Leak Detection Patterns

### Python
```python
# Unclosed file
f = open("file.txt")
# Missing: f.close()

# Unclosed connection
conn = sqlite3.connect("db")
# Missing: conn.close()

# Global cache (unbounded)
cache = []
def add_to_cache(item):
    cache.append(item)  # Grows forever
```

### Node.js
```javascript
// Event listener not removed
emitter.on('data', handler);
// Missing: emitter.off('data', handler)

// Unclosed database connection
const client = new MongoClient();
// Missing: client.close()

// Cache without limit
const cache = new Map();
```

### Go
```go
// Goroutine leak
go func() {
    for {
        // No exit condition
        doSomething()
    }
}()
```

## 4. Analysis Output

```
🔍 메모리 누수 탐지

=== 정적 분석 ===

🟡 가능한 누수 (3개):

1. src/cache.py:23
   - 전역 캐시 무제 증가
   - 라인: cache.append(item)

   제안: LRU 캐시로 변경

2. src/db.py:45
   - DB 연결 명시 종료 없음
   - 라인: conn = sqlite3.connect()

   제안: Context manager 사용

3. src/event.py:78
   - 이벤트 리스너 등록만 하고 해제 안함
   - 라인: emitter.on('message', handler)

   제안: emitter.off() 추가

=== 메모리 사용량 ===

Total Allocated: 1.2 GB
Peak Memory: 450 MB
GC Collections: 12
GC Time: 850ms (12%)

=== 높은 할당 (상위 5) ===

1. largeObject - 120 MB (src/data.py:12)
2. tempBuffer - 85 MB (src/utils.py:34)
```

## 5. Live Process Analysis

```bash
# Process running
/mem-check --live 1234

# Output:
=== PID 1234: python server.py ===

Memory Usage:
  RSS: 245 MB
  VSZ: 520 MB
  Heap: 180 MB

Growth Trend: ⬆️  (increasing)

Potential Leaks:
  - /lib/python3.9/site-packages/requests/api.py:189
  - src/handlers.py:45
```

## 6. Heap Analysis

```bash
# Heap dump analysis
go tool pprof -heap <heapfile>

# Python tracemalloc
python -m tracemalloc --snapshot 10

# Node.js clinic
clinic-memory -- heap-snapshot
```

## 7. Recommendations

```
💡 개선 제안

1. LRU 캐시 사용
   현재: 무제 증가
   제안: @lru_cache(maxsize=1000)

2. 컨텍스트 매니저 사용
   현재: 명시 종료
   제안: with 문 사용

3. 이벤트 리스너 해제
   현재: 등록만
   제안: weakref 사용

4. 스트림/이터레이터 사용
   현재: 리스트 한 번에 생성
   제안: 제너레이터로 변경
```

## 8. Detection Methods

### Static Code Analysis
```bash
# Find common leak patterns
grep -rn "global \w* \[\]" --include="*.py"
grep -rn "emitter\.on" --include="*.js" | grep -v "emitter\.off"
```

### Runtime Analysis
```bash
# Python with tracemalloc
python -m tracemalloc \
  --snapshot 10 \
  --compare-to snapshot.1

# Node.js with clinic
clinic-memory -- node --analyze server.js
```

## 9. CI/CD Integration

```yaml
# Memory leak detection in CI
- name: Check for memory leaks
  run: |
    python -m pytest --memray
```

## Rules

- Detect project type FIRST
- Analyze code for leak patterns
- Show memory usage summary
- Recommend specific fixes
- Support live process analysis
- Don't modify code, only analyze
- Support both Korean and English

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /mem-check
분석 모드: [static|live|heap]
탐지된 누수: [N] potential leaks
메모리 사용: [amount]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
