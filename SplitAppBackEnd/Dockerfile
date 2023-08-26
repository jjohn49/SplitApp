FROM node:18-alpine
WORKDIR /app
COPY package.json /app
RUN npm install && npm ci --only=production && npm cache clean --force
COPY . /app

CMD node app.js
EXPOSE 8081