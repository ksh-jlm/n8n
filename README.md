# n8n Workflow Automation Server

이것은 n8n을 Docker로 실행하는 프로젝트입니다.

## 프로젝트 구조

```
n8n/
├── .env                    # 환경 변수 (로컬에서만 사용)
├── .gitignore              # Git 제외 파일
├── docker-compose.yml      # Docker Compose 설정
├── Dockerfile              # n8n Docker 이미지 구성
└── README.md               # 이 파일
```

## 사전 요구사항

- Docker Desktop 설치됨
- Docker Compose 설치됨 (Docker Desktop에 포함됨)

## 환경 변수 설정

`.env` 파일에서 다음 변수들을 수정하세요:

| 변수 | 설명 | 기본값 |
|------|------|--------|
| `N8N_PORT` | n8n 서버 포트 | 5678 |
| `N8N_PROTOCOL` | 프로토콜 (http/https) | http |
| `N8N_HOST` | 호스트명 | localhost |
| `N8N_ENCRYPTION_KEY` | 데이터 암호화 키 | (필수) |
| `N8N_DEFAULT_LOGIN_EMAIL` | 기본 관리자 이메일 | admin@example.com |
| `N8N_DEFAULT_LOGIN_PASSWORD` | 기본 관리자 비밀번호 | password |
| `N8N_LOG_LEVEL` | 로그 레벨 | info |

## 실행 방법

### 1. 환경 변수 설정
```bash
# .env 파일 수정 (선택사항)
# 또는 기본값으로 사용
```

### 2. n8n 시작
```bash
docker-compose up -d
```

### 3. 서버 확인
브라우저에서 `http://localhost:5678` 접속

### 4. 로그 확인
```bash
docker-compose logs -f n8n
```

### 5. 서버 중지
```bash
docker-compose down
```

## 데이터 저장소

- **SQLite**: 로컬 개발 환경용 (기본값)
- **PostgreSQL/MySQL**: 프로덕션 환경용 (필요시 `.env` 수정)

데이터는 Docker volume `n8n_data`에 저장됩니다.

## 마이그레이션 (PostgreSQL 사용 시)

```bash
# .env 파일 수정
N8N_DB_TYPE=postgresdb
N8N_DB_POSTGRESDB_HOST=postgres
N8N_DB_POSTGRESDB_PORT=5432
N8N_DB_POSTGRESDB_DATABASE=n8n
N8N_DB_POSTGRESDB_USER=n8n
N8N_DB_POSTGRESDB_PASSWORD=password

# docker-compose.yml에 postgres 서비스 추가
```

## 유용한 명령어

```bash
# 컨테이너 상태 확인
docker-compose ps

# 로그 확인
docker-compose logs -f

# 컨테이너 재시작
docker-compose restart n8n

# 데이터 초기화 (주의!)
docker-compose down -v
```

## 트러블슈팅

### 포트 충돌
다른 포트를 사용하려면 `.env`에서 `N8N_PORT` 수정

### 권한 오류
```bash
# Linux/Mac에서 발생 시
sudo chown -R 1000:1000 ./n8n_data
```

### 데이터베이스 에러
```bash
# SQLite 파일 삭제 후 재시작
docker-compose down -v
docker-compose up -d
```

## 보안 고려사항

⚠️ 프로덕션 환경에서는:
1. `N8N_ENCRYPTION_KEY` 설정 필수
2. 강력한 `N8N_DEFAULT_LOGIN_PASSWORD` 설정
3. HTTPS 사용 (`N8N_PROTOCOL=https`)
4. 환경 변수를 `.env.local`로 관리 (`.gitignore`에 등록됨)

## 참고 자료

- [n8n 공식 문서](https://docs.n8n.io)
- [n8n Docker Hub](https://hub.docker.com/r/n8nio/n8n)
