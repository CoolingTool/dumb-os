#!/usr/bin/env bash

set -oue pipefail

# https://github.com/Stunkymonkey/nautilus-open-any-terminal#from-source
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
make

make install schema