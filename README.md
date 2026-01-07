# Claude Code Custom Skills

커스텀 Claude Code 스킬 모음입니다. AI 협업, 프롬프트 최적화, 스마트 오케스트레이션을 지원합니다.

## 📦 설치

```bash
git clone https://github.com/loboking/claude-code-skills.git ~/.claude/commands
```

## 🏷️ monggle- 접두사

모든 스킬은 `monggle-` 접두사로도 사용 가능합니다 (자동완성 활용):

```bash
# 기존 방식
/gemini, /super, /duo, /run, /smart-brain, /project-init

# monggle 접두사 (Tab 자동완성)
/monggle-gemini, /monggle-super, /monggle-duo
/monggle-run, /monggle-brain, /monggle-init
```

**장점**:
- `/mong<Tab>` 입력으로 모든 커스텀 스킬 목록 표시
- 공식 스킬과 구분 용이
- 기존 이름도 그대로 사용 가능

## 🛠️ 스킬 목록

### 1. `/gemini` - Gemini 서브에이전트 호출

Gemini API를 활용한 서브에이전트 호출 및 Claude-Gemini 논쟁 모드를 지원합니다.

**기본 사용법**:
```bash
/gemini 질문 내용
/gemini -h 질문  # haiku 모델
/gemini -s 질문  # sonnet 모델 (기본값)
/gemini -o 질문  # opus 모델
```

**논쟁 모드** (`-t` 옵션):
```bash
/gemini -t "주제"
/gemini -h -t "주제"  # haiku로 논쟁
/gemini -o -t "주제"  # opus로 논쟁
```
- Claude와 Gemini가 주제에 대해 10회 왕복 논쟁
- "계속" 입력 시 +10회 연장
- 합의점과 이견을 정리하여 최종 권장사항 제시

**특징**:
- 외부 AI 관점 활용으로 다양성 확보
- 토큰 관리 최적화 (요약 전송)
- 한국어 지원

---

### 2. `/super` - 슈퍼 프롬프트 생성

간단한 요청을 구체적인 요구사항으로 확장합니다.

**사용법**:
```bash
/super 구현 요청
/super -h 간단한 요청  # haiku
/super -s 중간 요청    # sonnet (기본값)
/super -o 복잡한 요청  # opus
```

**워크플로우**:
1. 의도 분석 (WHO/WHAT/WHY)
2. 프로젝트 컨텍스트 탐색 (Glob/Grep)
3. 요구사항 도출 (기능/비기능/예외 케이스)
4. 사용자 확인: 실행|수정|취소

**출력 예시**:
```
Goal: [한 문장 요약]
Requirements: [번호 목록]
Tech spec: 프레임워크, 파일 경로, 참조 코드
Exceptions/Tests: [필요시]
```

---

### 3. `/duo` - Claude + Gemini 협업

Claude와 Gemini가 2회 핑퐁 후 합의하여 구현합니다.

**사용법**:
```bash
/duo 구현 요청
/duo -h 간단한 구현  # haiku
/duo -s 중간 구현    # sonnet (기본값)
/duo -o 복잡한 구현  # opus
```

**워크플로우**:
1. **Phase 1**: Super 프롬프트 분석
2. **Phase 2**: Gemini 2회 협업
   - Round 1: Gemini 의견 수렴
   - Round 2: Claude 접근법 피드백
3. **Phase 3**: 합의 사항 보고
4. 사용자 확인 후 실행

**특징**:
- 두 AI의 강점 결합
- 투명한 의견 공개
- 갈등 시 사용자 결정

---

### 4. `/run` - 스마트 오케스트레이터

작업 복잡도를 분석하여 최적의 모델/에이전트를 자동 선택합니다.

**사용법**:
```bash
# 자동 분석 후 추천
/run 구현 요청

# 모델 지정 즉시 실행
/run -h 간단한 작업  # haiku
/run -s 중간 작업    # sonnet
/run -o 복잡한 작업  # opus

# 계획만 보기
/run --dry 작업
```

**옵션**:
- **모델**: `-h` (haiku) | `-s` (sonnet) | `-o` (opus)
- **저장**: `--temp` (임시) | `--save` (영구)
- **실행**: `--parallel` | `--seq` | `--dry`
- **스킵**: `--no-mcp` | `--no-gemini` | `--no-hook`
- **컨텍스트**: `--fresh` (/clear 권장) | `--compact`

**자동 탐지**:
- 프로젝트 타입 (Python/Android/React/Go/Rust/Swift)
- 필요한 에이전트 (프로젝트 컨텍스트 반영)
- MCP 서버 추천
- 훅 자동 적용

**특징**:
- 성능 우선 모델 선택
- 병렬 처리 최적화
- 한국어 실행 계획

---

### 5. `/smart-brain` - 프로젝트별 토큰 최적화

현재 프로젝트의 `CLAUDE.md`에 토큰 절약 규칙을 추가합니다.

**사용법**:
```bash
cd /your/project
/smart-brain
```

