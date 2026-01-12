#!/bin/bash

# Claude Code Agent Benchmark Script
# 각 에이전트의 성능을 측정하고 결과를 기록합니다.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIOS_DIR="${SCRIPT_DIR}/scenarios"
RESULTS_DIR="${SCRIPT_DIR}/results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULT_FILE="${RESULTS_DIR}/benchmark_${TIMESTAMP}.json"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 에이전트 목록
AGENTS=(
    "duo"
    "run"
    "super"
    "gemini"
    "architecture-designer"
    "code-reviewer"
    "debug-master"
)

# 시나리오 목록
SCENARIOS=(
    "simple"
    "medium"
    "complex"
)

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Claude Code Agent Benchmark${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_section() {
    echo -e "${GREEN}▶ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "  $1"
}

# JSON 초기화
init_results() {
    cat > "${RESULT_FILE}" <<EOF
{
  "timestamp": "${TIMESTAMP}",
  "date": "$(date -Iseconds)",
  "benchmarks": []
}
EOF
    echo -e "${GREEN}✓ Results file created: ${RESULT_FILE}${NC}"
}

# 수동 벤치마크 실행
run_manual_benchmark() {
    local agent=$1
    local scenario=$2
    local scenario_file="${SCENARIOS_DIR}/${scenario}.txt"

    print_section "Benchmarking: @agent-${agent} with ${scenario} scenario"

    echo ""
    print_info "시나리오 내용:"
    cat "${scenario_file}" | sed 's/^/    /'
    echo ""

    print_warning "수동 측정이 필요합니다. 다음 단계를 따라주세요:"
    echo ""
    print_info "1. 새 터미널에서 다음 명령어를 실행하세요:"
    echo -e "   ${BLUE}time @agent-${agent} \"\$(cat ${scenario_file})\"${NC}"
    echo ""
    print_info "2. 실행이 완료되면 다음 정보를 입력하세요:"
    echo ""

    # 사용자 입력 받기
    read -p "  실행 시간 (초): " exec_time
    read -p "  Input 토큰: " input_tokens
    read -p "  Output 토큰: " output_tokens
    read -p "  API 호출 횟수: " api_calls
    read -p "  품질 평가 (1-5): " quality

    # 결과 저장
    local total_tokens=$((input_tokens + output_tokens))

    # JSON에 추가
    local temp_file="${RESULTS_DIR}/temp.json"
    jq ".benchmarks += [{
        \"agent\": \"${agent}\",
        \"scenario\": \"${scenario}\",
        \"execution_time\": ${exec_time},
        \"tokens\": {
            \"input\": ${input_tokens},
            \"output\": ${output_tokens},
            \"total\": ${total_tokens}
        },
        \"api_calls\": ${api_calls},
        \"quality\": ${quality}
    }]" "${RESULT_FILE}" > "${temp_file}" && mv "${temp_file}" "${RESULT_FILE}"

    echo -e "${GREEN}✓ 결과 저장 완료${NC}"
    echo ""
}

# 자동 벤치마크 (로그 파싱)
run_auto_benchmark() {
    local agent=$1
    local scenario=$2

    print_section "Auto-benchmarking: @agent-${agent} with ${scenario} scenario"
    print_error "자동 벤치마크는 현재 지원되지 않습니다."
    print_info "Claude Code CLI는 대화형이므로 수동 측정이 필요합니다."
    echo ""
}

# 결과 분석
analyze_results() {
    print_section "분석 결과"

    if [ ! -f "${RESULT_FILE}" ]; then
        print_error "결과 파일이 없습니다."
        return
    fi

    local count=$(jq '.benchmarks | length' "${RESULT_FILE}")

    if [ "${count}" -eq 0 ]; then
        print_warning "벤치마크 결과가 없습니다."
        return
    fi

    echo ""
    print_info "총 ${count}개의 벤치마크 완료"
    echo ""

    # 에이전트별 평균 계산
    print_info "에이전트별 평균:"
    for agent in "${AGENTS[@]}"; do
        local avg_time=$(jq -r ".benchmarks | map(select(.agent == \"${agent}\")) | if length > 0 then (map(.execution_time) | add / length) else 0 end" "${RESULT_FILE}")
        local avg_tokens=$(jq -r ".benchmarks | map(select(.agent == \"${agent}\")) | if length > 0 then (map(.tokens.total) | add / length) else 0 end" "${RESULT_FILE}")

        if (( $(echo "$avg_time > 0" | bc -l) )); then
            printf "  %-25s 시간: %6.1f초  토큰: %7.0f\n" "${agent}" "${avg_time}" "${avg_tokens}"
        fi
    done

    echo ""
    print_info "상세 결과: ${RESULT_FILE}"
}

