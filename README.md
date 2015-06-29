# [![>bootenv](http://bootenv.com/img/logo-light-transparent-readme-files.png)](http://bootenv.com)-DOCKER-REST API

[![dockeri.co](http://dockeri.co/image/bootenv/bootenv-rest-api)](https://registry.hub.docker.com/u/bootenv/bootenv-rest-api/)

[![license](https://img.shields.io/badge/license-Apache_2.0-blue.svg)](LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/bootenv/bootenv-docker-rest-api.svg "GitHub issues")](https://github.com/bootenv/bootenv-docker-rest-api/issues)
[![GitHub stars](https://img.shields.io/github/stars/bootenv/bootenv-docker-rest-api.svg "GitHub stars")](https://github.com/bootenv/bootenv-docker-rest-api)

## Introduction

The official `>bootenv` REST-API Docker image, made with love by the `>bootenv` community.

### Version

Current Version: **1.0.0-alpha.1**

### Prerequisites

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/)
* [Docker](https://docs.docker.com/userguide/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Contributing

If you find this image useful here's how you can help:

- Send a Pull Request with your awesome new features and bug fixes
- Help new users with [Issues](https://github.com/bootenv/bootenv-docker-rest-api/issues) they may encounter

## Installation

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image. 

These builds are performed by the **Docker Trusted Build** service.

```bash
docker pull bootenv/bootenv-rest-api:1.0.0-alpha.1
```

You can also pull the `latest` tag which is built from the repository *HEAD*

```bash
docker pull bootenv/bootenv-rest-api:latest
```

Alternately you can build the image locally.

```bash
git clone https://github.com/bootenv/bootenv-docker-rest-api.git
cd bootenv-docker-rest-api
docker build --tag="bootenv/bootenv-rest-api:latest" .
```

## Quick Start

The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/).

```bash
wget https://raw.githubusercontent.com/bootenv/bootenv-docker-rest-api/master/docker-compose.yml
docker-compose up
```

__NOTE__: Please allow a couple of minutes for the `>bootenv` REST-API to start.

Visit `>bootenv` REST-API status at [http://localhost:3000](http://localhost:3000).

To explore `>bootenv` REST-API visit [http://localhost:3000/explorer](http://localhost:3000/explorer).


## Configuration

### Database

`>bootenv` REST-API uses a MongoDB database backend to store its data.

#### External MongoDB Server

The image can be configured to use an external MongoDB database. The database configuration should be specified using environment variables while starting the `>bootenv` REST-API image.

Before you start the `>bootenv` REST-API image create user and database for `>bootenv`.

```bash
mongod --noauth
mongo
use bootenv-db;
db.createUser({user: "myuser", pwd: "mypassword", roles: [ { role: "userAdmin", db: "bootenv-db" } ]});
```

We are now ready to start the `>bootenv` REST-API.

*Assuming that the MongoDB server is running on `192.168.1.100:27017`

```bash
docker run -d -p 3000:3000 --env='NODE_ENV=production' --env='MONGO_URL=mongodb://myuser:mypassword@192.168.1.100:27017' bootenv/bootenv-rest-api:latest
```

#### Linking to MongoDB Container

Alternately, you can manually launch the `>bootenv` REST-API container and the supporting `mongodb` container by following this two steps guide.

* Step 1. Launch a mongodb container

```bash
docker run -d --name mongo -v $(pwd)/mongo:/data/db -p 27017:27017 mongo:3.0.4
```

* Step 2. Launch the `>bootenv` REST-API container

```bash
docker run -d --name api --link mongo:mongo -p 3000:3000 --env='NODE_ENV=production' --env='MONGO_URL=mongodb://mongo:27017' bootenv/bootenv-rest-api:latest
```

## Further Reading / Useful Links

* [StrongLoop](https://strongloop.com/)
* [LoopBack](http://docs.strongloop.com/display/public/LB/LoopBack)
* [Getting started with LoopBack](http://docs.strongloop.com/display/public/LB/Getting+started+with+LoopBack)
* [Docker](https://docs.docker.com/userguide/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Versions
 
 - 1.0.0-alpha.1 (current)

## License

[Apache-2.0](LICENSE)
