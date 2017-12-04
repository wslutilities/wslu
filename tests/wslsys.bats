#!/usr/bin/env bats

#wslsys testing
@test "wslsys - No parameter" {
  run src/wslsys
  [ "$status" -eq 0 ]
}

@test "wslsys - Help" {
  run src/wslsys --help
  [ "${lines[0]}" = "wslsys - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s" ]
  [ "${lines[2]}" = "For more help for wslsys, visit the following site:" ]
  [ "${lines[3]}" = "http://garage.patrickwu.cf/man/wslu/wslsys" ]
}

@test "wslsys - Help - Alt." {
  run src/wslsys -h
  [ "${lines[0]}" = "wslsys - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s" ]
  [ "${lines[2]}" = "For more help for wslsys, visit the following site:" ]
  [ "${lines[3]}" = "http://garage.patrickwu.cf/man/wslu/wslsys" ]
}
