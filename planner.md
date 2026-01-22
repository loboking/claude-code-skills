---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
description: 프로젝트 기획서 작성 및 요구사항 상세화 - 아이디어를 실행 가능한 기획으로 전환
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /planner 사용 가이드

용도: 아이디어 → 상세 기획서 자동 생성

사용법:
  /planner <아이디어>              # 간단 아이디어 → 상세 기획
  /planner --full <주제>           # 빈 상태 → 전체 기획서
  /planner --story <기능>          # 사용자 스토리 생성

  /planner -h <아이디어>           # haiku 모델
  /planner -s <아이디어>           # sonnet 모델 (기본값)
  /planner -o <아이디어>           # opus 모델

모드:
  기본 모드        간단 요청 → 상세 요구사항
  --full           빈 상태 → 전체 프로젝트 기획서
  --story          기능 → 사용자 스토리
  --scope          프로젝트 범위 정의
  --priority       기능 우선순위 매트릭스

옵션:
  -h, --haiku      빠른 실행 (간단한 기획)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 기획)
  --compact        간결 모드
  --interactive    대화형 기획 (질문-답변)
  --help           이 도움말 표시

예시:
  /planner 로그인 기능 추가
    → 요구사항, 기술 스펙, 예외 케이스 도출

  /planner --full "Todo 앱 만들기"
    → 전체 기획서 (목표, 기능, 우선순위, 일정)

  /planner --story "사용자가 할 일을 추가할 수 있다"
    → Given-When-Then 사용자 스토리

  /planner -o --priority
    → 기능 우선순위 매트릭스 (중요도 vs 난이도)

언제 사용:
  ✅ 막연한 아이디어를 구체화
  ✅ 프로젝트 시작 전 기획서 작성
  ✅ 요구사항 누락 방지
  ✅ 팀 커뮤니케이션용 문서

워크플로우:
  아이디어 입력 → 분석 → 상세 기획서 → 검토|수정|저장
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

**Extract flags first:**
- MODEL: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet
- MODE_FLAGS: `--full`, `--story`, `--scope`, `--priority`, `--interactive`
- COMPACT_FLAG: `--compact`

**Template mode detection:**
- Explicit `--compact` → ultra-compact
- Mode flags (--full, --story, etc.) → full
- <15 words → ultra-compact (auto)
- <30 words → compact (auto)
- 30+ words → full

## 2. Quality Check

Critical keywords detection (결제, 인증, 보안, 마이그레이션 등):
- 감지 시 Full 모드 권장 경고 표시
- 사용자 선택 후 진행

## 3. Templates

### Ultra-Compact Template (<15 words)
```markdown
## 요구사항 분석

**Goal**: [1문장 요약]

**구현 요소**:
- [핵심 기능 1]
- [핵심 기능 2]
- [핵심 기능 3]

**주의사항**: [1-2가지]

**다음 단계**: [즉시 실행 가능한 액션]
```

### Compact Template (<30 words)
```markdown
## 상세 요구사항

**Goal**: [한 문장 요약]

**Requirements**:
1. [기능 요구사항 1]
2. [기능 요구사항 2]
3. [기능 요구사항 3]

**Tech Spec**:
- Framework: [감지된 프레임워크]
- Files: [파일 경로 목록]

**Edge Cases**: [2-3가지]

**Testing**: [필수 테스트만]

---
실행|수정|취소
```

### Full Template (Default Mode)
```markdown
## 상세 요구사항

### Goal
[한 문장 요약]

### Requirements
1. [기능 요구사항 1]
2. [기능 요구사항 2]
...

### Tech Spec
- Framework: [감지된 프레임워크]
- Files to modify: [파일 경로]
- Dependencies: [필요한 라이브러리]

### Edge Cases
- [예외 상황 1]
- [예외 상황 2]

### Testing
- [테스트 케이스 1]
- [테스트 케이스 2]

---
실행|수정|취소
```

### --full Mode (전체 기획서)
```markdown
# [프로젝트명] 기획서

## 1. 프로젝트 개요
- **목적**: [왜 만드는가]
- **타겟 사용자**: [누구를 위한가]
- **핵심 가치**: [어떤 문제를 해결하는가]

## 2. 주요 기능
### 2.1 [기능 1]
- 설명: ...
- 우선순위: High/Medium/Low
- 난이도: 1-5

## 3. 기능 우선순위 매트릭스
| 기능 | 중요도 | 난이도 | 우선순위 |
|------|-------|--------|---------|
| ... | ... | ... | P0/P1/P2 |

## 4. 기술 스택
- Frontend/Backend/Database/Infrastructure

## 5. 프로젝트 범위
### In Scope / Out of Scope

## 6. 위험 요소
## 7. 마일스톤
## 8. 성공 지표
```

### --story Mode (사용자 스토리)
```markdown
## User Story: [기능명]

**As a** [사용자 역할]
**I want** [원하는 기능]
**So that** [목적/가치]

### Acceptance Criteria
- [ ] Given [전제 조건]
      When [사용자 행동]
      Then [예상 결과]

### Test Scenarios
1. Happy Path: [정상 시나리오]
2. Edge Case: [예외 시나리오]

### Definition of Done
- [ ] 코드 작성 완료
- [ ] 단위 테스트 통과
- [ ] 코드 리뷰 완료
```

### --priority Mode (우선순위 매트릭스)
```
## 기능 우선순위 매트릭스

High Impact, Low Effort (Quick Wins) ⭐
- [기능 A]

High Impact, High Effort (Major Projects)
- [기능 B]

Low Impact, Low Effort (Fill-ins)
- [기능 C]

Low Impact, High Effort (Time Sinks) ❌
- [피해야 할 기능]

### 권장 순서
1. Quick Wins 먼저
2. Major Projects
3. Fill-ins (시간 여유 시)
4. Time Sinks 제외
```

### --scope Mode (범위 정의)
```markdown
## 프로젝트 범위 정의

### ✅ In Scope (포함)
### ❌ Out of Scope (제외)
### ⚠️ Nice to Have (선택)
### 📏 Constraints (제약사항)
```

## 4. Project Context Detection

Use Glob/Grep to check:
- Existing project or new?
- Tech stack detection
- Project stage

## 5. Rules

1. **Parse Options FIRST**
2. **Auto-compact** for simple requests
3. **Full mode** for complex requests
4. **Korean Output**
5. **Token Optimization**: diff-only, 참조 형식, 반복 축약

### Token Optimization
- 출력 효율성: diff-only, 참조 형식
- 중복 방지: 사용자 입력 반복 X
- 구조화: 마크다운 섹션, 테이블

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /planner
모델: [haiku|sonnet|opus]
모드: [default|full|story|priority|scope]
템플릿: [ultra-compact|compact|full]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
