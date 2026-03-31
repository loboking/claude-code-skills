# Monggle Agent Toolkit

**Claude Code & Antigravity**를 위한 AI 에이전트 모음 - Claude + Gemini 협업, 스마트 오케스트레이션, PRD 기반 개발 자동화

> 🎯 **두 플랫폼 모두 지원**: Claude Code와 Google Antigravity에서 동일한 스킬 사용 가능!

---

## 🆕 최신 업데이트 (v2.0)

### ✨ PRD 기반 워크플로우 추가

이제 `super`, `duo`, `run` 에이전트가 **기본적으로 Plan Mode**로 작동합니다!

**주요 특징:**
- 📋 **자동 PRD 생성**: 요청 → PRD → TASK → TODOS 구조
- ✅ **승인 후 실행**: 계획 확인 → 승인 → 구현 (안전성 ↑)
- 🔒 **범위 제한 강제**: PRD 기반 명시적 파일 목록, 위반 시 경고
- ⚡ **--auto 옵션**: Free Pass 모드 (계획 생략, 바로 실행)
- 💾 **PRD 캐싱**: 1시간 재사용, 토큰 30-50% 절약

**사용 예시:**
```bash
# 기본: PRD 생성 → 승인 → 실행
/super 로그인 기능 추가
# → PRD 표시 → 승인 여부 확인 → 구현

# Free Pass: 바로 실행
/super --auto 간단한 버그 수정
# → PRD 생략, 즉시 구현

# PRD 생략 (위험)
/super --skip-prd 테스트 코드 작성
# → 경고 표시, 범위 제한 없음
```

**PRD 템플릿 3종:**
- `feature-prd.md`: 기능 개발용 (244 lines)
- `bugfix-prd.md`: 버그 수정용 (231 lines)
- `refactor-prd.md`: 리팩토링용 (337 lines)

**저장 위치:**
- `~/.claude/.prd/current-prd.md` (현재 PRD)
- `~/.claude/.prd/archive/` (완료된 PRD 보관)

---

## 🚀 빠른 설치 (다른 PC에서도 동일)

### 1. 전제 조건
- **Claude Code CLI** v1.0.62 이상 설치 필요
  - 설치: https://claude.ai/download
  - 확인: 터미널에서 `claude --version`

### 2. 설치 명령어
```bash
# 한 줄 설치 (복사 후 붙여넣기)
git clone https://github.com/loboking/claude-code-skills.git ~/.claude/commands && cd ~/.claude/commands && ./install.sh
```

**또는 단계별 설치:**
```bash
# 1. Repository 클론
git clone https://github.com/loboking/claude-code-skills.git ~/.claude/commands

# 2. 디렉토리 이동
cd ~/.claude/commands

# 3. 설치 스크립트 실행 (필수!)
./install.sh

# 4. Claude Code CLI 재시작
```

### 3. 기존 설치자 업데이트

이미 설치된 경우, 아래 명령어로 최신 버전으로 업데이트:

```bash
# 한 줄 업데이트
cd ~/.claude/commands && git pull && ./install.sh
```

**또는 단계별:**
```bash
# 1. 디렉토리 이동
cd ~/.claude/commands

# 2. 최신 버전 가져오기
git pull

# 3. 설치 스크립트 재실행 (Agent, PRD 템플릿 업데이트)
./install.sh

# 4. Claude Code CLI 재시작
```

### 4. 설치 확인
```bash
# Skill 목록 확인
ls ~/.claude/commands/*.md | grep -v README

# Agent 목록 확인
ls ~/.claude/agents/*.md | head -5

# PRD 디렉토리 확인
ls ~/.claude/.prd/templates/

# 테스트 실행
claude-code
# 그 후 채팅에서: /doc-writer --help
```

**⚠️ 중요:**
- `install.sh`를 반드시 실행해야 Agent가 작동합니다
- Skill은 바로 사용 가능 (install.sh 없이도 동작)
- Agent는 install.sh가 `~/.claude/agents/`에 파일 복사
- PRD 디렉토리는 자동 생성됨 (`~/.claude/.prd/`)

---

## 🌟 Antigravity에서 사용하기

**Google Antigravity**도 스킬 시스템을 지원합니다!

### Antigravity란?
- Google의 AI 코딩 도구
- Claude Code와 유사한 skills 시스템
- 스킬 구조: `SKILL.md` + `scripts/` + `references/`

