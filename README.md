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

3가지 방식으로 호출할 수 있습니다:

| 방식 | 예시 | 특징 |
|-----|------|------|
| **@ 멘션** | `@agent-duo implement feature` | 자동완성 지원 (권장) |
| **자연어** | `Use duo to implement feature` | 직접 호출 |
| **슬래시** | `/duo implement feature` | 레거시 방식 |

**@ 멘션 사용법:**
```bash
@agent-       # 입력 후 Tab → 모든 에이전트 자동완성
@agent-duo    # duo 에이전트
@agent-run    # run 에이전트
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

## 주요 에이전트

### 🤝 duo - Claude + Gemini 동적 협업

Claude와 Gemini가 합의할 때까지 동적으로 협업합니다.

```bash
@agent-duo 마이크로서비스 설계
@agent-duo -o 결제 시스템 아키텍처
```

| 속성 | 값 |
|-----|-----|
| **속도** | 🐌 느림 (다중 라운드) |
| **토큰** | 💰💰💰 높음 |
| **품질** | ⭐⭐⭐⭐⭐ 최고 |
| **사용 시기** | 복잡한 설계 결정 |

**사용 시기:**
- 설계 검증이 필요한 복잡한 구현
- 여러 접근법 비교 필요
- 트레이드오프가 있는 아키텍처 결정

---

### 🎯 run - 스마트 오케스트레이터

작업 복잡도를 분석하여 최적의 모델/에이전트를 자동 선택합니다.

```bash
@agent-run 코드 리팩토링           # 자동 분석 후 추천
@agent-run -h README 수정          # haiku로 즉시 실행
@agent-run -o 전체 아키텍처 설계   # opus로 즉시 실행
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡ 가변 (선택된 모델에 따라) |
| **토큰** | 💰 가변 |
| **품질** | ⭐⭐⭐⭐ 최적화됨 |
| **특징** | 자동 모델 선택 |

**옵션:**
- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값)
- `-o` : opus (최고 품질)

---

### ⚡ super - 슈퍼 프롬프트 생성

간단한 요청을 상세 요구사항으로 자동 확장합니다.

```bash
@agent-super 로그인 기능 추가
@agent-super --compact API 엔드포인트
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡ 빠름 |
| **토큰** | 💰 낮음 |
| **품질** | ⭐⭐⭐⭐ 우수 |
| **특징** | 간결 모드 지원 |

**자동 간결 모드:**
- <15단어: Ultra-Compact
- 15-29단어: Compact
- 30+단어: Full

---

### 🤖 gemini - Gemini 서브에이전트

Gemini AI를 호출하거나 논쟁 모드를 실행합니다.

```bash
@agent-gemini React 최적화 패턴은?
@agent-gemini -t "TDD vs BDD"      # 논쟁 모드
```

| 속성 | 값 |
|-----|-----|
| **속도** | ⚡⚡⚡ 매우 빠름 |
| **토큰** | 💰 낮음 (Gemini API) |
| **품질** | ⭐⭐⭐ 양호 |
| **특징** | 논쟁 모드 지원 |

---

## 개발 지원 에이전트

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
