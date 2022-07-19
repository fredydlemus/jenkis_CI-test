FROM node:16.14.2

WORKDIR /app

COPY ["package.json", "package-lock.json", "/app/"]

RUN npm install

EXPOSE 3000

COPY [".", "/app/"]

CMD ["node", "index.js"]