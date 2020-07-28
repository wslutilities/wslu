#!/usr/bin/env bats

#wslusc testing

teardown() {
  echo "removal for temporary shortcuts"
  rm -rf "$(wslupath -D)/htop.lnk"
  rm -rf "$(wslupath -D)/gedit.lnk"
}

@test "wslusc - No parameter" {
  run out/wslusc
  [ "$status" -eq 21 ]
}

@test "wslusc - Help" {
  run out/wslusc --help
  [ "${lines[0]}" = "wslusc - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslusc [-gi] [-e PATH] [-n NAME] [-i FILE] COMMAND" ]
  [ "${lines[2]}" = "wslusc [-hv]" ]
}

@test "wslusc - Help - Alt." {
  run out/wslusc -h
  [ "${lines[0]}" = "wslusc - Part of wslu, a collection of utilities for Windows 10 Windows Subsystem for Linux" ]
  [ "${lines[1]}" = "Usage: wslusc [-gi] [-e PATH] [-n NAME] [-i FILE] COMMAND" ]
  [ "${lines[2]}" = "wslusc [-hv]" ]
}

@test "wslusc - non-exist file" {
  run out/wslusc wryyyyy
  [ "$status" -eq 30 ]
}

@test "wslusc - without GUI" {
  run out/wslusc htop
  [ -f "$(wslupath -D)/htop.lnk" ]
}

@test "wslusc - with GUI" {
  run out/wslusc -g gedit
  [ -f "$(wslupath -D)/gedit.lnk" ]
}

# TODO: Add more tests to cover all possible cases