---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task, TodoWrite
description: Smart orchestrator with dynamic model/agent selection (user)
---
Args: "$ARGUMENTS"

## 1. Parse Options & Detect Immediate Execution
```
Model:  -h (haiku) | -s (sonnet) | -o (opus) | auto
Save:   --temp (disposable) | --save (permanent)
Exec:   --parallel | --seq | --dry (plan only)
Skip:   --no-mcp | --no-gemini | --no-hook
Fresh:  --fresh (recommend /clear) | --compact (recommend /compact)
```

**Immediate Execution Logic**:
- If `-h`, `-s`, or `-o` detected → Set model and skip to Step 10 (execute immediately)
- If `--dry` detected → Show plan only, skip execution
- If no model option → Continue with analysis (Steps 2-9)

## 2. Context Management (First)
Before analysis, check task complexity:
- Complex/large task → Output: "💡 복잡한 작업입니다. /compact 실행을 권장합니다."
- Completely new topic → Output: "💡 새 작업입니다. /clear 를 고려해보세요."
- --fresh flag → Output clear recommendation
- --compact flag → Output compact recommendation

## 3. Project Context Detection
Detect project type via file patterns:
| Pattern | Project Type | Preferred Agent |
|---------|--------------|-----------------|
| *.py, requirements.txt, pyproject.toml | Python | general-purpose (python focus) |
| build.gradle, AndroidManifest.xml | Android | general-purpose (android focus) |
| package.json, *.ts, *.tsx | Node.js/React | general-purpose (js/ts focus) |
| go.mod, *.go | Go | general-purpose (go focus) |
| Cargo.toml, *.rs | Rust | general-purpose (rust focus) |
| *.swift, Package.swift | Swift | general-purpose (swift focus) |

Use Glob to detect, then tailor agent prompts accordingly.

## 4. Analyze Task
- Complexity: simple/medium/complex
- Required agents: select based on project context
- Parallelizable: yes/no (check dependencies)
- MCP needed: which servers
- New skill/agent/hook needed: yes/no

## 5. Model Selection (Performance First)
- ONLY clearly simple → haiku
- Ambiguous or medium → sonnet
- Complex → opus
- When in doubt → higher model

## 6. Resource Decision
- Existing agent sufficient? → use it (with project context)
- New agent needed? → ~/.claude/agents/ or ~/.claude/temp/agents/
- New skill needed? → ~/.claude/commands/ or ~/.claude/temp/commands/
- New hook needed? → ~/.claude/hooks/custom/ or ~/.claude/temp/hooks/

## 7. Hook Auto-Detection
| Task Type | Hook Type | Action |
|-----------|-----------|--------|
| Code write/edit | PostToolUse | Auto format/lint |
| File modification | PreToolUse | Secret check |
| Build/deploy | PostToolUse | Run tests |

## 8. MCP Recommendation
| Task Type | MCP Server |
|-----------|------------|
| Web/crawl | puppeteer, playwright |
| Database | postgres, sqlite |
| Git/GitHub | github |
| API test | fetch |

## 9. Report Plan (Korean)
```
## 실행 계획

### 컨텍스트
- 프로젝트: [감지된 타입]
- 💡 [권장사항 - 있으면]

### 작업 분석
- 복잡도: [단순/중간/복잡]
- 병렬 처리: [가능/불가]

### 리소스
- 모델: [haiku/sonnet/opus] - [이유]
- 에이전트: [목록] (프로젝트 컨텍스트 반영)
- 훅: [목록] (필요시)
- MCP: [목록] (필요시)

---
실행|수정|취소
```

## 10. Execution
**Triggered by**: "실행" response OR model option (-h/-s/-o) in args

Steps:
1. Create temp directories if needed
2. Create hooks if needed
3. Execute with Task tool:
   - Use model from option (-h→haiku, -s→sonnet, -o→opus) or recommended model
   - Parallel if safe, sequential if dependencies
4. Provide full context including project type
5. Report results

## 11. Cleanup
- Delete ~/.claude/temp/* if --temp
- Restore settings.json if temp hooks

## Rules
- NEVER sacrifice quality for token savings
- Provide FULL context to agents
- Detect project type and adapt
- Respond in Korean
