#!/usr/bin/env bats

#wslsys testing
@test "wslsys - No parameter" {
  run out/wslsys
  [ "$status" -eq 0 ]
}

@test "wslsys - Help" {
  run out/wslsys --help
  [ "${lines[0]}" = "wslsys - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslsys (-h|-v|-I|-b|-B|-fB|-U|-R|-K|-P) -s" ]
}

@test "wslsys - Help - Alt." {
  run out/wslsys -h
  [ "${lines[0]}" = "wslsys - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslsys (-h|-v|-I|-b|-B|-fB|-U|-R|-K|-P) -s" ]
}
