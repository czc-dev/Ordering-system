# Ordering

[![Build Status](https://travis-ci.com/assly/Ordering-system.svg?token=psdNHptWTJtv9nkysqWZ&branch=master)](https://travis-ci.com/assly/Ordering-system)

## Usage

### Setup

```
$ make init
```

### Run (on development)

```
$ make up
```

### Run production(no check)

#### 1.

```
$ make pinit
```

#### 2.

```diff
# docker-compose.yml(41)
- bundle exec rails s
+ bundle exec rails s -e production
```

#### 3.

Follow this setting. [#3](https://github.com/assly/Ordering-system/issues/3#issuecomment-423792514)

#### 4.

```
$ make up
```

### Run test

Validate `nginx.conf`, `unbound.conf` and run `rspec`.

```
$ make tests
```

### Generate ERD

Required:graphviz on running machine.

```
$ make erd
```

### More...

Read [Makefile](Makefile).

## Reference

- [REF.md](REF.md)
