#!/usr/bin/env bash
for f in /usr/bin/wsl*; do
    	sudo rm -f $f;
	echo "rm -f $f";
done
sudo rm -rf /usr/share/wslu
echo "rm -rf /usr/share/wslu"
sudo rm -f /usr/lib/mime/packages/wslview
echo "rm -f /usr/lib/mimepackages/wslview"
sudo update-mime
