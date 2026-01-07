---
allowed-tools: Read, Grep, Glob, Task
description: Convert simple request to detailed super prompt (user)
---
Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /super 사용 가이드

용도: 간단한 요청을 상세한 슈퍼 프롬프트로 변환

사용법:
  /super <구현 요청>               # 기본 (sonnet)
  /super -h <구현 요청>            # haiku 모델
  /super -s <구현 요청>            # sonnet 모델
  /super -o <구현 요청>            # opus 모델

옵션:
  -h, --haiku      빠른 실행 (간단한 작업)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 작업)
  --help           이 도움말 표시

예시:
  /super 사용자 인증 API 만들기
  /super -o 마이크로서비스 아키텍처 설계
  /super -h TODO 리스트 컴포넌트

언제 사용:
  ✅ 요구사항을 체계적으로 정리하고 싶을 때
  ✅ Edge case와 예외 처리 검토 필요
  ✅ 구현 전 명확한 스펙 도출

워크플로우:
  요청 분석 → 프로젝트 컨텍스트 파악 → 슈퍼 프롬프트 생성 → 실행|수정|취소
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Model Option
Check if args starts with `-h`, `-s`, or `-o`:
- `-h` → model = haiku
- `-s` → model = sonnet (default)
- `-o` → model = opus

Remove model flag from args, store remaining as request.

---

## 2. Analyze Intent
Process:
1. Analyze intent (WHO/WHAT/WHY)
2. Check project context via Glob/Grep if needed
3. Derive requirements (functional/non-functional/edge cases)

---

## 3. Output Super Prompt (Korean)
Output format:
- Goal: [one sentence]
- Requirements: [numbered list]
- Tech spec: framework, file paths, reference code
- Exceptions/Tests: [if needed]

Ask user: 실행|수정|취소

---

## 4. Execution
**Triggered by**: "실행" response

On execution:
- Use selected model (haiku/sonnet/opus)
- Call Task tool with full super prompt
- Report implementation results

## Rules
- Parse model option FIRST before analysis
- Preserve analysis workflow
- Respond in Korean

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /super
모델: [haiku|sonnet|opus]
사용 에이전트: [none]
호출 스킬: [none]
분석 모드: super prompt
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
