# ---ESTAGIO 1: Build & Dependencias ---
FROM node:20-alpine AS builder

WORKDIR /APP

COPY package*.json ./

RUN npm install

COPY . .

# ---ESTAGIO 2: IMAGEM de produção leve ---
FROM node:20-alpine

WORKDIR /APP

COPY package*.json ./
RUN npm ci --only=production

COPY --from=builder /APP/server.js ./server.js

USER node
EXPOSE 3000

CMD ["node", "server.js"]