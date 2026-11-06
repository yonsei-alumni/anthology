# 연세대학교 졸업생 문집

연세대학교 졸업생 문집 웹사이트입니다.

- 배포 주소: https://yonsei-reunion.github.io

## 사전 준비

- [pandoc](https://pandoc.org/installing.html)

## 빌드

```bash
./build.sh
```

`src/content/` 디렉토리의 Markdown 파일을 HTML로 변환하여 `public/` 디렉토리에 출력합니다.

## 배포

`main` 브랜치에 push하면 GitHub Actions(`.github/workflows/deploy.yml`)가 빌드 후 `public/` 디렉토리를 GitHub Pages([yonsei-reunion.github.io](https://yonsei-reunion.github.io))에 배포합니다.

## 디렉토리 구조

```
src/
├── content/    # Markdown 원고 파일
└── template/
    ├── page.html   # pandoc HTML 템플릿
    └── style/      # CSS, 이미지 등 정적 자원
public/             # 빌드 결과물 (gitignore 대상)
```

## 페이지 추가 방법

1. `src/content/`에 새 Markdown 파일을 생성합니다. 첫 줄에 `# 제목`을 작성합니다.
2. `src/template/page.html`의 내비게이션 링크를 수동으로 추가합니다.
3. 다른 페이지에서 링크할 때는 `.html` 확장자를 사용합니다. (예: `essay-guide.html`)
