---
allowed-tools: Bash, Grep, Glob, Read, Edit, Write
description: 버전 업 + 태그 생성 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /bump 사용 가이드

용도: 버전 자동 증가 및 태그 생성

사용법:
  /bump                         # 자동 증가 (Git 커밋 기반)
  /bump major                   # 메이저 버전 (1.0.0 → 2.0.0)
  /bump minor                   # 마이너 버전 (1.0.0 → 1.1.0)
  /bump patch                   # 패치 버전 (1.0.0 → 1.0.1)
  /bump --pre <id>              # 프리릴리즈 (1.0.0 → 1.0.1-rc.1)

지원 파일:
  package.json       Node.js
  pyproject.toml      Python (PEP 621)
  Cargo.toml         Rust
  composer.json      PHP
  go.mod             Go (indirect)

옵션:
  major              메이저 버전 증가 (호환 불가)
  minor              마이너 버전 증가 (기능 추가)
  patch              패치 버전 증가 (버그 수정)
  --pre <id>         프리릴리즈 (alpha, beta, rc)
  --no-tag           태그 생성 스킵
  --push             태그 푸시까지

예시:
  /bump                         # 자동 감지
  /bump patch                   # 패치 증가
  /bump minor --push            # 마이너 + 푸시

언제 사용:
  ✅ 릴리즈 준비 완료 시
  ✅ CHANGELOG 작성 후
  ✅ 배포 직전

워크플로우:
  현재 버전 감지 → 증가 타입 결정 → 파일 업데이트 → 태그 생성 → Git 커밋
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- Version type: `major`, `minor`, `patch` (or auto-detect)
- Pre-release: `--pre <id>` (alpha, beta, rc)
- Flags: `--no-tag`, `--push`

## 2. Detect Current Version

```python
# Priority order
1. git tag (latest)
2. package.json (version)
3. pyproject.toml (project.version)
4. Cargo.toml (version)
5. composer.json (version)
6. Default: 0.1.0
```

## 3. Auto-Detect Bump Type

From recent commits (conventional commits):

```bash
# Check commit messages since last tag
git log $(git describe --tags --abbrev=0)..HEAD --oneline

# Bump rules:
!  → breaking change: major
feat! → major
feat  → minor
fix   → patch
chore → patch (default)
```

## 4. Update Version Files

### package.json (Node.js)
```json
{
  "version": "1.2.3"
}
```

### pyproject.toml (Python)
```toml
[project]
name = "myproject"
version = "1.2.3"
```

### Cargo.toml (Rust)
```toml
[package]
name = "myproject"
version = "1.2.3"
```

### composer.json (PHP)
```json
{
  "version": "1.2.3"
}
```

## 5. Create Git Tag

```bash
# Annotated tag
git tag -a v1.2.3 -m "Release v1.2.3

- Add new feature X
- Fix bug Y
- Update dependencies"

# Lightweight tag
git tag v1.2.3
```

## 6. Commit & Push (Optional)

```bash
# Commit version file changes
git add package.json
git commit -m "chore: bump version to 1.2.3"

# Push tag
git push origin main --tags
```

## 7. Pre-release Support

```bash
# Pre-release identifiers
/bump --pre alpha   # 1.0.0 → 1.0.1-alpha.0
/bump --pre beta    # 1.0.0 → 1.0.1-beta.0
/bump --pre rc      # 1.0.0 → 1.0.1-rc.0

# Build metadata
/bump --pre rc --build 20250331
```

## 8. Output

```
🔖 버전 업그레이드

현재 버전: 1.2.0
새로운 버전: 1.3.0 (minor)

변경 사유:
- feat: add user authentication (8 commits ago)
- feat: implement OAuth login (5 commits ago)

업데이트 파일:
  ✅ package.json: 1.2.0 → 1.3.0

생성된 태그:
  🏷️  v1.3.0

다음 단계:
  1. CHANGELOG.md 업데이트: /changelog
  2. GitHub Release 생성
  3. 배포 실행
```

## Rules

- Detect current version from multiple sources
- Auto-detect bump type from commits
- Update all version files found
- Create annotated Git tag
- Support pre-release versions
- Don't push without `--push` flag
- Support both Korean and English

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /bump
이전 버전: [X.Y.Z]
새 버전: [X.Y.Z]
증가 타입: [major|minor|patch|pre]
태그: [tag-name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
