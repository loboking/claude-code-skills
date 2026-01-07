---
allowed-tools: Read, Grep, Glob, Task
description: Convert simple request to detailed super prompt (user)
---
Args: "$ARGUMENTS"

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
