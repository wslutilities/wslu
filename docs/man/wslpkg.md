## Manpage Name

wslpkg - Component of Windows 10 Linux Subsystem Utility

## Synopsis

`wslusc (-h|-v|-S|-U|-B|-R|-K|-P)`

## Description

This is WSL Package Installer, which is a minimal package manager for installing special packages. Also, it provide some simple commands to install apps from third-party repositories.

## Commands

**add**
- Install a special package. If repository is specified, it will install the package through the repository.

**remove**
- Remove a special package. If repository is specified, it will remove the package through the repository.

### Options

**-h, --help**
- print a simple help

**-v, --version**
- print current version

**-l, --list**
- print the special packages that is able to be installed

### Available Package

**pulseaudio**
- install pulseaudio to provide additional sound playing feature to WSL. 

**vcxsrv**
- install vcxsrv to provide additional GUI feature to WSL.