**추가되는 규칙**:
- **diff-only**: 변경 부분만 출력
- **참조 우선**: `파일명:라인번호` 형식 사용
- **중복 축약**: 반복 패턴 축약
- **코드 우선**: 긴 설명 대신 실행 가능한 코드
- **재작업 방지**: 보안/에러/성능/타입 체크
- **금지 패턴**: 불필요한 기능 추가, 과도한 로그, 미사용 코드

**효과**:
- 세션당 20-40% 토큰 절약 예상
- 기존 CLAUDE.md 보존 (섹션만 추가/업데이트)

---

### 6. `/project-init` - 스마트 프로젝트 초기화

Plan Mode로 프로젝트 구조를 설계한 후 자동으로 초기화합니다.

**사용법**:
```bash
# 자동 감지
/project-init

# 타입 지정
/project-init react
/project-init -t nextjs -n my-blog

# 계획만 보기
/project-init --dry flutter
```

**지원 프로젝트**:
- **Web**: React, Next.js, Vue, Vite
- **Mobile**: Flutter, React Native, Android, iOS
- **Backend**: Spring Boot, FastAPI, Express, Go, Rust
- **Desktop**: Electron, Tauri

**워크플로우**:
1. **프로젝트 타입 선택** (자동 감지 또는 사용자 지정)
2. **Plan Mode 진입** - 디렉토리 구조, 의존성, 설정 파일 계획
3. **사용자 승인** - 실행|수정|취소
4. **자동 실행**:
   - CLI 명령어 실행 (`npx create-react-app`, `flutter create` 등)
   - 설정 파일 생성 (`.gitignore`, `README.md`, `CLAUDE.md`)
   - 린팅/포매팅 설정
   - Git 초기화 및 첫 커밋

**생성되는 파일**:
- `README.md` (프로젝트 설명, 설치 방법, 개발 가이드)
- `CLAUDE.md` (토큰 최적화 규칙 포함)
- `.gitignore` (타입별 템플릿)
- 타입별 설정 파일 (`tsconfig.json`, `build.gradle`, `pubspec.yaml` 등)

**옵션**:
- `-t, --type [type]`: 프로젝트 타입 명시
- `-n, --name [name]`: 프로젝트 이름
- `--no-git`: Git 초기화 건너뛰기
- `--no-deps`: 의존성 설치 건너뛰기
- `--dry`: 계획만 보기 (실행 안함)
- `-m [model]`: Plan Mode 모델 선택

**특징**:
- Plan Mode 필수 진입 (계획 없이 실행 불가)
- 프로덕션 수준 설정
- 타입 안전 기본값 (TypeScript, strict linting)
- 다음 단계 가이드 제공

---

## 🎯 사용 시나리오

### 시나리오 1: 새 프로젝트 시작
```bash
# 1. 프로젝트 초기화 (Plan Mode)
/project-init react

# 2. 구조 확인 → 실행
# → 자동으로 React + TypeScript + Tailwind 설정
# → README, CLAUDE.md, .gitignore 생성
# → Git 초기화 및 첫 커밋

# 3. 첫 기능 구현
/super 로그인 페이지 추가
```

### 시나리오 2: 새 기능 구현
```bash
/super 사용자 인증 기능 추가
# → 요구사항 확인
# → 실행 선택
```

### 시나리오 3: 복잡한 아키텍처 결정
```bash
/duo 마이크로서비스 vs 모놀리식 선택
# → Claude + Gemini 협업
# → 합의 기반 구현
```

### 시나리오 4: 대규모 리팩토링
```bash
/run -o 전체 코드베이스 리팩토링
# → Opus 모델 자동 선택
# → 프로젝트 타입 탐지
# → 최적 에이전트 활용
```

### 시나리오 5: 외부 관점 필요
```bash
/gemini -t "REST vs GraphQL"
# → 10회 논쟁
# → 다각도 분석
# → 합의/이견 정리
```

---

## 📋 요구사항

- **Claude Code CLI**: 최신 버전
- **Gemini API** (gemini-agent): `/gemini`, `/duo`에 필요
- **Git**: 저장소 관리용

---

## 🔧 고급 사용법

### 워크플로우 체이닝

**완전한 프로젝트 워크플로우**:
```bash
# 1. 프로젝트 초기화
/project-init nextjs -n my-app

# 2. 토큰 최적화 (자동 포함되지만 추가 커스터마이징 가능)
/smart-brain

# 3. 요구사항 확장
/super 블로그 시스템 추가

# 4. AI 협업으로 검증
/duo [요구사항]

# 5. 최적 모델로 실행
/run -o [최종 구현]
```

**기존 프로젝트 개선**:
```bash
# 1. 토큰 최적화 적용
/smart-brain

# 2. 요구사항 확장
/super 새 기능 추가

# 3. AI 협업으로 검증
/duo [요구사항]

# 4. 최적 모델로 실행
/run -o [최종 구현]
```

### 프로젝트별 커스터마이징
각 프로젝트의 `CLAUDE.md`에 스킬별 기본 옵션 설정 가능:
```markdown
## Custom Skill Defaults
- /run: --no-mcp (MCP 비활성)
- /duo: --temp (임시 파일만)
```

---

## 🤝 기여

이슈 및 PR 환영합니다!

**Repository**: https://github.com/loboking/claude-code-skills

---

## 📄 라이선스

MIT License
