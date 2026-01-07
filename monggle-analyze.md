---
allowed-tools: Bash, Read, Glob, Grep, Write
description: Analyze project structure and generate report (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /monggle-analyze 사용 가이드

용도: 프로젝트 구조 분석 및 상세 리포트 생성

사용법:
  /monggle-analyze                 # 현재 디렉토리 분석
  /monggle-analyze <path>          # 특정 경로 분석

옵션:
  --help           이 도움말 표시

예시:
  /monggle-analyze
  /monggle-analyze ~/projects/my-app

언제 사용:
  ✅ 새 프로젝트 파악 (인수인계)
  ✅ 기술 부채 평가
  ✅ 문서화 자동 생성

워크플로우:
  프로젝트 루트 감지 → 구조 분석 → 기술 스택 파악 → 리포트 생성 → docs/02-architecture/에 저장

생성 위치:
  docs/02-architecture/project-analysis-{timestamp}.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 기능 설명

`/monggle-analyze` 스킬은 현재 작업 디렉토리의 프로젝트를 자동으로 분석하여 프로젝트 타입, 디렉토리 구조, 기술 스택, 아키텍처 패턴, 엔트리 포인트 및 핵심 모듈 목록을 포함하는 마크다운 보고서를 생성합니다. 이 보고서는 `docs/02-architecture/` 디렉토리에 저장됩니다.

## 1. Detect Project Root

Use Bash to find project root:

```bash
detect_root() {
  # Try git root first
  if git rev-parse --show-toplevel 2>/dev/null; then
    return
  fi

  # Search upward for project markers
  dir="$PWD"
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/package.json" ] || \
       [ -f "$dir/pom.xml" ] || \
       [ -f "$dir/build.gradle" ] || \
       [ -f "$dir/Cargo.toml" ] || \
       [ -f "$dir/go.mod" ] || \
       [ -f "$dir/pyproject.toml" ] || \
       [ -f "$dir/requirements.txt" ] || \
       [ -f "$dir/pubspec.yaml" ] || \
       [ -d "$dir/.git" ]; then
      echo "$dir"
      return
    fi
    dir=$(dirname "$dir")
  done

  # Fallback to current directory
  echo "$PWD"
}

PROJECT_ROOT=$(detect_root)
cd "$PROJECT_ROOT"
```

## 2. Analyze Project Structure

### 2.1 Detect Project Type

Use Glob to detect project files:

| Pattern | Project Type |
|---------|--------------|
| package.json + (*.tsx \| *.jsx) | React/Next.js/Vue |
| build.gradle + AndroidManifest.xml | Android |
| *.xcodeproj + *.swift | iOS |
| pubspec.yaml + lib/**/*.dart | Flutter |
| Cargo.toml + src/**/*.rs | Rust |
| go.mod + **/*.go | Go |
| pom.xml + src/**/*.java | Java/Spring |
| pyproject.toml \| requirements.txt | Python/FastAPI |
| *.csproj + **/*.cs | C#/.NET |

### 2.2 Count Files by Type

Use Bash to generate statistics:

```bash
echo "## File Statistics"
for ext in ts tsx js jsx py java kt swift go rs; do
  count=$(find . -type f -name "*.$ext" 2>/dev/null | wc -l | xargs)
  [ "$count" -gt 0 ] && echo "- .$ext: $count files"
done
```

### 2.3 Generate Directory Tree

Use Bash with tree or fallback:

```bash
if command -v tree &> /dev/null; then
  tree -L 3 -I 'node_modules|.git|dist|build|target|.next|coverage' -F
else
  # Fallback: manual tree using find
  find . -maxdepth 3 -not -path '*/node_modules/*' -not -path '*/.git/*' \
    -not -path '*/dist/*' -not -path '*/build/*' -not -path '*/target/*' \
    | sort | sed 's|^\./||'
fi
```

### 2.4 Extract Dependencies

Use Read + Grep to parse dependency files:

**For Node.js (package.json)**:
```bash
if [ -f package.json ]; then
  echo "### Dependencies (package.json)"
  grep -A 50 '"dependencies"' package.json | grep '"' | head -20
fi
```

**For Python (requirements.txt)**:
```bash
if [ -f requirements.txt ]; then
  echo "### Dependencies (requirements.txt)"
  head -20 requirements.txt
fi
```

**For Java (pom.xml)**:
```bash
if [ -f pom.xml ]; then
  echo "### Dependencies (pom.xml)"
  grep -A 3 '<dependency>' pom.xml | head -40
fi
```

### 2.5 Identify Frameworks

Use Grep to search for common imports/frameworks:

```bash
# React
if grep -r "from 'react'" . 2>/dev/null | head -1 | grep -q react; then
  echo "- React"
fi

# Next.js
if [ -f next.config.js ]; then
  echo "- Next.js"
fi

# Spring Boot
if grep -r "@SpringBootApplication" . 2>/dev/null | head -1 | grep -q Spring; then
  echo "- Spring Boot"
fi
```

### 2.6 Architecture Pattern Detection

Check for common architecture directories:

```bash
echo "## Architecture Pattern"
if [ -d "controllers" ] && [ -d "models" ] && [ -d "views" ]; then
  echo "- MVC Pattern detected"
elif [ -d "domain" ] && [ -d "infrastructure" ]; then
  echo "- Clean Architecture detected"
elif [ -d "services" ] && [ -d "repositories" ]; then
  echo "- Layered Architecture detected"
fi
```

## 3. Generate Report

Create markdown report with all collected information and save to:
`docs/02-architecture/project-analysis-{timestamp}.md`

Report should include:
- Project type
- Directory structure
- File statistics
- Technology stack
- Architecture pattern
- Entry points
- Key modules
- Recommendations

## 사용 예시

```bash
/monggle-analyze
```

## 출력 예시

```markdown
# 프로젝트 분석 보고서

**분석 시간:** 2026년 1월 7일 수요일 10:00:00

## 1. 프로젝트 타입
- **주요 언어:** TypeScript
- **프레임워크:** React (CRA)

## 2. 디렉토리 구조

```
.
├── public/
│   └── index.html
├── src/
│   ├── assets/
│   ├── components/
│   │   ├── Button.tsx
│   │   └── Header.tsx
│   ├── hooks/
│   │   └── useAuth.ts
│   ├── pages/
│   │   ├── HomePage.tsx
│   │   └── AboutPage.tsx
│   ├── services/
│   │   └── api.ts
│   ├── App.tsx
│   ├── index.tsx
│   └── react-app-env.d.ts
├── package.json
├── tsconfig.json
├── README.md
└── .git/
```

## 3. 기술 스택

-   **언어:** TypeScript, JavaScript
-   **프레임워크/라이브러리:**
    *   React (v18.2.0)
    *   React Router (v6.20.0)
    *   Axios (v1.6.2)
    *   Tailwind CSS (v3.3.6)
-   **빌드 도구:** Webpack (via Create React App)
-   **테스트:** Jest, React Testing Library

## 4. 아키텍처 패턴

-   **추정 패턴:** Feature-sliced design 또는 Domain-driven design (계층형)
    *   `pages/`: UI/View 레이어
    *   `components/`: UI 구성 요소
    *   `services/`: 비즈니스 로직 및 데이터 접근 레이어
    *   `hooks/`: 재사용 가능한 로직

## 5. 엔트리 포인트 및 핵심 모듈

-   **엔트리 포인트:** `src/index.tsx`
-   **핵심 모듈/파일:**
    *   `src/App.tsx`: 메인 애플리케이션 컴포넌트
    *   `src/services/api.ts`: API 통신 로직
    *   `src/components/`: 재사용 가능한 UI 컴포넌트
    *   `src/pages/`: 라우팅되는 페이지 컴포넌트
    *   `src/hooks/`: 커스텀 React Hooks
```

---

## Rules

- Always detect project root first (don't assume current dir)
- Use Bash for file system operations (fast, reliable)
- Handle missing files gracefully (check existence first)
- Exclude common build/vendor directories (node_modules, .git, etc.)
- Generate actionable recommendations
- Respond in Korean
- Save report with timestamp to avoid overwrites

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /monggle-analyze
모델: [current model]
사용 에이전트: [none]
호출 스킬: [none]
분석 파일: [count]개
리포트 위치: docs/02-architecture/project-analysis-{timestamp}.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

---
