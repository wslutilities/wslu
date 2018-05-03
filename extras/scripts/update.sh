#!/usr/bin/env bash
#this script will try to update from base release
echo "Updating from the git repository..."
git --git-dir=~/.wslu/.git/ --work-tree=~/.wslu/ fetch
git --git-dir=~/.wslu/.git/ --work-tree=~/.wslu/ pull
git --git-dir=~/.wslu/.git/ --work-tree=~/.wslu/ fetch --tags
git --git-dir=~/.wslu/.git/ --work-tree=~/.wslu/ checkout $(git describe --tags $(git rev-list --tags --max-count=1))
