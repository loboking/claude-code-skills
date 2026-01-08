# Token Optimization Template

**목적**: 모든 monggle 스킬에 적용할 표준 토큰 최적화 규칙

---

## 사용 방법

1. 스킬 `.md` 파일의 `Rules` 섹션에 아래 내용 추가
2. 또는 별도의 `## Token Optimization` 섹션 생성

---

## 복사할 템플릿

### Rules 섹션에 추가

```markdown
## Rules
- [기존 규칙들...]
- **Token optimization**: Follow output efficiency guidelines below

### Token Optimization Rules

1. **Output Efficiency**
   - **diff-only**: Show only changed parts, not entire files
   - **Reference format**: Use `filename:line_number` instead of code duplication
   - **Abbreviate repetition**: Use "... (N more similar)" for patterns
   - **Code-first**: Executable code > lengthy explanations
   - **Minimal comments**: Only for complex logic, not obvious code

2. **Avoid Redundancy**
   - Don't repeat user input verbatim
   - Don't re-explain what was already said
   - Don't show full file contents unless requested
   - Use summaries for large outputs

3. **Structured Output**
   - Use markdown sections for organization
   - Bullet points > paragraphs for lists
   - Tables for comparisons
   - Code blocks with syntax highlighting

4. **Context Management**
   - Only read files that are directly relevant
   - Use Grep/Glob efficiently (specific patterns)
   - Don't explore unnecessarily
   - Reuse previously read information

5. **Response Length**
   - Concise explanations (3-5 sentences per section)
   - Examples over theory
   - Step-by-step for complex tasks
   - Ask for clarification instead of guessing
```

---

## 한글 버전 (Korean Version)

```markdown
## Rules
- [기존 규칙들...]
- **토큰 최적화**: 아래 출력 효율성 가이드라인 준수

### 토큰 최적화 규칙

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
   - 코드 블록에 문법 강조

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
```

---

## 출력 예시 (Before/After)

### ❌ Before (Token Wasteful)

```markdown
사용자님께서 요청하신 로그인 기능을 구현하기 위해서는 다음과 같은 단계들이 필요합니다.

첫 번째로, 사용자 인증을 처리하는 컴포넌트를 만들어야 합니다. 이 컴포넌트는 이메일과 비밀번호를 입력받아서 서버로 전송하고, 서버에서 인증 결과를 받아와서 처리합니다.

두 번째로, 서버측 API 엔드포인트를 구현해야 합니다. 이 엔드포인트는 클라이언트로부터 받은 이메일과 비밀번호를 검증하고, 유효한 경우 JWT 토큰을 발급합니다.

세 번째로... [계속 장황한 설명]

전체 파일 내용:
```javascript
// src/components/Login.tsx (전체 200줄)
import React from 'react';
import { useState } from 'react';
// ... 전체 파일 출력
```

이렇게 구현하면 됩니다. 혹시 더 궁금하신 점이 있으시면 말씀해주세요.
```

### ✅ After (Token Optimized)

```markdown
## 구현 계획

1. 클라이언트: src/components/Login.tsx
2. 서버: src/api/auth.ts
3. 타입: src/types/auth.ts

## 주요 변경

**src/components/Login.tsx:15-30**
```diff
+ const handleLogin = async (email, password) => {
+   const token = await authAPI.login(email, password);
+   localStorage.setItem('token', token);
+ }
```

**src/api/auth.ts** (신규)
```typescript
export const login = async (email, password) => {
  // JWT 토큰 반환
}
```

## 테스트
- 정상 로그인: ✅
- 잘못된 비밀번호: 에러 메시지 확인
```

---

## 적용 체크리스트

새 스킬 작성 시:
- [ ] Rules 섹션에 토큰 최적화 규칙 추가
- [ ] 출력 예시는 간결하게 (전체 파일 금지)
- [ ] 반복 패턴은 축약
- [ ] 참조 형식 사용 (파일명:라인번호)
- [ ] 코드 우선, 설명 최소화

---

## 예상 효과

- **Before**: 1500-2000 토큰/응답
- **After**: 500-800 토큰/응답
- **절감율**: 약 60% 토큰 절약
- **세션당**: 20-40% 전체 토큰 절약

---

## 참고: /smart-brain 스킬

기존 `/smart-brain` 스킬이 프로젝트별 CLAUDE.md에 이 규칙을 자동 추가합니다.
새 스킬은 이 규칙을 기본적으로 따라야 합니다.
