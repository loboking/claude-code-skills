---
allowed-tools: Bash, Grep, Glob, Read, LSP
description: API 문서 추출 (user)
---

Args: "$ARGUMENTS"

## 0. Help System (First Priority)

Check if args match help patterns:
- `--help`
- `-h` alone (without other text)
- empty args

If help requested, show and exit:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📖 /api-docs 사용 가이드

용도: 코드에서 API 문서 자동 추출

사용법:
  /api-docs                      # 자동 감지 후 생성
  /api-docs --openapi            # OpenAPI/Swagger 생성
  /api-docs --sphinx             # Python Sphinx 생성
  /api-docs --output <dir>       # 출력 디렉토리 지정

지원 언어/프레임워크:
  Python    FastAPI, Flask, Sphinx
  Node.js   Express, Fastify
  Go        net/http, gin, echo
  Java      Spring Boot, JAX-RS
  Rust      Actix, Rocket

출력 형식:
  OpenAPI 3.x (JSON/YAML)
  Swagger 2.0
  Sphinx RST
  Markdown

옵션:
  --openapi          OpenAPI/Swagger spec 생성
  --sphinx           Sphinx 문서 생성
  --markdown         Markdown으로 생성
  --output <dir>     출력 디렉토리
  --serve            문서 서버 실행

예시:
  /api-docs                      # 자동 감지
  /api-docs --openapi --output docs/
  /api-docs --serve             # http://localhost:8000

언제 사용:
  ✅ API 개발 완료 후
  ✅ 프론트엔드 팀 전용 시
  ✅ API 문서 자동화

워크플로우:
  코드 분석 → API 라우트 추출 → 문서 생성 → 시각화
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

Check for:
- `--openapi`: Generate OpenAPI/Swagger spec
- `--sphinx`: Generate Sphinx documentation
- `--markdown`: Generate Markdown docs
- `--output <dir>`: Output directory
- `--serve`: Serve documentation

## 2. Project Detection & Framework

```python
# Python
if [ -f "main.py" ] && grep -q "fastapi\|flask\|tornado" main.py; then
    if grep -q "fastapi" main.py; then
        # FastAPI auto-docs
        echo "Using FastAPI built-in docs"
    elif grep -q "flask" main.py; then
        # Flask with Flask-RESTX
        echo "Using Flask-RESTX"
    fi
fi

# Node.js
if [ -f "package.json" ] && grep -q "express\|fastify\|koa" package.json; then
    echo "Detected Node.js framework"
fi

# Go
if [ -f "go.mod" ] && grep -q "gin\|echo\|fiber" go.mod; then
    echo "Detected Go framework"
fi
```

## 3. API Extraction Methods

### Python (FastAPI - Built-in)
```python
# FastAPI automatically generates OpenAPI
from fastapi import FastAPI
app = FastAPI()

# Access at:
# http://localhost:8000/docs (Swagger UI)
# http://localhost:8000/openapi.json (OpenAPI JSON)
```

### Python (Flask)
```bash
# Install flask-swagger or Flask-RESTX
pip install flask-swagger

# Generate from docstrings
# Or use apispec
```

### Node.js (Express)
```javascript
// Use swagger-jsdoc or swagger-autogen
const swaggerJSDoc = require('swagger-jsdoc');
const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'My API',
      version: '1.0.0',
    },
  },
  apis: ['./routes/*.js'], // Scan route files
};
```

### Go (with annotations)
```go
// Install swag
// go install github.com/swaggo/swag/cmd/swag@latest

// @title My API
// @version 1.0
// @description My API description
func main() {
    // swag will generate docs from annotations
}
```

## 4. Generated Formats

### OpenAPI Spec (YAML)
```yaml
openapi: 3.0.0
info:
  title: My API
  version: 1.0.0
paths:
  /users:
    get:
      summary: List users
      responses:
        '200':
          description: Success
```

### Markdown
```markdown
# API Documentation

## Users

### List Users
**GET** /api/users

Returns a list of users.

**Response:**
```json
[{"id": 1, "name": "John"}]
```
```

### Sphinx (Python)
```rst
API Reference
===============

.. automodule:: mymodule
   :members:
   :undoc-members:
   :show-inheritance:
```

## 5. Output Structure

```
docs/
├── openapi.yaml         # OpenAPI spec
├── openapi.json         # OpenAPI JSON
├── api.md              # Markdown docs
├── static/             # Swagger UI assets
└── index.html          # Documentation index
```

## 6. Serve Documentation

```bash
# With --serve flag
python -m http.server 8000 --directory docs

# Or use swagger-ui
docker run -p 8080:8080 -e SWAGGER_JSON=/docs/openapi.json \
  swaggerapi/swagger-ui
```

## 7. Auto-Discovery

Scan project for API routes:
```python
# Python decorators
@app.get("/users")
@app.post("/users")
def ...:

# Node.js express
router.get('/users', ...)
router.post('/users', ...)

# Go handlers
func GetUsers(c *gin.Context) { ... }
```

## Rules

- Detect framework FIRST
- Extract from docstrings/annotations
- Generate OpenAPI 3.x when possible
- Include request/response schemas
- Support multiple output formats
- Don't execute code, only analyze
- Support both Korean and English

---

## Final Metadata Output

Always append to the end of your response:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /api-docs
프레임워크: [detected framework]
추출된 엔드포인트: [N]개
출력 형식: [openapi|sphinx|markdown]
출력 경로: [output-path]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
