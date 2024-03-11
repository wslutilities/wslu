#!/usr/bin/env bats

#wslsys testing
@test "wslsys - No parameter" {
  run out/wslsys
  [[ "${lines[2]}" =~ ^Build\:\ [0-9]{5}$ ]]
  [ "$status" -eq 0 ]
}

@test "wslsys - Help" {
  run out/wslsys --help
  [ "${lines[0]}" = "wslsys - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [[ "${lines[1]}" =~ ^Usage\:\ .*wslsys\ \[\-VIbBFUWRKPSltTd\]\ \[\-s\]$ ]]
  [[ "${lines[2]}" =~ ^.*wslsys\ \[\-hv\]\ \[\-n\ NAME\]$ ]]
}

@test "wslsys - Help - Alt." {
  run out/wslsys -h
  [ "${lines[0]}" = "wslsys - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [[ "${lines[1]}" =~ ^Usage\:\ .*wslsys\ \[\-VIbBFUWRKPSltTd\]\ \[\-s\]$ ]]
  [[ "${lines[2]}" =~ ^.*wslsys\ \[\-hv\]\ \[\-n\ NAME\]$ ]]
}

@test "wslsys - /w parameter" {
  run out/wslsys -B
  [[ "${lines[0]}" =~ ^Build\:\ [0-9]{5}$ ]]
  [ "$status" -eq 0 ]
}

@test "wslsys - /w parameter - shortform" {
  run out/wslsys -B -s
  [[ "${lines[0]}" =~ ^[0-9]{5}$ ]]
  [ "$status" -eq 0 ]
}
