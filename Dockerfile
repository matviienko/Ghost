# https://docs.ghost.org/faq/node-versions/
# https://github.com/nodejs/LTS
# https://github.com/TryGhost/Ghost/blob/3.3.0/package.json#L38
FROM node:12-buster-slim

USER root

# grab gosu for easy step-down from root
# https://github.com/tianon/gosu/releases
ENV GOSU_VERSION 1.12
ENV GHOST_INSTALL /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost/content
ENV GHOST_CLI_VERSION 1.15.3
ENV GHOST_VERSION 3.40.5

# ENV NODE_ENV production

# RUN yarn global add knex-migrator grunt-cli ember-cli

RUN apt-get update && apt-get install -y git python build-essential

RUN npm update -g npm

RUN npm install -g grunt-cli

RUN npm install -g ember-cli

RUN set -eux && mkdir -p "$GHOST_INSTALL"

COPY . "$GHOST_INSTALL"

RUN chown node:node -R "$GHOST_INSTALL";

RUN chmod 0777 -R "$GHOST_INSTALL";

COPY docker-entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR $GHOST_INSTALL
USER node
EXPOSE 2368
ENTRYPOINT ["docker-entrypoint.sh"]
# CMD ["npm", "start"]
CMD ["grunt", "dev"]
# CMD ["grunt", "prod"]
# CMD ["grunt", "release"]
# CMD grunt release && ls -la && ls -la ./.build && ls -la ./.dist