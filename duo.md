---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task
description: Claude + Gemini 2-round collaboration with super prompt (user)
---
Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /duo 사용 가이드

용도: Claude와 Gemini가 2회 협업하여 구현 전 합의 도출

사용법:
  /duo <구현 요청>                 # 기본 (sonnet)
  /duo -h <구현 요청>              # haiku 모델
  /duo -s <구현 요청>              # sonnet 모델
  /duo -o <구현 요청>              # opus 모델

옵션:
  -h, --haiku      빠른 실행 (간단한 작업)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 작업)
  --help           이 도움말 표시

예시:
  /duo 로그인 기능 구현
  /duo -o 대규모 아키텍처 설계
  /duo -h 간단한 유틸 함수 추가

언제 사용:
  ✅ 복잡한 구현 전 설계 검증
  ✅ 다양한 관점의 접근법 비교
  ✅ 리스크가 높은 변경사항

워크플로우:
  요청 분석 → Gemini 1차 의견 → Gemini 2차 피드백 → 합의 도출 → 실행|수정|취소
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Model Option
Check if args starts with `-h`, `-s`, or `-o`:
- `-h` → model = haiku
- `-s` → model = sonnet (default)
- `-o` → model = opus

Remove model flag from args, store remaining as request.

---

## Phase 1: Super Prompt (analyze request)
1. Analyze intent (WHO/WHAT/WHY)
2. Check project context via Glob/Grep if needed
3. Derive requirements (functional/non-functional/edge cases)

## Phase 2: Gemini Collaboration (2 rounds)

### Round 1
Call: `gemini-agent "구현 요청: [요약]. 어떻게 구현할까? 핵심 고려사항은?"`
Receive opinion.

### Round 2
Call: `gemini-agent "내 접근법: [Claude's approach]. 이 방식 어때? 우려사항이나 개선점?"`
Receive feedback.

## Phase 3: Consensus Report (Korean)
Output format:
```
## 협업 결과

### Gemini 의견
- [key points]

### Claude 의견
- [key points]

### 합의 사항
- [agreed approach]

### 이견 (있다면)
- [disagreements]

---
실행|수정|취소
```

On "실행": implement based on consensus with selected model.

## 4. Execution Phase
**Triggered by**: "실행" response

On execution:
- Use selected model (haiku/sonnet/opus)
- Call Task tool with consensus prompt
- Report implementation results

## Rules
- Parse model option FIRST before super prompt analysis
- Always 2 rounds with gemini-agent
- Report both opinions transparently
- Respond in Korean
- If conflict: present both, let user decide
- Use selected model in implementation phase

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /duo
모델: [haiku|sonnet|opus]
사용 에이전트: gemini-agent
호출 스킬: [none]
협업 라운드: 2
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
