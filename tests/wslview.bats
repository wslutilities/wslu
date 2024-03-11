#!/usr/bin/env bats

setup() {
  if [[ "$(wslsys -T -s)" != "Desktop" ]]; then
    skip "unsupported platform"
  fi
}

#wslview testing
@test "wslview - No parameter" {
  run out/wslview
  [ "$status" -eq 21 ]
}

@test "wslview - Help" {
  run out/wslview --help
  [ "${lines[0]}" = "wslview - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [[ "${lines[1]}" =~ ^Usage\:\ .*wslview\ \[\-ehsvurE\]$ ]]
  [[ "${lines[2]}" =~ ^.*wslview\ \[\-E\ ENGINE\]\ LINK/FILE$ ]]
}

@test "wslview - Help - Alt." {
  run out/wslview -h
  [ "${lines[0]}" = "wslview - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [[ "${lines[1]}" =~ ^Usage\:\ .*wslview\ \[\-ehsvurE\]$ ]]
  [[ "${lines[2]}" =~ ^.*wslview\ \[\-E\ ENGINE\]\ LINK/FILE$ ]]
}

@test "wslview - Linux - relative" {
  run out/wslview .
  if [ $(wslsys -B -s) -ge 18362 ]; then
    [ "$status" -eq 0 ]
  else
    [ "$status" -eq 34 ]
  fi
}

@test "wslview - Linux - absolute" {
  run out/wslview /home
  if [ $(wslsys -B -s) -ge 18362 ]; then
    [ "$status" -eq 0 ]
  else
    [ "$status" -eq 34 ]
  fi
}

@test "wslview - Linux - file protocol" {
  run out/wslview file:///etc
  if [ $(wslsys -B -s) -ge 18362 ]; then
    [ "$status" -eq 0 ]
  else
    [ "$status" -eq 34 ]
  fi
}

@test "wslview - Windows folder in Linux - absolute" {
  run out/wslview /mnt/c/Windows
  if [ $(wslsys -B -s) -ge 18362 ]; then
    [ "$status" -eq 0 ]
  else
    [ "$status" -eq 34 ]
  fi
}

@test "wslview - Windows folder in Linux - file protocol" {
  run out/wslview file:///mnt/c/Users
  if [ $(wslsys -B -s) -ge 18362 ]; then
    [ "$status" -eq 0 ]
  else
    [ "$status" -eq 34 ]
  fi
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

@test "wslview - Internet - with brackets" {
  run out/wslview "https://www.duckduckgo.com/?q=[wslu]"
  [ "$status" -eq 0 ]
}
