---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
description: 체계적 버그 분석 - 과학적 방법론으로 복잡한 버그 해결
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System

If args match `--help`, `-h` alone, or empty:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🐛 /debug-master 사용 가이드

용도: 복잡한 버그를 체계적으로 분석하고 해결

사용법:
  /debug-master <버그 설명>          # 버그 분석 시작
  /debug-master <스택트레이스>       # 크래시 분석

  /debug-master -h <버그>           # haiku (빠른 분석)
  /debug-master -s <버그>           # sonnet (기본값)
  /debug-master -o <버그>           # opus (심층 분석)

디버깅 방법론:
  🔬 Scientific Method - 가설 수립 → 실험 → 검증
  🔪 Divide and Conquer - 이진 탐색으로 범위 축소
  🔍 Root Cause Analysis - 5 Why 기법
  🦆 Rubber Duck - 단계별 논리 검토
  ⏰ Time Travel - 상태 변화 추적

5단계 프로세스:
  1. REPRODUCE - 최소 재현 케이스
  2. ISOLATE - 문제 범위 축소
  3. ANALYZE - 근본 원인 파악
  4. FIX - 수정 구현
  5. VERIFY - 검증 및 회귀 테스트

예시:
  /debug-master "앱이 로그인 시 크래시"
  /debug-master "N+1 쿼리 성능 문제"
  /debug-master "간헐적 NullPointerException"

언제 사용:
  ✅ 크래시 및 스택 트레이스 분석
  ✅ 간헐적/재현 어려운 버그
  ✅ 성능 병목 진단
  ✅ 메모리 누수 추적
  ✅ 회귀 버그 조사
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet

## 2. Debugging Methodology

### Phase 1: REPRODUCE
**목표**: 일관된 최소 재현 케이스

- 버그를 트리거하는 가장 작은 테스트 케이스 생성
- 환경, 설정, 조건 문서화
- 재현이 일관적인지 확인
- 모든 관련 입력, 상태, 출력 기록

### Phase 2: ISOLATE
**목표**: 문제 범위를 특정 컴포넌트로 축소

- 이진 탐색: 코드 절반 주석 → 테스트 → 반복
- 의존성 하나씩 제거
- 컴포넌트 독립 테스트
- 필요한 최소 조건 식별

### Phase 3: ANALYZE
**목표**: 버그 발생 원인 이해

- 로그, 스택 트레이스, 에러 메시지 분석
- 핵심 결정 지점에 로깅/브레이크포인트 추가
- 메모리 상태, 변수 값, 객체 라이프사이클 검사
- 타이밍, 스레딩, 레이스 조건 확인
- git history로 최근 변경 검토

### Phase 4: FIX
**목표**: 견고한 솔루션 구현

- 증상이 아닌 근본 원인 해결
- 부작용과 엣지 케이스 고려
- 방어적 프로그래밍 적용
- 검증 및 에러 핸들링 추가

### Phase 5: VERIFY
**목표**: 수정 확인 및 회귀 방지

- 원래 재현 케이스 테스트
- 엣지 케이스 및 경계 조건 테스트
- 기존 테스트 스위트 실행
- 성능 회귀 확인
- 새 버그 도입 여부 확인

## 3. Output Format

```markdown
## 🐛 Debug Report

### 버그 요약
- 증상: [설명]
- 심각도: [Critical/Major/Minor]
- 재현율: [항상/가끔/특정 조건]

### Phase 1: 재현
- 재현 단계:
  1. [단계]
  2. [단계]
- 환경: [OS/버전/설정]
- 최소 케이스: [코드 또는 설명]

### Phase 2: 격리
- 문제 위치: [파일:라인]
- 관련 컴포넌트: [목록]

### Phase 3: 분석
**가설**: [근본 원인 추정]
**근거**: [증거]
**확인 방법**: [테스트]

### Phase 4: 수정
```diff
- 문제 코드
+ 수정 코드
```

### Phase 5: 검증
- [ ] 원래 버그 해결됨
- [ ] 엣지 케이스 통과
- [ ] 회귀 없음
```

## 4. Rules

1. **체계적 접근**: 5단계 프로세스 준수
2. **가설 기반**: 추측 아닌 근거 있는 분석
3. **근본 원인**: 증상이 아닌 원인 해결
4. **Token 최적화**: diff-only, 핵심만

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /debug-master
모델: [haiku|sonnet|opus]
버그 유형: [crash|performance|logic|intermittent]
근본 원인: [발견됨|조사 중]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
