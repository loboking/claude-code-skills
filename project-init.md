---
allowed-tools: AskUserQuestion, EnterPlanMode, Bash, Write, Edit, Read, Glob, Grep, TodoWrite
description: Smart project initialization with plan mode (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /project-init 사용 가이드

용도: 프로젝트 타입별 자동 초기화 (구조, 설정, Git, 문서)

사용법:
  /project-init                    # 자동 감지 또는 질문
  /project-init <type>             # 명시적 타입 지정
  /project-init -t <type> -n <name> # 옵션과 함께

옵션:
  -t, --type [type]    프로젝트 타입 지정
  -n, --name [name]    프로젝트 이름
  --no-git             Git 초기화 건너뛰기
  --no-deps            의존성 설치 건너뛰기
  --template [url]     커스텀 템플릿 사용
  --dry                계획만 표시
  --help               이 도움말 표시

지원 타입:
  react, next, vue, android, ios, flutter
  react-native, spring, fastapi, express
  go, rust, electron, tauri

예시:
  /project-init react              # React 프로젝트
  /project-init -t nextjs -n blog  # Next.js 블로그
  /project-init --dry flutter      # Flutter 계획만 보기

언제 사용:
  ✅ 새 프로젝트 시작
  ✅ 표준 구조/설정 자동화
  ✅ 팀 컨벤션 통일

워크플로우:
  타입 선택 → Plan Mode → 구조 설계 → 승인 → 초기화 → Git 커밋 → 완료
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Workflow

### Phase 1: Project Type Selection

**Auto-detect or Ask**:
- If in empty directory → ask user
- If args provided (e.g., `/project-init react`) → use args
- If package files exist → detect and confirm

**Supported Types**:

| Type | Trigger | Init Command |
|------|---------|--------------|
| React | react, vite-react | `npm create vite@latest . -- --template react-ts` |
| Next.js | next, nextjs | `npx create-next-app@latest . --typescript --tailwind --app` |
| Vue | vue | `npm create vite@latest . -- --template vue-ts` |
| Android | android, kotlin | `gradle init --type kotlin-application` |
| iOS | ios, swift | `swift package init --type executable` |
| Flutter | flutter | `flutter create .` |
| React Native | react-native, rn | `npx react-native init` |
| Spring Boot | spring, java | `curl https://start.spring.io/starter.zip -d dependencies=web,jpa -o init.zip && unzip init.zip` |
| FastAPI | fastapi, python | Create structure manually |
| Express | express, node | `npm init -y && npm install express typescript @types/node @types/express` |
| Go | go, golang | `go mod init` |
| Rust | rust, cargo | `cargo init` |
| Electron | electron | `npm create @quick-start/electron` |
| Tauri | tauri | `npm create tauri-app@latest` |

### Phase 2: Plan Mode (EnterPlanMode)

**Planning includes**:
1. **Directory Structure**
   ```
   project/
   ├── src/
   ├── tests/
   ├── docs/
   ├── .github/workflows/
   └── config/
   ```

2. **Essential Files**
   - `.gitignore` (type-specific)
   - `README.md` (with badges, setup instructions)
   - `CLAUDE.md` (project rules + token optimization)
   - `.env.example` (if needed)
   - CI/CD config (GitHub Actions/GitLab CI)

3. **Dependencies**
   - Core libraries
   - Dev dependencies
   - Linting/formatting tools

4. **Configuration**
   - TypeScript/ESLint/Prettier (web)
   - Gradle/Maven (Android/Java)
   - Package.swift/Podfile (iOS)
   - pubspec.yaml (Flutter)

5. **Git Setup**
   - `git init`
   - Initial commit
   - Branch strategy (main/develop)

### Phase 2.5: Directory Structure

Create organized docs folder:

```bash
mkdir -p docs/{01-getting-started,02-architecture,03-api,04-development,05-deployment,06-operations,07-reference}
mkdir -p docs/02-architecture/diagrams
```

Generate documentation templates:

**docs/README.md**:
```markdown
# [Project Name] Documentation

## Structure
- [01 Getting Started](./01-getting-started/) - Setup, installation, quick start
- [02 Architecture](./02-architecture/) - System design, diagrams, decisions
- [03 API](./03-api/) - API documentation, endpoints, schemas
- [04 Development](./04-development/) - Dev guides, conventions, workflows
- [05 Deployment](./05-deployment/) - Deploy guides, CI/CD, environments
- [06 Operations](./06-operations/) - Monitoring, troubleshooting, maintenance
- [07 Reference](./07-reference/) - Tech specs, dependencies, glossary
```

**docs/01-getting-started/README.md**:
```markdown
# Getting Started

## Prerequisites
- [List required software/tools]

## Installation
[Step-by-step setup instructions]

## Quick Start
[Minimal example to get running]

## Next Steps
- [Link to architecture docs]
- [Link to development guide]
```

**docs/02-architecture/README.md**:
```markdown
# Architecture

## Overview
[High-level system description]

## Components
[Key components and their responsibilities]

## Data Flow
[How data moves through the system]

## Diagrams
- [System Architecture](./diagrams/)
- [Database Schema](./diagrams/)

## Design Decisions
[Link to ADRs or key decisions]
```

**docs/02-architecture/project-analysis.md**:
```markdown
# Project Analysis

*Auto-generated by /project-init*

## Project Type
[Detected type]

## Structure
[Directory tree]

## Tech Stack
[Dependencies and frameworks]

## Configuration
[Key config files]

## Next Steps
[Recommended actions]
```

Apply this structure during Phase 4 execution.

### Phase 3: User Approval (ExitPlanMode)

Show plan in Korean:
```
## 프로젝트 초기화 계획

### 프로젝트 타입
[Detected Type]

### 디렉토리 구조
[Tree view]

### 실행 명령어
1. [init command]
2. [dependency installs]
3. [config setups]

### 생성 파일
- README.md
- CLAUDE.md (토큰 최적화 규칙)
- .gitignore
- [type-specific configs]

---
실행|수정|취소
```

### Phase 4: Execution

On "실행":

1. **Create directories**
   ```bash
   mkdir -p src tests docs .github/workflows
   ```

2. **Run init command**
   ```bash
   [detected init command]
   ```

3. **Generate files**
   - Write README.md with:
     - Project title
     - Setup instructions
     - Tech stack badges
     - Development guide
   - Write CLAUDE.md with token rules
   - Write .gitignore (type-specific template)
   - Write .env.example (if needed)

4. **Install dependencies**
   ```bash
   npm install  # or pip install, go get, cargo build
   ```

5. **Setup linting** (web projects)
   ```bash
   npm install -D eslint prettier
   npx eslint --init
   ```

6. **Git initialization**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: [Project Type] project setup

   🤖 Generated with [Claude Code](https://claude.com/claude-code)"
   ```

7. **Post-init report**
   ```
   ✅ 프로젝트 초기화 완료!

   ## 생성된 것
   - 디렉토리: src/, tests/, docs/
   - 설정 파일: [list]
   - 의존성: [count] packages

   ## 다음 단계
   1. 개발 서버 시작: [command]
   2. 테스트 실행: [command]
   3. 빌드: [command]

   ## 추천 작업
   - [ ] GitHub 저장소 생성
   - [ ] CI/CD 설정
   - [ ] 환경 변수 설정
   ```

### Phase 5: Template Customization

**Per project type, generate**:

#### React/Next.js
- `tsconfig.json` (strict mode)
- `.eslintrc.json` (Airbnb style)
- `tailwind.config.js`
- `components/` directory
- `hooks/` directory

#### Android
- `build.gradle.kts` (Kotlin DSL)
- `gradle.properties`
- `proguard-rules.pro`
- Package structure

#### iOS
- `Package.swift`
- `.swiftlint.yml`
- Folder structure (Sources, Tests)

#### Flutter
- `analysis_options.yaml`
- `lib/` structure (screens, widgets, services)

#### Spring Boot
- `application.yml`
- `Controller/Service/Repository` structure
- JPA entity templates

#### FastAPI
- `requirements.txt` or `pyproject.toml`
- `app/` structure (routers, models, schemas)
- `alembic/` for migrations

## Advanced Options

### Options
```
-t, --type [type]       : Specify project type explicitly
-n, --name [name]       : Project name
--no-git                : Skip git initialization
--no-deps               : Skip dependency installation
--template [url]        : Use custom template from GitHub
--dry                   : Plan only, don't execute
-m [haiku|sonnet|opus]  : Model for planning
```

### Examples
```bash
# Auto-detect and plan
/project-init

# Explicit type
/project-init react MyApp

# With options
/project-init -t nextjs -n my-blog --no-git

# Custom template
/project-init --template https://github.com/user/template

# Dry run
/project-init --dry flutter
```

## Integration with Other Skills

**After init, suggest**:
```
프로젝트가 초기화되었습니다!

다음 스킬로 계속하시겠습니까?
- /smart-brain : 토큰 최적화 규칙 추가 (이미 포함됨)
- /run : 첫 기능 구현
- /super : 요구사항 정의
```

## Error Handling

1. **Directory not empty**
   - Show existing files
   - Ask: "Overwrite | Merge | Cancel"

2. **Missing CLI tools**
   - Detect: `which npm`, `which flutter`, etc.
   - Suggest installation: `brew install node`, etc.

3. **Init command fails**
   - Show error
   - Suggest troubleshooting
   - Offer manual setup

## Rules

- Always use EnterPlanMode first (never skip planning)
- Respond in Korean
- Generate production-ready configs
- Include token optimization in CLAUDE.md
- Use type-safe defaults (TypeScript, strict linting)
- Create comprehensive .gitignore
- Add helpful README with next steps

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /project-init
모델: [current model]
사용 에이전트: [none]
호출 스킬: [none]
프로젝트 타입: [detected/specified type]
생성 파일: [count]개
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
