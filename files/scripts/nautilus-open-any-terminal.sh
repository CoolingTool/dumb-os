#!/usr/bin/env bash

# https://aur.archlinux.org/packages/nautilus-open-any-terminal
if ! rpm -q nautilus-python &> /dev/null; then
  echo "Installing \"nautilus-python\" package, which is necessary for nautilus-open-any-terminal to function"
  rpm-ostree install nautilus-python
fi
if ! rpm -q gettext &> /dev/null; then
  echo "Installing \"gettext\" package, which is necessary for nautilus-open-any-terminal to function"
  rpm-ostree install gettext
fi
if ! command -v make &> /dev/null; then
  echo "Installing \"make\" package, which is necessary for nautilus-open-any-terminal to function"
  rpm-ostree install make
fi


set -oue pipefail

# https://github.com/Stunkymonkey/nautilus-open-any-terminal#from-source
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
make

make install schema