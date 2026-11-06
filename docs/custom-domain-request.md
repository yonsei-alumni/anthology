# reunion.yonsei.ac.kr 도메인 연결 요청

연세대학교 졸업생 문집(졸업 25주년 재상봉 기념집) 웹사이트를 `reunion.yonsei.ac.kr` 주소로 접속할 수 있도록 DNS 레코드 추가를 요청드립니다.

## 요청 개요

| 항목 | 내용 |
|---|---|
| 연결할 도메인 | `reunion.yonsei.ac.kr` |
| 현재 사이트 주소 | https://yonsei-reunion.github.io |
| 호스팅 | GitHub Pages (정적 HTML 웹사이트) |
| 요청 작업 | `yonsei.ac.kr` 영역에 CNAME 레코드 1건 추가 |

사이트는 GitHub Pages에서 운영하므로 학교 서버나 IP를 따로 쓰지 않습니다. DNS 레코드만 추가해 주시면 됩니다.

## 요청 사항: CNAME 레코드 추가

| 이름(호스트) | 유형 | 값(대상) | TTL |
|---|---|---|---|
| `reunion` (= `reunion.yonsei.ac.kr.`) | CNAME | `yonsei-reunion.github.io.` | 기본값 (예: 3600) |

BIND zone 파일 형식으로는 다음 한 줄입니다.

```
reunion    IN    CNAME    yonsei-reunion.github.io.
```

참고 사항:

- 값에는 경로 없이 `yonsei-reunion.github.io`만 넣습니다.
- 2026년 11월 7일 기준으로 `reunion.yonsei.ac.kr`에는 레코드가 없어(NXDOMAIN) 기존 레코드와 겹치지 않습니다. CNAME은 같은 이름의 다른 레코드(A, MX, TXT 등)와 함께 둘 수 없으므로, 그사이 다른 레코드가 생겼다면 알려 주십시오.
- 교내용 DNS와 외부용 DNS를 따로 운영하신다면 양쪽 모두에 추가해 주십시오.
- 웹방화벽이나 리버스 프록시를 거치지 않고 DNS가 GitHub Pages를 직접 가리키도록 해 주십시오. GitHub가 이 도메인의 HTTPS 인증서를 자동 발급할 때 도메인이 GitHub 서버로 직접 연결되어 있어야 합니다.

### CNAME을 쓸 수 없는 경우

CNAME 대신 아래 A/AAAA 레코드로도 연결할 수 있습니다. 다만 GitHub가 IP를 바꾸면 레코드도 바꿔야 하므로 가능하면 CNAME을 권장합니다.

| 이름(호스트) | 유형 | 값 |
|---|---|---|
| `reunion` | A | `185.199.108.153` |
| `reunion` | A | `185.199.109.153` |
| `reunion` | A | `185.199.110.153` |
| `reunion` | A | `185.199.111.153` |
| `reunion` | AAAA | `2606:50c0:8000::153` |
| `reunion` | AAAA | `2606:50c0:8001::153` |
| `reunion` | AAAA | `2606:50c0:8002::153` |
| `reunion` | AAAA | `2606:50c0:8003::153` |

## 선택 사항: 도메인 소유 확인 TXT 레코드 (권장)

GitHub에서 도메인 소유 확인을 마쳐 두면 다른 GitHub 계정이 `reunion.yonsei.ac.kr`을 자기 사이트에 연결할 수 없습니다(서브도메인 탈취 방지). 가능하시면 아래 레코드도 함께 추가해 주십시오. 값은 GitHub에서 발급받아 따로 전달드리겠습니다.

| 이름(호스트) | 유형 | 값 |
|---|---|---|
| `_github-pages-challenge-yonsei-reunion.reunion` | TXT | (별도 전달) |

## HTTPS 인증서

HTTPS 인증서는 GitHub가 Let's Encrypt로 자동 발급하고 갱신하므로 학교에서 따로 준비하실 필요가 없습니다.

현재 `yonsei.ac.kr`에는 CAA 레코드가 없어서 인증서 발급에 문제가 없습니다. 나중에 CAA 레코드를 추가하시게 되면 `letsencrypt.org`도 허용해 주십시오.

```
yonsei.ac.kr.    IN    CAA    0 issue "letsencrypt.org"
```

## 설정 후 확인 방법

레코드가 반영되면 다음과 같이 조회됩니다.

```
$ dig +short reunion.yonsei.ac.kr
yonsei-reunion.github.io.
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

Windows에서는 `nslookup reunion.yonsei.ac.kr`을 실행했을 때 별칭(Aliases)에 `yonsei-reunion.github.io`가 나오면 됩니다.

## 이후 진행

DNS 반영이 확인되면 저희 쪽에서 다음 작업을 진행합니다. 학교 쪽에서 추가로 하실 일은 없습니다.

1. GitHub Pages 설정에 사용자 지정 도메인 `reunion.yonsei.ac.kr`을 등록합니다.
2. HTTPS 인증서가 발급되면 HTTPS 접속을 강제합니다.
3. 이후 기존 주소(https://yonsei-reunion.github.io)로 접속하면 https://reunion.yonsei.ac.kr 로 자동 이동합니다.

## 사이트 운영을 종료할 때

사이트를 내리게 되면 미리 알려드리겠습니다. 그때 위의 CNAME 레코드도 삭제해 주십시오. GitHub 쪽 설정만 지우고 CNAME 레코드를 남겨 두면 다른 사람이 이 주소를 가져가 쓸 수 있습니다.
