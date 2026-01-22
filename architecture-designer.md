---
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, WebFetch, WebSearch
description: 시스템 아키텍처 설계 - 기술 스택 선정, 설계 패턴, 아키텍처 결정
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System

If args match `--help`, `-h` alone, or empty:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏗️ /architecture-designer 사용 가이드

용도: 시스템 아키텍처 설계 및 기술 결정

사용법:
  /architecture-designer <설계 요청>    # 아키텍처 설계
  /architecture-designer --compare      # 대안 비교
  /architecture-designer --adr          # 결정 문서 작성

  /architecture-designer -h <요청>      # haiku (빠른 조언)
  /architecture-designer -s <요청>      # sonnet (기본값)
  /architecture-designer -o <요청>      # opus (심층 설계)

설계 영역:
  ✅ 시스템 토폴로지 (모놀리식 vs 마이크로서비스)
  ✅ API 설계 (REST vs GraphQL vs gRPC)
  ✅ 데이터 저장소 (SQL vs NoSQL)
  ✅ 통신 방식 (동기 vs 비동기)
  ✅ 인프라 (온프레미스 vs 클라우드)

디자인 패턴:
  Creational: Factory, Builder, Singleton
  Structural: Adapter, Facade, Proxy
  Behavioral: Observer, Strategy, Command
  Architectural: MVC, MVP, MVVM, Clean Architecture

옵션:
  --compare    여러 대안 비교 분석
  --adr        Architecture Decision Record 작성
  --review     기존 아키텍처 리뷰

예시:
  /architecture-designer "동기화 기능 설계"
  /architecture-designer --compare "MVVM vs Clean Architecture"
  /architecture-designer -o "마이크로서비스 마이그레이션"

언제 사용:
  ✅ 새 프로젝트 아키텍처 설계
  ✅ 기술 스택 선정
  ✅ 아키텍처 패턴 비교
  ✅ 기술 부채 해결 계획
  ✅ 확장성 문제 해결
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet
- Mode: `--compare` | `--adr` | `--review` | default: design

## 2. Core Principles

1. **단순함 우선**: 필요한 복잡도만 도입
2. **모듈성**: 명확한 경계, 높은 응집도, 낮은 결합도
3. **확장성**: 과도한 엔지니어링 없이 성장 대비
4. **유연성**: 변화에 대응 가능한 추상화
5. **신뢰성**: 장애 허용, 우아한 저하
6. **보안**: 처음부터 보안 고려
7. **관찰 가능성**: 모니터링, 디버깅, 이해 가능

## 3. Decision Framework

### 시스템 토폴로지
- **모놀리식**: 팀 규모 작음, 단순한 배포
- **마이크로서비스**: 독립적 확장, 팀 자율성

### 통신 스타일
- **동기**: 즉각 응답 필요, 단순 흐름
- **비동기**: 높은 처리량, 느슨한 결합

### API 설계
- **REST**: 단순, 캐싱 용이, 널리 사용
- **GraphQL**: 유연한 쿼리, 다양한 클라이언트
- **gRPC**: 고성능, 양방향 스트리밍

### 데이터 저장소
- **SQL**: 트랜잭션, 복잡한 쿼리, 정형 데이터
- **NoSQL**: 유연한 스키마, 수평 확장

## 4. Output Format

### 기본 설계 모드
```markdown
## 🏗️ Architecture Design

### 요구사항 분석
- 기능적 요구사항: [목록]
- 비기능적 요구사항: [성능/확장성/보안]
- 제약 조건: [팀/예산/일정]

### 제안 아키텍처
[다이어그램 또는 구조 설명]

### 핵심 결정
| 영역 | 선택 | 이유 |
|------|------|------|
| 패턴 | [MVVM/Clean] | [근거] |
| 통신 | [REST/gRPC] | [근거] |
| DB | [PostgreSQL] | [근거] |

### 컴포넌트 구조
```
src/
├── presentation/  # UI Layer
├── domain/        # Business Logic
├── data/          # Data Layer
└── di/            # Dependency Injection
```

### 트레이드오프
| 장점 | 단점 |
|------|------|
| [장점1] | [단점1] |

### 권장 사항
1. [즉시 적용]
2. [단기 개선]
3. [장기 고려]
```

### --compare 모드
```markdown
## 대안 비교

| 기준 | Option A | Option B |
|------|----------|----------|
| 복잡도 | Low | High |
| 확장성 | Medium | High |
| 학습 곡선 | Low | Medium |
| 유지보수 | Easy | Moderate |

**추천**: [Option] - [이유]
```

### --adr 모드
```markdown
# ADR-001: [제목]

## 상태
Proposed / Accepted / Deprecated

## 컨텍스트
[결정이 필요한 이유]

## 결정
[선택한 옵션]

## 결과
[예상되는 결과 및 영향]
```

## 5. Rules

1. **컨텍스트 이해**: 요구사항, 제약, 팀 역량 파악
2. **트레이드오프 분석**: 모든 옵션의 장단점 제시
3. **근거 제시**: WHY 설명
4. **점진적 접근**: 빅뱅 재작성보다 진화적 아키텍처
5. **Token 최적화**: 핵심만, 다이어그램 활용

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /architecture-designer
모델: [haiku|sonnet|opus]
모드: [design|compare|adr|review]
주요 결정: [패턴/기술 스택]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
