# Ordering

![GitHub tag (latest by date)](https://img.shields.io/github/tag-date/czc-dev/Ordering-system?style=for-the-badge)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/czcdev/orderingsystem?style=for-the-badge)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/czcdev/orderingsystem?style=for-the-badge)
[![CircleCI](https://circleci.com/gh/czc-dev/Ordering-system.svg?style=svg)](https://circleci.com/gh/czc-dev/Ordering-system)

[![DockerICO](https://dockeri.co/image/czcdev/orderingsystem)](https://hub.docker.com/r/czcdev/orderingsystem)

## Usage

### Setup

```shell
# copy .env.sample to .env
# then edit as you like it
$ cp .env.sample .env
```

### Run (on development)

```shell
$ make init
$ make up
```

### Run production

```shell
$ make production
```

### Run test

```shell
$ make rspec
```

### Generate ERD

```shell
$ make erd
```

## Reference

- [REF.md](REF.md)
