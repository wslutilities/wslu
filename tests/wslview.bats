#!/usr/bin/env bats

#wslview testing
@test "wslview - No parameter" {
  run out/wslview
  [ "$status" -eq 21 ]
}

@test "wslview - Help" {
  run out/wslview --help
  [ "${lines[0]}" = "wslview - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslview (-u|-r|-h|-v) ...LINK..." ]
}

@test "wslview - Help - Alt." {
  run out/wslview -h
  [ "${lines[0]}" = "wslview - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslview (-u|-r|-h|-v) ...LINK..." ]
}
