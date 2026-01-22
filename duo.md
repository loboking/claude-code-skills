---
description: DEPRECATED - Use monggle-duo instead
---

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /duo 사용 가이드 (DEPRECATED)

⚠️ 이 스킬은 에이전트로 마이그레이션되었습니다.

새로운 사용법:
  Use duo to implement feature           # 자연어 호출
  Use monggle-duo to design architecture # 긴 이름
  @agent-duo implement feature           # @ 멘션

옵션:
  -o, --opus       최고 품질 (복잡한 설계)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -h, --haiku      빠른 실행

기능:
  Claude + Gemini 동적 협업
  1-5 라운드 합의 도출
  다중 관점 분석

예시:
  Use duo to add login feature
  Use duo -o to design microservices
  @agent-duo analyze architecture

문서: ~/.claude/agents/duo.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

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
