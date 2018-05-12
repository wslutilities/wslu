#!/usr/bin/env bats

#wslsys testing
@test "wslfetch - No parameter" {
  run src/wslfetch
  [ "$status" -eq 0 ]
}

@test "wslfetch - Help" {
  run src/wslfetch --help
  [ "${lines[0]}" = "wslfetch - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslfetch (-h|-v|-s|-l|-c)" ]
  [ "${lines[2]}" = "For more help for wslfetch, visit the following site:" ]
  [ "${lines[3]}" = "https://github.com/patrick330602/wslu/wiki/wslfetch" ]
}

@test "wslfetch - Help - Alt." {
  run src/wslfetch -h
  [ "${lines[0]}" = "wslfetch - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslfetch (-h|-v|-s|-l|-c)" ]
  [ "${lines[2]}" = "For more help for wslfetch, visit the following site:" ]
  [ "${lines[3]}" = "https://github.com/patrick330602/wslu/wiki/wslfetch" ]
}