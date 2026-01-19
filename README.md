# Monggle Agent Toolkit

Claude Code를 위한 AI 에이전트 모음 - Claude + Gemini 협업, 스마트 오케스트레이션, 개발 자동화

## 설치

```bash
# 1. Repository 클론
git clone https://github.com/loboking/claude-code-skills.git ~/.claude/commands

# 2. 설치 스크립트 실행 (필수!)
cd ~/.claude/commands
./install.sh

# 3. Claude Code CLI 재시작
```

**⚠️ 중요:** `install.sh`를 반드시 실행해야 에이전트가 작동합니다!

## Gemini API 키 설정

`gemini`, `duo` 에이전트는 Gemini API를 사용합니다.

```bash
# 자동 설정 (권장) - 첫 사용 시 입력 프롬프트 표시
@agent-gemini 테스트

# 수동 설정
mkdir -p ~/.gemini
echo "YOUR_API_KEY" > ~/.gemini/config
chmod 600 ~/.gemini/config

# API 키 발급: https://aistudio.google.com/apikey
```

## 호출 방법

**2가지 실행 방식 + 3가지 호출 문법**

### 실행 방식 비교

| 방식 | 호출 | 속도 | 토큰 | 언제 사용? |
|-----|------|------|------|----------|
| **Skill** | `/duo 작업` | ⚡⚡⚡ 빠름 | 💰 적음 | 대부분의 경우 (권장) |
| **Agent** | `@agent-duo 작업` | ⚡ 느림 | 💰💰💰 많음 | 병렬/백그라운드 필요 시 |

### 호출 문법

| 문법 | Skill 예시 | Agent 예시 | 특징 |
|-----|-----------|-----------|------|
| **슬래시** | `/duo 구현` | - | 빠른 실행 (Skill만) |
| **@ 멘션** | - | `@agent-duo 구현` | 자동완성 지원 (Agent만) |
| **자연어** | `Use duo to implement` | `Use duo agent to implement` | 직관적 |

**사용 예시:**
```bash
# Skill 방식 (빠름, 토큰 효율)
/duo 로그인 추가
/gemini Python 설명
/run README 작성

# Agent 방식 (강력, 백그라운드)
@agent-duo 마이크로서비스 설계
@agent-gemini 알고리즘 분석
@agent-run 전체 리팩토링

# @ 멘션 자동완성
@agent-       # Tab → 모든 에이전트 목록
/mong         # Tab → 모든 Skill 목록 (monggle- 접두사)
```

---

## 성능 지표 범례

각 에이전트의 성능 특성을 한눈에 파악할 수 있습니다:

| 지표 | 설명 |
|-----|------|
| **속도** | ⚡⚡⚡ 빠름 → ⚡⚡ 보통 → ⚡ 느림 → 🐌 매우 느림 |
| **토큰** | 💰 낮음 → 💰💰 중간 → 💰💰💰 높음 |
| **품질** | ⭐⭐⭐ 양호 → ⭐⭐⭐⭐ 우수 → ⭐⭐⭐⭐⭐ 최고 |

---

## 주요 기능

### 🤝 duo - Claude + Gemini 동적 협업

Claude와 Gemini가 합의할 때까지 동적으로 협업합니다.

```bash
# Skill 방식 (빠름)
/duo 로그인 기능 추가

# Agent 방식 (강력)
@agent-duo 마이크로서비스 설계
@agent-duo -o 결제 시스템 아키텍처
```

| 속성 | Skill | Agent |
|-----|-------|-------|
| **속도** | ⚡⚡ 보통 | 🐌 느림 (다중 라운드) |
| **토큰** | 💰💰 중간 | 💰💰💰 높음 |
| **품질** | ⭐⭐⭐⭐⭐ 최고 | ⭐⭐⭐⭐⭐ 최고 |

**선택 가이드:**
- 간단한 코드 추가 → `/duo` (Skill)
- 복잡한 아키텍처 설계 → `@agent-duo` (Agent)
- 백그라운드 협업 필요 → `@agent-duo` (Agent)

---

### 🎯 run - 스마트 오케스트레이터

작업 복잡도를 분석하여 최적의 모델/에이전트를 자동 선택합니다.

```bash
# Skill 방식 (빠름)
/run 코드 리팩토링              # 자동 분석 후 추천
/run -h README 수정             # haiku로 즉시 실행

# Agent 방식 (강력)
@agent-run -o 전체 아키텍처 설계
@agent-run --dry 계획만 확인    # 백그라운드로 분석만
```

| 속성 | Skill | Agent |
|-----|-------|-------|
| **속도** | ⚡⚡ 빠름 | ⚡ 가변 |
| **토큰** | 💰 낮음 | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐ 우수 | ⭐⭐⭐⭐ 우수 |

