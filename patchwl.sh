#!/bin/sh

set -e

if grep -qs 'chimera' /etc/os-release; then
  if [ "$1" = "--nodepinst" ]; then
    echo "Not installing any dependecies"
    echo ""
    git clone https://github.com/joanbm/broadcom-wl-linux-mainline.git
    cd broadcom-wl-linux-mainline
    ./extract_and_patch
    cd hybrid-*
    make -C /lib/modules/$(uname -r)/build M=$(pwd) CC=clang
    doas mkdir -p /lib/modules/$(uname -r)/extra
    doas cp wl.ko /lib/modules/$(uname -r)/extra/
    doas depmod -a
    echo "(Optional) run modprobe wl"
    echo "Completed"
    echo ""
  else
    echo "Script is assuming that you are using linux-stable"
    printf "Are you using linux-stable [Y/n]: "
    read YESORNOSCRPTT
    if [ "$YESORNOSCRPTT" = "n" ] || [ "$YESORNOSCRPTT" = "N" ]; then
      echo "Run doas apk add linux-headers linux-(whatyouuse)-devel base-devel git wget"
      echo "And run this script again with --nodepinst"
      echo ""
      exit 0
    else
      echo "Expecting linux-stable"
      echo ""
      doas apk add linux-headers linux-stable-devel base-devel git wget
      git clone https://github.com/joanbm/broadcom-wl-linux-mainline.git
      cd broadcom-wl-linux-mainline
      ./extract_and_patch
      cd hybrid-*
      make -C /lib/modules/$(uname -r)/build M=$(pwd) CC=clang
      doas mkdir -p /lib/modules/$(uname -r)/extra
      doas cp wl.ko /lib/modules/$(uname -r)/extra/
      doas depmod -a
      echo "(Optional) run modprobe wl"
      echo "Completed"
      echo ""
    fi
  fi
elif grep -qs 'alpine' /etc/os-release; then
  if [ "$1" = "--nodepinst" ]; then
    echo "Not installing any dependecies"
    echo ""
    git clone https://github.com/joanbm/broadcom-wl-linux-mainline.git
    cd broadcom-wl-linux-mainline
    ./extract_and_patch
    cd hybrid-*
    make -C /lib/modules/$(uname -r)/build M=$(pwd)
    doas mkdir -p /lib/modules/$(uname -r)/extra
    doas cp wl.ko /lib/modules/$(uname -r)/extra/
    doas depmod -a
    echo "(Optional) run modprobe wl"
    echo "Completed"
    echo ""
  else
    echo "Script is assuming that you are using linux-stable"
    printf "Are you using linux-stable [Y/n]: "
    read YESORNOSCRPTT
    if [ "$YESORNOSCRPTT" = "n" ] || [ "$YESORNOSCRPTT" = "N" ]; then
      echo "Run doas apk add linux-headers linux-(whatyouuse)-dev build-base git wget"
      echo "And run this script again with --nodepinst"
      echo ""
      exit 0
    else
      echo "Expecting linux-stable"
      echo ""
      doas apk add linux-headers linux-stable-dev build-base git wget
      git clone https://github.com/joanbm/broadcom-wl-linux-mainline.git
      cd broadcom-wl-linux-mainline
      ./extract_and_patch
      cd hybrid-*
      make -C /lib/modules/$(uname -r)/build M=$(pwd)
      doas mkdir -p /lib/modules/$(uname -r)/extra
      doas cp wl.ko /lib/modules/$(uname -r)/extra/
      doas depmod -a
      echo "(Optional) run modprobe wl"
      echo "Completed"
      echo ""
    fi
  fi
fi
