# Faros

[![Circle CI](https://circleci.com/gh/felipesere/faros/tree/master.svg?style=svg)](https://circleci.com/gh/felipesere/faros/tree/master)

An app to share books, blogs, conferences, events or pretty much any other resource
for learning.

### Up and running

To install the dependencies and setup the database run the following commands:

```
mix deps.get
mix ecto.create
mix ecto.migrate
```

To start the server:

```
mix phoenix.server
```

## Prerequisites
* Install docker  `brew install docker`
* Install docker-machine: `brew install docker-machine`
* Create a boot2docker VM in vagrant: ` docker-machine create --driver virtualbox boot2docker`
* Install docker-compose `brew install docker-compose`

Make Docker talk to  to boot2docker: `eval $(docker-machine env boot2docker)`
`docker info` should give some usable info.

## Performing a release
Make sure you have your `boot2docker` VM up and can connect to it with Docker.

1. Double check the production settings in `config/prod.exs`
2. Run `mix package` to create all assets and package them in a Docker image

## Running it in docker/docker-compose
1. To run Faros with a MySQL db, run `docker-compose up`
2. Open your browser on the IP  of the VM: `docker-machine ip boot2docker`

The base image and the nginx-lb image used in docker-compose can be found here: http://github.com/felipesere/faros_docker
