---
allowed-tools: Read, Write, Edit, Bash(ls:*), Bash(find:*)
description: Add token optimization rules to project CLAUDE.md (user)
---

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /smart-brain 사용 가이드

용도: 프로젝트의 CLAUDE.md에 토큰 최적화 규칙 추가

사용법:
  /smart-brain                     # 현재 디렉토리에 적용

옵션:
  --help           이 도움말 표시

예시:
  cd my-project
  /smart-brain

언제 사용:
  ✅ 새 프로젝트 시작 시
  ✅ 토큰 사용량이 많을 때
  ✅ 팀 협업 시 규칙 통일 필요

워크플로우:
  CLAUDE.md 탐색 → 기존 규칙 확인 → 토큰 최적화 섹션 추가 → 완료

효과:
  - diff-only 출력 강제
  - 코드 재출력 방지
  - 불필요한 설명 제거
  - 예상 절감: 20-40% per session
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Find CLAUDE.md

Check for existing CLAUDE.md in current directory:
- `CLAUDE.md` (standard)
- `.claude.md` (hidden)
- `claude.md` (lowercase)

If none exist, create `CLAUDE.md`.

## 2. Check Existing Content

Read file and check if token optimization section exists:
- Search for "토큰 절약" or "Token" or "💾"
- If found → ask: "Token optimization section already exists. Overwrite?"

## 3. Add/Update Section

Append or update with:

```markdown
⸻

## 💾 토큰 절약 규칙

### 출력 최적화
- **diff-only**: 변경 부분만 출력 (전체 파일 재출력 금지)
- **참조 우선**: 코드 재출력 대신 `파일명:라인번호` 형식 사용
- **중복 축약**: 반복 패턴은 "... (N more similar)" 형태로 축약

### 코드 우선주의
- 긴 설명 대신 **실행 가능한 코드** 우선
- 주석은 복잡한 로직에만 최소화
- 문서는 README/docs에 분리 (코드 파일 내 X)

### 재작업 방지
한번에 정확한 구현으로 수정 왕복 최소화:
- [ ] 보안 체크 (injection, hardcoded secrets)
- [ ] 에러 처리 (edge cases, null safety)
- [ ] 성능 검토 (N+1 쿼리, 무한 루프)
- [ ] 타입 안전성 (TypeScript strict, Python type hints)

### 금지 패턴
- ❌ 요청 없는 기능 추가/삭제
- ❌ 과도한 console.log/print (디버깅 후 제거)
- ❌ 미사용 import/변수 (린터 경고 방치)
- ❌ "개선 제안" 섹션 (요청 시에만)

⸻
```

## 4. Confirm

Output:
```
✅ Token optimization rules added to CLAUDE.md

Rules applied:
- diff-only output
- Reference over duplication
- Code over explanation
- One-shot implementation

Estimated token savings: 20-40% per session
```

## Rules
- Detect Korean/English context and use appropriate language for confirmation
- Never overwrite entire file, only append/update section
- Preserve existing CLAUDE.md content

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /smart-brain
모델: [current model]
사용 에이전트: [none]
호출 스킬: [none]
처리 파일: [CLAUDE.md path]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
