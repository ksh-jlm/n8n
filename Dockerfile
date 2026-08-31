FROM n8nio/n8n:latest

# git push 자동화(Execute Command 노드)를 위해 git 설치
USER root
RUN apk add --no-cache git
USER node

ENV NODE_ENV=production

EXPOSE 5678

CMD ["n8n", "start"]
