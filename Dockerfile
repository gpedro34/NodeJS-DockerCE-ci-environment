FROM docker:dind

RUN apk add nodejs-current \
    && apk add npm \
    && npm install npm@latest