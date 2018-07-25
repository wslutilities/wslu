## Manpage Name

wslupath - Component of Windows 10 Linux Subsystem Utility

## Synopsis

`wslupath (-w|-d|-u|-m|-r) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]`

`wslupath (-h|-v|-R)`

## Description

This is a WSL Windows path Converter that can convert Windows path to other styles of path.

## Commands

### Output Type Options

**-w, --windows**
- print Windows form of path(C:\\Windows\\System32)

**-d, --windows-double-slash**
- print Windows form of path with double backslash(C:\\\\Windows\\\\System32)

**-u, --unix**
- print Unix form of path(/mnt/c/Windows/System32)

**-m, --mixed**
- print Windows form of path(C:WindowsSystem32)

**-r, --reg-data**
- use the registry data to print path[wslpath -R to know more]

### System Path

**-D, --desktop**
- print desktop path and exit

**-A, --appdata**
- print AppData path(%APPDATA%) and exit

**-T, --temp**
- print temp path(%TMP%) and exit

**-S, --sysdir**
- print system path and exit

**-W, --windir**
- print Windows path and exit

**-s, --start-menu**
- print Start Menu path and exit

**-su, --startup**
- print Startup path and exit

**-H, --home**
- print user home path(%HOMEPATH%) and exit

**-P, --program-files**
- print Program Files path(%ProgramFiles%) and exit

### Other Options

**-h, --help**
- print a simple help

**-v, --version**
- print current version

**-R, --avail-reg**
- print available registery input