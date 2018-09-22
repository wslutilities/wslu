#!/usr/bin/env bash
for f in /usr/bin/wsl*-dev; do
    	sudo rm -f $f;
	echo "rm -f $f";
done
sudo rm -rf /usr/share/wslu-dev
echo "rm -rf /usr/share/wslu-dev"
sudo rm -f /usr/lib/mime/packages/wslview-dev
echo "rm -f /usr/lib/mimepackages/wslview-dev"
sudo update-mime
sudo update-alternatives --remove x-www-browser /usr/bin/wslview-dev
sudo update-alternatives --remove www-browser /usr/bin/wslview-dev
