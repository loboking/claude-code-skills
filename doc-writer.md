---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, LSP
description: 프로젝트 문서 자동 생성 (README, API docs, guides) (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /doc-writer 사용 가이드

용도: 프로젝트 문서 자동 생성 및 업데이트

사용법:
  /doc-writer readme              # README.md 생성/업데이트
  /doc-writer api                 # API 문서 생성
  /doc-writer guide               # 사용자 가이드 생성
  /doc-writer changelog           # CHANGELOG.md 생성
  /doc-writer all                 # 모든 문서 생성

  /doc-writer -h readme           # haiku 모델
  /doc-writer -s api              # sonnet 모델 (기본값)
  /doc-writer -o guide            # opus 모델

문서 타입:
  readme       프로젝트 소개, 설치, 사용법
  api          API 문서 (OpenAPI/Swagger 기반)
  guide        사용자 가이드/튜토리얼
  changelog    변경 이력
  contributing 기여 가이드
  all          위 모든 문서

옵션:
  -h, --haiku      빠른 실행 (간단한 문서)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 문서)
  --template <id>  특정 템플릿 사용
  --lang <ko|en>   언어 선택 (기본: auto)
  --help           이 도움말 표시

예시:
  /doc-writer readme              # 코드 분석 후 README 생성
  /doc-writer api --lang en       # 영문 API 문서
  /doc-writer -o guide            # 고품질 가이드 문서
  /doc-writer changelog           # Git 히스토리 기반 CHANGELOG

언제 사용:
  ✅ 프로젝트 시작 시 문서 뼈대 생성
  ✅ 코드 변경 후 문서 업데이트
  ✅ API 문서 자동 생성
  ✅ 오픈소스 릴리즈 준비

워크플로우:
  프로젝트 분석 → 템플릿 선택 → 문서 생성 → 검토|수정|저장
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default (sonnet)
- Template: `--template <id>`
- Language: `--lang <ko|en>` | auto-detect
- Doc type: readme | api | guide | changelog | contributing | all

## 2. Project Analysis

Use Glob/Grep to detect:
- **Project type**: package.json (Node), requirements.txt (Python), go.mod (Go), etc.
- **Framework**: React, Next.js, Flask, Spring Boot, etc.
- **API style**: REST, GraphQL, gRPC
- **Existing docs**: Check for README.md, docs/ folder

## 3. Template Selection

### README Template Structure
```markdown
# [Project Name]

[One-line description]

## Features
- [Key feature 1]
- [Key feature 2]

## Installation
[Step-by-step install guide]

## Usage
[Quick start examples]

## API Reference (if applicable)
[Link to API docs or inline examples]

## Configuration
[Environment variables, config files]

## Contributing
[Link to CONTRIBUTING.md]

## License
[License info]
```

### API Docs Template
- **OpenAPI/Swagger**: Parse existing spec or generate from code
- **REST**: Endpoint list with examples
- **GraphQL**: Schema + query examples

### User Guide Template
- Getting Started
- Core Concepts
- Step-by-step Tutorials
- Troubleshooting
- FAQ

### CHANGELOG Template
```markdown
# Changelog

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## [1.0.0] - 2025-01-08
...
```

## 4. Content Generation

For each doc type:
1. **Analyze code**: Use LSP, Grep, Read to understand project
2. **Extract info**:
   - Functions/classes (API docs)
   - Dependencies (Installation)
   - Entry points (Usage)
   - Git history (Changelog)
3. **Apply template**: Fill template with extracted info
4. **Add examples**: Include code snippets from project
5. **Validate**: Check for completeness

## 5. Language Detection

Auto-detect from:
- Existing docs language
- Code comments language
- Git commit messages
- User's `--lang` option

If uncertain, ask user.

## 6. Output

Present generated document:
```
## 생성된 문서: README.md

[Generated content preview - first 30 lines]

...

파일 위치: /path/to/README.md
변경사항:
- 신규 생성 / 기존 업데이트
- [섹션별 요약]

---
저장|수정|취소
```

On "저장":
- Write file (or update if exists)
- Backup existing file if present
- Report success

## 7. Special Features

### API Documentation from Code
```python
# Python example
def get_user(user_id: int) -> User:
    """
    Retrieve user by ID.

    Args:
        user_id: The user's unique identifier

    Returns:
        User object

    Raises:
        NotFoundError: If user doesn't exist
    """
    pass
```
→ Extract to OpenAPI spec or Markdown

### Git-based Changelog
```bash
git log --pretty=format:"%h - %s (%an, %ar)" --date=short
```
→ Parse commits and categorize (feat:, fix:, docs:, etc.)

## Rules
- Parse options FIRST before analysis
- Detect project type for appropriate templates
- Preserve existing content when updating
- Add "Generated by /doc-writer" footer
- Support both Korean and English
- Include code examples from actual project code
- Validate links and references

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /doc-writer
모델: [haiku|sonnet|opus]
문서 타입: [readme|api|guide|changelog|all]
언어: [ko|en|auto]
생성 파일: [파일 경로]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
