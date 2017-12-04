#!/usr/bin/env bats

@test "wslpkg - No parameter" {
  run src/wslpkg
  [ "$status" -eq 20 ]
}

@test "wslpkg - Help" {
  run src/wslpkg --help
  [ "${lines[0]}" = "wslpkg - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslpkg [add|remove] ..NAME... [REPO]" ]
  [ "${lines[2]}" = "wslpkg (-h|-v|-l)" ]
  [ "${lines[3]}" = "For more help for wslpkg, visit the following site:" ]
  [ "${lines[4]}" = "http://garage.patrickwu.cf/man/wslu/wslpkg" ]
}


@test "wslpkg - Help - Alt." {
  run src/wslpkg -h
  [ "${lines[0]}" = "wslpkg - Component of Windows 10 Linux Subsystem Utility" ]
  [ "${lines[1]}" = "Usage: wslpkg [add|remove] ..NAME... [REPO]" ]
  [ "${lines[2]}" = "wslpkg (-h|-v|-l)" ]
  [ "${lines[3]}" = "For more help for wslpkg, visit the following site:" ]
  [ "${lines[4]}" = "http://garage.patrickwu.cf/man/wslu/wslpkg" ]
}

@test "wslpkg - Package Listing" {
  run src/wslpkg --list
  [ "${lines[0]}" = "Available Special Package:" ]
  [ "${lines[1]}" = "PulseAudio" ]
  [ "${lines[2]}" = "VcXsrv" ]
}

@test "wslpkg - Package Listing - Alt." {
  run src/wslpkg -l
  [ "${lines[0]}" = "Available Special Package:" ]
  [ "${lines[1]}" = "PulseAudio" ]
  [ "${lines[2]}" = "VcXsrv" ]
}


