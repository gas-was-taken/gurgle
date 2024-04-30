#!/bin/sh

OPENGAMEPADUI_VERSION="0.30.5"

install_gamescope() {
  printf "\nInstalling gamescope:\n"
  sudo apt install -y gamescope
}

install_opengamepadui() {
  printf "\nInstalling dependencies for opengamepadui:\n"

  sudo apt install -y \
  gcc \
  libev-dev \
  libx11-6 libx11-dev \
  libxau6 libxau-dev \
  libxcb1 libxcb1-dev \
  libxdmcp6 libxdmcp-dev \
  libxext6 libxext-dev \
  libxres1 libxres-dev \
  mangoapp \
  wireplumber \
  network-manager \
  firejail \
  wget

  build_ryzenadj

  if ! [ -x "$(command -v opengamepadui)" ]; then
    if [ -e opengamepadui.tar.gz ]; then sudo rm opengamepadui.tar.gz; fi
    wget https://github.com/ShadowBlip/OpenGamepadUI/releases/download/v$OPENGAMEPADUI_VERSION/opengamepadui.tar.gz
    if [ -d opengamepadui ]; then sudo rm -r opengamepadui; fi
    tar xvfz opengamepadui.tar.gz && sudo rm opengamepadui.tar.gz
    cd opengamepadui && sudo make install PREFIX=/usr/local && cd .. && sudo rm -r opengamepadui
  fi
}

build_ryzenadj() {
  if ! [ -x "$(command -v ryzenadj)" ]; then
    printf "\nBuilding RyzenAdj (let you adjust power on Ryzen APUs):\n"
    sudo apt install -y git build-essential cmake libpci-dev
    if [ -d RyzenAdj ]; then sudo rm -r RyzenAdj; fi
    git clone https://github.com/FlyGoat/RyzenAdj.git && cd RyzenAdj && rm -r win32 && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make && sudo cp ryzenadj /usr/local/bin/ && cd ../../ && sudo rm -r RyzenAdj
  fi
}

uninstall_gamescope() {
  printf "\nUninstalling gamescope:\n"
  sudo apt remove gamescope -y
}

uninstall_opengamepadui() {
  if [ -e opengamepadui.tar.gz ]; then sudo rm opengamepadui.tar.gz; fi
  wget https://github.com/ShadowBlip/OpenGamepadUI/releases/download/v$OPENGAMEPADUI_VERSION/opengamepadui.tar.gz
  if [ -d opengamepadui ]; then sudo rm -r opengamepadui; fi
  tar xvfz opengamepadui.tar.gz && sudo rm opengamepadui.tar.gz
  cd opengamepadui && sudo make uninstall PREFIX=/usr/local && cd .. && sudo rm -r opengamepadui
}

printf "Hello, let's turn your Debian system into a gaming console!\n"
install_gamescope
install_opengamepadui
