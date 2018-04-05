#!/usr/bin/env bash
echo "Updating from the git repository..."
git --git-dir=~/.wslu/.git/ --work-tree=~/.wslu/ fetch
git --git-dir=~/.wslu/.git/ --work-tree=~/.wslu/ pull

