---
allowed-tools: Bash, Grep, Glob, Read
description: 벤치마크 실행/비교 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /bench 사용 가이드

용도: 벤치마크 실행/비교

사용법:
  /bench                        # 자동 감지 후 실행
  /bench --run                 # 벤치마크 실행
  /bench --compare <baseline>  # 베이스라인과 비교
  /bench --suite <name>        # 특정 스위트 실행

지언어/도구:
  Python    pytest-benchmark, timeit
  Node.js   benchmark.js, picocli
  Go        go test -bench
  Rust     criterion
  Java     JMH (Java Microbenchmark Harness)

측정 항목:
  Execution time (실행 시간)
  Memory usage (메모리 사용량)
  Throughput (처리량)
  Latency (지연 시간)

옵션:
  --run              벤치마크 실행
  --compare <file>   이전 결과와 비교
  --suite <name>     특정 스위트 실행
  --iterations <n>   반복 횟수
  --warmup <n>       워밍업 횟수
  --output <file>    결과 저장

예시:
  /bench                        # 전체 실행
  /bench --run                 # 실행만
  /bench --compare baseline.json # 비교

언제 사용:
  ✅ 성능 최적화 전후 비교
  ✅ 병목 지점 발견 후 검증
  ✅ 새 알고리즘 구현 전 성능 테스트

워크플로우:
  감지 → 벤치마크 실행 → 결과 분석 → 개선 제안
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--run`: Execute benchmarks
- `--compare <file>`: Compare with baseline
- `--suite <name>`: Run specific test suite
- `--iterations <n>`: Number of iterations
- `--warmup <n>`: Warmup iterations

## 2. Project Detection & Tool Selection

```bash
# Python
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    pip install pytest-benchmark
    pytest benchmark --save=baseline.json
fi

# Node.js
if [ -f "package.json" ]; then
    npm install --save-dev benchmark
    node benchmark.js
fi

# Go
if [ -f "go.mod" ]; then
    go test -bench=. -benchmem
fi

# Rust
if [ -f "Cargo.toml" ]; then
    cargo bench
fi
```

## 3. Benchmark Structure

### Python (pytest-benchmark)
```python
import pytest_benchmark

def test_fast_operation(benchmark):
    @benchmark.pedantic(
        group="fast-operations",
        max_time=0.1
    )
    def result():
        return sum(range(100))
```

### Node.js (benchmark.js)
```javascript
const Benchmark = require('benchmark');
const suite = new Benchmark.Suite();

suite
  .add('Array#push', function() {
    const arr = [];
    arr.push(1);
  })
  .on('cycle', function(event) {
    console.log(String(event.target));
  })
  .run();
```

### Go
```go
func BenchmarkFunction(b *testing.B) {
    for i := 0; i < b.N; i++ {
        Function()
    }
}
```

## 4. Execution Modes

### Run Mode
```
🚀 벤치마크 실행

Target: src/utils.py
Iterations: 1000
Warmup: 100

Running benchmarks...
[=================] 100%

=== 결과 ===
Function         | Avg (ns) | Min (ns) | Max (ns)
----------------|----------|---------|---------
sum()           | 452      | 412     | 523
processData()   | 12,450   | 11,200  | 14,100
```

### Compare Mode
```
📊 벤치마크 비교

Baseline: v1.0.0
Current: v1.1.0

=== 성능 변화 ===

Function         | Before | After  | Change  | Status
----------------|--------|--------|---------|--------
sum()           | 520ns  | 450ns  | +13.5%  | ✅ Faster
processData()   | 15ms   | 12ms   | +20.0%  | ✅ Faster
renderHTML()    | 85ms   | 92ms   | -8.2%   | ❌ Slower

Overall: 2 functions improved, 1 regressed
```

## 5. Benchmark Templates

### Execution Time
```
Name (time in ms)         | 10th percentile | 50th percentile | 90th percentile
---------------------------|----------------|-----------------|-----------------
process_data             | 12.5           | 15.2            | 18.7
save_to_db                | 45.2           | 52.1            | 78.3
```

### Memory
```
Name                      | Allocations | Peak Memory |
---------------------------|-------------|--------------
process_data             | 1,234       | 45 MB        |
save_to_db                | 5,678       | 120 MB       |
```

## 6. Auto-Discovery

Scan for benchmark files:
```bash
# Python
find . -name "*bench*.py" -o -name "test_*.py"

# Go
find . -name "*_test.go"

# Node.js
find . -name "*bench*.js"
```

## 7. CI/CD Integration

```yaml
# Benchmark as part of CI
- name: Run benchmarks
  run: |
    pytest benchmark --save=baseline.json

- name: Compare baseline
  run: |
    pytest benchmark --compare=baseline.json --fail=7  # Fail if 7% slower
```

## 8. Output Formats

### JSON
```json
{
  "function": "processData",
  "stats": {
    "mean": 15245,
    "stddev": 234,
    "min": 14800,
    "max": 16000
  },
  "unit": "ns"
}
```

### Table
```
┌─────────────────┬──────────┬──────────┬──────────┐
│ Function        │ Mean     │ Min      │ Max      │
├─────────────────┼──────────┼──────────┼──────────┤
│ processData     │ 15.2ms   │ 14.1ms   │ 18.5ms   │
│ saveToDb        │ 52.1ms   │ 48.3ms   │ 78.2ms   │
└─────────────────┴──────────┴──────────┴──────────┘
```

## Rules

- Detect project type FIRST
- Find or create benchmark files
- Support comparison mode
- Show clear before/after metrics
- Generate baseline file
- Don't run in production without explicit request
- Support both Korean and English

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /bench
벤치마크 수: [N] functions
기준: [baseline file]
성능 변화: [improved/regressed]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
