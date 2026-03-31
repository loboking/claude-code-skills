---
allowed-tools: Bash, Grep, Glob, Read
description: 프로파일링 실행 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /profile 사용 가이드

용도: 프로파일링 실행 및 성능 분석

사용법:
  /profile                       # 현재 프로젝트 프로파일링
  /profile --cpu                 # CPU 프로파일링
  /profile --mem                 # 메모리 프로파일링
  /profile --file <path>         # 특정 파일만
  /profile --output <file>       # 결과 저장

지원 언어/도구:
  Python    cProfile, py-spy, scalene
  Go        pprof, trace
  Node.js   clinic.js, 0x, v8-profiler
  Java      JProfiler, VisualVM
  Rust      cpuprofiler, flamegraph

옵션:
  --cpu              CPU 프로파일링
  --mem              메모리 프로파일링
  --heap             힙 프로파일 (메모리 할당)
  --goroutine        고루틴 프로파일 (Go)
  --file <path>      특정 파일/함수 대상
  --output <file>    결과 저장 경로
  --format <type>    출력 형식 (text, json, flamegraph)
  --help             이 도움말 표시

예시:
  /profile                       # 기본 프로파일링
  /profile --cpu --flamegraph    # CPU 플레임그래프
  /profile --mem                 # 메모리 프로파일링

언제 사용:
  ✅ 성능 문제 진단 시
  ✅ 최적화 대상 찾기
  ✅ 리팩토링 전/후 비교
  ✅ 병목 함수 찾기

워크플로우:
  프로젝트 감지 → 프로파일러 실행 → 결과 분석 → 시각화
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--cpu`: CPU profiling
- `--mem`: Memory profiling
- `--heap`: Heap profiling
- `--goroutine`: Goroutine profiling (Go)
- `--file <path>`: Target specific file/function
- `--output <file>`: Save results
- `--format <type>`: Output format (text, json, flamegraph)

## 2. Project Detection & Tool Selection

```python
# Python - cProfile (built-in)
python -m cProfile -o profile.stats script.py
python -m pstats profile.stats

# Python - py-spy (sampling)
py-spy record -o profile.svg --pid <pid>
py-spy top --pid <pid>

# Go - pprof
go test -cpuprofile=cpu.prof -memprofile=mem.prof
go tool pprof -http=:8080 cpu.prof

# Node.js - clinic.js
clinic doctor -- node script.js
clinic flame -- node script.js

# Rust - flamegraph
cargo flamegraph
```

## 3. Profiling Modes

### CPU Profiling
```bash
# Python
python -m cProfile -s cumtime script.py

# Go
go test -bench=. -cpuprofile=cpu.prof
go tool pprof cpu.prof

# Node.js
node --prof script.js
```

### Memory Profiling
```bash
# Python
python -m memory_profiler script.py
mprof run --include-children python script.py

# Go
go test -memprofile=mem.prof
go tool pprof -http=:8080 mem.prof

# Node.js
node --heapsnapshot-signal=SIGUSR2 script.js
```

### Flamegraph Generation
```bash
# Python (py-spy)
py-spy record -o profile.svg --pid <pid>

# Go (pprof + flamegraph)
go tool pprof -raw -output=cpu.pprof cpu.prof | flamegraph.pl > cpu.svg

# Node.js (clinic.js)
clinic flame -- node script.js
```

## 4. Output Formats

### Text Summary
```
🔍 프로파일링 결과

=== Top 10 Functions (by CPU time) ===

#1 process_data() - 23.4%
   File: src/main.py:42
   Called: 1,234 times

#2 db.query() - 18.2%
   File: src/db.py:15
   Called: 5,678 times

#3 validate_input() - 12.1%
   File: src/utils.py:89
   Called: 8,901 times

💡 최적화 제안:
  1. process_data() - 캐싱 고려
  2. db.query() - 배치 쿼리로 변경
  3. validate_input() - 결과 재사용
```

### Flamegraph
```
📊 플레임그래프 생성

파일: /tmp/profile_flamegraph.svg
열기: open /tmp/profile_flamegraph.svg

해석:
- 너비 = CPU 시간 비율
- 높이 = 호출 스택 깊이
- 상단 = 진입점
- 하단 = 실제 실행
```

## 5. Interactive Analysis

```bash
# Go pprof interactive
go tool pprof cpu.prof
> top10    # Show top 10 functions
> list func_name  # Show function code
> web     # Open browser UI

# Python pstats interactive
python -m pstats profile.stats
% top 10
% stats function_name
```

## 6. Comparison Mode

Before/after profiling:
```bash
# Baseline
/profile --output baseline.prof

# After optimization
/profile --output optimized.prof

# Compare
diff -u baseline.prof optimized.prof
```

## Rules

- Detect project type FIRST
- Use most appropriate profiler
- Generate flamegraph when possible
- Show actionable recommendations
- Support comparison mode
- Don't profile production without explicit request
- Support both Korean and English

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /profile
프로파일 타입: [cpu|mem|heap|flamegraph]
결과 파일: [output-path]
상위 함수: [top-function]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
