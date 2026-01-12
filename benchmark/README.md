# Agent Benchmark Guide

Claude Code 에이전트의 성능을 측정하고 비교합니다.

## 빠른 시작

```bash
# 전체 벤치마크 실행
./benchmark.sh --manual

# 특정 에이전트만 테스트
./benchmark.sh --manual --agent duo

# 특정 시나리오만 테스트
./benchmark.sh --manual --scenario simple

# 결과 분석
./benchmark.sh --report
```

## 디렉토리 구조

```
benchmark/
├── benchmark.sh           # 벤치마크 실행 스크립트
├── scenarios/            # 테스트 시나리오
│   ├── simple.txt       # 간단한 작업 (README 수정)
│   ├── medium.txt       # 중간 작업 (기능 구현)
│   └── complex.txt      # 복잡한 작업 (아키텍처 설계)
├── results/              # 벤치마크 결과
│   ├── benchmark_YYYYMMDD_HHMMSS.json
│   └── readme_metrics.md
└── README.md            # 이 파일
```

## 측정 항목

각 에이전트에 대해 다음을 측정합니다:

| 항목 | 설명 | 측정 방법 |
|-----|------|---------|
| **실행 시간** | 작업 완료까지 걸린 시간 (초) | `time` 명령어 |
| **Input 토큰** | 입력 프롬프트 토큰 수 | Claude API 응답 |
| **Output 토큰** | 생성된 응답 토큰 수 | Claude API 응답 |
| **API 호출** | 총 API 호출 횟수 | 수동 카운트 |
| **품질** | 결과물 품질 (1-5) | 주관적 평가 |

## 벤치마크 실행 방법

### 1. 수동 벤치마크

가장 정확한 방법입니다. Claude Code CLI는 대화형이므로 수동 측정이 필요합니다.

```bash
# 1. 벤치마크 스크립트 실행
./benchmark.sh --manual --agent duo --scenario simple

# 2. 스크립트가 시나리오를 표시하고 명령어를 제공합니다
# 3. 새 터미널에서 제공된 명령어를 실행합니다
time @agent-duo "$(cat scenarios/simple.txt)"

# 4. 실행 후 다음 정보를 입력합니다:
#    - 실행 시간 (time 명령어 출력에서)
#    - Input/Output 토큰 (Claude API 응답에서)
#    - API 호출 횟수
#    - 품질 평가 (1-5)
```

### 2. 토큰 정보 확인 방법

Claude Code는 실행 후 토큰 정보를 표시합니다:

```
Token usage: 1234/200000 (input/output)
```

또는 `~/.claude/history.jsonl` 파일에서 확인할 수 있습니다.

### 3. 결과 분석

```bash
# 최신 벤치마크 결과 분석
./benchmark.sh --report

# 출력:
# - 에이전트별 평균 시간/토큰
# - README용 성능 지표 생성
```

## 시나리오 추가

새로운 테스트 시나리오를 추가하려면 `scenarios/` 디렉토리에 `.txt` 파일을 생성하세요:

```bash
# 새 시나리오 생성
cat > scenarios/my_scenario.txt <<EOF
여기에 테스트할 작업을 작성하세요.
EOF

# 실행
./benchmark.sh --manual --scenario my_scenario
```

## 결과 파일 형식

벤치마크 결과는 JSON 형식으로 저장됩니다:

```json
{
  "timestamp": "20260112_103000",
  "date": "2026-01-12T10:30:00+09:00",
  "benchmarks": [
    {
      "agent": "duo",
      "scenario": "simple",
      "execution_time": 45.2,
      "tokens": {
        "input": 1234,
        "output": 5678,
        "total": 6912
      },
      "api_calls": 3,
      "quality": 5
    }
  ]
}
```

## README 업데이트

벤치마크 완료 후:

1. `./benchmark.sh --report` 실행
2. `results/readme_metrics.md` 생성됨
3. 해당 내용을 `README.md`에 복사

## 커뮤니티 기여

벤치마크 결과를 공유하려면:

1. `results/` 디렉토리의 JSON 파일 업로드
2. 시스템 정보 포함 (OS, Claude Code 버전)
3. Pull Request 제출

## 주의사항

- **일관성**: 동일한 환경에서 측정하세요
- **반복**: 각 시나리오를 최소 3회 반복 권장
- **캐시**: 첫 실행은 캐시 워밍업으로 제외
- **네트워크**: 안정적인 네트워크 환경에서 측정

## 자동화 (향후)

현재는 수동 측정만 지원하지만, 향후 다음을 고려중입니다:

- Claude Code API를 통한 자동 실행
- 로그 파일 자동 파싱
- CI/CD 통합
- 성능 트렌드 추적

## 문제 해결

### "jq: command not found"

```bash
# macOS
brew install jq

# Linux
sudo apt-get install jq
```

### 토큰 정보를 찾을 수 없음

`~/.claude/history.jsonl` 파일을 확인하세요:

```bash
tail -n 50 ~/.claude/history.jsonl | jq '.usage'
```

## 예시 워크플로우

```bash
# 1. 전체 에이전트 벤치마크 (simple 시나리오만)
./benchmark.sh --manual --scenario simple

# 2. 주요 에이전트만 상세 테스트
for agent in duo run super gemini; do
  ./benchmark.sh --manual --agent $agent
done

# 3. 결과 분석 및 README 생성
./benchmark.sh --report

# 4. README.md 업데이트
cat results/readme_metrics.md >> ../README.md

# 5. Git 커밋
git add results/ ../README.md
git commit -m "chore: Add benchmark results"
```
