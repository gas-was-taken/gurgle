#!/bin/sh

WINE_LUTRIS_GE_VERSION="8-26"

echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null

sudo dpkg --add-architecture i386 && sudo apt update && sudo apt install -y wine64 wine32 libasound2-plugins:i386 libsdl2-2.0-0:i386 libdbus-1-3:i386 libsqlite3-0:i386 lutris

lutris --install-runner wine
wget "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-26/wine-lutris-GE-Proton$WINE_LUTRIS_GE_VERSION-x86_64.tar.xz"
tar xvf wine-lutris-GE-Proton$WINE_LUTRIS_GE_VERSION-x86_64.tar.xz
mkdir -p ~/.local/share/lutris/runners/wine/wine-ge-$WINE_LUTRIS_GE_VERSION-x86_64
mv lutris-GE-Proton8-26-x86_64/* ~/.local/share/lutris/runners/wine/wine-ge-$WINE_LUTRIS_GE_VERSION-x86_64/
