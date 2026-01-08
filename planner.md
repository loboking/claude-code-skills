---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task
description: 프로젝트 기획서 작성 및 요구사항 상세화 (super 기능 통합) (user)
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
  기본 모드        간단 요청 → 상세 요구사항 (기존 /super)
  --full           빈 상태 → 전체 프로젝트 기획서
  --story          기능 → 사용자 스토리
  --scope          프로젝트 범위 정의
  --priority       기능 우선순위 매트릭스

옵션:
  -h, --haiku      빠른 실행 (간단한 기획)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 기획)
  --template <id>  특정 템플릿 사용
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

특징:
  🔄 기존 /super 기능 완전 통합
  📋 사용자 스토리 자동 생성
  🎯 우선순위 매트릭스
  💬 대화형 기획 지원
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default (sonnet)
- Mode: `--full` | `--story` | `--scope` | `--priority` | default (super mode)
- Template: `--template <id>`
- Interactive: `--interactive`

## 2. Mode Routing

### Default Mode (Super Prompt - 기존 /super)
간단 요청 → 상세 요구사항

1. **Analyze intent** (WHO/WHAT/WHY)
2. **Check project context** via Glob/Grep
3. **Derive requirements**:
   - Functional requirements
   - Non-functional requirements
   - Edge cases
   - Testing requirements

**Output format**:
```
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
빈 상태 → 완전한 프로젝트 기획서

**Output format**:
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

### 2.2 [기능 2]
...

## 3. 기능 우선순위 매트릭스
| 기능 | 중요도 | 난이도 | 우선순위 |
|------|-------|--------|---------|
| 로그인 | High | 2 | P0 |
| ... | ... | ... | ... |

## 4. 기술 스택
- Frontend: [제안]
- Backend: [제안]
- Database: [제안]
- Infrastructure: [제안]

## 5. 프로젝트 범위
### In Scope
- [포함되는 기능]

### Out of Scope
- [제외되는 기능]

## 6. 위험 요소
- [기술적 리스크]
- [일정 리스크]
- [리소스 리스크]

## 7. 마일스톤
- Week 1: [목표]
- Week 2: [목표]
...

## 8. 성공 지표
- [측정 가능한 지표]
```

### --story Mode (사용자 스토리)
기능 설명 → Given-When-Then 사용자 스토리

**Output format**:
```markdown
## User Story: [기능명]

**As a** [사용자 역할]
**I want** [원하는 기능]
**So that** [목적/가치]

### Acceptance Criteria
- [ ] Given [전제 조건]
      When [사용자 행동]
      Then [예상 결과]

- [ ] Given [전제 조건 2]
      When [사용자 행동 2]
      Then [예상 결과 2]

### Test Scenarios
1. Happy Path: [정상 시나리오]
2. Edge Case: [예외 시나리오]

### Definition of Done
- [ ] 코드 작성 완료
- [ ] 단위 테스트 통과
- [ ] 코드 리뷰 완료
- [ ] 문서 업데이트
```

### --priority Mode (우선순위 매트릭스)
기능 목록 → 우선순위 매트릭스 생성

**Output format**:
```
## 기능 우선순위 매트릭스

High Impact, Low Effort (Quick Wins) ⭐
- [기능 A]
- [기능 B]

High Impact, High Effort (Major Projects)
- [기능 C]

Low Impact, Low Effort (Fill-ins)
- [기능 D]

Low Impact, High Effort (Time Sinks) ❌
- [피해야 할 기능]

### 권장 순서
1. Quick Wins 먼저
2. Major Projects
3. Fill-ins (시간 여유 시)
4. Time Sinks 제외
```

### --scope Mode (범위 정의)
프로젝트 범위 명확화

**Output format**:
```markdown
## 프로젝트 범위 정의

### ✅ In Scope (포함)
- [명확히 포함되는 기능]
- [경계 케이스 - 포함]

### ❌ Out of Scope (제외)
- [명확히 제외되는 기능]
- [향후 고려 사항]

### ⚠️ Nice to Have (선택)
- [시간 여유 시 추가]

### 📏 Constraints (제약사항)
- 기술적 제약: [예: 특정 프레임워크 사용]
- 시간 제약: [예: 2주 내 완료]
- 리소스 제약: [예: 1인 개발]
```

## 3. Interactive Mode (--interactive)

If `--interactive` flag:
1. Start conversation with user
2. Ask clarifying questions:
   - "누가 사용하나요?"
   - "왜 필요한가요?"
   - "핵심 기능 3가지는?"
   - "언제까지 완료해야 하나요?"
3. Build requirements progressively
4. Generate final planning document

## 4. Project Context Detection

Use Glob/Grep to check:
- Existing project or new project?
- Tech stack (detect from files)
- Team size (git contributors)
- Project stage (alpha/beta/production)

## 5. Validation

Before output:
- ✅ All requirements are measurable
- ✅ No conflicting requirements
- ✅ Tech stack is consistent
- ✅ Priorities are justified
- ✅ Timeline is realistic

## Rules
- Parse options FIRST before mode routing
- Super mode (default) must be backward compatible with /super
- Full mode creates comprehensive planning doc
- User stories follow Given-When-Then format
- Priority matrix uses Impact vs Effort axes
- Ask clarifying questions when ambiguous
- Respond in Korean

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /planner
모델: [haiku|sonnet|opus]
모드: [super|full|story|priority|scope]
대화형: [yes|no]
생성 문서: [planning.md | user-story.md | ...]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
