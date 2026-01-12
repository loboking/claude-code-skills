#!/bin/bash

# Claude Code Skills & Agents Installer
# Installs custom skills and agents to the correct locations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
COMMANDS_DIR="${CLAUDE_DIR}/commands"
AGENTS_DIR="${CLAUDE_DIR}/agents"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Claude Code Skills Installer${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "  $1"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# 설치 시작
print_header

# 1. Skills 설치 (이미 올바른 위치)
print_info "Step 1: Skills already installed"
print_success "Skills location: ${COMMANDS_DIR}/"

# 2. Agents 설치
print_info "Step 2: Installing agents..."

if [ ! -d "${AGENTS_DIR}" ]; then
    mkdir -p "${AGENTS_DIR}"
    print_success "Created agents directory"
fi

# agents 파일 복사
if [ -d "${SCRIPT_DIR}/agents" ]; then
    cp -r "${SCRIPT_DIR}/agents/"*.md "${AGENTS_DIR}/"
    print_success "Copied agent files to ${AGENTS_DIR}/"

    # 복사된 파일 개수 확인
    agent_count=$(ls -1 "${AGENTS_DIR}"/*.md 2>/dev/null | wc -l | tr -d ' ')
    print_info "Installed ${agent_count} agent files"
else
    print_error "agents/ directory not found in ${SCRIPT_DIR}"
    exit 1
fi

# 3. 심볼릭 링크 생성 (선택사항)
print_info "Step 3: Creating symbolic links for monggle- variants..."

cd "${AGENTS_DIR}"

# gemini.md → monggle-gemini.md 링크
if [ -f "monggle-gemini.md" ] && [ ! -L "gemini.md" ]; then
    ln -sf monggle-gemini.md gemini.md
    print_success "Created gemini.md → monggle-gemini.md"
fi

# super.md → monggle-super.md 링크
if [ -f "monggle-super.md" ] && [ ! -L "super.md" ]; then
    ln -sf monggle-super.md super.md
    print_success "Created super.md → monggle-super.md"
fi

# 4. 권한 설정
print_info "Step 4: Setting permissions..."
chmod 644 "${AGENTS_DIR}"/*.md 2>/dev/null || true
print_success "Permissions set"

# 5. 완료
echo ""
print_success "Installation complete!"
echo ""
print_info "Usage:"
echo "  @agent-duo      # Claude + Gemini collaboration"
echo "  @agent-run      # Smart orchestrator"
echo "  @agent-super    # Super prompt generator"
echo "  @agent-gemini   # Gemini sub-agent"
echo ""
print_info "For more information, see:"
echo "  ${COMMANDS_DIR}/README.md"
echo ""
print_warning "Note: Restart Claude Code CLI to apply changes"
echo ""
