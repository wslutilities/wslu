# Contributing

We love pull requests from everyone. By participating in this project, you agree to abide by [Code of Conduct](CODE_OF_CONDUCT.md).

> **ATTENTION!**
> 
> Built-in versions of wslu in Ubuntu are no longer supported by me.
>
> If you have problems, please check whther you are using the [PPA version of wslu](https://launchpad.net/~wslutilities/+archive/ubuntu/wslu). If not, please report to the Ubuntu WSL team; However, the PPA version of wslu will address most issue that come from the built-in version.

## Code contributions

### Setup

Run the following to get started:
```bash
git clone --recursive --branch dev/master https://github.com/wslutilities/wslu.git
./configure.sh
make
sudo make res_install
```

### Structure

```
wslu
|-src
|  |-etc
|  |  |-wslview.desktop: XDG-style app definition for wslview
|  |  |-wsl.ico: legacy default icon for wslusc
|  |  |-wsl-gui.ico: default icon for wslusc GUI shortcut
|  |  |-wsl-term.ico: default icon for wslusc cli shortcut
|  |  |-sudo.ps1: helper script for wslgsu
|  |  |-get_dpi.ps1: helper script for dpi function in wslsys
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
      |  |-copr: COPR specific files (for Fedora Only)
         \-obs: OBS specific files (Other RPM-based distros)
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

- run `make` to build executables to `out` folder and manages to `out-docs` folder.
- run `make doc` to build manpage only.
- run `make clean` to remove `out` and `out-docs` folder.
- run `make test` to run tests.
- run `make install` to install.
- run `make res_install` to install just resources.
- run `make uninstall` to uninstall.
- run `cd extras/scripts && ./builder-docs.sh` to build docs to `gendocs`.

Pass necessary environment variables if necessary. The default installation is in `/usr` folder:
- `DESTDIR`: You can change the destination installation folder. It is empty by default.
- `PREFIX`: You can change the prefix for where to install. It is `/usr` by default.

### Built-in Functions/Variables

For contributing, there are several functions and variables built-in the header that can be used accross all utility source files.

#### Variables

- Base util information:
  - `wslu_util_fullpath` - the full path to utility
  - `wslu_util_name` - current utility name
  - `wslu_version` - wslu version, written by `VERSION`
  - `wslu_prefix` - the location `wslu` installed to, written by the `PREFIX` during the make.
  - `wslu_dest_dir` - the location `wslu` installed to, written by the `DESTDIR` during the make.
  - `wslu_debug` - the variable used for calling utility across. This will allow calling the `--debug` option for other `wslu` utilities inside script easier.
- Formatting: `black`, `red`, `green`, `brown`, `blue`, `purple`, `cyan`, `yellow`, `white`, `dark_gray`, `light_red`, `light_green`, `light_blue`, `light_purple`, `light_cyan`, `light_gray`, `orange`, `light_orange`, `deep_purple`, `bold`, `reset`
- Indicator: `info`, `input_info`, `error`, `warn`
- Windows Builds:
  - `BN_APR_EIGHTEEN` - Windows 10 Version 1803, Redstone 4, April 2018 Update
  - `BN_OCT_EIGHTEEN` - Windows 10 Version 1809, Redstone 5, October 2018 Update
  - `BN_MAY_NINETEEN` - Windows 10 Version 1903, 19H1, May 2019 Update
  - `BN_NOV_NINETEEN` - Windows 10 Version 1909, 19H2, November 2019 Update
  - `BN_MAY_TWENTYTY` - Windows 10 Version 2004, 20H1, May 2020 Update
  - `BN_OCT_NINETEEN` - Windows 10 Version 20H2, Windows 10 October 2020 Update
  - `BN_MAY_TWNETONE` - Windows 10 Version 21H1, Windows 10 May 2021 Update
  - `BN_NOV_TWENTONE` - Windows 10 Version 21H2, Windows 10 November 2021 Update
  - `BN_ELEVEN_21H2` - Windows 11 Version 21H2

#### Functions
> Note: `baseexec_gen` and `var_gen` are used for headers only, thus not showing here.

- `debug_echo <debug information>` 

  Will print debug information when pass `--debug` in the utility.
- `error_echo <error information> <error code>`

  Will print error information and return error code. For details of the error code standard for `wslu`, please check [here](https://wslutiliti.es/wslu/faq.html#what-is-the-error-code-returned).
- `help`

  Get help print-out.
- `version`

  Get version print-out.
- `double_dash_p`

  Replace the `\` to `\\`
- `interop_prefix`

  Return the root folder for the mounted drives.
- `sysdrive_prefix`

  Return the location of the system drive.
- `wslu_get_build`

  Return the Windows build number.
- `wslu_get_wsl_ver`

  Return the WSL version used for the current distribution.
- `chcp_com <codepage>`

  Set the Codepage by calling `chcp.com`
- `winps_exec <command>`

  Execute powershell commands by calling Windows PowerShell.
- `cmd_exec <command>`

  Execute cmd commands by calling `cmd.exe`
- `wslu_function_check <function_name>`

  Check whether a function exists.
- `wslu_file_check <check_location> <file>`

  Check whether a file exist in the corresbonding location. If not, it will copy from the source folder (`/<PREFIX>/share/wslu`).
- `wslpy_check`

  Check whether `wslpy >= 0.1.0` is installed. 

### Test

`wslu` use [bats](https://github.com/bats-core/bats-core) for testing. Please refer to [its guide](https://github.com/bats-core/bats-core#writing-tests) to write tests.

### Push Requests

Make sure that the codes changed are tested.

Then create Pull requests [here](https://github.com/wslutilities/wslu/compare).


## Financial contributions

We also welcome financial contributions in full transparency on our [open collective](https://opencollective.com/wslutilities).
Anyone can file an expense. If the expense makes sense for the development of the community, it will be "merged" in the ledger of our open collective by the core contributors and the person who filed the expense will be reimbursed.

### Contributors

Thank you to all the people who have already contributed to wslu!
<a href="graphs/contributors"><img src="https://opencollective.com/wslutilities/contributors.svg?width=890" /></a>


### Backers

Thank you to all our backers! [[Become a backer](https://opencollective.com/wslu#backer)]

<a href="https://opencollective.com/wslutilities#backers" target="_blank"><img src="https://opencollective.com/wslutilities/backers.svg?width=890"></a>


### Sponsors

Thank you to all our sponsors! (please ask your company to also support this open source project by [becoming a sponsor](https://opencollective.com/wslu#sponsor))

<a href="https://opencollective.com/wslutilities/sponsor/0/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/1/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/2/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/3/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/4/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/5/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/6/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/7/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/8/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/wslutilities/sponsor/9/website" target="_blank"><img src="https://opencollective.com/wslutilities/sponsor/9/avatar.svg"></a>