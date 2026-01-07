---
description: Gemini 서브에이전트 호출 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /gemini 사용 가이드

용도: Gemini AI 서브에이전트를 호출하여 질문하거나 논쟁 모드 실행

사용법:
  /gemini <질문>                   # 기본 질문
  /gemini -h <질문>                # haiku 모델
  /gemini -s <질문>                # sonnet 모델
  /gemini -o <질문>                # opus 모델
  /gemini -t <주제>                # 논쟁 모드 (Claude vs Gemini)

옵션:
  -h, --haiku      빠른 실행 (간단한 작업)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 작업)
  -t, --debate     논쟁 모드 활성화
  --help           이 도움말 표시

예시:
  /gemini Python 비동기 프로그래밍 설명해줘
  /gemini -s React 최적화 패턴은?
  /gemini -t "TDD vs BDD 어느게 더 나은가?"

언제 사용:
  ✅ 다른 AI 관점이 필요할 때
  ✅ 논쟁을 통한 심층 분석
  ✅ 코드 구현 전 아이디어 검증

워크플로우:
  질문 → Gemini 호출 → 결과 정리 → 사용자 전달
  또는
  주제(-t) → Claude 주장 → Gemini 반박 → N회 반복 → 결론
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options
Check args for options (in order):
1. Model option: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default (sonnet)
2. Mode option: `-t` (debate mode) | default (normal mode)

Remove parsed options from args, store remaining as query/topic.

## 2. Option Detection
Routing logic:
- If `-t` found → Debate Mode (Claude vs Gemini)
- If `-t` not found → Normal Mode (simple query)

---

## 3. Normal Mode (no -t flag)
Call: `gemini-agent "$QUERY"` (with model selected)

After receiving result:
- Code request → write to file
- Analysis → summarize and show
- Question → deliver answer

---

## 4. Debate Mode (-t flag)

### Usage
`/gemini [-h/-s/-o] -t "주제"`
- Optional: `-h/-s/-o` for model selection (default: sonnet)

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

1.  **Parse topic**: Extract topic after "-t"

2.  **Initialize debate**:
    *   Claude states initial position
    *   Track round count (start: 1, max: 10)
    *   Keep conversation summary

3.  **Each round**:
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

4.  **After max rounds**:
    ```
    ## [10]회차 완료

    계속 (+10회 연장) | 종료
    ```

5.  **On "계속"**: max += 10, continue loop

6.  **On "종료" or natural end**:
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

## 5. Model Usage
When calling gemini-agent:
- Pass selected model (haiku/sonnet/opus) for consistency
- Normal mode: Model affects response depth/quality
- Debate mode: Model used for Claude's reasoning in each round

## Rules
- Parse model and mode options FIRST before routing
- Preserve `-t` debate mode functionality
- Respond in Korean
- Show ALL exchanges to user (both sides)
- Be fair - present both positions objectively
- Debate should be constructive, not hostile

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /gemini
모델: [haiku|sonnet|opus]
사용 에이전트: gemini-agent
호출 스킬: [if any sub-skills called]
실행 모드: [normal|debate]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
