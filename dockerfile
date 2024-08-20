FROM node:latest as frontend_build 

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY --from=frontend_build /app/build .

EXPOSE 80
