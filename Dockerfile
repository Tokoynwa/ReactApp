# Step 1: Build the application
FROM node:16 as build

WORKDIR /app
COPY package.json ./
RUN yarn install
COPY . .
RUN yarn build

# Step 2: Serve the application from Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
