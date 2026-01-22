---
allowed-tools: Read, Grep, Glob, Bash, Edit, LSP
description: 정밀 디버깅 - 재현 어려운 버그, 성능 문제, 복잡한 로직 버그 전문
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System

If args match `--help`, `-h` alone, or empty:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 /precision-debugger 사용 가이드

용도: 표적 항암치료 같은 정밀 디버깅 - 복잡하고 재현 어려운 버그 전문

사용법:
  /precision-debugger <버그 설명>      # 정밀 분석 시작
  /precision-debugger --bisect         # git bisect로 도입 시점 추적

  /precision-debugger -h <버그>        # haiku (빠른 분석)
  /precision-debugger -s <버그>        # sonnet (기본값)
  /precision-debugger -o <버그>        # opus (심층 분석)

debug-master vs precision-debugger:
  debug-master: 일반 버그 (명확한 에러, 빠른 수정)
  precision-debugger: 복잡한 버그 (재현 어려움, 성능, 간헐적)

전문 영역:
  ✅ 재현이 어려운 버그 (간헐적 발생)
  ✅ 성능 문제 (느림, 메모리 누수, CPU 과부하)
  ✅ 복잡한 로직 버그 (여러 모듈 연관)
  ✅ 버그 도입 시점 추적 (git bisect)
  ✅ 최소 재현 케이스 생성
  ✅ 프로덕션 전용 버그 (로컬 재현 안됨)

옵션:
  --bisect     git bisect로 버그 도입 커밋 찾기
  --profile    성능 프로파일링
  --memory     메모리 누수 분석

예시:
  /precision-debugger "가끔 발생하는 NullPointerException"
  /precision-debugger --bisect "언제부터 느려졌는지 모름"
  /precision-debugger -o --memory "메모리 사용량 계속 증가"

언제 사용:
  ✅ 간헐적 버그 (10번 중 1번 발생)
  ✅ 성능 저하 (원인 불명)
  ✅ 메모리 누수
  ✅ 복잡한 상태 관련 버그
  ✅ 회귀 버그 (언제 도입되었는지 모름)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet
- Mode: `--bisect` | `--profile` | `--memory`

## 2. 과학적 디버깅 방법론

### Phase 1: 문제 정의
1. **증상 수집**
   - 사용자 보고서 분석
   - 에러 로그 수집
   - 재현 빈도 파악 (항상? 가끔? 특정 조건?)

2. **환경 분석**
   - OS, 브라우저, 디바이스
   - 버전, 설정, 네트워크 상태
   - 데이터 상태 (DB, 캐시)

### Phase 2: 가설 수립
```markdown
**가설 1**: [버그 원인 추측]
- 근거: [왜 이렇게 생각하는가?]
- 테스트 방법: [어떻게 검증할 것인가?]
- 예상 결과: [맞다면 무엇이 보일까?]

**가설 2**: [대안 원인]
- 근거: ...
```

### Phase 3: 최소 재현 케이스
1. 불필요한 요소 제거
2. 의존성 단순화
3. 데이터 최소화
4. 자동화된 재현 스크립트 생성

### Phase 4: 정밀 추적
- **git bisect**: 버그 도입 커밋 찾기
- **프로파일링**: CPU/메모리 핫스팟
- **상태 추적**: 변수 값 변화 기록

### Phase 5: 수정 및 검증
- 근본 원인 해결
- 회귀 테스트 작성
- 성능 영향 확인

## 3. 특수 모드

### --bisect 모드
```bash
# 버그 도입 커밋 찾기
git bisect start
git bisect bad HEAD
git bisect good v1.0.0
# 자동 테스트
git bisect run ./test-bug.sh
```

### --profile 모드
- CPU 핫스팟 분석
- 메모리 할당 추적
- I/O 병목 식별

### --memory 모드
- 힙 덤프 분석
- 객체 라이프사이클 추적
- GC 로그 분석

## 4. Output Format

```markdown
## 🎯 Precision Debug Report

### 버그 프로필
- 유형: [간헐적/성능/메모리/로직]
- 재현율: [N%]
- 심각도: [Critical/Major/Minor]

### 환경 요인
| 요인 | 정상 | 버그 발생 |
|------|------|-----------|
| 데이터 크기 | <100 | >1000 |
| 동시 요청 | 1 | 10+ |

### 가설 검증
| 가설 | 결과 | 근거 |
|------|------|------|
| 레이스 조건 | ✅ 확인 | [증거] |
| 메모리 누수 | ❌ 기각 | [증거] |

### 근본 원인
- 위치: [파일:라인]
- 원인: [상세 설명]
- 트리거 조건: [발생 조건]

### 최소 재현 케이스
```언어
// 버그를 재현하는 최소 코드
```

### 수정 방안
```diff
- 문제 코드
+ 수정 코드
```

### 검증
- [ ] 원래 재현 케이스에서 해결됨
- [ ] 회귀 테스트 추가됨
- [ ] 성능 영향 없음
```

## 5. Rules

1. **과학적 접근**: 가설 → 실험 → 검증
2. **최소 재현**: 버그를 트리거하는 최소 조건
3. **근본 원인**: 증상이 아닌 원인 해결
4. **증거 기반**: 추측 아닌 데이터로 판단
5. **Token 최적화**: 핵심 발견사항 중심

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /precision-debugger
모델: [haiku|sonnet|opus]
모드: [default|bisect|profile|memory]
버그 유형: [intermittent|performance|memory|logic]
근본 원인: [발견됨|조사 중]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
