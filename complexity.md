---
allowed-tools: Bash, Grep, Glob, Read, LSP
description: 복잡도 분석 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /complexity 사용 가이드

용도: 복잡도 분석, 리팩토링 후보 추천

사용법:
  /complexity                    # 전체 복잡도 분석
  /complexity --file <path>      # 특정 파일만
  /complexity --threshold <n>   # 임계값 설정
  /complexity --top <n>         # 상위 N개 표시

지언어/도구:
  Python    radon, mccabe, lizard
  Go        gocyclo, complexity
  JS/TS     eslint-plugin-complexity
  Java      PMD, Checkstyle
  Rust      cargo-complexity

복잡도 지표:
  Cyclomatic Complexity (CC)  분기 복잡도
  Cognitive Complexity        인지 복잡도
  Halstead Volume            난이도 복잡도
  Maintainability Index     유지보수 지수

옵션:
  --file <path>       특정 파일/디렉토리
  --threshold <n>     경고 임계값 (기본: 10)
  --top <n>           상위 N개만 표시
  --format <type>     출력 형식 (text, json, html)

예시:
  /complexity                    # 전체 분석
  /complexity --file src/main.py # 특정 파일
  /complexity --top 20           # 상위 20개

언제 사용:
  ✅ 리팩토링 전후 복잡도 비교
  ✅ 복잡한 함수 찾기
  ✅ 코드 품질 개선 대상 선정
  ✅ PR 리뷰시 복잡도 확인

워크플로우:
  코드 스캔 → 복잡도 계산 → 분석 → 리팩토링 제안
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--file <path>`: Target specific file/directory
- `--threshold <n>`: Warning threshold (default: 10)
- `--top <n>`: Show top N items
- `--format <type>`: Output format

## 2. Project Detection & Tool Selection

```bash
# Python
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    radon cc . -s -a        # Cyclomatic complexity
    radon mi . -s          # Maintainability index
fi

# Go
if [ -f "go.mod" ]; then
    gocyclo -over 15 .    # Show functions with CC > 15
fi

# JavaScript/TypeScript
if [ -f "package.json" ]; then
    npx eslint --ext .js,.ts \
      --rule 'complexity: ["error", { max: 10 }]'
fi
```

## 3. Complexity Metrics

### Cyclomatic Complexity (CC)
```
1  → Simple (if)
2  → Moderate (if-else)
3+ → Complex (nested if)
10+ → Very Complex (needs refactor)
```

### Complexity Levels
```
A (1-5):    Low risk
B (6-10):   Moderate risk
C (11-20):  High risk
D (21+):    Very high risk
```

### Maintainability Index (MI)
```
0-20:    Very hard to maintain
21-40:   Hard to maintain
41-60:   Moderate
61-80:   Easy
81-100:  Very easy
```

## 4. Analysis Output

```
🔍 코드 복잡도 분석

=== 전체 요약 ===
평균 CC: 8.5
최대 CC: 45
MI 점수: 52/100

=== 리팩토링 후보 (상위 10) ===

#1 processUser() - CC: 45 🔴
   File: src/main.py:123
   이유: 중첩 if-else, try-catch

   제안:
   - 가드 절 분리
   - 전략 패턴 적용
   - 함수 분리

#2 validateAndSave() - CC: 32 🟠
   File: src/db.py:56
   이유: 다중 조건 검사

   제안:
   - 룩업 검증 로직 분리
   - Result 타입 사용

#3 handleRequest() - CC: 28 🟠
   File: src/api.js:45
   이유: HTTP 메서드 분기

   제안:
   - 라우터로 분리
   - 핸들러 함수 분리

=== 파일별 복잡도 ===
File                 | CC | MI | Status
---------------------|----|----|--------
src/main.py         | 12 | 45 | ⚠️
src/db.py            |  8 | 67 | ✅
src/utils.py        | 15 | 38 | 🔴
```

## 5. Refactoring Recommendations

### High CC Functions
```
🔄 리팩토링 제안

1. processUser() (CC: 45)
   현재: 단일 함수에서 모든 처리
   제안:
   - validateUser() - CC: 5
   - fetchUserData() - CC: 3
   - saveUser() - CC: 2

   절감: 45 → 10 (78% 감소)
```

### Code Smells Detected
```
👃 코드 스멜 감지

Long Parameter List (5+)
  - processUser(req, res, next, config, db, logger)

Long Method (>50 lines)
  - processUser() - 123 lines

Deep Nesting (4+ levels)
  - validateAndSave() - 6 levels deep
```

## 6. Interactive Mode

```bash
# Radon HTML report
radon cc . -s -a -o html
open radon-report/index.html

# JSON output for tool integration
radon cc . -s -a -o json > complexity.json
```

## 7. Trend Analysis

Compare complexity over time:
```bash
# Current vs last month
git stash
git checkout HEAD~1
/complexity > old_complexity.txt
git stash pop
/complexity > new_complexity.txt
diff old_complexity.txt new_complexity.txt
```

## 8. CI/CD Integration

```yaml
# Fail if complexity too high
- name: Check complexity
  run: |
    radon cc . --fail-under=B
    # Fail if any file has complexity > 20
```

## Rules

- Detect project type FIRST
- Calculate multiple complexity metrics
- Highlight functions exceeding threshold
- Provide refactoring suggestions
- Show visual risk indicators
- Support both Korean and English
- Don't modify code, only analyze

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /complexity
분석 파일: [N] files
평균 CC: [score]
MI 점수: [score/100]
리팩토링 후보: [N] functions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
