---
description: DEPRECATED - Use monggle-duo instead
---

# ⚠️ DEPRECATED: /duo Skill

This skill has been migrated to an agent for token efficiency.

## Migration Info

**Old Usage:**
```
/duo implement feature
/duo -o complex architecture design
```

**New Usage:**
```
Use duo to implement feature              # 짧은 이름
Use monggle-duo to implement feature      # 긴 이름 (동일)
Use duo -o to design complex architecture
```

**Token Savings:** 1,500t per invocation (43% overhead reduction)

---

## Why the Change?

The original `/duo` skill had a two-layer overhead:
1. Skill loading (1,500t)
2. Task tool → Agent loading (2,000t)
3. **Total overhead: 3,500t**

The new `duo-agent` eliminates the Skill layer:
1. Agent loading directly (2,000t)
2. **Total overhead: 2,000t**
3. **Savings: 1,500t (43% reduction)**

---

## Migration Period

**Both /duo and duo-agent are available until 2025-01-23.**

After this date, /duo will be removed entirely.

---

## Documentation

See the full agent documentation:
- File: `~/.claude/commands/agents/duo-agent.md`
- Features: Same functionality, optimized structure
- Invocation: Natural language ("Use duo-agent to...")

---

## Need Help?

If you have questions about the migration:
1. Check `~/.claude/CLAUDE.md` for migration guide
2. Review `~/.claude/commands/agents/duo-agent.md` for usage examples
3. Test the new agent: `Use duo-agent to add a simple utility function`
