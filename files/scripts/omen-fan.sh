#!/usr/bin/env bash

set -oue pipefail

# https://wiki.archlinux.org/title/HP_Omen_16-c0140AX#Fan_control_Script
# No install instructions, but that's fine, it's very trival to do so
#
# Not for these people though https://redd.it/1e5bh6x/

if ! rpm -q python3-tomlkit &> /dev/null; then
  echo "Installing \"python3-tomlkit\" package, which is necessary for omen-fan to function"
  rpm-ostree install python3-tomlkit
fi

# Bad idea
if ! rpm -q python3-pip &> /dev/null; then
  echo "Installing \"python3-pip\" package, which is necessary for omen-fan to function"
  rpm-ostree install python3-pip
fi

set -x

# Worse idea
echo "Installing \"click-aliases\" via pip, which is necessary for omen-fan to function"
rpm-ostree uninstall python3-click
pip install click click-aliases --root-user-action=ignore

git clone https://github.com/alou-S/omen-fan

install -T -m 755 omen-fan/omen-fan.py /usr/bin/omen-fan
install -T -m 755 omen-fan/omen-fand.py /usr/bin/omen-fand