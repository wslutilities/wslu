# Contribution

## Setup

running the following to get started:

```bash
curl -o- https://raw.githubusercontent.com/wslutilities/wslu/develop/scripts/install-dev.sh | bash
```

## Build Structure

```
wslu
|-src
|  |-wslu-header: Header file of all script
|  \-<components>.sh: Components of script
|-scripts: scripts used for building, installing and uninstalling
|-tests: location for script tests
\-extras
   \-bats: testing utility
```

## Build

run `make` to build executable to `out` folder.
run `make clean` to clean `out` folder.
run `make test` to run tests.

## Test

`wslu` use [bats](https://github.com/bats-core/bats-core) for testing. Please refer to [its guide](https://github.com/bats-core/bats-core#writing-tests) to write tests.

## Build Packages

For Debian Package, run:
```bash
cd script
sudo ./builder-deb.sh
```

For RPM Package, run:
```bash
cd script
sudo ./builder-rpm.sh
```

It is suggested to do such action in Ubuntu 14.04 LTS or its corresponding environment.