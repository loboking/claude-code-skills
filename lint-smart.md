---
allowed-tools: Bash, Grep, Glob, Read
description: 프로젝트 자동 감지 후 적절한 린터 실행 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /lint-smart 사용 가이드

용도: 프로젝트 자동 감지 후 적절한 린터 실행

사용법:
  /lint-smart                     # 현재 프로젝트 자동 감지 후 린터 실행
  /lint-smart --fix              # 문제 자동 수정
  /lint-smart --check            # 수정 없이 검사만
  /lint-smart --file <path>      # 특정 파일만 린트

지원 언어/프레임워크:
  JavaScript/TypeScript  eslint, tslint
  Python                  flake8, pylint, mypy, ruff
  Go                      golangci-lint, gofmt, go vet
  Java                    checkstyle, pmd
  Ruby                    rubocop
  Rust                    clippy
  PHP                     phpcs, phpstan

옵션:
  --fix              문제 자동 수정 (가능한 경우)
  --check            수정 없이 검사만
  --file <path>      특정 파일/디렉토리만 대상
  --config <path>    설정 파일 직접 지정
  --help             이 도움말 표시

예시:
  /lint-smart                     # 전체 프로젝트 린트
  /lint-smart --fix              # 문제 수정까지
  /lint-smart --file src/main.ts # 특정 파일만
  /lint-smart --check            # CI 환경용

언제 사용:
  ✅ PR 생성 전 코드 품질 확인
  ✅ 로컬 개발 중 실시간 피드백
  ✅ 팀 코딩 스타일 통일

워크플로우:
  프로젝트 감지 → 린터 선택 → 실행 → 결과 정리
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--fix`: Enable auto-fix
- `--check`: Check only (no modifications)
- `--file <path>`: Target specific file/directory
- `--config <path>`: Use specific config file

## 2. Project Detection

Use Glob to detect project type:

```python
# Check in order of specificity
- package.json → Node.js/TypeScript
  - "eslintConfig" or .eslintrc* → eslint
  - "tslint" → tslint

- requirements.txt, setup.py, pyproject.toml → Python
  - .flake8, setup.cfg (flake8 section) → flake8
  - .pylintrc → pylint
  - mypy.ini → mypy

- go.mod → Go
  - .golangci.yml → golangci-lint

- pom.xml, build.gradle → Java
  - checkstyle config → checkstyle

- Gemfile → Ruby
  - .rubocop.yml → rubocop

- Cargo.toml → Rust
  - clippy → rustc clippy

- composer.json → PHP
  - phpcs.xml → phpcs
```

## 3. Linter Selection & Execution

### JavaScript/TypeScript (eslint)
```bash
npx eslint --format=stylish [target]
# With fix: --fix
```

### Python (flake8 - fast, ruff - faster)
```bash
flake8 --max-line-length=100 [target]
# Or ruff check [target]
```

### Go (golangci-lint)
```bash
golangci-lint run [target]
# Or: go vet ./...
```

### Java (checkstyle)
```bash
mvn checkstyle:check
```

### Ruby (rubocop)
```bash
bundle exec rubocop [target]
```

### Rust (clippy)
```bash
cargo clippy -- -D warnings
```

### PHP (phpcs)
```bash
vendor/bin/phpcs --standard=PSR12 [target]
```

## 4. Fallback Strategy

If no project-specific linter found:
1. Try generic linters:
   - `eslint` for any .js/.ts files
   - `flake8` for any .py files
   - `gofmt` for any .go files

2. If no linter installed:
   ```
   ⚠️ No linter found. Install recommendation:
   - Node.js: npm install -D eslint
   - Python: pip install flake8
   - Go: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
   ```

## 5. Output Format

```bash
# Success
✅ Lint passed: No issues found

# Issues found
⚠️ Lint found 12 issues

[filename]:[line]:[column]: [error|warning]: [message]
  [code context if available]

Summary:
  Errors: 2
  Warnings: 10
  Files: 5

Auto-fix available: Run /lint-smart --fix
```

## 6. Auto-Fix Mode

With `--fix` flag:
1. Run linter with auto-fix option
2. Show fixed issues count
3. List remaining issues (if any)
4. Report modified files

```
🔧 Auto-fixing issues...

Fixed: 8 issues
Remaining: 4 issues (manual fix required)

Modified files:
  - src/main.ts
  - utils/helper.ts

Remaining issues:
  [file]:[line]: [reason requiring manual fix]
```

## Rules

- Detect project type FIRST
- Use most specific linter for project
- Respect existing config files
- Don't auto-fix without `--fix` flag
- Show clear, actionable error messages
- Support both Korean and English output

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /lint-smart
프로젝트 타입: [detected type]
린터: [linter name]
문제 수: [errors] errors, [warnings] warnings
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
