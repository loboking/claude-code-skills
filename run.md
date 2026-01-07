---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task, TodoWrite
description: Smart orchestrator with dynamic model/agent selection (user)
---
Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /run 사용 가이드

용도: 작업 분석 후 최적 모델/에이전트 자동 선택 및 실행

사용법:
  /run <작업>                      # 자동 분석 후 모델 추천
  /run -h <작업>                   # haiku로 즉시 실행
  /run -s <작업>                   # sonnet으로 즉시 실행
  /run -o <작업>                   # opus로 즉시 실행
  /run --dry <작업>                # 계획만 표시 (실행 안 함)

옵션:
  -h, --haiku      빠른 실행 (간단한 작업)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 작업)
  --dry            계획만 표시
  --temp           임시 리소스 사용
  --save           영구 리소스 저장
  --parallel       병렬 실행
  --seq            순차 실행
  --no-mcp         MCP 서버 미사용
  --fresh          /clear 권장
  --compact        /compact 권장
  --help           이 도움말 표시

예시:
  /run README 작성               # 분석 후 모델 추천
  /run -s 테스트 코드 추가       # sonnet으로 즉시 실행
  /run -o 전체 아키텍처 리팩토링 # opus로 즉시 실행
  /run --dry 프로젝트 초기화     # 계획만 확인

언제 사용:
  ✅ 작업 복잡도를 모를 때 (자동 분석)
  ✅ 프로젝트 타입별 최적화 필요
  ✅ 여러 에이전트/훅/MCP 조율 필요

워크플로우:
  작업 분석 → 프로젝트 감지 → 모델/에이전트 선택 → 실행 계획 → 실행|수정|취소
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

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

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /run
모델: [haiku|sonnet|opus]
사용 에이전트: [list of agents]
호출 스킬: [if any]
프로젝트 타입: [detected type]
실행 모드: [parallel|sequential|dry-run]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
