---
allowed-tools: Bash, Grep, Glob, Read
description: 보안 취약점 스캔 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /audit 사용 가이드

용도: 보안 취약점 스캔

사용법:
  /audit                         # 전체 스캔
  /audit --deps                  # 의존성 취약점만
  /audit --secrets               # 시크릿 노출만
  /audit --license               # 라이선스 검사
  /audit --fix                   # 자동 수정 (가능한 경우)

지원 도구:
  npm/yarn/pnpm      npm audit, yarn audit
  Python             pip-audit, safety
  Go                 go vet, govulncheck
  Docker             trivy
  Container          grype
  General            gitleaks (secrets)

옵션:
  --deps              의존성 취약점만
  --secrets           시크릿/민감 정보만
  --license           라이선스 검사
  --docker            Docker 이미지 스캔
  --fix               자동 수정 (가능한 경우)
  --help              이 도움말 표시

예시:
  /audit                         # 전체 스캔
  /audit --deps                  # 의존성만
  /audit --secrets               # 시크릿만
  /audit --fix                   # 자동 수정

언제 사용:
  ✅ PR 생성 전 보안 검사
  ✅ 외부 라이브러리 추가 후
  ✅ 운영 환경 배포 전
  ✅ 정기 보안 점검

워크플로우:
  프로젝트 감지 → 도구 선택 → 스캔 → 결과 정리
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--deps`: Dependencies only
- `--secrets`: Secrets/credentials only
- `--license`: License compliance
- `--docker`: Docker image scan
- `--fix`: Auto-fix vulnerabilities

## 2. Project Detection & Tool Selection

```bash
# Node.js
if [ -f "package.json" ]; then
    npm audit      # or yarn audit, pnpm audit
fi

# Python
if [ -f "requirements.txt" ]; then
    pip-audit      # or safety check
fi

# Go
if [ -f "go.mod" ]; then
    go vulncheck ./...
    go vet ./...
fi

# Docker
if [ -f "Dockerfile" ]; then
    trivy image .
fi
```

## 3. Scan Types

### Dependency Vulnerabilities
```bash
# Node.js
npm audit --json
npm audit fix     # with --fix flag

# Python
pip-audit --format json
safety check --json

# Go
go vulncheck ./...
```

### Secrets Scanning
```bash
# gitleaks - find secrets in git history
gitleaks detect --source . --verbose

# truffleHog (alternative)
trufflehog --regex --entropy=false /path/to/repo
```

### License Compliance
```bash
# Node.js
npx license-checker --production

# Python
pip-licenses
```

### Container Scanning
```bash
# Trivy (multi-purpose)
trivy image your-image:tag
trivy fs .              # filesystem scan
```

## 4. Severity Classification

```
CRITICAL  🔴 즉시 수정 필요
HIGH      🟠 조속 수정 권장
MEDIUM    🟡 계획적 수정
LOW       🟢 확인 필요
```

## 5. Output Format

```
🔒 보안 감사 결과

=== 의존성 취약점 ===

🔴 CRITICAL (2)
  lodash < 4.17.21 - Prototype Pollution
  express < 4.18.2 - DoS

🟠 HIGH (5)
  axios < 0.25.0 - SSRF
  ...

=== 시크릿 노출 ===

🟡 WARNING (3)
  .env:3 - potential API key
  config.py:45 - hardcoded password

=== 라이선스 ===

⚠️  Non-compliant (2)
  GPL-3.0 - copyleft license detected

📊 요약:
  CRITICAL: 2 | HIGH: 5 | MEDIUM: 12 | LOW: 8

🔧 수정 방법:
  npm audit fix    # 자동 수정
  npm audit fix --force  # 모든 취약점 수정 (주의)
```

## 6. Auto-Fix Mode

With `--fix` flag:
```bash
# Node.js - automatic fix
npm audit fix

# Python - manual steps required
pip install --upgrade <package>

# Go - update dependencies
go get -u ./...
```

## Rules

- Detect project type FIRST
- Use most appropriate scanner
- Show severity classification
- Recommend fix steps
- Don't auto-fix without `--fix` flag
- Support both Korean and English

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /audit
스캔 유형: [deps|secrets|license|docker|all]
취약점: [X] critical, [X] high, [X] medium, [X] low
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
