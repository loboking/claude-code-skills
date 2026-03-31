---
allowed-tools: Bash, Grep, Glob, Read, LSP
description: 성능 병목 지점 찾기 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /bottleneck 사용 가이드

용도: 성능 병목 지점 찾기 및 분석

사용법:
  /bottleneck                    # 자동 감지 후 병목 분석
  /bottleneck --cpu             # CPU 병목 분석
  /bottleneck --mem             # 메모리 병목 분석
  /bottleneck --io              # I/O 병목 분석
  /bottleneck --profile <pid>   # 실행 중인 프로세스 프로파일링

지원 언어/도구:
  Python    py-spy, pprof, cProfile
  Go        pprof, trace
  Node      clinic, 0x, v8-profiler
  Java      JProfiler, VisualVM
  General   perf, flamegraph, strace

옵션:
  --cpu               CPU 병목 분석
  --mem               메모리 병목 분석
  --io                I/O 병목 분석
  --profile <pid>     실행 중인 프로세스 프로파일링
  --flamegraph        플레임그래프 생성
  --top <n>           상위 N개 병목 표시
  --help              이 도움말 표시

예시:
  /bottleneck                    # 자동 분석
  /bottleneck --cpu             # CPU 병목 찾기
  /bottleneck --profile 1234    # PID 1234 프로세스 분석
  /bottleneck --flamegraph      # 시각화 생성

언제 사용:
  ✅ 애플리케이션이 느릴 때
  ✅ CPU/메모리 사용량이 높을 때
  ✅ 특정 기능이 느릴 때

워크플로우:
  프로젝트 감지 → 프로파일링 도구 선택 → 실행 → 결과 분석
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--cpu`: Analyze CPU bottlenecks
- `--mem`: Analyze memory bottlenecks
- `--io`: Analyze I/O bottlenecks
- `--profile <pid>`: Profile running process
- `--flamegraph`: Generate flamegraph
- `--top <n>`: Show top N bottlenecks (default: 10)

## 2. Project Detection

Use Glob to detect project type:

```python
# Python
requirements.txt, pyproject.toml, *.py

# Node.js
package.json, *.js, *.ts

# Go
go.mod, *.go

# Java
pom.xml, build.gradle, *.java
```

## 3. Static Analysis (Code-based)

Before profiling, analyze code for common bottlenecks:

### Python patterns to check:
```python
# N+1 queries
for item in items:
    result = db.query(item.id)  # ⚠️

# Inefficient loops
for i in range(len(items)):
    for j in range(len(items)):  # ⚠️ O(n²)

# Blocking I/O
time.sleep(1)  # ⚠️

# Repeated regex compilation
re.match(pattern, text)  # ⚠️ in loop
```

### Node.js patterns:
```javascript
// Blocking operations
syncFunctions();  // ⚠️

// Event loop blocking
while(true) { process(); }  // ⚠️

// Memory leaks
global.cache = [];  // ⚠️ unbounded
```

### Go patterns:
```go
// Goroutine leaks
go func() {
    for {
        // ⚠️ no exit condition
    }
}()

// Inefficient string concatenation
s := ""
for _, v := range items {
    s += v  // ⚠️ use strings.Builder
}
```

## 4. Dynamic Profiling (Tool-based)

### Python (py-spy - sampling profiler)
```bash
# Install if needed: pip install py-spy

# Sample running process
py-spy top --pid <pid>

# Record for flamegraph
py-spy record -o profile.svg --pid <pid>

# Dump current call stack
py-spy dump --pid <pid>
```

### Python (cProfile - deterministic)
```bash
python -m cProfile -o profile.stats script.py
python -m pstats profile.stats
```

### Go (pprof)
```bash
# CPU profiling
go test -cpuprofile=cpu.prof
go tool pprof cpu.prof

# Memory profiling
go test -memprofile=mem.prof
go tool pprof mem.prof

# HTTP profiling (import _ "net/http/pprof")
curl http://localhost:6060/debug/pprof/heap > heap.prof
```

### Node.js (clinic.js)
```bash
# Install: npm install -g clinic
clinic doctor -- node server.js
clinic flame -- node server.js
```

### General (perf - Linux)
```bash
perf record -F 99 -p <pid> -g -- sleep 30
perf report
perf script | stackcollapse-perf.pl | flamegraph.pl > flamegraph.svg
```

## 5. Result Analysis

Format output:

```
🔍 병목 분석 결과

=== 상위 병목 (Top 10) ===

#1. process_data() - 23.4% CPU
   File: src/main.py:42
   Hot path: process_data → validate → save

#2. db.query() - 18.2% CPU
   File: src/db.py:15
   Issue: N+1 query pattern detected

#3. regex_match() - 12.1% CPU
   File: src/utils.py:89
   Issue: Repeated compilation in loop

=== 추천 수정 사항 ===

1. [HIGH] process_data() 최적화
   - 현재: O(n²) 루프
   - 제안: hash map 사용으로 O(n) 개선

2. [MEDIUM] N+1 쿼리 해결
   - 현재: 루프 내 개별 쿼리
   - 제안: batch query 또는 eager loading

3. [LOW] 정규식 사전 컴파일
   - 현재: 매번 컴파일
   - 제안: re.compile() 모듈 레벨에서 실행
```

## 6. Flamegraph Generation

With `--flamegraph` flag:

```bash
# Generate SVG
# Tools: py-spy, go tool pprof, FlameGraph
```

Output flamegraph path and key observations:

```
📊 플레임그래프 생성

파일: /tmp/bottleneck_flamegraph.svg

주요 관찰:
  - process_data()이 전체 시간의 40% 차지
  - I/O 대기 시간: 25%
  - GC 시간: 8%

브라우저에서 열기: file:///tmp/bottleneck_flamegraph.svg
```

## 7. Process Profiling

With `--profile <pid>`:

```bash
# Attach to running process
# Requires appropriate tool for language
```

Check if tool available:
- Python: `py-spy`
- Go: `pprof` endpoint
- Node.js: `clinic`

If tool not installed:
```
⚠️ 프로파일링 도구가 필요합니다:

  pip install py-spy  # Python
  npm install -g clinic  # Node.js
```

## Rules

- Detect project type FIRST
- Try static analysis before profiling
- Show actionable recommendations
- Prioritize by impact (HIGH/MEDIUM/LOW)
- Generate flamegraph when requested
- Don't profile production without explicit `--profile` flag
- Support both Korean and English output

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /bottleneck
프로젝트 타입: [detected type]
분석 방법: [static|dynamic|both]
상위 병목: [top bottleneck]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
