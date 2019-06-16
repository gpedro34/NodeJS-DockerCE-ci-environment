FROM jenkins/jnlp-agent-docker:latest
# See https://github.com/jenkinsci/docker/blob/master/README.md for more information on the base image

ARG COMPOSE_VERSION="1.23.2"

LABEL vendor.name="jenkins" \
    vendor.docker.home="https://hub.docker.com/u/jenkins" \
    vendor.docker.repository="https://hub.docker.com/r/jenkins/jnlp-agent-docker" \
    vendor.docker.repository.name="jnlp-agent-docker" \
    vendor.docker.repository.tag="latest" \
    vendor.docker.repository.OS="Linux" \
    vendor.docker.repository.distribution="Alpine" \
    vendor.docker.repository.workDir="/home/jenkins" \ 
    vendor.docker.repository.distribution.java.home="/usr/lib/jvm/java-1.8-openjdk" \
    vendor.docker.repository.distribution.java.version="8u201" \
    vendor.docker.repository.distribution.java.alpine.version="8.201.08-r1"

LABEL maintainer.name="gpedro34" \
    maintainer.docker.home="https://hub.docker.com/u/gpedro34" \
    maintainer.docker.repository="https://hub.docker.com/r/gpedro34/nodejs-dockerce-ci-environment" \
    maintainer.github.home="http://github.com/gpedro34" \
    maintainer.github.repository="http://github.com/gpedro34/nodejs-dockerce-ci-environment.git" \
    maintainer.release.tag="latest"


USER root

# Update repositories lists
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main" >> /etc/apk/repositories
RUN apk update

# Install build compilers and python tools
RUN apk add --no-cache build-base=0.5-r1
RUN apk add --no-cache py-setuptools=40.6.3-r0 py2-pip=18.1-r0 \
    python2-dev=2.7.16-r1 \
    libffi-dev=3.2.1-r6 \
    openssl-dev=1.1.1b-r1 \
    libc-dev=0.7.1-r0 \
    make=4.2.1-r2

# Install NodeJS and NPM
RUN apk add --no-cache nodejs-current=11.3.0-r0 npm=10.14.2-r0

# Install Docker CE
RUN apk add --no-cache docker=18.09.1-r0

# Install compose run script
RUN curl -L --fail https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/run.sh -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN adduser jenkins root

# Drop back to the regular jenkins user
USER jenkins

RUN node -v
RUN npm -v
RUN docker -v
# docker-compose runs as a docker container
# and as such can't have it's version verified at build stage
# since it doesn't have the docker unix socker mapped to `/var/run/`