# Ordering

[![Build Status](https://travis-ci.com/arsley/Ordering-system.svg?branch=master)](https://travis-ci.com/arsley/Ordering-system)

## Usage

### Setup

```shell
# copy .env.sample to .env
# then edit as you like it
$ cp .env.sample .env
$ cp web/.env.sample web/.env

$ make init
```

### Run (on development)

```shell
$ make up
```

### Run production(no check)

#### 1.

Change `web/.env`.

```diff
- RAILS_ENV=development
+ RAILS_ENV=production
```

#### 2.

```shell
# run db migration, data initialization, assets precompilation
$ make pinit
```

#### 3.

Follow this setting. [#3](https://github.com/assly/Ordering-system/issues/3#issuecomment-423792514)

#### 4.

```shell
$ make upd
```

### Run test

Validate `nginx.conf`, `unbound.conf` and run `rspec`.

```shell
$ make tests
```

### Generate ERD

Required:graphviz on running machine.

```shell
$ make erd
```

### More...

Read [Makefile](Makefile).

## Reference

- [REF.md](REF.md)
