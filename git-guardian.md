---
allowed-tools: Read, Bash, Grep, Glob
description: 안전한 Git 워크플로우 자동화 - Secrets 스캔 + 구조화된 커밋 메시지
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
🛡️ /git-guardian 사용 가이드

용도: 안전하고 체계적인 Git 커밋 워크플로우

사용법:
  /git-guardian                # 기본 (3단계 승인)
  /git-guardian --auto         # 자동 승인 (위험 인지 시만)
  /git-guardian --dry          # 시뮬레이션만 (실제 커밋 X)
  /git-guardian --no-secrets   # Secrets 스캔 건너뛰기 (비추천)

기능:
  ✅ 구조화된 커밋 메시지 자동 생성
  ✅ Secrets 자동 스캔 (API키, 비밀번호)
  ✅ 3단계 승인 프로세스 (Stage → Commit → Push)
  ✅ 기능별 파일 그룹핑
  ✅ Force push 차단

커밋 메시지 형식:
  제목: [간결한 변경 요약 - 50자 이내]
  상태: [add|fix|error|del]
  설명: [변경 이유와 목적]
  변경된 파일: [기능별 그룹핑]

상태 자동 추론:
  add     새로운 기능/파일 추가
  fix     버그 수정, 기존 기능 개선
  error   에러 처리 개선
  del     코드/기능 제거

안전장치:
  🚫 Force push 절대 금지
  ⚠️ main/master 직접 push 경고
  ⚠️ 10개+ 파일 동시 커밋 경고
  🛑 Secrets 발견 시 자동 중단

예시:
  /git-guardian               # 전체 워크플로우
  /git-guardian --auto        # 개인 프로젝트용 빠른 커밋
  /git-guardian --dry         # 커밋 메시지 미리보기

언제 사용:
  ✅ 프로덕션 코드 푸시
  ✅ 팀 협업 프로젝트
  ✅ 민감 정보 커밋 방지
  ✅ 체계적인 커밋 메시지

빠른 커밋이 필요하면:
  ❌ /commit 사용 (기존 스킬)

워크플로우:
  변경 분석 → Secrets 스캔 → 상태 추론 →
  파일 그룹핑 → 커밋 메시지 생성 → 3단계 승인
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- `--auto` - 자동 승인 (Secrets 스캔은 유지)
- `--dry` - 시뮬레이션만
- `--no-secrets` - Secrets 스캔 건너뛰기

## 2. Phase 1: 변경 분석

```bash
git status --short
git diff --numstat HEAD
git diff --cached --name-only
```

Output:
```markdown
## 변경 분석 결과

**총 변경 파일**: N개
**추가 라인**: +N
**삭제 라인**: -N

**파일 목록**:
- M  src/api/auth.ts (+145, -12)
- A  src/components/LoginForm.tsx (+89, -0)
...
```

## 3. Phase 2: Secrets 스캔

**스캔 패턴:**
```
\.env$, \.pem$, \.key$
API[_-]?KEY, SECRET[_-]?KEY
password\s*=, token\s*[:=]
[0-9a-f]{32,} (32자+ hex)
sk_live_[a-zA-Z0-9]+ (Stripe)
ghp_[a-zA-Z0-9]+ (GitHub)
```

**발견 시:**
```markdown
❌ **Secrets 발견!**

파일: src/config.ts:15
패턴: API_KEY = "sk_live_abc123..."

**조치 필요:**
1. 해당 라인 제거
2. .env 파일로 이동
3. .gitignore에 .env 추가
4. git reset HEAD src/config.ts

**중단합니다.**
```

## 4. Phase 3: 상태 자동 추론

| 상태 | 설명 | 조건 |
|------|------|------|
| add | 새 기능/파일 | 새 파일 생성 (A) |
| fix | 버그 수정 | 기존 파일 수정 (M), "fix" 키워드 |
| error | 에러 처리 | try-catch 추가 |
| del | 코드 제거 | 파일 삭제 (D) |

## 5. Phase 4: 기능별 파일 그룹핑

| 카테고리 | 패턴 |
|----------|------|
| API Layer | src/api/, src/services/ |
| UI Components | src/components/, src/views/ |
| Utilities | src/utils/, src/helpers/ |
| State Management | src/store/, src/redux/ |
| Tests | tests/, __tests__/, *.test.* |
| Documentation | docs/, *.md |
| Configuration | *.config.*, package.json |
| Styles | *.css, *.scss, styles/ |

## 6. Phase 5: 커밋 메시지 생성

```markdown
제목: feat(auth): Add JWT authentication system

상태: add

설명:
JWT 기반 사용자 인증 시스템을 추가했습니다.
로그인/로그아웃 API 엔드포인트를 구현하고,
토큰 검증 미들웨어를 추가했습니다.

변경된 파일:

### API Layer
- src/api/auth.ts (+145, -12)
- src/api/middleware/verifyToken.ts (+58, -0)

### UI Components
- src/components/LoginForm.tsx (+89, -0)

### Tests
- tests/api/auth.test.ts (+120, -0)
```

## 7. Phase 6: 3단계 승인

### Step 1: Stage 승인
```
Stage all files? [Y/n]
```

### Step 2: Commit 승인
```
[메시지 표시]
Commit? [Y/e/n]
- Y: 승인
- E: 편집
- N: 취소
```

### Step 3: Push 승인
```
Push to origin/main? [y/N]
⚠️ main 브랜치 직접 push 경고
```

## 8. 안전장치

### 절대 금지
```bash
git push --force    # 차단
git push -f         # 차단
```

### 경고
- main/master 직접 push
- 10개+ 파일 동시 커밋
- 100줄+ 단일 파일 변경

### 자동 중단
- Secrets 패턴 발견
- .env, .pem, .key 파일 stage
- node_modules/ 포함

## 9. Rules

1. **Git 저장소 확인** 필수
2. **Secrets 스캔** 항상 수행 (--no-secrets 제외)
3. **Force push 차단** 무조건
4. **3단계 승인** (--auto 제외)
5. **구조화된 메시지** 자동 생성

## 10. Output Format

```markdown
## 🛡️ Git Guardian 보고서

### 실행 단계
- [✅] 변경 분석
- [✅] Secrets 스캔
- [✅] 상태 추론
- [✅] 파일 그룹핑
- [✅] 커밋 메시지 생성
- [✅] Stage 승인
- [✅] Commit 승인
- [✅] Push 승인

### 최종 결과
**커밋 ID**: abc1234
**브랜치**: main
**파일**: N개
**라인**: +N, -N

### 커밋 메시지
[생성된 커밋 메시지]

완료! 🎉
```

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /git-guardian
모델: sonnet
모드: [default|auto|dry]
Secrets 스캔: [yes|no]
커밋 상태: [add|fix|error|del]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
