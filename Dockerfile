FROM node:14.17-slim as build

LABEL "com.github.actions.name"="Automated version bump for Android apps."
LABEL "com.github.actions.description"="Automated version bump for Android apps."
LABEL "com.github.actions.icon"="chevron-up"
LABEL "com.github.actions.color"="blue"

COPY ./ ./

RUN apt-get update
RUN apt-get install -y git

RUN npm ci
RUN npm run clean
RUN npm run build
RUN npm run package
RUN npm prune --production

RUN ls

ENTRYPOINT ["node", "dist/index.js"]
