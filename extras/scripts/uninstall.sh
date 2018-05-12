#!/usr/bin/env bash
for f in /usr/bin/wsl*; do
    	sudo rm -f $f;
	echo "rm -f $f";
done
