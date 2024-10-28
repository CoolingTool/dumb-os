#!/usr/bin/env bash

set -euo pipefail

rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${OS_VERSION}.noarch.rpm

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo

rpm-ostree install mpd

sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo