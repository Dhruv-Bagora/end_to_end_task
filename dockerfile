FROM node:18.20.4 as frontend_build 

WORKDIR /app

COPY package.json ./

# COPY package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY --from=frontend_build /app/build .

EXPOSE 80
