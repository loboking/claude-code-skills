---
allowed-tools: Read, Grep, Glob
description: Convert simple request to detailed super prompt (user)
---
Request: "$ARGUMENTS"

Process:
1. Analyze intent (WHO/WHAT/WHY)
2. Check project context via Glob/Grep if needed
3. Derive requirements (functional/non-functional/edge cases)

Output format (respond in Korean):
- Goal: [one sentence]
- Requirements: [numbered list]
- Tech spec: framework, file paths, reference code
- Exceptions/Tests: [if needed]

Ask user: 실행|수정|취소. On "실행", start implementation.
