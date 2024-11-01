#!/usr/bin/env bash

set -oue pipefail

# https://wiki.archlinux.org/title/HP_Omen_16-c0140AX#Fan_control_Script

if ! rpm -q python3 &> /dev/null; then
  echo "Installing \"python3\" package, which is necessary for omen-fan to function"
  rpm-ostree install python3
fi
if ! rpm -q kernel-devel &> /dev/null; then
  echo "Installing \"kernel-devel\" package, which is necessary for omen-fan to function"
  rpm-ostree install kernel-devel
fi
if ! rpm -q dkms &> /dev/null; then
  echo "Installing \"dkms\" package, which is necessary for omen-fan to function"
  rpm-ostree install dkms
fi
if ! rpm -q make &> /dev/null; then
  echo "Installing \"make\" package, which is necessary for omen-fan to function"
  rpm-ostree install make
fi

set -x

mkdir -p /usr/include && cd /usr/include
git clone https://github.com/alou-S/omen-fan && cd omen-fan

python3 -m venv env
./env/bin/python3 -m pip install click tomlkit click-aliases

sed -i 's/#!\/usr\/bin\/env /#!\/usr\/include\/omen-fan\/env\/bin\//' *.py

install -T -m 755 omen-fan.py /usr/bin/omen-fan
install -T -m 755 omen-fand.py /usr/bin/omen-fand