### 설치 방법

#### 1️⃣ 전역 설치 (모든 프로젝트에서 사용)
```bash
# Antigravity 전역 스킬 디렉토리에 클론
git clone https://github.com/loboking/claude-code-skills.git ~/.gemini/antigravity/skills/monggle-toolkit

# 설치 확인
ls ~/.gemini/antigravity/skills/monggle-toolkit/*.md
```

#### 2️⃣ 워크스페이스 설치 (특정 프로젝트만)
```bash
# 프로젝트 디렉토리에서 실행
cd <your-project>

# .agent/skills 디렉토리에 클론
git clone https://github.com/loboking/claude-code-skills.git .agent/skills/monggle-toolkit

# 설치 확인
ls .agent/skills/monggle-toolkit/*.md
```

### Antigravity 스킬 구조

```
~/.gemini/antigravity/skills/monggle-toolkit/  (전역)
또는
<workspace>/.agent/skills/monggle-toolkit/      (워크스페이스)
│
├── duo.md                # Claude + Gemini 협업
├── gemini.md             # Gemini AI 호출
├── run.md                # 스마트 오케스트레이터
├── super.md              # 슈퍼 프롬프트 생성 (PRD 기반)
├── doc-writer.md         # 문서 자동 생성
├── smart-brain.md        # 토큰 최적화
└── project-init.md       # 프로젝트 초기화
```

### 사용 방법

Antigravity에서 스킬 사용:
```bash
# Antigravity AI 채팅에서
/duo 로그인 기능 추가
/super 사용자 인증 시스템    # PRD 기반 계획
/doc-writer readme
/gemini Python 설명해줘
```

**참고:**
- Antigravity는 `@agent-*` 형식은 지원하지 않습니다
- `/스킬명` 형식만 사용 (Skill 방식)
- 스크립트 실행 지원 (Python, Bash, Node, Go)
- PRD 워크플로우는 Claude Code와 동일하게 작동

