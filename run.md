---
description: DEPRECATED - Use run-agent instead
---

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /run 사용 가이드 (DEPRECATED)

⚠️ 이 스킬은 에이전트로 마이그레이션되었습니다.

새로운 사용법:
  Use run to analyze task                # 자연어 호출
  Use monggle-run to implement feature   # 긴 이름
  @agent-run analyze codebase            # @ 멘션

옵션:
  -o, --opus       최고 품질 (복잡한 작업)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -h, --haiku      빠른 실행
  --dry            계획만 표시 (실행 안함)
  --temp           임시 리소스 사용

기능:
  작업 복잡도 자동 분석
  최적 모델/에이전트 선택
  프로젝트 타입 감지
  Hook/MCP 자동 추천

예시:
  Use run to refactor code
  Use run -h to fix typo
  Use run --dry to show plan
  @agent-run analyze this project

문서: ~/.claude/agents/run.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

---

# ⚠️ DEPRECATED: /run Skill

This skill has been migrated to an agent for token efficiency.

## Migration Info

**Old Usage:**
```
/run analyze task
/run -s implement feature
/run --dry show execution plan
```

**New Usage:**
```
Use run to analyze task                # 짧은 이름
Use monggle-run to analyze task        # 긴 이름 (동일)
Use run -s to implement feature
Use run --dry to show execution plan
```

**Token Savings:** 1,500t per invocation (43% overhead reduction)

---

## Why the Change?

The original `/run` skill had a two-layer overhead:
1. Skill loading (1,500t)
2. Task tool → Agent loading (2,000t)
3. **Total overhead: 3,500t**

The new `run-agent` eliminates the Skill layer:
1. Agent loading directly (2,000t)
2. **Total overhead: 2,000t**
3. **Savings: 1,500t (43% reduction)**

---

## Migration Period

**Both /run and run-agent are available until 2025-01-23.**

After this date, /run will be removed entirely.

---

## Documentation

See the full agent documentation:
- File: `~/.claude/commands/agents/run-agent.md`
- Features: Same 9-phase analysis, optimized execution
- Invocation: Natural language ("Use run-agent to...")

---

## Key Features Preserved

All features from /run are available in run-agent:
- ✅ Automatic model selection (haiku/sonnet/opus)
- ✅ Project type detection (React, Python, Go, etc.)
- ✅ Hook auto-detection
- ✅ MCP recommendation
- ✅ Parallel/sequential execution
- ✅ Dry-run mode (--dry)
- ✅ Temporary resources (--temp)
- ✅ Immediate execution (-h/-s/-o flags)

---

## Need Help?

If you have questions about the migration:
1. Check `~/.claude/CLAUDE.md` for migration guide
2. Review `~/.claude/commands/agents/run-agent.md` for usage examples
3. Test the new agent: `Use run-agent to analyze this codebase`
