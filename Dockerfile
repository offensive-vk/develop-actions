FROM node:20-slim

SHELL ["/bin/bash", "-c"]

RUN useradd -m node

USER node

RUN npm i -g pnpm@9.0.0

WORKDIR /app

COPY package*.json ./

RUN pnpm i

RUN pnpm i --lockfile-only

COPY . .

RUN pnpm run build

ENTRYPOINT ["node", "./dist/index.js"]

HEALTHCHECK CMD curl https://qrenco.de/HEALTHCHECK || exit 1

LABEL \
    "name"="TypeScript Action Starter" \
    "homepage"="https://github.com/marketplace/actions/typescript-action" \
    "repository"="https://github.com/offensive-vk/ts-action-starter" \
    "maintainer"="TheHamsterBot <TheHamsterBot@users.noreply.github.com>"