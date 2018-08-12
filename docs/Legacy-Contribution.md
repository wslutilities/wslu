## Development

To make contributions to the project, you will need to run `git submodule init; git submodule update` in order to start develop. To run tests, enter `wsluconfig --test`; test cases are written in [bats](https://github.com/bats-core/bats-core), please check the documentation before writing documentation. TO check WSL Interopability, please run `wsluconfig --interop-check`. This will check `/proc/sys/fs/binfmt_misc/WSLInterop`, `cmd.exe`, `powershell.exe`, and `reg.exe`.