**옵션:**
- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값)
- `-o` : opus (최고 품질)
- `--dry` : 계획만 생성 (실행 안함)

---

### ⚡ super - 슈퍼 프롬프트 생성

간단한 요청을 상세 요구사항으로 자동 확장합니다.

```bash
# Skill 방식 (빠름)
/super 로그인 기능 추가
/super --compact API 엔드포인트

# Agent 방식 (강력)
@agent-super -o 결제 시스템 설계
```

| 속성 | Skill | Agent |
|-----|-------|-------|
| **속도** | ⚡⚡⚡ 빠름 | ⚡⚡ 보통 |
| **토큰** | 💰 낮음 | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐ 우수 | ⭐⭐⭐⭐ 우수 |

**자동 간결 모드:**
- <15단어: Ultra-Compact
- 15-29단어: Compact
- 30+단어: Full

---

### 🤖 gemini - Gemini 서브에이전트

Gemini AI를 호출하거나 논쟁 모드를 실행합니다.

```bash
# Skill 방식 (빠름)
/gemini Python 비동기 설명해줘
/gemini -t "TDD vs BDD"         # 논쟁 모드

# Agent 방식 (강력)
@agent-gemini 복잡한 알고리즘 분석
```

| 속성 | Skill | Agent |
|-----|-------|-------|
| **속도** | ⚡⚡⚡ 매우 빠름 | ⚡⚡ 빠름 |
| **토큰** | 💰 낮음 | 💰 낮음 |
| **품질** | ⭐⭐⭐ 양호 | ⭐⭐⭐ 양호 |

**특징:** 논쟁 모드 (`-t`) 지원 - Claude vs Gemini 논쟁

---

### 📝 간단한 Skill 전용 기능

이 기능들은 Skill으로만 제공됩니다 (빠르고 효율적).

#### doc-writer - 문서 자동 생성
```bash
/doc-writer readme              # README.md 생성
/doc-writer api                 # API 문서 생성
/doc-writer -h changelog        # haiku로 변경 이력 생성
```
- README, API 문서, 가이드 자동 생성
- Git 히스토리 기반 CHANGELOG
- ⚡⚡⚡ 빠름, 💰 저비용

#### smart-brain - 토큰 최적화
```bash
/smart-brain                    # 프로젝트에 CLAUDE.md 최적화 규칙 추가
```
- diff-only 출력, 참조 우선, 재작업 방지
- 세션당 20-40% 토큰 절약
- ⚡⚡⚡ 빠름

#### project-init - 프로젝트 초기화
```bash
/project-init react             # React 프로젝트 초기화
/project-init                   # 자동 감지
```
- README, CLAUDE.md, .gitignore, 설정 파일, Git 초기화
- React, Next.js, Flutter, Android, iOS, Spring Boot 등 지원
- ⚡⚡ 보통

---

## 개발 지원 에이전트

(Agent 전용 - 고급 기능)

### 🏗️ architecture-designer - 아키텍처 설계

시스템 아키텍처 설계 및 기술 스택 평가를 지원합니다.

```bash
@agent-architecture-designer
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡ 보통 |
| **토큰** | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐⭐ 최고 |
| **모델** | sonnet |

**사용 시기:**
- 새 프로젝트 아키텍처 설계
- 기존 시스템 리팩토링
- 디자인 패턴 선택

---

### 🔍 code-reviewer - 코드 리뷰

구현 완료 후 코드 품질을 검토합니다.

```bash
@agent-code-reviewer
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡ 빠름 |
| **토큰** | 💰 낮음 |
| **품질** | ⭐⭐⭐⭐ 우수 |
| **모델** | sonnet |

**리뷰 영역:**
- 베스트 프랙티스 준수
- 잠재적 버그 발견
- 성능 최적화 제안

---

### 🐛 debug-master - 디버깅 전문가

복잡한 버그를 체계적으로 분석하고 해결합니다.

```bash
@agent-debug-master
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡ 느림 (체계적 분석) |
| **토큰** | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐⭐ 최고 |
| **모델** | sonnet |

**전문 분야:**
- 크래시 분석
- 성능 병목 진단
- 메모리 누수 추적

---

### 🎨 frontend-designer - 프론트엔드 디자인

톤앤매너 일치 + 무료 리소스 + 최신 트렌드 디자인을 제공합니다.

```bash
@agent-frontend-designer
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡ 보통 |
| **토큰** | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐ 우수 |
| **특징** | Anti-AI 디자인 |

---

### 🔐 git-guardian - Git 워크플로우

