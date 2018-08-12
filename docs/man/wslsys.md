# wslsys

## Manpage Name

wslsys - Component of Windows 10 Linux Subsystem Utility

## Synopsis

`wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s`

## Description

This is a WSL system information printer to print out some basic system information.

## Commands

Default will print out the overall system information. more options are following(add -s flag to print only value):

**-h, --help**
- print a simple help

**-v, --version**
- print current version

**-S, --shell**
- print used shell

**-U, --uptime**
- print current uptime

**-b, --branch**
- print windows build information

**-B, --build**
- print Windows build information

**-fB, --full-build**
- print full Windows build information

**-K, --kernel**
- print WSL kernel info

**-R, --release**
- print WSL system release info

**-P, --package**
- print total installed packages
