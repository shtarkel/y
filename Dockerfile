#Dynamic build
FROM node:10-slim
WORKDIR /
COPY package.json package-lock.json ./
RUN npm i
COPY . ./
CMD ["npm", "start"]