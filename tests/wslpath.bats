#!/usr/bin/env bats

#wslpath testing
@test "wslpath - No parameter" {
  run wslpath
  [ "${lines[0]}" = "wslpath (-w|-d|-u|-m|-r) [-D|-A|-T|-S|-W|-s|-su|-H|-P|...NAME...]" ]
  [ "${lines[1]}" = "wslpath (-h|-v|-R)" ]
}

@test "wslpath - No parameter /w Windows Double DirPath /w double quote" {
  run wslpath "C:\\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslpath - No parameter /w Windows Double DirPath /w single quote" {
  run wslpath 'C:\\Windows'
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslpath - No parameter /w Windows Double DirPath /wo quote" {
  run wslpath C:\\Windows
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslpath - No parameter /w Windows DirPath /w double quote" {
  run wslpath "C:\Windows"
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslpath - No parameter /w Windows DirPath /w single quote" {
  run wslpath 'C:\Windows'
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}

@test "wslpath - No parameter /w Windows DirPath /w quote" {
  run wslpath C:\Windows
  [ "${lines[0]}" = "/mnt/c/Windows" ]
}
