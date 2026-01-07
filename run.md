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
Skip:   --no-mcp | --no-gemini | --no-hook
```

## 2. Analyze Task
- Complexity: simple/medium/complex
- Required agents: [Explore, Plan, code-reviewer, debug-master, architecture-designer, tech-doc-writer, general-purpose]
- Parallelizable: yes/no (check dependencies)
- MCP needed: which servers
- New skill/agent needed: yes/no
- Hook needed: yes/no (auto-detect)

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
- New hook needed? → create in:
  - ~/.claude/hooks/custom/ (--save or reusable)
  - ~/.claude/temp/hooks/ (--temp, one-time)

## 5. Hook Auto-Detection
| Task Type | Hook Type | Action |
|-----------|-----------|--------|
| Code write/edit | PostToolUse | Auto format/lint |
| File modification | PreToolUse | Secret check |
| Build/deploy | PostToolUse | Run tests |
| Session setup | SessionStart | Init environment |

Hook creation process:
1. Create script in hooks directory
2. Backup settings.json
3. Update settings.json with jq
4. Confirm with user before applying

## 6. MCP Recommendation
| Task Type | MCP Server |
|-----------|------------|
| Web/crawl | puppeteer, playwright |
| Database | postgres, sqlite |
| Git/GitHub | github |
| API test | fetch |
| File heavy | filesystem |

## 7. Report Plan (Korean)
```
## 실행 계획

### 작업 분석
- 복잡도: [단순/중간/복잡]
- 병렬 처리: [가능/불가]

### 리소스
- 모델: [haiku/sonnet/opus] - [선택 이유]
- 에이전트: [목록] (신규 시: 1회성/영구)
- 훅: [목록] (신규 시: 1회성/영구) ← 없으면 생략
- MCP 추천: [목록] (필요시)

### 예상
- 토큰 비용: [낮음/중간/높음]
- 품질 보장: [설명]

---
실행|수정|취소
```

## 8. Execution
On "실행":
1. Create temp directories if needed (mkdir -p ~/.claude/temp/{agents,commands,hooks})
2. Create hooks if needed (script + settings.json update)
3. Execute with Task tool
   - Use selected model
   - Parallel if safe, sequential if dependencies exist
4. Provide full context to agents (don't cut corners)
5. Report results with quality check

## 9. Cleanup
- Delete ~/.claude/temp/* after completion (if --temp used)
- Restore settings.json if temp hooks were added
- Report cleanup status

## Quality Rules
- NEVER sacrifice quality for token savings
- Provide FULL context to agents
- If result quality is poor → retry with higher model
- Respond in Korean
- --dry: show plan only, no execution
- --no-hook: skip hook auto-detection
