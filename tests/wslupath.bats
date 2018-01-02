#!/usr/bin/env bats

#wslupath testing
@test "wslupath - No parameter" {
  run src/wslupath
  [ "${lines[0]}" = "wslupath (-w|-d|-u|-m|-r) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[1]}" = "wslupath (-h|-v|-R)" ]
  [ "$status" -eq 20 ]
}

@test "wslupath - Help" {
  run src/wslupath --help
  [ "${lines[0]}" = "wslupath - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslupath (-w|-d|-u|-m|-r) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[2]}" = "wslupath (-h|-v|-R)" ]
  [ "${lines[3]}" = "For more help for wslupath, visit the following site:" ]
  [ "${lines[4]}" = "http://garage.patrickwu.cf/man/wslu/wslupath" ]
}

@test "wslupath - Help - Alt." {
  run src/wslupath -h
  [ "${lines[0]}" = "wslupath - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslupath (-w|-d|-u|-m|-r) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[2]}" = "wslupath (-h|-v|-R)" ]
  [ "${lines[3]}" = "For more help for wslupath, visit the following site:" ]
  [ "${lines[4]}" = "http://garage.patrickwu.cf/man/wslu/wslupath" ]
}
@test "wslupath - Available Registery" {
  run src/wslupath --avail-reg
  [ "${lines[0]}" = "Available registery input:" ]
}

@test "wslupath - Available Registery - Alt." {
  run src/wslupath -R
  [ "${lines[0]}" = "Available registery input:" ]
}

@test "wslupath - No parameter - Windows Double DirPath" {
  run src/wslupath "C:\\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslupath - No parameter - Windows DirPath" {
  run src/wslupath "C:\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslupath - No parameter - Linux DirPath" {
  skip "WIP feature"
  run src/wslupath "/mnt/c/Windows"
  [ "${lines[0]}" = "C:\\Windows" ]
}

@test "wslupath - /w parameter - No Input" {
  run src/wslupath -w
  [ "${status}" -eq 21 ]
}
