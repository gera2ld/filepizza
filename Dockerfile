FROM --platform=$BUILDPLATFORM node:alpine AS builder
COPY . ./
RUN npm install && npm run build

FROM node:alpine
ENV NODE_ENV production
WORKDIR /filepizza
COPY --from=builder ./package.json ./package-lock.json ./
COPY --from=builder ./dist ./dist
RUN npm install
EXPOSE 80
CMD node ./dist/index.js
