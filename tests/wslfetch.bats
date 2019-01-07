#!/usr/bin/env bats

#wslsys testing
@test "wslfetch - No parameter" {
  run out/wslfetch
  [ "$status" -eq 0 ]
}

@test "wslfetch - Help" {
  run out/wslfetch --help
  [ "${lines[0]}" = "wslfetch - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslfetch (-h|-v|-s|-l|-c)" ]
}

@test "wslfetch - Help - Alt." {
  run out/wslfetch -h
  [ "${lines[0]}" = "wslfetch - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslfetch (-h|-v|-s|-l|-c)" ]
}