# 결과를 README 형식으로 출력
generate_readme_metrics() {
    print_section "README 성능 지표 생성"

    local output_file="${RESULTS_DIR}/readme_metrics.md"

    cat > "${output_file}" <<'EOF'
## 성능 지표 (벤치마크 결과)

> 실제 측정 데이터 기반 (2026-01-12)

EOF

    for agent in "${AGENTS[@]}"; do
        local data=$(jq -r ".benchmarks | map(select(.agent == \"${agent}\"))" "${RESULT_FILE}")
        local count=$(echo "${data}" | jq 'length')

        if [ "${count}" -gt 0 ]; then
            local avg_time=$(echo "${data}" | jq 'map(.execution_time) | add / length')
            local avg_tokens=$(echo "${data}" | jq 'map(.tokens.total) | add / length')
            local avg_quality=$(echo "${data}" | jq 'map(.quality) | add / length')

            # 속도 평가
            local speed_icon="⚡⚡"
            if (( $(echo "$avg_time > 60" | bc -l) )); then
                speed_icon="🐌"
            elif (( $(echo "$avg_time > 30" | bc -l) )); then
                speed_icon="⚡"
            elif (( $(echo "$avg_time < 10" | bc -l) )); then
                speed_icon="⚡⚡⚡"
            fi

            # 토큰 평가
            local token_icon="💰"
            if (( $(echo "$avg_tokens > 5000" | bc -l) )); then
                token_icon="💰💰💰"
            elif (( $(echo "$avg_tokens > 2000" | bc -l) )); then
                token_icon="💰💰"
            fi

            # 품질 평가
            local quality_stars=""
            for i in $(seq 1 ${avg_quality%.*}); do
                quality_stars="${quality_stars}⭐"
            done

            cat >> "${output_file}" <<EOF
### ${agent}

| 속성 | 값 |
|-----|-----|
| **속도** | ${speed_icon} (평균 ${avg_time}초) |
| **토큰** | ${token_icon} (평균 ${avg_tokens}) |
| **품질** | ${quality_stars} |

EOF
        fi
    done

    echo -e "${GREEN}✓ README 지표 생성: ${output_file}${NC}"
    echo ""
    print_info "이 내용을 README.md에 복사하세요."
}

# 사용법 출력
show_usage() {
    cat <<EOF
사용법: $0 [옵션]

옵션:
  -a, --auto              자동 벤치마크 실행 (현재 미지원)
  -m, --manual            수동 벤치마크 실행
  -s, --scenario SCENARIO 특정 시나리오만 실행 (simple, medium, complex)
  -g, --agent AGENT       특정 에이전트만 실행
  -r, --report            결과 분석 및 리포트 생성
  -h, --help              이 도움말 표시

예시:
  $0 --manual                          # 모든 에이전트 수동 벤치마크
  $0 --manual --agent duo              # duo 에이전트만 벤치마크
  $0 --manual --scenario simple        # simple 시나리오만 벤치마크
  $0 --report                          # 결과 분석

EOF
}

# 메인 실행
main() {
    print_header

    # 옵션 파싱
    local mode="help"
    local target_agent=""
    local target_scenario=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--auto)
                mode="auto"
                shift
                ;;
            -m|--manual)
                mode="manual"
                shift
                ;;
            -g|--agent)
                target_agent="$2"
                shift 2
                ;;
            -s|--scenario)
                target_scenario="$2"
                shift 2
                ;;
            -r|--report)
                mode="report"
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                print_error "알 수 없는 옵션: $1"
                show_usage
                exit 1
                ;;
        esac
    done

    case $mode in
        manual)
            init_results

            # 에이전트 선택
            local agents_to_test=("${AGENTS[@]}")
            if [ -n "${target_agent}" ]; then
                agents_to_test=("${target_agent}")
            fi

            # 시나리오 선택
            local scenarios_to_test=("${SCENARIOS[@]}")
            if [ -n "${target_scenario}" ]; then
                scenarios_to_test=("${target_scenario}")
            fi

            # 벤치마크 실행
            for agent in "${agents_to_test[@]}"; do
                for scenario in "${scenarios_to_test[@]}"; do
                    run_manual_benchmark "${agent}" "${scenario}"
                done
            done

            analyze_results
            generate_readme_metrics
            ;;
        auto)
            print_error "자동 벤치마크는 현재 지원되지 않습니다."
            print_info "수동 모드를 사용하세요: $0 --manual"
            exit 1
            ;;
        report)
            # 가장 최신 결과 파일 찾기
            local latest_result=$(ls -t "${RESULTS_DIR}"/benchmark_*.json 2>/dev/null | head -1)
            if [ -z "${latest_result}" ]; then
                print_error "결과 파일이 없습니다."
                print_info "먼저 벤치마크를 실행하세요: $0 --manual"
                exit 1
            fi

            RESULT_FILE="${latest_result}"
            analyze_results
            generate_readme_metrics
            ;;
        help)
            show_usage
            ;;
    esac
}

# 스크립트 실행
main "$@"
