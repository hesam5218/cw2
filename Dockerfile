FROM node:16

WORKDIR /app

COPY server.js .

EXPOSE 8081  443

CMD ["node", "server.js"]

