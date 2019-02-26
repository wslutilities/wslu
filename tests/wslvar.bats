#!/usr/bin/env bats

#wslvar testing
@test "wslvar - No parameter" {
  run out/wslvar
  [ "$status" -eq 21 ]
}

@test "wslvar - Help" {
  run out/wslvar --help
  [ "${lines[0]}" = "wslvar - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslvar (--sys|--shell) [NAME]" ]
  [ "${lines[2]}" = "wslvar (--help|--version|--getsys|--getshell)" ]
}

@test "wslvar - Help - Alt." {
  run out/wslvar -h
  [ "${lines[0]}" = "wslvar - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslvar (--sys|--shell) [NAME]" ]
  [ "${lines[2]}" = "wslvar (--help|--version|--getsys|--getshell)" ]
}
@test "wslvar - System Variables" {
  run out/wslvar -s ProgramData
  [ "${lines[0]}" = "C:\ProgramData" ]
}

@test "wslvar - /w parameter - No Input" {
  run out/wslvar -s
  [ "${status}" -eq 21 ]
}
