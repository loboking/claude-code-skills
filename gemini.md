---
allowed-tools: Bash(gemini-agent:*)
description: Gemini 서브에이전트 호출 (user)
---

Args: "$ARGUMENTS"

## Option Detection
Check if args starts with "-t":
- Yes → Debate Mode (Claude vs Gemini)
- No → Normal Mode (simple query)

---

## Normal Mode (no -t flag)
Call: `gemini-agent "$ARGUMENTS"`

After receiving result:
- Code request → write to file
- Analysis → summarize and show
- Question → deliver answer

---

## Debate Mode (-t flag)

### Usage
`/gemini -t "주제"`

### Workflow
```
Max rounds: 10 (default)
Extension: +10 per "계속"

[Round N/10]
[Claude] Initial position or rebuttal
[Gemini] Response (via gemini-agent)
... repeat ...

[After 10 rounds]
계속 | 종료
```

### Implementation

1. **Parse topic**: Extract topic after "-t"

2. **Initialize debate**:
   - Claude states initial position
   - Track round count (start: 1, max: 10)
   - Keep conversation summary

3. **Each round**:
   ```
   Claude: State position/rebuttal (show to user)

   Call gemini-agent with:
   "논쟁 주제: [topic]
   이전 요약: [summary]
   Claude 발언: [claude's statement]

   당신은 Gemini입니다. 위 주장에 대해 반박하거나 의견을 제시하세요."

   Show: [Gemini] response

   Update summary (keep last 2-3 exchanges detailed)
   ```

4. **After max rounds**:
   ```
   ## [10]회차 완료

   계속 (+10회 연장) | 종료
   ```

5. **On "계속"**: max += 10, continue loop

6. **On "종료" or natural end**:
   ```
   ## 논쟁 결론

   ### 합의점
   - [agreed points]

   ### 이견
   - [Claude]: ...
   - [Gemini]: ...

   ### 최종 권장사항
   - [recommendation based on debate]
   ```

### Display Format
```
## 논쟁: [topic]

[Round 1/10]
[Claude] ...주장...
[Gemini] ...반박...

[Round 2/10]
[Claude] ...재반박...
[Gemini] ...응답...

...

[10회 완료]
계속 | 종료
```

### Token Management
- Keep full history for user display
- Send only summary + last 2 exchanges to gemini-agent
- Summary format: "Claude는 X를 주장, Gemini는 Y를 주장"

---

## Rules
- Respond in Korean
- Show ALL exchanges to user (both sides)
- Be fair - present both positions objectively
- Debate should be constructive, not hostile
