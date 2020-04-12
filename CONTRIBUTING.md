# Contributing

We love pull requests from everyone. By participating in this project, you agree to abide by [Code of Conduct](CODE_OF_CONDUCT.md).

## Code contributions

### Setup

Run the following to get started:
```bash
git clone --recursive --branch develop https://github.com/wslutilities/wslu.git
./configure.sh
make
sudo make res_install
```

### Structure

```
wslu
|-src
|  |-etc
|  |  |-wsl.ico: legacy default icon for wslusc
|  |  |-wsl-gui.ico: default icon for wslusc GUI shortcut
|  |  |-wsl-term.ico: default icon for wslusc cli shortcut
|  |  |-sudo.ps1: helper script for wslgsu 
|  |  |-wslsc-helper.sh: helper script for wslusc on WSL side
|  |  \-runHidden.vbs: helper script for wslusc on Windows side
|  |-wslu-header: Header file of all script
|  \-<components>.sh: Components of script
|-tests: location for script tests
\-extras
   |-bats: testing utility
   |-scripts: scripts
   \-build
      |-debian: files for building .deb
      |-rpm: files for building .rpm
      |-arch: files for building Arch Linux packages
      \-alpine: files for building Alpine Linux packages
```

### configure.sh

`configure.sh` is the script to complete some preprocessing task for both developing and packaging building.

Following parameter is available for developing:
- `-e,  --env` -- Environment Check, check whether it is using Fake WSL Environment, normal Linux or WSL.
- `-p, --prsh` -- Check Status of `powershell.exe`.
- `-P,  --pkg` -- Install Needed Packages required by your system for building.

Following parameter is available for package building:
- `--build` -- helper to add the version to wslu header.
- `--deb <distro>` -- preprocessing script for deb packages.`<distro>` should be version code name like `bionic`, `stable`, `kali-rolling` or `buster`.
- `--rpm` -- preprocessing script for rpm packages.

### Build & Install

run `make` to build executables to `out` folder and manages to `out-docs` folder.
run `make doc` to build manpage only.
run `make clean` to remove `out` and `out-docs` folder.
run `make test` to run tests.
run `make install` to install.
run `make res_install` to install just resources.
run `make uninstall` to uninstall.
run `cd extras/scripts && ./builder-docs.sh` to build docs to `gendocs`.

Pass necessary environment variables if necessary. The default installation is in `/usr` folder:
- `DESTDIR`: You can change the destination installation folder. It is empty by default.
- `PREFIX`: You can change the prefix for where to install. It is `/usr` by default.

### Test

`wslu` use [bats](https://github.com/bats-core/bats-core) for testing. Please refer to [its guide](https://github.com/bats-core/bats-core#writing-tests) to write tests.

### Push Requests

Make sure that the codes changed are tested.

Then create Pull requests [here](https://github.com/wslutilities/wslu/compare).


## Financial contributions

We also welcome financial contributions in full transparency on our [open collective](https://opencollective.com/wslu).
Anyone can file an expense. If the expense makes sense for the development of the community, it will be "merged" in the ledger of our open collective by the core contributors and the person who filed the expense will be reimbursed.

### Contributors

Thank you to all the people who have already contributed to wslu!
<a href="graphs/contributors"><img src="https://opencollective.com/wslu/contributors.svg?width=890" /></a>


### Backers

Thank you to all our backers! [[Become a backer](https://opencollective.com/wslu#backer)]

<a href="https://opencollective.com/wslu#backers" target="_blank"><img src="https://opencollective.com/wslu/backers.svg?width=890"></a>


### Sponsors

Thank you to all our sponsors! (please ask your company to also support this open source project by [becoming a sponsor](https://opencollective.com/wslu#sponsor))

<a href="https://opencollective.com/wslu/sponsor/0/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/1/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/2/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/3/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/4/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/5/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/6/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/7/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/8/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/wslu/sponsor/9/website" target="_blank"><img src="https://opencollective.com/wslu/sponsor/9/avatar.svg"></a>