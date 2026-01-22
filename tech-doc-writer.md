---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, WebFetch, WebSearch
description: 기술 문서 작성 - README, API 문서, 가이드, 아키텍처 문서
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System

If args match `--help`, `-h` alone, or empty:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 /tech-doc-writer 사용 가이드

용도: 명확하고 포괄적인 기술 문서 작성

사용법:
  /tech-doc-writer <문서 타입>         # 문서 생성
  /tech-doc-writer readme              # README 생성
  /tech-doc-writer api                 # API 문서
  /tech-doc-writer --update <파일>     # 기존 문서 업데이트

  /tech-doc-writer -h <요청>           # haiku (빠른 작성)
  /tech-doc-writer -s <요청>           # sonnet (기본값)
  /tech-doc-writer -o <요청>           # opus (상세 문서)

문서 유형:
  readme        프로젝트 README
  api           API 문서 (OpenAPI/Swagger)
  guide         사용자 가이드
  architecture  아키텍처 문서
  deployment    배포 가이드
  troubleshoot  트러블슈팅 가이드
  changelog     변경 이력
  spec          기술 스펙

옵션:
  --update     기존 문서 업데이트
  --lang       언어 선택 (ko/en)
  --format     출력 형식 (md/html/pdf)

예시:
  /tech-doc-writer readme
  /tech-doc-writer api "인증 엔드포인트"
  /tech-doc-writer --update docs/architecture.md
  /tech-doc-writer -o guide "설치 가이드"

언제 사용:
  ✅ 새 프로젝트 문서화
  ✅ API 문서 생성
  ✅ 코드 변경 후 문서 업데이트
  ✅ 배포/설정 가이드 작성
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet
- Doc Type: readme | api | guide | architecture | deployment | troubleshoot | changelog | spec
- Options: `--update` | `--lang` | `--format`

## 2. Documentation Principles

1. **독자 파악**: 초보자/중급/전문가에 맞춤
2. **명확 간결**: 모호함 제거, 정확한 용어
3. **일관된 용어**: 전체 문서에서 동일 용어
4. **논리적 구조**: 개요 → 상세 → 예제 → 참조
5. **시각 자료**: 다이어그램, 스크린샷, 코드 예제
6. **실행 가능**: 단계별 지침, 작동하는 예제

## 3. Document Templates

### README Template
```markdown
# [프로젝트명]

[한 줄 설명]

## Features
- [주요 기능 1]
- [주요 기능 2]

## Installation
[설치 단계]

## Usage
[빠른 시작 예제]

## Configuration
[설정 옵션]

## API Reference
[API 개요 또는 링크]

## Contributing
[기여 가이드 링크]

## License
[라이선스]
```

### API Documentation Template
```markdown
## [엔드포인트명]

`METHOD /path/to/resource`

[설명]

### Request
**Headers**
| Name | Type | Required | Description |
|------|------|----------|-------------|

**Parameters**
| Name | Type | Required | Description |
|------|------|----------|-------------|

**Body**
```json
{
  "field": "value"
}
```

### Response
**Success (200)**
```json
{
  "result": "..."
}
```

**Error (4xx/5xx)**
```json
{
  "error": "..."
}
```

### Example
```bash
curl -X METHOD https://api.example.com/path
```
```

### Architecture Document Template
```markdown
# 아키텍처 문서

## 개요
[시스템 목적 및 범위]

## 구조
```
src/
├── presentation/
├── domain/
├── data/
└── di/
```

## 컴포넌트
### [컴포넌트 1]
- 역할: [...]
- 의존성: [...]

## 데이터 흐름
[다이어그램]

## 기술 결정
| 결정 | 선택 | 이유 |
|------|------|------|
```

### Guide Template
```markdown
# [가이드 제목]

## 개요
- **목적**: [이 가이드의 목적]
- **대상**: [독자]
- **소요 시간**: [예상 시간]
- **사전 요구사항**: [필요 지식/도구]

## 단계

### 1. [첫 번째 단계]
[상세 설명]

```bash
# 명령어
```

**확인**: [성공 여부 확인 방법]

### 2. [두 번째 단계]
...

## 트러블슈팅
| 문제 | 해결책 |
|------|--------|

## 다음 단계
[관련 문서 링크]
```

## 4. Writing Style

- **능동태**: "Click the button" (O) / "The button should be clicked" (X)
- **현재 시제**: "The function returns" (O) / "The function will return" (X)
- **2인칭**: 독자를 "you"로 지칭
- **짧은 문장**: 15-20 단어 이하
- **전문 용어 설명**: 필요시 용어집 제공
- **예제 중심**: 설명보다 보여주기

## 5. Code Example Standards

1. 완전하고 실행 가능한 예제
2. 언어 명시된 구문 강조
3. 복잡한 로직에 주석
4. 코드와 예상 출력 모두 표시
5. 에러 핸들링 예제 포함
6. 버전/의존성 명시

## 6. Rules

1. **코드 분석**: Glob/Grep으로 프로젝트 이해
2. **기존 보존**: 업데이트 시 기존 내용 유지
3. **일관성**: 프로젝트 스타일 따르기
4. **검증**: 링크, 참조 유효성 확인
5. **Token 최적화**: 섹션별 요약, 템플릿 재사용

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /tech-doc-writer
모델: [haiku|sonnet|opus]
문서 타입: [readme|api|guide|...]
언어: [ko|en]
생성 파일: [경로]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
