#!/bin/bash
distro="$(cat /etc/os-release | head -n1 | sed -e 's/NAME=\"//g')"
