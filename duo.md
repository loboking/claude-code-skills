---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task
description: Claude + Gemini 2-round collaboration with super prompt (user)
---
Args: "$ARGUMENTS"

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
