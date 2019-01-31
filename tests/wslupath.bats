#!/usr/bin/env bats

#wslupath testing
@test "wslupath - No parameter" {
  skip "Deprecated"
  run out/wslupath
  [ "${lines[0]}" = "wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[1]}" = "wslupath (-h|-v|-R)" ]
  [ "$status" -eq 20 ]
}

@test "wslupath - Help" {
  skip "Deprecated"
  run out/wslupath --help
  [ "${lines[0]}" = "wslupath - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[2]}" = "wslupath (-h|-v|-R)" ]
}

@test "wslupath - Help - Alt." {
  skip "Deprecated"
  run out/wslupath -h
  [ "${lines[0]}" = "wslupath - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslupath (-dOr) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[2]}" = "wslupath (-h|-v|-R)" ]
}
@test "wslupath - Available Registery" {
  skip "Deprecated"
  run out/wslupath --avail-reg
  [ "${lines[0]}" = "Available registery input:" ]
}

@test "wslupath - Available Registery - Alt." {
  skip "Deprecated"
  run out/wslupath -R
  [ "${lines[0]}" = "Available registery input:" ]
}

@test "wslupath - No parameter - Windows Double DirPath" {
  skip "Deprecated"
  run out/wslupath "C:\\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslupath - No parameter - Windows DirPath" {
  skip "Deprecated"
  run out/wslupath "C:\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslupath - No parameter - Linux DirPath" {
  skip "Deprecated"
  run out/wslupath "/mnt/c/Windows"
  [ "${lines[0]}" = "c:\\Windows" ]
}

@test "wslupath - /w DoubleDash - Windows Double DirPath" {
  skip "Deprecated"
  run out/wslupath -d "C:\\Windows"
  [ "${lines[0]}" = "C:\\\\Windows" ]
}

@test "wslupath - /w DoubleDash - Windows DirPath" {
  skip "Deprecated"
  run out/wslupath -d "C:\Windows"
  [ "${lines[0]}" = "C:\\\\Windows" ]
}

@test "wslupath - /w DoubleDash - Linux DirPath" {
  skip "Deprecated"
  run out/wslupath -d "/mnt/c/Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}
@test "wslupath - /w parameter - No Input" {
  skip "Deprecated"
  run out/wslupath -d
  [ "${status}" -eq 21 ]
}
