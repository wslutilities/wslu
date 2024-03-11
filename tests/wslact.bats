#!/usr/bin/env bats

#wslact testing
@test "wslact - Help" {
  run out/wslact --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact COMMAND ..." ]
}

@test "wslact - Help - Alt." {
  run out/wslact -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact COMMAND ..." ]
}

@test "wslact - Time Sync - Help" {
  run out/wslact time-sync --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact time-reset [-h]" ]
}

@test "wslact - Time Sync - Help - Alt." {
  run out/wslact time-sync -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact time-reset [-h]" ]
}

@test "wslact - Time Sync - short form - Help" {
  run out/wslact ts --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact time-reset [-h]" ]
}

@test "wslact - Time Sync - short form - Help - Alt." {
  run out/wslact ts -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact time-reset [-h]" ]
}

@test "wslact - Smart Mounting - Help" {
  run out/wslact auto-mount --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact auto-mount [-mh]" ]
}

@test "wslact - Smart Mounting - Help - Alt." {
  run out/wslact auto-mount -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact auto-mount [-mh]" ]
}

@test "wslact - Smart Mounting - short form - Help" {
  run out/wslact am --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact auto-mount [-mh]" ]
}

@test "wslact - Smart Mounting - short form - Help - Alt." {
  run out/wslact am -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact auto-mount [-mh]" ]
}

@test "wslact - Memory Reclamation - Help" {
  run out/wslact memory-reclaim --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact memory-reclaim [-h]" ]
}

@test "wslact - Memory Reclamation - Help - Alt." {
  run out/wslact memory-reclaim -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact memory-reclaim [-h]" ]
}

@test "wslact - Memory Reclamation - short form - Help" {
  run out/wslact mr --help
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact memory-reclaim [-h]" ]
}

@test "wslact - Memory Reclamation - short form - Help - Alt." {
  run out/wslact mr -h
  [ "${lines[0]}" = "wslact - Part of wslu, a collection of utilities for Windows Subsystem for Linux (WSL)" ]
  [ "${lines[1]}" = "Usage: wslact memory-reclaim [-h]" ]
}
