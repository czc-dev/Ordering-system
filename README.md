# Ordering

![GitHub tag (latest by date)](https://img.shields.io/github/tag-date/czc-dev/Ordering-system?style=for-the-badge)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/czcdev/orderingsystem?style=for-the-badge)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/czcdev/orderingsystem?style=for-the-badge)
[![CircleCI](https://circleci.com/gh/czc-dev/Ordering-system.svg?style=svg)](https://circleci.com/gh/czc-dev/Ordering-system)

[![DockerICO](https://dockeri.co/image/czcdev/orderingsystem)](https://hub.docker.com/r/czcdev/orderingsystem)

## Usage

### Run (on development)

```shell
$ make init

# up postgres
# run foreman (rails server / webpack-dev-server)
# - ctrl-c to stop
$ make up

# stop postgres
$ make down
```

### Run test

```shell
$ bundle exec rspec
```

### Run CI (on local)

```shell
$ circleci local execute --job rspec
```

## Reference

- [REF.md](REF.md)
