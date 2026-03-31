---
allowed-tools: Bash, Read, Write, Edit, Grep
description: Git 커밋 기반으로 CHANGELOG.md 자동 생성 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /changelog 사용 가이드

용도: Git 커밋 기반으로 CHANGELOG.md 자동 생성

사용법:
  /changelog                      # 전체 히스토리로 CHANGELOG 생성
  /changelog --since <tag>        # 특정 태그 이후부터
  /changelog --unreleased         # Unreleased 섹션만
  /changelog --bump               # 버전 자동 증가
  /changelog --format <type>      # 포맷 선택 (keepachangelog|conventional)

지원 커밋 컨벤션:
  feat:     새로운 기능
  fix:      버그 수정
  docs:     문서 변경
  style:    코드 스타일 (포맷팅, 세미콜론 등)
  refactor: 리팩토링
  perf:     성능 개선
  test:     테스트 추가/수정
  chore:    빌드/프로세스/도구 변경

옵션:
  --since <tag|date>    시작 지점 (태그 또는 날짜)
  --until <tag|date>    종료 지점
  --unreleased          아직 릴리즈되지 않은 커밋만
  --bump <major|minor|patch>  버전 증가
  --format <type>       CHANGELOG 포맷
  --output <file>       출력 파일 (기본: CHANGELOG.md)
  --help                이 도움말 표시

예시:
  /changelog                      # 전체 히스토리
  /changelog --since v1.0.0       # v1.0.0 이후
  /changelog --unreleased         # 릴리즈 대기 중
  /changelog --bump patch         # 버전 패치 증가

언제 사용:
  ✅ 릴리즈 전 변경 사항 정리
  ✅ 버전 관리 자동화
  ✅ 오픈소스 프로젝트 문서화

워크플로우:
  Git 로그 수집 → 커밋 파싱 → 카테고리 분류 → CHANGELOG 생성
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--since <tag|date>`: Start point
- `--until <tag|date>`: End point
- `--unreleased`: Only unreleased commits
- `--bump <major|minor|patch>`: Version bump
- `--format <keepachangelog|conventional>`: Format style
- `--output <file>`: Output file path

## 2. Git Log Collection

Get commit history:

```bash
# Get commits since last tag
git describe --tags --abbrev=0 2>/dev/null || echo "HEAD~10"

# Get log
git log --pretty=format:"%H|%s|%an|%ad" --date=short [range]
```

## 3. Commit Parsing

Parse conventional commits:

Pattern: `^(type)(?:\((scope\))?: (.+))`

Types:
- `feat:` → Added
- `fix:` → Fixed
- `docs:` → Documentation
- `style:` → Style
- `refactor:` → Changed
- `perf:` → Performance
- `test:` → Tests
- `chore:` → Chore
- `build:` → Build
- `ci:` → CI

## 4. Generate CHANGELOG

### Keep a Changelog Format (Default)

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- New feature from feat: commits

### Fixed
- Bug fix from fix: commits

### Changed
- Refactoring from refactor: commits

### Deprecated
- ...

### Removed
- ...

### Security
- ...

## [1.2.0] - 2025-03-31

### Added
- ...

### Fixed
- ...
```

### Conventional Changelog Format

```markdown
# CHANGELOG

<a name="1.2.0"></a>
## 1.2.0 (2025-03-31)


### Features
* **scope:** description ([hash](url))

### Bug Fixes
* description ([hash](url))

### Performance Improvements
* description ([hash](url))
```

## 5. Version Bumping

With `--bump` flag:

1. Detect current version:
   - From git tags (latest)
   - From package.json
   - From pyproject.toml
   - Default: 0.1.0

2. Increment based on type:
   - `major`: 1.2.3 → 2.0.0
   - `minor`: 1.2.3 → 1.3.0
   - `patch`: 1.2.3 → 1.2.4

3. Auto-detect bump type from commits:
   - `feat!` or `BREAKING CHANGE` → major
   - `feat:` → minor
   - `fix:` → patch

## 6. Output

```
📝 CHANGELOG.md 생성 완료

요약:
  커밋 수: 42
  기간: 2025-03-15 ~ 2025-03-31

변경 사항:
  ✨ Added: 8
  🐛 Fixed: 12
  📝 Documentation: 3
  ♻️  Changed: 5
  ⚡ Performance: 2

버전: 1.3.0 (minor bump)

파일: CHANGELOG.md
```

## 7. Integration with Version Tags

```bash
# After generating changelog
git tag -a v1.3.0 -m "Release v1.3.0"

# Or with auto-commit
git add CHANGELOG.md
git commit -m "docs: update CHANGELOG for v1.3.0"
```

## Rules

- Parse conventional commits correctly
- Group by type (Added, Fixed, Changed, etc.)
- Preserve existing CHANGELOG content
- Use ISO date format (YYYY-MM-DD)
- Support both Korean and English
- Link commits if git remote available

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /changelog
커밋 범위: [since] ~ [until]
버전: [version]
파일: CHANGELOG.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
