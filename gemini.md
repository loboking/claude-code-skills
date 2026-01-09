---
description: Gemini 서브에이전트 호출 (user)
---

# Monggle Gemini

Gemini AI 서브에이전트를 호출하여 질문하거나 논쟁 모드를 실행합니다.

## 호출 방법

| 방식 | 예시 | 특징 |
|-----|------|------|
| **@ 멘션** | `@agent-monggle-gemini question` | 자동완성 지원 |
| **자연어** | `Use monggle-gemini to ask question` | 직접 호출 |
| **슬래시** | `/monggle-gemini question` | 기존 방식 |

## 사용 시기

- 다른 AI 관점이 필요할 때
- 논쟁을 통한 심층 분석
- 코드 구현 전 아이디어 검증

## 모델 옵션

- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값, 균형)
- `-o` : opus (최고 품질)
- `-t` : 논쟁 모드 (Claude vs Gemini)

## 예시

```bash
# @ 멘션 (자동완성 지원)
@agent-monggle-gemini Python 비동기 프로그래밍 설명해줘
@agent-monggle-gemini -t "TDD vs BDD 어느게 더 나은가?"

# 자연어
Use monggle-gemini to explain React optimization
Use monggle-gemini -t to debate microservices vs monolith

# 슬래시 명령어
/monggle-gemini -s React 최적화 패턴은?
```

## 워크플로우

### 일반 모드
```
질문 → Gemini 호출 → 결과 정리 → 사용자 전달
```

### 논쟁 모드 (-t)
```
주제 → Claude 주장 → Gemini 반박 → N회 반복 → 결론
```

## 상세 문서

- 에이전트 파일: `~/.claude/agents/monggle-gemini.md`
- 짧은 이름: `gemini` (동일 기능)
