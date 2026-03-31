---
allowed-tools: Bash, Grep, Glob, Read, Edit, Write
description: README 동기화 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /readme-sync 사용 가이드

용도: 코드 변경 → README 최신화

사용법:
  /readme-sync                  # 자동 감지 후 동기화
  /readme-sync --check           # 동기화 필요 여부만 확인
  /readme-sync --sections <sec>  # 특정 섹션만

동기화 항목:
  Installation   설치 명령어 업데이트
  Usage          사용 예시 업데이트
  API            API 문서 섹션 업데이트
  Dependencies   의존성 목록 업데이트
  Configuration  설정 변수 업데이트

옵션:
  --check            동기화 필요 여부만 확인
  --sections <s>     특정 섹션만 (콤마 구분)
  --dry-run          변경 사항만 보여주기
  --help             이 도움말 표시

예시:
  /readme-sync                  # 전체 동기화
  /readme-sync --check           # 확인만
  /readme-sync --dry-run         # 미리보기

언제 사용:
  ✅ 공개 API 변경 후
  ✅ 새로운 의존성 추가 후
  ✅ CLI 인터페이스 변경 후
  ✅ README 최신화 필요 시

워크플로우:
  코드 분석 → README 읽기 → 비교 → 업데이트 제안
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--check`: Check only, no modifications
- `--sections <s>`: Specific sections (comma-separated)
- `--dry-run`: Show changes only

## 2. Code Analysis

Analyze project to detect changes:

```bash
# Package.json changes
if [ -f "package.json" ]; then
    # Extract scripts, dependencies, version
fi

# Requirements.txt changes
if [ -f "requirements.txt" ]; then
    # Extract dependencies
fi

# CLI interface changes
grep -r "argparse\|click\|commander\|yargs" --include="*.py" .
```

## 3. README Sections to Sync

### Installation
```markdown
## Installation

```bash
npm install my-package
# or
pip install my-package
```
```

### Usage
```markdown
## Usage

```javascript
const pkg = require('my-package');
pkg.doSomething();
```
```

### API Reference
```markdown
## API

### `pkg.doSomething(input)`
Does something.

**Parameters:**
- `input` (string): The input

**Returns:** Promise<void>
```

### Dependencies
```markdown
## Dependencies

- Node.js >= 18
- redis >= 6.0
```

### Configuration
```markdown
## Configuration

| Key | Description |
|-----|-------------|
| API_KEY | API key for service |
```

## 4. Detection Logic

```python
# Detect new dependencies
old_deps = extract_from_readme("Dependencies")
new_deps = extract_from_code("package.json")
diff = compare(old_deps, new_deps)

# Detect new CLI commands
old_commands = extract_from_readme("Usage")
new_commands = extract_from_code("cli.py", "main.js")
diff = compare(old_commands, new_commands)
```

## 5. Sync Modes

### Check Mode (--check)
```
📋 README 동기화 확인

✅ Installation: 최신 상태
❌ Usage: 업데이트 필요
  - 새로운 함수: processFile()
  - 삭제된 함수: oldFunc()

✅ API: 최신 상태
❌ Dependencies: 업데이트 필요
  - 추가: redis@7.0
  - 삭제: lodash@3.0

📊 요약: 2개 섹션 업데이트 필요
```

### Dry-Run Mode (--dry-run)
```
🔄 README 동기화 미리보기

--- Changes: Usage ---

@@ -12,6 +12,8 @@
 const pkg = require('my-package');
-pkg.doThing();
+pkg.doSomething(data);
+pkg.processFile(path);

--- Changes: Dependencies ---

@@ -5,4 +5,5 @@
- redis@6.0
+ redis@7.0
```

## 6. Auto-Update Sections

```bash
# Check if README exists
if [ ! -f "README.md" ]; then
    echo "README.md not found"
    exit 1
fi

# Extract current README sections
extract_section("Installation") > /tmp/install.md
extract_section("Usage") > /tmp/usage.md

# Update with new content
update_section("Dependencies" "$new_deps")
```

## 7. Smart Detection

Detect what changed:
```bash
# Git diff to find changed files
changed=$(git diff --name-only HEAD~1 HEAD)

# If package.json changed → update Installation & Dependencies
# If src/cli.js changed → update Usage
# If src/api/* changed → update API
```

## 8. Output

```
📝 README 동기화 완료

업데이트된 섹션:
  ✅ Dependencies
  ✅ Usage

변경 사항:
  + redis@7.0 added
  + processFile() added
  - oldFunc() removed

파일: README.md
준비 상태: 커밋 제안됨

git add README.md
git commit -m "docs: update README with new API"
```

## Rules

- Check if README.md exists FIRST
- Detect changes from git diff
- Update specific sections only
- Preserve README structure
- Don't modify without confirmation
- Support both Korean and English
- Create git commit with changes

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /readme-sync
README: README.md
업데이트 섹션: [sections]
변경 수: [N] sections
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
