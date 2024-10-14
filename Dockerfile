from node:slim

WORKDIR /app

ENV NODE_ENV development

COPY package.json /app

RUN yarn install

COPY . /app

EXPOSE 3000

CMD [ "node", "index.js" ]
