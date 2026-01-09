---
description: Claude + Gemini 동적 협업 (복잡한 설계 검증, 다양한 관점 비교)
---

# Monggle Duo

Claude와 Gemini가 동적으로 협업하여 합의 도출 후 구현합니다.

## 호출 방법

| 방식 | 예시 | 특징 |
|-----|------|------|
| **@ 멘션** | `@agent-monggle-duo implement feature` | 자동완성 지원 |
| **자연어** | `Use monggle-duo to implement feature` | 직접 호출 |
| **슬래시** | `/monggle-duo implement feature` | 기존 방식 |

## 사용 시기

- 설계 검증이 필요한 복잡한 구현
- 여러 접근법 비교 필요
- 다양한 관점이 필요한 고위험 변경사항
- 트레이드오프가 있는 아키텍처 결정

## 모델 옵션

- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값, 균형)
- `-o` : opus (최고 품질)

## 예시

```bash
# @ 멘션 (자동완성 지원)
@agent-monggle-duo add logout button
@agent-monggle-duo -o design payment architecture

# 자연어
Use monggle-duo to implement login feature
Use monggle-duo -o to design microservices

# 슬래시 명령어
/monggle-duo implement user registration
```

## 상세 문서

- 에이전트 파일: `~/.claude/agents/monggle-duo.md`
- 짧은 이름: `duo` (동일 기능)
