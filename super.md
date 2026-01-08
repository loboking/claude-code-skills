---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task
description: 슈퍼 프롬프트 생성 - 간단 요청을 상세 요구사항으로 확장 (user)
---
Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /super 사용 가이드

용도: 간단 요청 → 상세 요구사항 자동 생성

사용법:
  /super <구현 요청>               # 간단 요청 → 상세 요구사항
  /super -h <요청>                # haiku 모델
  /super -s <요청>                # sonnet 모델 (기본값)
  /super -o <요청>                # opus 모델
  /super --compact <요청>         # 간결 모드 (자동 감지)

옵션:
  -h, --haiku      빠른 실행
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질
  --compact        간결 모드 (자동 감지: <15단어=초간결, <30단어=간결)
  --help           이 도움말 표시

예시:
  /super 로그인 기능 추가
    → 요구사항, 기술 스펙, 예외 케이스, 테스트 요건 도출

  /super 성능 개선
    → 프로파일링 계획, 최적화 전략, 측정 지표 제안

  /super --compact API 엔드포인트 추가
    → 초간결 모드 (핵심 요구사항만)

언제 사용:
  ✅ 막연한 아이디어를 구체적 요구사항으로
  ✅ 구현 전 요구사항 명확화
  ✅ 예외 케이스 누락 방지
  ✅ 테스트 전략 수립

워크플로우:
  간단 요청 → 분석 → 상세 요구사항 → 실행|수정|취소

특징:
  🎯 WHO/WHAT/WHY 분석
  📋 기능/비기능 요구사항 도출
  ⚠️ 예외 케이스 자동 탐지
  ✅ 테스트 요건 포함
  💾 토큰 최적화 (자동 간결 모드)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options and Smart Compact Detection (FIRST - Token Optimization)

**Extract flags first**, then determine template mode:

```
# Step 1: Parse and extract flags
MODEL = extract_model_flag(-h, -s, -o) | default: sonnet
COMPACT_FLAG = extract_flag(--compact)

# Step 2: Count words (excluding ALL extracted flags)
CLEAN_ARGS = remove all extracted flags from ARGUMENTS
WORD_COUNT = count words in CLEAN_ARGS

# Step 3: Determine template mode
if COMPACT_FLAG:
  TEMPLATE_MODE = "ultra-compact"  # Explicit user request
elif WORD_COUNT < 15:
  TEMPLATE_MODE = "ultra-compact"  # Auto-detect
elif WORD_COUNT < 30:
  TEMPLATE_MODE = "compact"  # Auto-detect
else:
  TEMPLATE_MODE = "full"  # Default for complex requests
```

## 1.5. Template Selection (Based on Parsed Mode)

### Ultra-Compact Template (TEMPLATE_MODE = "ultra-compact")
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

### Compact Template (TEMPLATE_MODE = "compact")
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

### Full Template (TEMPLATE_MODE = "full")
Use the complete template described below.

---

## 2. Analyze Intent (WHO/WHAT/WHY) - For Full Template Only

Parse the user's request to understand:
- **WHO**: Target users/stakeholders
- **WHAT**: Specific functionality requested
- **WHY**: Business value/problem being solved

## 3. Check Project Context

Use Glob/Grep to detect:
- **Project type**: package.json (Node), requirements.txt (Python), go.mod (Go), etc.
- **Framework**: React, Next.js, Flask, Spring Boot, etc.
- **Existing patterns**: Authentication, API structure, testing setup
- **Tech stack**: Database, state management, build tools

## 4. Derive Requirements

### Functional Requirements
- Core features needed
- User interactions
- Data flow

### Non-Functional Requirements
- Performance targets
- Security considerations
- Scalability needs
- Maintainability

### Edge Cases
- Error scenarios
- Boundary conditions
- Validation rules
- Race conditions

### Testing Requirements
- Unit test scenarios
- Integration test cases
- E2E test flows
- Performance benchmarks

## 5. Output Format (Full Template)

```markdown
## 상세 요구사항

### Goal
[한 문장 요약 - 비즈니스 가치 명시]

### Requirements
1. [기능 요구사항 1]
2. [기능 요구사항 2]
3. [기능 요구사항 3]
...

### Tech Spec
- **Framework**: [감지된 프레임워크]
- **Files to modify**: [파일 경로]
- **Dependencies**: [필요한 라이브러리]
- **Database changes**: [스키마 변경 사항]

### Edge Cases
- [예외 상황 1]: [처리 방법]
- [예외 상황 2]: [처리 방법]
- [예외 상황 3]: [처리 방법]

### Testing
- **Unit tests**: [테스트 케이스 1, 2, 3]
- **Integration tests**: [테스트 시나리오]
- **E2E tests**: [사용자 플로우]

### Security Considerations
- [보안 체크포인트 1]
- [보안 체크포인트 2]

### Performance Targets
- [성능 목표 1]
- [성능 목표 2]

---
실행|수정|취소
```

## Rules
- Parse options FIRST before analysis
- Auto-detect compact mode based on word count (토큰 절약)
- Always analyze project context via Glob/Grep
- Derive comprehensive requirements (기능/비기능/예외/테스트)
- Include security and performance considerations
- Respond in Korean
- **Token optimization**: Follow output efficiency guidelines below

### Token Optimization Rules

1. **출력 효율성**
   - **diff-only**: 변경 부분만 표시, 전체 파일 재출력 금지
   - **참조 형식**: 코드 중복 대신 `파일명:라인번호` 형식 사용
   - **반복 축약**: 반복 패턴은 "... (N개 더)" 형태로 축약
   - **코드 우선**: 실행 가능한 코드 > 긴 설명
   - **최소 주석**: 복잡한 로직에만, 자명한 코드는 주석 불필요

2. **중복 방지**
   - 사용자 입력을 그대로 반복하지 않기
   - 이미 말한 내용 재설명 금지
   - 요청 없으면 전체 파일 내용 표시 금지
   - 대용량 출력은 요약 사용

3. **구조화된 출력**
   - 마크다운 섹션으로 구조화
   - 목록은 단락 대신 불릿 포인트
   - 비교는 테이블 사용
   - 간결한 설명 (섹션당 3-5문장)

4. **컨텍스트 관리**
   - 직접 관련된 파일만 읽기
   - Grep/Glob 효율적 사용 (구체적 패턴)
   - 불필요한 탐색 금지
   - 이전에 읽은 정보 재사용

5. **응답 길이**
   - 간결한 설명 (섹션당 3-5문장)
   - 이론보다 예시
   - 복잡한 작업은 단계별
   - 추측 대신 명확화 질문

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /super
모델: [haiku|sonnet|opus]
모드: [ultra-compact|compact|full]
단어 수: [WORD_COUNT]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