안전한 Git 워크플로우 자동화 - Secrets 스캔 + 구조화된 커밋 메시지

```bash
@agent-git-guardian
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡⚡ 빠름 |
| **토큰** | 💰 낮음 |
| **품질** | ⭐⭐⭐⭐ 우수 |
| **특징** | Secrets 스캔 |

---

### 🎯 precision-debugger - 정밀 디버깅

표적 항암치료처럼 복잡하고 재현 어려운 버그를 정밀하게 추적합니다.

```bash
@agent-precision-debugger
```

| 속성 | 값 |
|-----|-----|
| **속도** | 🐌 매우 느림 (정밀 분석) |
| **토큰** | 💰💰💰 높음 |
| **품질** | ⭐⭐⭐⭐⭐ 최고 |
| **특징** | 재현 어려운 버그 전문 |

---

### 📋 product-manager - 제품 관리

PRD 작성, 사용자 스토리 정의, 기능 우선순위 설정을 지원합니다.

```bash
@agent-product-manager
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡ 보통 |
| **토큰** | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐ 우수 |
| **모델** | sonnet |

---

### 📝 tech-doc-writer - 기술 문서 작성

API 문서, 사용자 가이드, 아키텍처 문서를 자동 생성합니다.

```bash
@agent-tech-doc-writer
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡ 빠름 |
| **토큰** | 💰 낮음 |
| **품질** | ⭐⭐⭐⭐ 우수 |
| **모델** | sonnet |

---

## 프로젝트 관리 에이전트

### 📋 planner - 프로젝트 기획서 작성

아이디어를 상세 기획서로 변환합니다.

```bash
/planner 로그인 기능 추가
/planner --full "Todo 앱"
/planner --story "할 일 추가"
```

**모드:**
- 기본: 상세 요구사항
- `--full`: 전체 기획서
- `--story`: Given-When-Then 스토리
- `--priority`: 우선순위 매트릭스

---

### 🚀 project-init - 스마트 프로젝트 초기화

Plan Mode로 프로젝트를 설계하고 자동 초기화합니다.

```bash
/project-init react
/project-init -t nextjs -n my-app
```

**지원:** React, Next.js, Flutter, Android, iOS, Spring Boot, FastAPI, Go, Rust

---

## 스킬 (슬래시 명령어)

에이전트가 아닌 단순 스킬:

| 스킬 | 설명 |
|-----|------|
| `/doc-writer` | 프로젝트 문서 자동 생성 |
| `/smart-brain` | 프로젝트 CLAUDE.md에 토큰 최적화 규칙 추가 |

---

## monggle- 접두사

모든 스킬/에이전트는 `monggle-` 접두사로도 사용 가능합니다:

```bash
@agent-monggle-duo        # = @agent-duo
@agent-monggle-run        # = @agent-run
/monggle-doc-writer       # = /doc-writer
```

**장점:** `/mong` 또는 `@agent-mong` 입력 후 Tab으로 모든 커스텀 목록 표시

---

## 파일 구조

```
~/.claude/commands/
├── agents/                    # 에이전트 정의 (YAML frontmatter)
│   ├── duo.md                # Claude + Gemini 협업
│   ├── run.md                # 스마트 오케스트레이터
│   ├── super.md              # 슈퍼 프롬프트
│   ├── gemini.md             # Gemini 서브에이전트
│   ├── architecture-designer.md
│   ├── code-reviewer.md
│   ├── debug-master.md
│   ├── frontend-designer.md
│   ├── git-guardian.md
│   ├── precision-debugger.md
│   ├── product-manager.md
│   ├── tech-doc-writer.md
│   └── monggle-*             # monggle 접두사 버전
│
├── commands/                  # 스킬 (슬래시 명령어용)
│   ├── duo.md                # → agents/duo.md 안내
│   ├── run.md                # → agents/run.md 안내
│   ├── planner.md            # 스킬 (상세 로직)
│   ├── project-init.md
│   ├── doc-writer.md
│   ├── smart-brain.md
│   └── monggle-*             # 심볼릭 링크
│
└── .common/                   # 공통 템플릿
    ├── TOKEN_OPTIMIZATION_TEMPLATE.md
    └── GEMINI_API_KEY_CHECK_TEMPLATE.md
