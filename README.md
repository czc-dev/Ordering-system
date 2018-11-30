# Ordering

[![Build Status](https://travis-ci.com/arsley/Ordering-system.svg?branch=master)](https://travis-ci.com/arsley/Ordering-system)

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

Change `.env`.

```diff
- RAILS_ENV=development
+ RAILS_ENV=production
```

#### 2.

```
$ make pinit
```

#### 3.

Follow this setting. [#3](https://github.com/assly/Ordering-system/issues/3#issuecomment-423792514)

#### 4.

```
$ make upd
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
