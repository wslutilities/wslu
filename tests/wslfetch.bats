#!/usr/bin/env bats

#wslsys testing
@test "wslfetch - No parameter" {
  run out/wslfetch
  [ "$status" -eq 0 ]
}

@test "wslfetch - Help" {
  run out/wslfetch --help
  [ "${lines[0]}" = "wslfetch - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslfetch [-hvlsc]" ]
}

@test "wslfetch - Help - Alt." {
  run out/wslfetch -h
  [ "${lines[0]}" = "wslfetch - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslfetch [-hvlsc]" ]
}
