---
allowed-tools: Bash(gemini-agent:*)
description: Gemini 서브에이전트 호출
---

Gemini 서브에이전트를 호출하여 다음 요청을 처리하세요:

`gemini-agent "$ARGUMENTS"`

결과를 받은 후:
- 코드 요청이면 해당 코드를 파일에 작성하세요
- 분석 요청이면 결과를 정리해서 보여주세요
- 질문이면 답변을 전달하세요
