#!/usr/bin/env bats

#wslvar testing
@test "wslvar - No parameter" {
  run out/wslvar
  [ "$status" -eq 21 ]
}

@test "wslvar - Help" {
  run out/wslvar --help
  [ "${lines[0]}" = "wslvar - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslvar [-sl] NAME" ]
  [ "${lines[2]}" = "wslvar [-hvSL]" ]
}

@test "wslvar - Help - Alt." {
  run out/wslvar -h
  [ "${lines[0]}" = "wslvar - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslvar [-sl] NAME" ]
  [ "${lines[2]}" = "wslvar [-hvSL]" ]
}
@test "wslvar - System Variables" {
  run out/wslvar -s ProgramFiles
  [ "${lines[0]}" = "C:\Program Files" ]
}

@test "wslvar - /w -s parameter - No Input" {
  run out/wslvar -s
  [ "${status}" -eq 21 ]
}

@test "wslvar - Register Variables" {
  run out/wslvar -l AppData
  [[ "${lines[0]}" =~ ^C\:\\Users\\.*\\AppData\\Roaming$ ]]
}

@test "wslvar - /w -l parameter - No Input" {
  run out/wslvar -l
  [ "${status}" -eq 21 ]
}
