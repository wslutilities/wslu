# Contributing

We love pull requests from everyone. By participating in this project, you
agree to abide by [Code of Conduct](CODE_OF_CONDUCT.md).

## Code contributions

### Setup

**DO NOT `git clone`.** Running the following to get started:

```bash
curl -o- https://raw.githubusercontent.com/wslutilities/wslu/develop/extras/scripts/install.sh | bash
```

### Build Structure

```
wslu
|-src
|  |-mime/wslview: mime file for wslview
|  |-etc
|  |  |-wsl.ico: default icon for wslusc
|  |  \-runHidden.vbs: script for wslusc
|  |-wslu-header: Header file of all script
|  \-<components>.sh: Components of script
|-tests: location for script tests
\-extras
   |-bats: testing utility
   |-scripts: scripts used for building, installing and uninstalling
   \-build
      |-debian: files for building .deb
      |-rpm: files for building .rpm
      |-arch: files for building Arch Linux packages
      \-alpine: files for building Alpine Linux packages
```

### Build

run `make` to build executable to `out` folder.
run `make clean` to clean `out` folder.
run `make test` to run tests.

### Test

`wslu` use [bats](https://github.com/bats-core/bats-core) for testing. Please refer to [its guide](https://github.com/bats-core/bats-core#writing-tests) to write tests.

### Build Packages

For Debian Package, run:
```bash
cd extras/script
sudo ./builder-deb.sh
```

For RPM Package, run:
```bash
cd extras/script
sudo ./builder-rpm.sh
```

It is suggested to do such action in Ubuntu 16.04 LTS or its corresponding environment.

### Push Requests

Make sure that the code changed is tested on:
- one of the Debian-based distro;
- one of SUSE;
- one of Arch distro;
- one of Alpine distro.

Then create Pull requests [here](https://github.com/wslutilities/wslu/compare).


## Financial contributions

We also welcome financial contributions in full transparency on our [open collective](https://opencollective.com/wslu).
Anyone can file an expense. If the expense makes sense for the development of the community, it will be "merged" in the ledger of our open collective by the core contributors and the person who filed the expense will be reimbursed.


## Credits


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