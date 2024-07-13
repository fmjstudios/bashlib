#!/usr/bin/env bash

# shellcheck disable=SC1091

rc() {
  if [ -e "${HOME}/.bashrc" ]; then source "${HOME}/.bashrc"; fi
  if [ -e "${HOME}/.zshrc" ]; then source "${HOME}/.zshrc"; fi
}

venv() {
  if [ -e "$(pwd)/.venv/bin/activate" ]; then
    source "$(pwd)/.venv/bin/activate"
    exit 0
  else
    python -m venv "(pwd)/.venv"
    exit 0
  fi
}
