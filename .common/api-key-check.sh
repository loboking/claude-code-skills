#!/bin/bash
# Common API Key Check Function
# Usage: source ~/.claude/commands/.common/api-key-check.sh && check_gemini_api_key

check_gemini_api_key() {
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
}

# 함수가 source되면 자동으로 실행되지 않음
# 명시적으로 check_gemini_api_key 호출 필요
