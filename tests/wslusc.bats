#!/usr/bin/env bats

#wslusc testing

teardown() {
  echo "removal for temporary shortcuts"
  rm -rf "`out/wslupath -D`/test1.lnk"
  rm -rf "`out/wslupath -D`/test2.lnk"

}

@test "wslusc - No parameter" {
  run out/wslusc
  [ "$status" -eq 21 ]
}

@test "wslusc - Help" {
  run out/wslusc --help
  [ "${lines[0]}" = "wslusc - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslusc (-i|-g|-h|-v) ...NAME..." ]
  [ "${lines[2]}" = "For more help for wslusc, visit the following site:" ]
  [ "${lines[3]}" = "https://github.com/patrick330602/wslu/wiki/wslusc" ]
}

@test "wslusc - Help - Alt." {
  run out/wslusc -h
  [ "${lines[0]}" = "wslusc - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslusc (-i|-g|-h|-v) ...NAME..." ]
  [ "${lines[2]}" = "For more help for wslusc, visit the following site:" ]
  [ "${lines[3]}" = "https://github.com/patrick330602/wslu/wiki/wslusc" ]
}

@test "wslusc - without GUI" {
  run out/wslusc test1
  [ -f "`out/wslupath -D`/test1.lnk" ]
}

@test "wslusc - with GUI" {
  run out/wslusc -x test2
  [ -f "`out/wslupath -D`/test2.lnk" ]
}
