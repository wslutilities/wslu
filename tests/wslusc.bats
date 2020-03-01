#!/usr/bin/env bats

#wslusc testing

teardown() {
  echo "removal for temporary shortcuts"
  rm -rf "$(wslupath -D)/test1.lnk"
  rm -rf "$(wslupath -D)/test2.lnk"

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

@test "wslusc - without GUI" {
  run out/wslusc test1
  [ -f "$(wslupath -D)/test1.lnk" ]
}

@test "wslusc - with GUI" {
  run out/wslusc -g test2
  [ -f "$(wslupath -D)/test2.lnk" ]
}
