#!/bin/sh
if [ -d tmp/ ]; then sudo rm -r tmp; fi

mkdir -p ./tmp && cd tmp

printf "Hello, let's turn your Debian system into a gaming console!\n"

sh ../scripts/install-kernel.sh
sh ../scripts/install-opengamepadui.sh
sh ../scripts/install-lutris.sh