```

---

## 사용 시나리오

### 새 프로젝트 시작
```bash
/project-init react
# → Plan Mode → 승인 → 자동 초기화
```

### 새 기능 구현
```bash
@agent-super 사용자 인증 추가
# → 요구사항 확인 → 실행
```

### 복잡한 설계 결정
```bash
@agent-duo 마이크로서비스 vs 모놀리식
# → Claude + Gemini 협업 → 합의 기반 구현
```

### 코드 리뷰
```bash
@agent-code-reviewer
# → 최근 변경 코드 분석 → 개선 제안
```

### 버그 디버깅
```bash
@agent-debug-master
# → 체계적 분석 → 근본 원인 파악 → 해결
```

---

## 언제 Skill? 언제 Agent?

### 선택 가이드

| 상황 | 추천 | 이유 |
|-----|------|------|
| README 작성 | `/doc-writer` | 빠르고 간단 |
| 간단한 기능 추가 | `/duo` | 토큰 효율적 |
| 복잡한 아키텍처 | `@agent-duo` | 심층 분석 |
| 여러 작업 동시 진행 | `@agent-*` | 병렬 처리 |
| 1시간+ 걸리는 작업 | `@agent-*` | 백그라운드 실행 |
| 빠른 질문 | `/gemini` | 즉각 응답 |

### 원칙

1. **의심스러우면 Skill 먼저** (빠르고 효율적)
2. **Skill로 부족하면 Agent** (강력하지만 느림)
3. **병렬 처리 필요하면 Agent** (동시 실행)
4. **대부분의 경우 Skill로 충분** (95%)

### 실제 예시

```bash
# ✅ 이렇게 하세요
/duo 로그인 기능 추가              # 간단 → Skill
/doc-writer readme              # 문서 → Skill
/smart-brain                    # 최적화 → Skill

# 🔧 이럴 때만 Agent
@agent-duo 마이크로서비스 설계    # 복잡한 설계
@agent-run 전체 시스템 리팩토링   # 긴 작업
@agent-duo & @agent-gemini &    # 병렬 실행
```

---

## 🤖 스킬 자동 추천

Claude는 상황을 감지하여 관련 스킬을 **자동으로 추천**합니다.

### 추천 시나리오

| 상황 | 추천 스킬 | 예시 |
|-----|----------|------|
| 📄 문서 작성 요청 | `/doc-writer` | "README 만들어줘" → `/doc-writer readme` |
| 🏗️ 설계/아키텍처 질문 | `/duo` | "어떤 아키텍처가 좋을까?" → `/duo` |
| 🚀 프로젝트 초기화 | `/project-init` | "새 React 프로젝트" → `/project-init react` |
| 💰 토큰 최적화 필요 | `/smart-brain` | 세션 시작 시 → `/smart-brain` |
| 📋 기획서 작성 | `/planner` | "기획서 작성해줘" → `/planner` |
| ✨ 막연한 아이디어 | `/super` | "뭔가 만들고 싶은데" → `/super` |
| 🎯 작업 복잡도 분석 | `/run` | "어떻게 진행하지?" → `/run` |
| 🤖 다른 AI 의견 | `/gemini` | "다른 의견 듣고 싶어" → `/gemini` |
| 🔄 A vs B 비교 | `/duo` | "A vs B 뭐가 나아?" → `/duo` |
| 🔍 검증 필요 | `/gemini -t` | "검증해줘" → `/gemini -t` (논쟁) |

### 추천 예시

```
사용자: "README 만들어줘"
Claude: "README 생성은 `/doc-writer readme` 스킬을 사용하시겠어요?"

사용자: "마이크로서비스 vs 모놀리식"
Claude: "중요한 결정이네요. `@agent-duo`로 심층 분석하시겠어요?"

사용자: "기획서 작성해줘"
Claude: "`/planner`로 상세 기획서를 생성하시겠어요?"

사용자: "이 작업 어떻게 진행하지?"
Claude: "`/run`으로 복잡도를 분석하고 최적 모델을 추천해드릴까요?"
```

### 추천 규칙

- ✅ **자동 감지**: 상황에 맞는 스킬 추천
- ✅ **명령어 포함**: 바로 사용 가능한 명령어 제시
- ✅ **Skill 우선**: 빠르고 효율적인 Skill 먼저 추천
- ✅ **사용자 선택**: 강요하지 않음 (선택사항)
- ✅ **복잡하면 Agent**: 필요시 Agent 제안

---

## 요구사항

- **Claude Code CLI**: v1.0.62+ (@ 멘션 지원)
- **Gemini API**: `gemini`, `duo` 에이전트용
- **Git**: 저장소 관리

---

## 설치 확인

```bash
# 에이전트 자동완성 테스트
@agent-<Tab>

# 스킬 목록 확인
ls ~/.claude/commands/*.md

# Gemini API 테스트
@agent-gemini hello
```

---

## 기여

이슈 및 PR 환영합니다!

**Repository**: https://github.com/loboking/claude-code-skills

---

## 라이선스

MIT License
