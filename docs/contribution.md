# Contribution

## Start

Install `wslu` using source code. Everything will set-up automatically.

## Build Structure

```
wslu
|-src
|  |-wslu-header: Header file of all script
|  \-<components>.sh: Components of script
|-script: scripts used for building, installing and uninstalling
|-tests: location for script tests
\-extras
   |-bats: testing utility
   \-wiki: the clone of this wiki page
```

## Build

run `make` to build executable in `out` folder.
run `make clean` to remove the `out` folder.
run `make test` to run tests.

## Test

`wslu` use [bats](https://github.com/bats-core/bats-core) for testing. Please refer to [its guide](https://github.com/bats-core/bats-core#writing-tests) to write tests.

