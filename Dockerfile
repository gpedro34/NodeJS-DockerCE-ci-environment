FROM jenkins/jnlp-agent-docker

RUN apk add nodejs-current \
    && apk add npm