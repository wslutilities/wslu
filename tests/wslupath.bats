#!/usr/bin/env bats

#wslupath testing
@test "wslupath - No parameter" {
  run out/wslupath
  [ "${lines[0]}" = "wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[1]}" = "wslupath (-h|-v|-R)" ]
  [ "$status" -eq 20 ]
}

@test "wslupath - Help" {
  run out/wslupath --help
  [ "${lines[0]}" = "wslupath - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[2]}" = "wslupath (-h|-v|-R)" ]
  [ "${lines[3]}" = "For more help for wslupath, visit the following site:" ]
  [ "${lines[4]}" = "https://github.com/patrick330602/wslu/wiki/wslupath" ]
}

@test "wslupath - Help - Alt." {
  run out/wslupath -h
  [ "${lines[0]}" = "wslupath - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[2]}" = "wslupath (-h|-v|-R)" ]
  [ "${lines[3]}" = "For more help for wslupath, visit the following site:" ]
  [ "${lines[4]}" = "https://github.com/patrick330602/wslu/wiki/wslupath" ]
}
@test "wslupath - Available Registery" {
  run out/wslupath --avail-reg
  [ "${lines[0]}" = "Available registery input:" ]
}

@test "wslupath - Available Registery - Alt." {
  run out/wslupath -R
  [ "${lines[0]}" = "Available registery input:" ]
}

@test "wslupath - No parameter - Windows Double DirPath" {
  run out/wslupath "C:\\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslupath - No parameter - Windows DirPath" {
  run out/wslupath "C:\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslupath - No parameter - Linux DirPath" {
  skip "WIP feature"
  run out/wslupath "/mnt/c/Windows"
  [ "${lines[0]}" = "C:\\Windows" ]
}

@test "wslupath - /w parameter - No Input" {
  run out/wslupath -w
  [ "${status}" -eq 21 ]
}
