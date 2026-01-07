---
allowed-tools: AskUserQuestion, EnterPlanMode, Bash, Write, Edit, Read, Glob, Grep, TodoWrite
description: Smart project initialization with plan mode (user)
---

Args: "$ARGUMENTS"

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
