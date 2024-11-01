#!/usr/bin/env bash

set -oue pipefail

# https://wiki.archlinux.org/title/HP_Omen_16-c0140AX#Fan_control_Script
# No install instructions, but that's fine, it should be trival to do so
#
# Not for these people though https://redd.it/1e5bh6x/

if ! rpm -q python3 &> /dev/null; then
  echo "Installing \"python3\" package, which is necessary for omen-fan to function"
  rpm-ostree install python3
fi

set -x

mkdir -p /usr/include && cd /usr/include
git clone https://github.com/alou-S/omen-fan && cd omen-fan

python3 -m venv env
source env/bin/activate
python3 -m pip install click tomlkit click-aliases
deactivate

sed -i 's/#!\/usr\/bin\/env python3/#!\/usr\/include\/omen-fan\/env\/bin\/python3' *.py

install -T -m 755 omen-fan.py /usr/bin/omen-fan
install -T -m 755 omen-fand.py /usr/bin/omen-fand