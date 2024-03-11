#!/usr/bin/env bats

#wslusc testing

teardown() {
  echo "removal for temporary shortcuts"
  rm -rf "$(wslupath -D)/top.lnk"
  rm -rf "$(wslupath -D)/xeyes.lnk"
  rm -rf "$(wslupath -D)/lolwhat.lnk"
}

@test "wslusc - No parameter" {
  run out/wslusc
  [ "$status" -eq 21 ]
}

@test "wslusc - Help" {
  run out/wslusc --help
  [ "${lines[0]}" = "wslusc - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslusc [-IsgN] [-d SHORTCUT_FILE] [-e PATH] [-n NAME] [-i FILE] COMMAND" ]
  [ "${lines[2]}" = "wslusc [-hv]" ]
}

@test "wslusc - Help - Alt." {
  run out/wslusc -h
  [ "${lines[0]}" = "wslusc - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslusc [-IsgN] [-d SHORTCUT_FILE] [-e PATH] [-n NAME] [-i FILE] COMMAND" ]
  [ "${lines[2]}" = "wslusc [-hv]" ]
}

@test "wslusc - non-exist file" {
  run out/wslusc wryyyyy
  [ "$status" -eq 30 ]
}

@test "wslusc - without GUI" {
  run out/wslusc top
  [ -f "$(wslupath -D)/top.lnk" ]
}

@test "wslusc - with GUI" {
  run out/wslusc -g xeyes
  [ -f "$(wslupath -D)/xeyes.lnk" ]
}

@test "wslusc - with Custom Name" {
  run out/wslusc -n "lolwhat" top
  [ -f "$(wslupath -D)/lolwhat.lnk" ]
}

# TODO: Add more tests to cover all possible cases