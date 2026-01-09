---
description: 슈퍼 프롬프트 생성 - 간단 요청을 상세 요구사항으로 확장 (user)
---

# Monggle Super

간단한 요청을 상세 요구사항으로 자동 확장합니다.

## 호출 방법

| 방식 | 예시 | 특징 |
|-----|------|------|
| **@ 멘션** | `@agent-monggle-super implement feature` | 자동완성 지원 |
| **자연어** | `Use monggle-super to analyze request` | 직접 호출 |
| **슬래시** | `/monggle-super implement feature` | 기존 방식 |

## 사용 시기

- 막연한 아이디어를 구체적 요구사항으로 변환
- 구현 전 요구사항 명확화
- 예외 케이스 누락 방지
- 테스트 전략 수립

## 모델 옵션

- `-h` : haiku (빠른 실행)
- `-s` : sonnet (기본값, 균형)
- `-o` : opus (최고 품질)
- `--compact` : 간결 모드 (자동 감지)

## 예시

```bash
# @ 멘션 (자동완성 지원)
@agent-monggle-super 로그인 기능 추가
@agent-monggle-super -o 결제 시스템 설계
@agent-monggle-super --compact API 엔드포인트 추가

# 자연어
Use monggle-super to analyze login feature
Use monggle-super -o to design payment system

# 슬래시 명령어
/monggle-super 성능 개선
```

## 워크플로우

```
간단 요청 → 분석 → 상세 요구사항 → 실행|수정|취소
```

## 특징

- WHO/WHAT/WHY 분석
- 기능/비기능 요구사항 도출
- 예외 케이스 자동 탐지
- 테스트 요건 포함
- 토큰 최적화 (자동 간결 모드)

## 상세 문서

- 에이전트 파일: `~/.claude/agents/monggle-super.md`
- 짧은 이름: `super` (동일 기능)
