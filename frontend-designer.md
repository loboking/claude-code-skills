---
allowed-tools: Read, Write, WebFetch, Bash, Glob, Grep
description: 프론트엔드 디자인 - 톤앤매너 일치 + 무료 리소스 + Anti-AI 디자인
model: sonnet
---

Args: "$ARGUMENTS"

## 0. Help System

If args match `--help`, `-h` alone, or empty:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 /frontend-designer 사용 가이드

용도: AI 느낌 없는, 사람이 만든 것 같은 유니크한 디자인

사용법:
  /frontend-designer <페이지 설명>     # 페이지 디자인
  /frontend-designer --analyze <URL>   # 기존 페이지 분석

  /frontend-designer -h <요청>         # haiku (빠른 디자인)
  /frontend-designer -s <요청>         # sonnet (기본값)
  /frontend-designer -o <요청>         # opus (정교한 디자인)

핵심 원칙:
  ✅ 톤앤매너 일치 - 기존 페이지와 완벽한 조화
  ✅ 무료 리소스만 - 저작권 100% 안전
  ✅ 아이콘 최소화 - AI 느낌 제거
  ✅ 최신 트렌드 - 2024-2025 디자인
  ✅ Material Design 회피 - 사람이 만든 느낌

무료 리소스:
  폰트: Google Fonts (OFL, Apache 2.0)
  아이콘: Heroicons (MIT), Lucide (ISC)
  이미지: Unsplash, Pexels (CC0)
  일러스트: unDraw (MIT)

옵션:
  --analyze     기존 페이지 톤앤매너 분석
  --dark        다크 모드 버전
  --responsive  반응형 디자인 포함

예시:
  /frontend-designer "로그인 페이지"
  /frontend-designer --analyze "https://example.com"
  /frontend-designer -o "대시보드 + 반응형"

언제 사용:
  ✅ 새 페이지 디자인
  ✅ 기존 디자인 개선
  ✅ 톤앤매너 통일
  ✅ 저작권 안전한 리소스 필요
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1. Parse Options

- Model: `-h` (haiku) | `-s` (sonnet) | `-o` (opus) | default: sonnet
- Mode: `--analyze` | `--dark` | `--responsive`

## 2. Phase 1: 톤앤매너 분석

### 기존 페이지 분석 (--analyze 또는 자동)
```markdown
## 톤앤매너 분석 결과

### 색상 팔레트
- Primary: #3B82F6 (파랑)
- Secondary: #10B981 (초록)
- Accent: #F59E0B (주황)
- Background: #F9FAFB
- Text: #111827

### 타이포그래피
- 주 폰트: Inter, sans-serif
- 제목: 32px/24px/18px
- 본문: 16px, Line Height 1.5

### 간격 시스템
- 기본 그리드: 8px
- 여백: 16px, 24px, 32px, 48px
- Border Radius: 8px, 12px

### 효과
- Box Shadow: 0 1px 3px rgba(0,0,0,0.1)
- Transition: 200ms ease-in-out
```

## 3. Phase 2: 저작권 안전 리소스

### 허용 (100% 안전)
| 카테고리 | 출처 | 라이선스 |
|----------|------|----------|
| 폰트 | Google Fonts | OFL, Apache 2.0 |
| 아이콘 | Heroicons, Lucide | MIT, ISC |
| 이미지 | Unsplash, Pexels | CC0 |
| 일러스트 | unDraw | MIT |
| CSS | Tailwind | MIT |

### 금지
- ❌ FontAwesome Free (상업적 제한)
- ❌ Bootstrap Icons (SCSS 의존)
- ❌ 출처 불명 아이콘
- ❌ Freepik, iStock (유료)

## 4. Phase 3: Anti-AI 디자인

### 피해야 할 것 (AI 느낌)
- ❌ 균일한 8px 그리드
- ❌ 완벽한 대칭
- ❌ Material Design 그대로
- ❌ 아이콘 과다 사용
- ❌ 무난한 파란색 (#2196F3)

### 적용해야 할 것 (사람 느낌)
- ✅ 미세한 비대칭 (2-4px 차이)
- ✅ 손글씨/필기체 악센트
- ✅ 의도적 불완전함
- ✅ 유니크한 색상 조합
- ✅ 여백 강조 (컨텐츠 적게)

## 5. Output Format

```markdown
## 🎨 Frontend Design

### 디자인 컨셉
- 스타일: [미니멀/모던/플레이풀]
- 톤: [전문적/친근함/세련됨]

### 색상 팔레트
```css
:root {
  --primary: #...;
  --secondary: #...;
  --accent: #...;
  --bg: #...;
  --text: #...;
}
```

### 사용 리소스
- 폰트: [Google Fonts 링크]
- 아이콘: [Heroicons/Lucide 필요한 것만]
- 이미지: [Unsplash 검색어]

### HTML/CSS 코드
[실제 구현 코드]

### 반응형 브레이크포인트
- Mobile: < 640px
- Tablet: 640px - 1024px
- Desktop: > 1024px
```

## 6. Rules

1. **톤앤매너 일치**: 기존 디자인과 조화
2. **저작권 안전**: 허용 리소스만 사용
3. **Anti-AI**: 사람이 만든 느낌
4. **최소주의**: 아이콘, 요소 최소화
5. **Token 최적화**: 코드 중심, 설명 최소화

---

## Final Metadata Output

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 실행 정보

스킬: /frontend-designer
모델: [haiku|sonnet|opus]
페이지: [생성된 페이지명]
사용 리소스: [폰트/아이콘/이미지]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
