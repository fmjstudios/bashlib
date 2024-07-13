#!/usr/bin/env bash

# shellcheck source=lib/log.sh
. ../lib/log.sh

# shellcheck source=lib/perm.sh
. ../lib/perm.sh

update() {
  local tools=("pacman" "yay")
  log::green "Updating system packages with ${tools[0]}"
  perm::run_as_root "${tools[0]}" -Syu

  log::green "Updating system packages with ${tools[1]}"
  "${tools[1]}" -Syu
}

mirrors() {
  sudo reflector \
    --save /etc/pacman.d/mirrorlist \
    --country 'Germany,Netherlands,Sweden,Belgium,France,Austria' \
    --protocol https \
    --latest 10
}
