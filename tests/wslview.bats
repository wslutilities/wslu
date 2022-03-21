#!/usr/bin/env bats

#wslview testing
@test "wslview - No parameter" {
  run out/wslview
  [ "$status" -eq 21 ]
}

@test "wslview - Help" {
  run out/wslview --help
  [ "${lines[0]}" = "wslview - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [[ "${lines[1]}" =~ ^Usage\:\ .*wslview\ \[\-hvur\]$ ]]
  [[ "${lines[2]}" =~ ^.*wslview\ \[\-E\ ENGINE\]\ LINK/FILE$ ]]
}

@test "wslview - Help - Alt." {
  run out/wslview -h
  [ "${lines[0]}" = "wslview - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [[ "${lines[1]}" =~ ^Usage\:\ .*wslview\ \[\-hvur\]$ ]]
  [[ "${lines[2]}" =~ ^.*wslview\ \[\-E\ ENGINE\]\ LINK/FILE$ ]]
}

@test "wslview - Linux - relative" {
  run out/wslview .
  [ "$status" -eq 0 ]
}

@test "wslview - Linux - absolute" {
  run out/wslview /home
  [ "$status" -eq 0 ]
}

@test "wslview - Linux - file protocol" {
  run out/wslview file:///etc
  [ "$status" -eq 0 ]
}

@test "wslview - Windows folder in Linux - absolute" {
  run out/wslview /mnt/c/Windows
  [ "$status" -eq 0 ]
}

@test "wslview - Windows folder in Linux - file protocol" {
  run out/wslview file:///mnt/c/Users
  [ "$status" -eq 0 ]
}

@test "wslview - Windows - absolute" {
  run out/wslview "C:/Users/Public"
  [ "$status" -eq 0 ]
}

@test "wslview - Windows - file protocol" {
  run out/wslview "file:///C:/Windows/System32"
  [ "$status" -eq 0 ]
}

@test "wslview - Internet - no protocol" {
  run out/wslview "www.duckduckgo.com"
  [ "$status" -eq 0 ]
}

@test "wslview - Internet - http" {
  run out/wslview "http://info.cern.ch"
  [ "$status" -eq 0 ]
}

@test "wslview - Internet - https" {
  run out/wslview "https://wslutiliti.es/"
  [ "$status" -eq 0 ]
}
