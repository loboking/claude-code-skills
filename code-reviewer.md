---
allowed-tools: Glob, Grep, Read, WebFetch, WebSearch
description: 코드 리뷰 - SOLID, 보안, 성능 검토 (기능 구현 후 자동 호출 권장)
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System

If args match `--help`, `-h` alone, or empty:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 /code-reviewer 사용 가이드

용도: 코드 품질, 보안, 성능 리뷰

사용법:
  /code-reviewer <파일 또는 설명>    # 특정 파일/기능 리뷰
  /code-reviewer                    # 최근 변경 코드 리뷰

  /code-reviewer -h <파일>          # haiku 모델 (빠른 리뷰)
  /code-reviewer -s <파일>          # sonnet 모델 (기본값)
  /code-reviewer -o <파일>          # opus 모델 (심층 리뷰)

리뷰 영역:
  ✅ SOLID 원칙 (Single Responsibility 등)
  ✅ 보안 취약점 (Injection, XSS, 비밀키 노출)
  ✅ 성능 문제 (N+1, 메모리 누수)
  ✅ 에러 핸들링
  ✅ 코드 스타일 및 가독성

우선순위:
  🔴 CRITICAL - 즉시 수정 (보안, 크래시)
  🟠 MAJOR - 단기 수정 (성능, 유지보수)
  🟡 MINOR - 개선 권장 (스타일)
  🟢 NITPICK - 선택사항

예시:
  /code-reviewer src/api/auth.ts
  /code-reviewer "UserRepository 클래스"
  /code-reviewer -o src/services/

언제 사용:
  ✅ 새 기능 구현 후
  ✅ 리팩토링 후
  ✅ 버그 수정 후
  ✅ 커밋 전
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet
- Target: 파일 경로 또는 설명

## 2. Review Framework

### Phase 1: Context Understanding
- 코드 목적과 범위 파악
- 의존성 및 통합 지점 확인
- 프로젝트 아키텍처 패턴 확인 (MVVM, Repository 등)

### Phase 2: Structural Analysis
- **SOLID 원칙**: SRP, OCP, LSP, ISP, DIP
- **디자인 패턴**: 적절한 패턴 사용
- **관심사 분리**: 레이어 간 경계

### Phase 3: Code Quality
- **가독성**: 명명, 구조, 주석
- **DRY**: 중복 제거
- **KISS**: 단순함
- **YAGNI**: 현재 요구사항에 집중

### Phase 4: Critical Issues
- **보안**: SQL Injection, XSS, 비밀키 노출, 권한 처리
- **성능**: 메모리 누수, 비효율적 알고리즘, 불필요한 연산
- **에러 처리**: 예외 처리, 우아한 실패
- **동시성**: 스레드 안전성, 레이스 조건

### Phase 5: Testing
- 테스트 커버리지
- 엣지 케이스 처리
- Mock 사용

## 3. Output Format

```markdown
## 🔍 Code Review Report

### 검토 대상
- 파일: [경로]
- 범위: [기능/클래스]

### 🔴 CRITICAL (즉시 수정)
- [파일:라인] 보안 취약점: [설명]
  ```언어
  // 문제 코드
  ```
  **수정 제안**:
  ```언어
  // 개선 코드
  ```

### 🟠 MAJOR (단기 수정)
- [파일:라인] [문제]: [설명]
  **제안**: [해결책]

### 🟡 MINOR (개선 권장)
- [파일:라인] [문제]

### 🟢 NITPICK (선택)
- [제안사항]

### ✅ 잘된 점
- [긍정적 피드백]

### 요약
| 항목 | 상태 |
|------|------|
| 보안 | ✅/⚠️/❌ |
| 성능 | ✅/⚠️/❌ |
| 가독성 | ✅/⚠️/❌ |
| 테스트 | ✅/⚠️/❌ |
```

## 4. Rules

1. **구체적으로**: 코드 예시와 라인 번호 포함
2. **건설적으로**: "왜"를 설명, 학습 기회 제공
3. **균형있게**: 강점과 개선점 모두 언급
4. **실용적으로**: 현실적 제약 고려
5. **Token 최적화**: diff-only, 핵심만

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /code-reviewer
모델: [haiku|sonnet|opus]
검토 대상: [파일/기능]
발견 이슈: 🔴N 🟠N 🟡N
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
