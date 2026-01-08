---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, Task
description: Claude + Gemini dynamic collaboration with super prompt (user)
---
Args: "$ARGUMENTS"

## 0. API Key Check (First Priority)

Check Gemini API key:
```bash
if [ -z "$GEMINI_API_KEY" ] && [ ! -f ~/.gemini/config ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⚠️  Gemini API 키가 설정되지 않았습니다."
  echo ""
  echo "API 키 발급: https://aistudio.google.com/apikey"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  read -s -p "API 키 입력: " key
  echo ""

  mkdir -p ~/.gemini
  echo "$key" > ~/.gemini/config
  chmod 600 ~/.gemini/config
  export GEMINI_API_KEY=$key

  echo "✅ API 키가 설정되었습니다."
elif [ -f ~/.gemini/config ]; then
  export GEMINI_API_KEY=$(cat ~/.gemini/config)
fi
```

## 1. Help System

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /duo 사용 가이드

용도: Claude와 Gemini가 동적으로 협업하여 합의 도출

사용법:
  /duo <구현 요청>                 # 기본 (sonnet)
  /duo -h <구현 요청>              # haiku 모델
  /duo -s <구현 요청>              # sonnet 모델
  /duo -o <구현 요청>              # opus 모델

옵션:
  -h, --haiku      빠른 실행 (간단한 작업)
  -s, --sonnet     균형 잡힌 성능 (기본값)
  -o, --opus       최고 품질 (복잡한 작업)
  --help           이 도움말 표시

예시:
  /duo 로그인 기능 구현
  /duo -o 대규모 아키텍처 설계
  /duo -h 간단한 유틸 함수 추가

언제 사용:
  ✅ 복잡한 구현 전 설계 검증
  ✅ 다양한 관점의 접근법 비교
  ✅ 리스크가 높은 변경사항

워크플로우:
  요청 분석 → Gemini 동적 협업 (합의까지) → 실행|수정|취소

특징:
  🔄 협업 라운드는 AI들이 동적으로 결정
  🎯 합의 도달 시 자동 종료
  📊 최대 5라운드까지 진행
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 2. Parse Model Option
Check if args starts with `-h`, `-s`, or `-o`:
- `-h` → model = haiku
- `-s` → model = sonnet (default)
- `-o` → model = opus

Remove model flag from args, store remaining as request.

---

## Phase 1: Super Prompt (analyze request)
1. Analyze intent (WHO/WHAT/WHY)
2. Check project context via Glob/Grep if needed
3. Derive requirements (functional/non-functional/edge cases)

## Phase 2: Dynamic Gemini Collaboration

**목표**: 합의 도달 시까지 동적으로 협업 (최대 5라운드)

### 라운드 진행 로직

```
Round 1:
  Call: gemini-agent "구현 요청: [요약]. 어떻게 구현할까? 핵심 고려사항은?"
  Analyze response for keywords:
    - "합의" / "동의" / "좋은 접근" → consensus_level += 2
    - "우려" / "문제" / "개선 필요" → consensus_level -= 1
    - "대안" / "다른 방법" → need_discussion = true

Round 2:
  Call: gemini-agent "내 접근법: [Claude's approach]. 이 방식 어때? 우려사항이나 개선점?"
  Analyze response similarly.

Round 3+ (if needed):
  If consensus_level < 3 OR need_discussion:
    Call: gemini-agent "이견 사항: [disagreement points]. 어떻게 조율할까?"
  Else:
    Break (합의 도달)

Max rounds: 5
```

### 합의 판단 기준
- ✅ **합의**: consensus_level >= 3 AND no critical issues
- ⚠️ **추가 논의 필요**: 우려사항 있지만 해결 가능
- ❌ **이견**: 근본적인 접근 차이 (사용자 판단 필요)

### 실제 구현
각 라운드마다:
1. gemini-agent 호출
2. 응답 분석 (키워드 추출)
3. 합의 레벨 계산
4. 다음 라운드 필요성 판단
5. 최대 5라운드 또는 합의 도달 시 종료

## Phase 3: Consensus Report (Korean)
Output format:
```
## 협업 결과 (총 N라운드)

### 협업 과정
**Round 1**: [Gemini 초기 의견 요약]
**Round 2**: [Claude 접근법에 대한 Gemini 피드백]
**Round 3** (if any): [조율 과정]
...

### Gemini 최종 의견
- [key points]

### Claude 최종 의견
- [key points]

### 합의 사항
- [agreed approach]

### 이견 (있다면)
- [disagreements]

### 합의 수준
- 🟢 완전 합의 / 🟡 부분 합의 / 🔴 이견 있음

---
실행|수정|취소
```

On "실행": implement based on consensus with selected model.

## 4. Execution Phase
**Triggered by**: "실행" response

On execution:
- Use selected model (haiku/sonnet/opus)
- Call Task tool with consensus prompt
- Report implementation results

## Rules
- Check API key FIRST (before any processing)
- Parse model option SECOND
- Dynamic rounds (1-5) until consensus or max reached
- Report all rounds transparently
- Respond in Korean
- If persistent conflict: present both, let user decide
- Use selected model in implementation phase
- Each round must have clear purpose (not repetitive)

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /duo
모델: [haiku|sonnet|opus]
사용 에이전트: gemini-agent
호출 스킬: [none]
협업 라운드: [actual_rounds_used] (동적)
합의 수준: [🟢|🟡|🔴]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
