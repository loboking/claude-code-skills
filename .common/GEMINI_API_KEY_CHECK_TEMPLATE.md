# Gemini API Key Check Template

**목적**: Gemini를 사용하는 모든 스킬에 복사/붙여넣기 할 표준 API 키 체크 로직

---

## 사용 방법

1. Gemini를 사용하는 스킬 `.md` 파일 열기
2. `Args: "$ARGUMENTS"` 다음에 아래 섹션 추가
3. 기존 `## 0. Help System` → `## 1. Help System`으로 번호 조정
4. 나머지 섹션 번호도 +1씩 조정

---

## 복사할 템플릿

```markdown
## 0. API Key Check (First Priority)

Check Gemini API key:
\`\`\`bash
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
\`\`\`
```

---

## Rules 섹션에 추가

기존 Rules 섹션의 맨 위에 다음 줄 추가:
```markdown
- Check API key FIRST (before any processing)
```

---

## 적용된 스킬 목록

- [x] /gemini (gemini.md)
- [x] /duo (duo.md)
- [ ] /super (super.md) - Gemini 미사용
- [ ] /run (run.md) - Gemini 미사용
- [ ] /smart-brain (smart-brain.md) - Gemini 미사용
- [ ] /project-init (project-init.md) - Gemini 미사용

---

## 검증 체크리스트

스킬에 API 키 체크를 추가한 후:
- [ ] `## 0. API Key Check` 섹션이 Args 직후에 있는가?
- [ ] 기존 섹션 번호가 모두 +1 조정되었는가?
- [ ] Rules에 "Check API key FIRST" 규칙 추가되었는가?
- [ ] `gemini-agent` 호출 전에 키 체크가 실행되는가?

---

## 동작 원리

1. **환경 변수 우선**: `$GEMINI_API_KEY`가 이미 설정되어 있으면 그대로 사용
2. **파일 체크**: `~/.gemini/config` 파일이 있으면 읽어서 환경 변수로 설정
3. **대화형 입력**: 둘 다 없으면 사용자에게 입력 요청
4. **안전한 저장**: 입력받은 키를 `~/.gemini/config`에 저장 (권한 600)
5. **환경 변수 설정**: `export GEMINI_API_KEY`로 현재 세션에 설정

---

## 보안 고려사항

- `~/.gemini/config` 파일은 `chmod 600`으로 소유자만 읽기/쓰기 가능
- `.gitignore`에 `*config` 패턴으로 Git 추적 제외
- `read -s` 플래그로 입력 시 화면에 키가 표시되지 않음
- 스킬 코드 자체에는 API 키 하드코딩 금지

---

## 문제 해결

### API 키가 계속 요청됨
```bash
# ~/.gemini/config 파일 권한 확인
ls -la ~/.gemini/config
# -rw------- (600)이어야 함

# 파일 내용 확인 (키가 올바르게 저장되었는지)
cat ~/.gemini/config
```

### API 키 변경
```bash
# 기존 키 삭제 후 스킬 재실행
rm ~/.gemini/config
/gemini 테스트 질문
```

### 수동 설정
```bash
# 환경 변수로 직접 설정 (임시)
export GEMINI_API_KEY="your-api-key-here"

# 파일로 직접 저장 (영구)
mkdir -p ~/.gemini
echo "your-api-key-here" > ~/.gemini/config
chmod 600 ~/.gemini/config
```
