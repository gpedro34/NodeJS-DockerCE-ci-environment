# Node JS + NPM + Docker + docker-compose in a Docker container

## Usage

`docker run --privileged -d -v /var/run/docker.sock:/var/run/docker.sock gpedro34/nodejs-dockercd-ci-environment`
Needs docker unix socket mapped to `/var/run/`

## Notes

- Build fails a lot while installing **gcc** and **docker**, just keep trying to build without **--no-cache** flag in the docker build command and it will eventually get built

- You can specify the docker-compose version by changing COMPOSE_VERSION argument at the top of the [Dockerfile](https://github.com/gpedro34/nodejs-docker-jenkins-ci-environment/blob/master/Dockerfile)
