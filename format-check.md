---
allowed-tools: Bash, Grep, Glob, Read
description: 코드 포맷 검사만 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /format-check 사용 가이드

용도: 코드 포맷 검사만 (수정 X)

사용법:
  /format-check                  # 전체 포맷 검사
  /format-check --fix            # 포맷 수정도 함께
  /format-check --file <path>    # 특정 파일만

지언어/도구:
  JavaScript/TypeScript  prettier, eslint --fix
  Python                 black, ruff format, yapf
  Go                     gofmt, goimports
  Java                   google-java-format
  Rust                   rustfmt
  PHP                    phpcbf
  C/C++                  clang-format

옵션:
  --fix              포맷 수정까지 실행
  --file <path>      특정 파일/디렉토리만
  --check           검사만 (기본값)
  --diff            diff만 표시

예시:
  /format-check                  # 검사만
  /format-check --fix            # 수정까지

언제 사용:
  ✅ PR 생성 전 코드 스타일 확인
  ✅ CI/CD 파이프라인
  ✅ 팀 코딩 스타일 점검

워크플로우:
  프로젝트 감지 → 포매터 선택 → 검사 → 결과 표시
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--fix`: Enable auto-format
- `--file <path>`: Target specific file/directory
- `--diff`: Show diff only

## 2. Project Detection & Tool Selection

```bash
# JavaScript/TypeScript
if [ -f "package.json" ]; then
    if grep -q "prettier" package.json; then
        npx prettier --check "$files"
    else
        npx eslint --check "$files"
    fi
fi

# Python
if [ -f "pyproject.toml" ]; then
    black --check "$files"       # or ruff format --check
fi

# Go
if [ -f "go.mod" ]; then
    gofmt -l "$files"            # -l = list files that need formatting
    goimports -l "$files"        # import organization
fi

# Rust
if [ -f "Cargo.toml" ]; then
    rustfmt --check "$files"
fi
```

## 3. Check Modes

### Check Only (Default)
```bash
# Return exit code if formatting needed
prettier --check "*.js" "*.ts"
black --check .
gofmt -l .

# Output format:
# - Exit 0: All files formatted
# - Exit 1: Some files need formatting
```

### With Diff
```bash
# Show what would change
prettier --check "**/*.js" --diff
black --check --diff .
gofmt -d .
```

### Fix Mode
```bash
# Actually format files
prettier --write "**/*.js"
black .
gofmt -w .
rustfmt .
```

## 4. Output Format

```
🎨 코드 포맷 검사

검사 대상: 15 files

✅ 포맷 정상 (12 files)
❌ 포맷 필요 (3 files):

  src/main.js
    Line 5: Indentation expected
    Line 12: Trailing comma

  utils/helper.py
    Line 8: E301 expected 1 blank line

  config.yaml
    Line 3: Inconsistent spacing

📊 요약:
  정상: 12
  수정 필요: 3
  비윬: 80% 포맷 준수

🔧 수정 방법:
  /format-check --fix
  또는 각 도구 직접 실행:
  npx prettier --write .
  black .
```

## 5. CI/CD Integration

```yaml
# GitHub Actions example
- name: Check code format
  run: |
    npx prettier --check "**/*.{js,ts}"
    black --check .

# Allow auto-fix in specific branches
- name: Format code
  if: github.ref == 'refs/heads/main'
  run: |
    npx prettier --write "**/*.{js,ts}"
    black .
```

## 6. Editor Integration

Most editors support format-on-save:
```json
// .vscode/settings.json
{
  "editor.formatOnSave": true,
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter"
  }
}
```

## Rules

- Detect project type FIRST
- Check existing config files (.prettierrc, pyproject.toml, etc.)
- Respect project-specific formatting rules
- Show clear diff for files needing format
- Don't modify files without `--fix` flag
- Support both Korean and English
- Return proper exit codes for CI

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /format-check
검사 파일: [N] files
정상: [X] | 수정 필요: [Y]
포맷터: [tool-name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
