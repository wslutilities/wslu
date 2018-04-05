#!/usr/bin/env bats

#wslusc testing

teardown() {
  echo "removal for temporary shortcuts"
  rm -rf "`src/wslpath -D`/test1.lnk"
  rm -rf "`src/wslpath -D`/test2.lnk"

}

@test "wslusc - No parameter" {
  run src/wslusc
  [ "$status" -eq 21 ]
}

@test "wslusc - Help" {
  run src/wslusc --help
  [ "${lines[0]}" = "wslusc - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslusc (-g|-h|-v) ..NAME..." ]
  [ "${lines[2]}" = "For more help for wslusc, visit the following site:" ]
  [ "${lines[3]}" = "http://garage.patrickwu.cf/man/wslu/wslusc" ]
}

@test "wslusc - Help - Alt." {
  run src/wslusc -h
  [ "${lines[0]}" = "wslusc - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslusc (-g|-h|-v) ..NAME..." ]
  [ "${lines[2]}" = "For more help for wslusc, visit the following site:" ]
  [ "${lines[3]}" = "http://garage.patrickwu.cf/man/wslu/wslusc" ]
}

@test "wslusc - without GUI" {
  run src/wslusc test1
  [ -f "`src/wslpath -D`/test1.lnk" ]
}

@test "wslusc - with GUI" {
  run src/wslusc -x test2
  [ -f "`src/wslpath -D`/test2.lnk" ]
}