# MirrorLit 애플리케이션 Dockerfile
FROM node:18

WORKDIR /app

# package.json과 package-lock.json 복사
COPY package*.json ./

# 의존성 설치
RUN npm install

# 소스 코드 복사
COPY . .

# 포트 노출 (기본 포트 3000)
EXPOSE 3000

# 애플리케이션 실행
CMD ["npm", "start"]

