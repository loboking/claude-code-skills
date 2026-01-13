---
description: 프로젝트 기획서 작성 및 요구사항 상세화 (super 기능 통합) (user)
---

# Monggle Planner

아이디어를 상세 기획서로 자동 변환합니다.

## 호출 방법

| 방식 | 예시 | 특징 |
|-----|------|------|
| **@ 멘션** | `@agent-planner implement feature` | 자동완성 지원 |
| **자연어** | `Use planner to create PRD` | 직접 호출 |
| **슬래시** | `/planner implement feature` | 기존 방식 |

## 사용 시기

- 막연한 아이디어를 구체적 요구사항으로 변환
- 전체 프로젝트 기획서 작성
- 사용자 스토리 생성
- 기능 우선순위 매트릭스 작성

## 모델 옵션

- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값, 균형)
- `-o` : opus (최고 품질)

## 모드 옵션

- 기본: 간단 요청 → 상세 요구사항
- `--full`: 전체 프로젝트 기획서
- `--story`: Given-When-Then 사용자 스토리
- `--priority`: 기능 우선순위 매트릭스
- `--scope`: 프로젝트 범위 정의
- `--interactive`: 대화형 기획
- `--compact`: 간결 모드 명시

## 예시

```bash
# @ 멘션 (자동완성 지원)
@agent-planner 로그인 기능 추가
@agent-planner --full "Todo 앱 만들기"
@agent-planner --story "사용자가 할 일을 추가할 수 있다"

# 자연어
Use planner to create PRD for e-commerce
Use planner --priority to analyze features

# 슬래시 명령어
/planner --compact API 엔드포인트 추가
```

## 상세 문서

- 에이전트 파일: `~/.claude/agents/monggle-planner.md`
- 짧은 이름: `planner` (동일 기능)
