---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task, TodoWrite
description: Smart orchestrator with dynamic model/agent selection (user)
---
Args: "$ARGUMENTS"

## 1. Parse Options
```
Model:  -h (haiku) | -s (sonnet) | -o (opus) | auto
Save:   --temp (disposable) | --save (permanent)
Exec:   --parallel | --seq | --dry (plan only)
Skip:   --no-mcp | --no-gemini
```

## 2. Analyze Task
- Complexity: simple/medium/complex
- Required agents: [Explore, Plan, code-reviewer, debug-master, architecture-designer, tech-doc-writer, general-purpose]
- Parallelizable: yes/no (check dependencies)
- MCP needed: which servers
- New skill/agent needed: yes/no

## 3. Model Selection (Performance First)
Priority: Quality over cost savings
- ONLY clearly simple (file search, short summary) → haiku
- Ambiguous or medium → sonnet (default safe choice)
- Complex (architecture, debug, multi-file, security) → opus
- When in doubt → use higher model

## 4. Resource Decision
- Existing agent sufficient? → use it
- New agent needed? → create in:
  - ~/.claude/agents/ (--save or reusable)
  - ~/.claude/temp/agents/ (--temp, one-time)
- New skill needed? → create in:
  - ~/.claude/commands/ (--save)
  - ~/.claude/temp/commands/ (--temp)

## 5. MCP Recommendation
| Task Type | MCP Server |
|-----------|------------|
| Web/crawl | puppeteer, playwright |
| Database | postgres, sqlite |
| Git/GitHub | github |
| API test | fetch |
| File heavy | filesystem |

## 6. Report Plan (Korean)
```
## 실행 계획

### 작업 분석
- 복잡도: [단순/중간/복잡]
- 병렬 처리: [가능/불가]

### 리소스
- 모델: [haiku/sonnet/opus] - [선택 이유]
- 에이전트: [목록] (신규 시: 1회성/영구)
- MCP 추천: [목록] (필요시)

### 예상
- 토큰 비용: [낮음/중간/높음]
- 품질 보장: [설명]

---
실행|수정|취소
```

## 7. Execution
On "실행":
1. Create temp resources if needed (mkdir -p ~/.claude/temp/agents ~/.claude/temp/commands)
2. Execute with Task tool
   - Use selected model
   - Parallel if safe, sequential if dependencies exist
3. Provide full context to agents (don't cut corners)
4. Report results with quality check

## 8. Cleanup
- Delete ~/.claude/temp/* after completion (if --temp used)
- Report cleanup status

## Quality Rules
- NEVER sacrifice quality for token savings
- Provide FULL context to agents
- If result quality is poor → retry with higher model
- Respond in Korean
- --dry: show plan only, no execution