### 참고 자료
- [Antigravity Skills 샘플](https://github.com/pjt3591oo/antigravity-skills)
- [Antigravity Skills 시작하기](https://blog.naver.com/pjt3591oo/224147187928)

---

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

---

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
/super 사용자 인증 시스템    # PRD 생성
/gemini Python 설명
/run README 작성

# Agent 방식 (강력, 백그라운드)
@agent-duo 마이크로서비스 설계
@agent-super 결제 시스템     # PRD 기반 상세 설계
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

### ⚡ super - 슈퍼 프롬프트 생성 (PRD 기반) 🆕

간단한 요청을 PRD 기반 상세 요구사항으로 자동 확장합니다.

```bash
# Skill 방식 (빠름)
/super 로그인 기능 추가
# → PRD 생성 → 승인 → 구현

/super --auto 간단한 버그 수정
# → PRD 생략, 바로 실행

/super --skip-prd 테스트 코드
# → PRD 생략 (위험 경고)

/super --compact API 엔드포인트
# → 간결 모드

# Agent 방식 (강력)
@agent-super -o 결제 시스템 설계
# → 상세 PRD + 구현
```

| 속성 | Skill | Agent |
|-----|-------|-------|
| **속도** | ⚡⚡⚡ 빠름 | ⚡⚡ 보통 |
| **토큰** | 💰 낮음 | 💰💰 중간 |
| **품질** | ⭐⭐⭐⭐ 우수 | ⭐⭐⭐⭐ 우수 |

**PRD 워크플로우:**
1. 요청 분석 → PRD 생성 (Goal, Requirements, Scope, Tech Spec)
2. 범위 확인 → 사용자 승인
3. TASK 분해 → TODOS 생성
4. 최종 계획 표시 → 실행 승인
5. PRD 기반 구현 (범위 위반 감지)
6. 완료 후 PRD Archive로 이동

**자동 간결 모드:**
- <15단어: Ultra-Compact
- 15-29단어: Compact
- 30+단어: Full (PRD 포함)

**플래그:**
- `--auto`: PRD 및 Plan 생략, 바로 실행
- `--skip-prd`: PRD 생략 (위험 경고)
- `--compact`: 간결 모드 강제

---

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

#### lint-smart - 스마트 린터 🆕
```bash
/lint-smart                     # 프로젝트 자동 감지 후 린트
/lint-smart --fix              # 문제 자동 수정
/lint-smart --file src/main.ts # 특정 파일만
```
- JavaScript/TypeScript, Python, Go, Java, Ruby, Rust, PHP 지원
- eslint, flake8, golangci-lint, rubocop, clippy 등 자동 선택
- ⚡⚡⚡ 빠름, 💰 저비용

#### changelog - CHANGELOG 자동 생성 🆕
```bash
/changelog                      # 전체 히스토리로 CHANGELOG 생성
/changelog --since v1.0.0       # v1.0.0 이후부터
/changelog --unreleased         # 릴리즈 대기 중만
/changelog --bump patch         # 버전 패치 증가
```
- Conventional Commits 파싱
- Keep a Changelog 형식 지원
- 자동 버전 증가 (major/minor/patch)
- ⚡⚡⚡ 빠름

#### bottleneck - 성능 병목 분석 🆕
```bash
/bottleneck                    # 자동 감지 후 병목 분석
/bottleneck --cpu             # CPU 병목 분석
/bottleneck --profile <pid>   # 실행 중인 프로세스 프로파일링
/bottleneck --flamegraph      # 플레임그래프 생성
```
- Python (py-spy, cProfile), Go (pprof), Node (clinic) 지원
- 정적 분석 + 동적 프로파일링
- ⚡⚡ 보통

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

### ⚖️ judge - 중립적 평가자

중립적 입장에서 비판적 평가를 수행합니다. Opus 전용, 직설적 피드백 제공.

```bash
@agent-judge evaluate "Should I use microservices for MVP?"
@agent-judge --brutal review authentication code
@agent-judge --duo --moderate evaluate architecture design
```

| 속성 | 값 |
|-----|-----|
| **속도** | 🐌 느림 (심층 평가) |
| **토큰** | 💰💰💰 높음 |
| **품질** | ⭐⭐⭐⭐⭐ 최고 |
| **모델** | opus (강제) |

**평가 영역:**
- 기술적 의사결정 (아키텍처, 기술 스택)
- 코드 품질 (보안, 성능, SOLID 원칙)
- 아이디어/기획 (실현 가능성, 비즈니스 가치)
- 논리/주장 (논리적 타당성, 증거 강도)

**출력:**
- A-F 등급 + 1-10 점수
- 판결문 (승인/조건부/반려)
- 강점 vs 약점 (우선순위별)
- 반박 논리 (Devil's Advocate)
- 대안 제시 (최소 2개 + Trade-off)

**옵션:**
```bash
--brutal     # 매우 강하게 (쓴소리, 거침없는 비판)
--moderate   # 적당히 직설적 (기본값, 권장)
--objective  # 객관적 비판만 (감정 배제)
--duo        # Claude + Gemini 협업 (1-3라운드)
```

**차별화:**
- vs. code-reviewer: 4가지 영역 + 판결문 + 점수
- vs. duo: 비판/평가 전문 (합의 도출 X)
- 건설적이지만 냉정한 평가
- 반박 논리 + 대안 필수

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

## monggle- 접두사

**모든 스킬/에이전트는 `monggle-` 접두사로도 사용 가능합니다:**

```bash
# Skill
/monggle-super 로그인 기능      # = /super
/monggle-duo 설계               # = /duo
/monggle-run 작업               # = /run
/monggle-gemini 질문            # = /gemini
/monggle-lint-smart             # = /lint-smart 🆕
/monggle-changelog              # = /changelog 🆕
/monggle-bottleneck             # = /bottleneck 🆕
/monggle-doc-writer readme      # = /doc-writer
/monggle-smart-brain            # = /smart-brain
/monggle-project-init react     # = /project-init
/monggle-planner 기획서         # = /planner

# Agent
@agent-monggle-super 구현       # = @agent-super
@agent-monggle-duo 설계         # = @agent-duo
@agent-monggle-run 작업         # = @agent-run
@agent-monggle-gemini 질문      # = @agent-gemini
```

**장점:**
- `/mong<Tab>` → 모든 Skill 자동완성
- `@agent-mong<Tab>` → 모든 Agent 자동완성
- 커스텀 스킬 발견성 향상

---

## 파일 구조

```
~/.claude/
├── commands/                      # Skill (슬래시 명령어)
│   ├── super.md                  # → agents/super.md 안내
│   ├── duo.md                    # → agents/duo.md 안내
│   ├── run.md                    # → agents/run.md 안내
│   ├── gemini.md                 # → agents/gemini.md 안내
│   ├── planner.md                # Skill (상세 로직)
│   ├── project-init.md
│   ├── doc-writer.md
│   ├── smart-brain.md
│   └── monggle-*                 # 심볼릭 링크
│
├── agents/                        # Agent (YAML frontmatter)
│   ├── super.md                  # 슈퍼 프롬프트 (PRD 기반) 🆕
│   ├── duo.md                    # Claude + Gemini 협업
│   ├── run.md                    # 스마트 오케스트레이터
│   ├── gemini.md                 # Gemini 서브에이전트
│   ├── architecture-designer.md
│   ├── code-reviewer.md
│   ├── debug-master.md
│   ├── frontend-designer.md
│   ├── git-guardian.md
│   ├── precision-debugger.md
│   ├── product-manager.md
│   ├── tech-doc-writer.md
│   ├── judge.md
│   └── monggle-*                 # monggle 접두사 버전
│
├── .prd/                          # PRD 저장소 🆕
│   ├── current-prd.md            # 현재 작업 중인 PRD
│   ├── archive/                  # 완료된 PRD 보관
│   │   └── prd-*.md
│   └── templates/                # PRD 템플릿
│       ├── COMMON_PRD_WORKFLOW.md
│       ├── feature-prd.md        # 기능 개발용
│       ├── bugfix-prd.md         # 버그 수정용
│       └── refactor-prd.md       # 리팩토링용
│
└── .common/                       # 공통 템플릿
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

### 새 기능 구현 (PRD 기반) 🆕
```bash
/super 사용자 인증 추가
# → PRD 생성 → 범위 확인 → 승인 → 구현

@agent-super -o 결제 시스템 구현
# → 상세 PRD → TASK 분해 → 순차 실행
```

### 빠른 버그 수정
```bash
/super --auto 로그인 버그 수정
# → PRD 생략, 바로 수정
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

### PRD 관리
```bash
# PRD 확인
cat ~/.claude/.prd/current-prd.md

# 완료된 PRD 목록
ls ~/.claude/.prd/archive/

# PRD 재사용 (1시간 이내)
/super 추가 기능 구현
# → 기존 PRD 자동 로드 (토큰 절약)
```

---

## 🤖 자동화 기능 🆕

Vibe Coding Rules는 개발 흐름에 맞춰 자동으로 코드 품질을 관리합니다.

### Git Hooks

#### pre-commit (커밋 전)
```bash
# 자동으로 실행:
- /lint-smart --check    # 코드 품질 검사 (수정 없음)
- Secrets 검사           # 민감 정보 포함 확인
```

#### post-commit (커밋 후)
```bash
# 자동 추천:
- /changelog --unreleased  # CHANGELOG 업데이트
```

### SessionStart Hook

세션 시작 시 자동으로 프로젝트를 분석:
```
═══════════════════════════════════════════════════
🔄 Vibe Coding Rules - 세션 시작
═══════════════════════════════════════════════════

프로젝트: Node.js
최근 커밋: [최근 3개 커밋 표시]
코드 품질 도구: eslint 사용 가능

💡 추천 스킬:
  📝 /changelog         - CHANGELOG 자동 생성
  🔍 /lint-smart        - 코드 품질 검사
  ⚡ /bottleneck       - 성능 병목 분석
```

### 자동 감지 기능

| 상황 | 자동 동작 |
|------|----------|
| 코드 변경 | `/lint-smart` 실행 제안 |
| N+1 쿼리 패턴 | `/bottleneck --db` 실행 제안 |
| Blocking I/O | `/bottleneck --io` 실행 제안 |
| Conventional Commit | `/changelog` 업데이트 제안 |
| 세션 시작 | 프로젝트 분석 후 스킬 추천 |

### 자동화 설정

```json
// .claude/settings.json
{
  "monggle": {
    "autoQuality": {
      "enabled": true,
      "lintOnCommit": true,
      "changelogOnCommit": true,
      "suggestOnEdit": true
    }
  }
}
```

### 자동화 비활성화

```bash
# Git hooks 비활성화
git config --unset hook.pre-commit

# 또는 개별 훅 제거
rm .git/hooks/pre-commit
rm .git/hooks/post-commit
```

---

## 언제 Skill? 언제 Agent?

### 선택 가이드

| 상황 | 추천 | 이유 |
|-----|------|------|
| README 작성 | `/doc-writer` | 빠르고 간단 |
| 간단한 기능 추가 | `/super` | PRD 기반 계획 |
| 복잡한 아키텍처 | `@agent-super -o` | 상세 PRD + 구현 |
| 여러 작업 동시 진행 | `@agent-*` | 병렬 처리 |
| 1시간+ 걸리는 작업 | `@agent-*` | 백그라운드 실행 |
| 빠른 질문 | `/gemini` | 즉각 응답 |

### 원칙

1. **의심스러우면 Skill 먼저** (빠르고 효율적)
2. **Skill로 부족하면 Agent** (강력하지만 느림)
3. **병렬 처리 필요하면 Agent** (동시 실행)
4. **대부분의 경우 Skill로 충분** (95%)
5. **PRD가 필요하면 super** (계획 기반 개발) 🆕

### 실제 예시

```bash
# ✅ 이렇게 하세요
/super 로그인 기능 추가            # 계획 기반 → Skill
/duo 아키텍처 설계                # 협업 → Skill
/doc-writer readme              # 문서 → Skill
/smart-brain                    # 최적화 → Skill

# 🔧 이럴 때만 Agent
@agent-super -o 결제 시스템 설계   # 복잡한 설계 + PRD
@agent-duo 마이크로서비스 설계     # 심층 협업
@agent-run 전체 시스템 리팩토링    # 긴 작업
@agent-super & @agent-duo &      # 병렬 실행
```

---

## 🤖 스킬 자동 추천

Claude는 상황을 감지하여 관련 스킬을 **자동으로 추천**합니다.

### 추천 시나리오

| 상황 | 추천 스킬 | 예시 |
|-----|----------|------|
| 📄 문서 작성 요청 | `/doc-writer` | "README 만들어줘" → `/doc-writer readme` |
| 🔍 코드 품질 확인 | `/lint-smart` | "코드 검사해줘" → `/lint-smart` 🆕 |
| 📝 CHANGELOG 작성 | `/changelog` | "변경사항 정리" → `/changelog` 🆕 |
| ⚡ 성능 문제 | `/bottleneck` | "앱이 느려" → `/bottleneck` 🆕 |
| 🏗️ 설계/아키텍처 질문 | `/duo` | "어떤 아키텍처가 좋을까?" → `/duo` |
| 🚀 프로젝트 초기화 | `/project-init` | "새 React 프로젝트" → `/project-init react` |
| 💰 토큰 최적화 필요 | `/smart-brain` | 세션 시작 시 → `/smart-brain` |
| 📋 기획서 작성 | `/planner` 또는 `/super` | "기획서 작성해줘" → `/super` (PRD) |
| ✨ 막연한 아이디어 | `/super` | "로그인 시스템 만들고 싶어" → `/super` (PRD) |
| 🎯 작업 복잡도 분석 | `/run` | "어떻게 진행하지?" → `/run` |
| 🤖 다른 AI 의견 | `/gemini` | "다른 의견 듣고 싶어" → `/gemini` |
| 🔄 A vs B 비교 | `/duo` | "A vs B 뭐가 나아?" → `/duo` |
| 🔍 검증 필요 | `/gemini -t` | "검증해줘" → `/gemini -t` (논쟁) |

### 추천 예시

```
사용자: "README 만들어줘"
Claude: "README 생성은 `/doc-writer readme` 스킬을 사용하시겠어요?"

사용자: "로그인 기능 추가해줘"
Claude: "기능 개발은 `/super`로 PRD 기반 계획을 먼저 수립하시겠어요?"

사용자: "마이크로서비스 vs 모놀리식"
Claude: "중요한 결정이네요. `@agent-duo`로 심층 분석하시겠어요?"

사용자: "기획서 작성해줘"
Claude: "`/super`로 PRD를 생성하시겠어요? 또는 `/planner`로 간단한 기획서를 만들 수도 있습니다."

사용자: "이 작업 어떻게 진행하지?"
Claude: "`/run`으로 복잡도를 분석하고 최적 모델을 추천해드릴까요?"
```

### 추천 규칙

- ✅ **자동 감지**: 상황에 맞는 스킬 추천
- ✅ **명령어 포함**: 바로 사용 가능한 명령어 제시
- ✅ **Skill 우선**: 빠르고 효율적인 Skill 먼저 추천
- ✅ **사용자 선택**: 강요하지 않음 (선택사항)
- ✅ **복잡하면 Agent**: 필요시 Agent 제안
- ✅ **PRD 우선**: 기능 개발 시 `/super` 추천 (계획 기반) 🆕

---

## 🔧 문제 해결

### Skill이 작동 안 함
```bash
# 1. 파일 존재 확인
ls ~/.claude/commands/*.md

# 2. 권한 확인
chmod +x ~/.claude/commands/*.md

# 3. Claude Code 재시작
```

### Agent가 작동 안 함
```bash
# 1. install.sh 실행 확인
cd ~/.claude/commands && ./install.sh

# 2. Agent 파일 확인
ls ~/.claude/agents/*.md

# 3. PRD 디렉토리 확인
ls ~/.claude/.prd/templates/

# 4. Claude Code 재시작
```

### PRD 관련 오류 🆕
```bash
# PRD 디렉토리 수동 생성
mkdir -p ~/.claude/.prd/{archive,templates}

# 템플릿 파일 확인
ls ~/.claude/.prd/templates/

# 템플릿이 없으면 재설치
cd ~/.claude/commands && ./install.sh

# PRD 캐시 초기화
rm ~/.claude/.prd/current-prd.md
```

### Gemini API 오류
```bash
# API 키 확인
cat ~/.gemini/config

# API 키 재설정
mkdir -p ~/.gemini
echo "YOUR_API_KEY" > ~/.gemini/config
chmod 600 ~/.gemini/config

# API 키 발급: https://aistudio.google.com/apikey
```

### 명령어 자동완성 안 됨
```bash
# Claude Code 버전 확인 (v1.0.62+ 필요)
claude --version

# 업데이트
# macOS: brew upgrade claude-code
# 또는 https://claude.ai/download에서 최신 버전 다운로드
```

---

## 📋 요구사항

- **Claude Code CLI**: v1.0.62+ (@ 멘션 지원)
  - macOS: `brew install claude-code`
  - 또는 https://claude.ai/download
- **Git**: 저장소 클론용
- **Gemini API** (선택): `gemini`, `duo` 기능 사용 시
  - 무료 발급: https://aistudio.google.com/apikey
- **Disk Space**: ~50MB (PRD 디렉토리 포함) 🆕

---

## 설치 확인

```bash
# 에이전트 자동완성 테스트
@agent-<Tab>

# 스킬 목록 확인
ls ~/.claude/commands/*.md

# PRD 템플릿 확인
ls ~/.claude/.prd/templates/

# Gemini API 테스트
@agent-gemini hello

# PRD 워크플로우 테스트
/super --help
```

---

## 기여

이슈 및 PR 환영합니다!

**Repository**: https://github.com/loboking/claude-code-skills

---

## 버전 이력

### v2.1 (2026-03-31) 🆕
- ✨ **코드 품질 스킬 추가** (`/lint-smart`)
  - 프로젝트 자동 감지 (JS/TS, Python, Go, Java, Ruby, Rust, PHP)
  - eslint, flake8, golangci-lint, rubocop, clippy 등 자동 선택
- ✨ **문서 자동화 스킬 추가** (`/changelog`)
  - Git 커밋 기반 CHANGELOG.md 자동 생성
  - Conventional Commits 파싱
  - Keep a Changelog 형식 지원
  - 자동 버전 증가 (major/minor/patch)
- ✨ **성능 분석 스킬 추가** (`/bottleneck`)
  - 성능 병목 지점 찾기
  - py-spy, pprof, clinic.js 지원
  - 플레임그래프 생성

### v2.0 (2026-01-22)
- ✨ PRD 기반 워크플로우 추가 (`super`, `duo`, `run`)
- ✨ 기본 Plan Mode (승인 후 실행)
- ✨ `--auto` 플래그 (Free Pass 모드)
- ✨ `--skip-prd` 플래그 (PRD 생략, 위험 경고)
- ✨ 범위 제한 강제 (PRD 기반 파일 목록)
- ✨ PRD 템플릿 3종 (feature, bugfix, refactor)
- ✨ PRD 캐싱 (1시간 TTL, 토큰 30-50% 절약)
- ✨ Self-Review Round 0 (PRD 검증)
- ✨ Self-Review Round 4 (범위 준수)
- ✨ Post-Execution PRD 완료 처리

### v1.0 (2025-12)
- 초기 릴리스
- Skill & Agent 시스템
- Claude + Gemini 협업
- 스마트 오케스트레이션

---

## 라이선스

MIT License
