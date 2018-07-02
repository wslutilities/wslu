#!/usr/bin/env bats

#wslsys testing
@test "wslsys - No parameter" {
  run out/wslsys
  [ "$status" -eq 0 ]
}

@test "wslsys - Help" {
  run out/wslsys --help
  [ "${lines[0]}" = "wslsys - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s" ]
  [ "${lines[2]}" = "For more help for wslsys, visit the following site:" ]
  [ "${lines[3]}" = "https://github.com/patrick330602/wslu/wiki/wslsys" ]
}

@test "wslsys - Help - Alt." {
  run out/wslsys -h
  [ "${lines[0]}" = "wslsys - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslsys (-h|-v|-S|-U|-b|-B|-fB|-R|-K|-P) -s" ]
  [ "${lines[2]}" = "For more help for wslsys, visit the following site:" ]
  [ "${lines[3]}" = "https://github.com/patrick330602/wslu/wiki/wslsys" ]
}
