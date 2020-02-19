#!/usr/bin/env bats

#wslsys testing
@test "wslact - No parameter" {
  run out/wslfetch
  [ "$status" -eq 0 ]
}

@test "wslact - Help" {
  run out/wslact --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslact [flags] [command] ..." ]
}

@test "wslact - Help - Alt." {
  run out/wslact -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslact [flags] [command] ..." ]
}