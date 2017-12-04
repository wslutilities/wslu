#!/usr/bin/env bats

#wslu testing
@test "wslu - No parameter" {
  run src/wslu
  [ "${lines[0]}" = "wslu (-h|-v|-s)" ]
  [ "$status" -eq 20 ]
}

@test "wslu - Help" {
  run src/wslu --help
  [ "${lines[0]}" = "wslu - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslu (-h|-v|-s)" ]
  [ "${lines[2]}" = "For more help for wslu, visit the following site:" ]
  [ "${lines[3]}" = "http://garage.patrickwu.cf/man/wslu/wslu" ]
}

@test "wslu - Help - Alt." {
  run src/wslu -h
  [ "${lines[0]}" = "wslu - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslu (-h|-v|-s)" ]
  [ "${lines[2]}" = "For more help for wslu, visit the following site:" ]
  [ "${lines[3]}" = "http://garage.patrickwu.cf/man/wslu/wslu" ]
}

@test "wslu - Silent" {
  run src/wslu --silent
  [ "$status" -eq 0 ]
}

@test "wslu - Silent - Alt." {
  run src/wslu -s
  [ "$status" -eq 0 ]
}

@test "wslu - Colortesting 1" {
  color="$(. src/wslu --silent;echo -e $black | cat -A)"
  [ "$color" = "^[[30m$" ]
}

@test "wslu - Colortesting 2" {
  color="$(. src/wslu --silent;echo -e $light_red | cat -A)"
  [ "$color" = "^[[1;31m$" ]
}

@test "wslu - colortesting 3" {
  color="$(. src/wslu --silent;echo -e $orange | cat -A)"
  [ "$color" = "^[[38;5;202m$" ]
}

@test "wslu - Format 1" {
  format="$(. src/wslu --silent;echo -e $bold | cat -A)"
  [ "$format" = "^[[1m$" ]
}

@test "wslu - Format 2" {
  format="$(. src/wslu --silent;echo -e $reset | cat -A)"
  [ "$format" = "^[(B^[[m$" ]
}

@test "wslu - Indicator" {
  format="$(. src/wslu --silent;echo -e $info | cat -A)"
  [ "$format" = "^[[32m[info]^[(B^[[m$" ]
}
