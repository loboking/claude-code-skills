# Claude Code Custom Skills

커스텀 Claude Code 스킬 및 에이전트 모음입니다.

## 설치

```bash
git clone https://github.com/loboking/claude-code-skills.git ~/.claude/commands
```

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
| **@ 멘션** | `@agent-duo implement feature` | 자동완성 지원 |
| **자연어** | `Use duo to implement feature` | 직접 호출 |
| **슬래시** | `/duo implement feature` | 기존 방식 |

**@ 멘션 사용법:**
```bash
@agent-       # 입력 후 Tab → 모든 에이전트 자동완성
@agent-duo    # duo 에이전트
@agent-run    # run 에이전트
```

## 에이전트 목록

### duo - Claude + Gemini 동적 협업

Claude와 Gemini가 합의할 때까지 동적으로 협업합니다.

```bash
@agent-duo 마이크로서비스 설계
@agent-duo -o 결제 시스템 아키텍처
```

**사용 시기:**
- 설계 검증이 필요한 복잡한 구현
- 여러 접근법 비교 필요
- 트레이드오프가 있는 아키텍처 결정

---

### run - 스마트 오케스트레이터

작업 복잡도를 분석하여 최적의 모델/에이전트를 자동 선택합니다.

```bash
@agent-run 코드 리팩토링           # 자동 분석 후 추천
@agent-run -h README 수정          # haiku로 즉시 실행
@agent-run -o 전체 아키텍처 설계   # opus로 즉시 실행
```

**옵션:**
- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값)
- `-o` : opus (최고 품질)

---

### super - 슈퍼 프롬프트 생성

간단한 요청을 상세 요구사항으로 자동 확장합니다.

```bash
@agent-super 로그인 기능 추가
@agent-super --compact API 엔드포인트
```

**자동 간결 모드:**
- <15단어: Ultra-Compact
- 15-29단어: Compact
- 30+단어: Full

---

### gemini - Gemini 서브에이전트

Gemini AI를 호출하거나 논쟁 모드를 실행합니다.

```bash
@agent-gemini React 최적화 패턴은?
@agent-gemini -t "TDD vs BDD"      # 논쟁 모드
```

---

### planner - 프로젝트 기획서 작성

아이디어를 상세 기획서로 변환합니다.

```bash
@agent-planner 로그인 기능 추가
@agent-planner --full "Todo 앱"
@agent-planner --story "할 일 추가"
```

**모드:**
- 기본: 상세 요구사항
- `--full`: 전체 기획서
- `--story`: Given-When-Then 스토리
- `--priority`: 우선순위 매트릭스

---

### project-init - 스마트 프로젝트 초기화

Plan Mode로 프로젝트를 설계하고 자동 초기화합니다.

```bash
@agent-project-init react
@agent-project-init -t nextjs -n my-app
```

**지원:** React, Next.js, Flutter, Android, iOS, Spring Boot, FastAPI, Go, Rust

---

## 스킬 목록 (슬래시 명령어)

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
~/.claude/
├── commands/           # 스킬 (슬래시 명령어)
│   ├── duo.md         # → 에이전트 안내
│   ├── run.md         # → 에이전트 안내
│   ├── super.md       # → 에이전트 안내
│   ├── gemini.md      # → 에이전트 안내
│   ├── planner.md     # 스킬 (상세 로직)
│   ├── project-init.md
│   ├── doc-writer.md
│   ├── smart-brain.md
│   └── monggle-*      # 심볼릭 링크
│
└── agents/             # 에이전트 (상세 로직)
    ├── monggle-duo.md
    ├── monggle-run.md
    ├── monggle-super.md
    ├── monggle-gemini.md
    └── duo.md, run.md, etc.  # 심볼릭 링크
```

---

## 사용 시나리오

### 새 프로젝트 시작
```bash
@agent-project-init react
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

### 대규모 작업
```bash
@agent-run -o 전체 리팩토링
# → Opus 자동 선택 → 최적 실행
```

---

## 요구사항

- **Claude Code CLI**: 최신 버전
- **Gemini API**: `gemini`, `duo` 에이전트용
- **Git**: 저장소 관리

---

## 기여

이슈 및 PR 환영합니다!

**Repository**: https://github.com/loboking/claude-code-skills

---

## 라이선스

MIT License
