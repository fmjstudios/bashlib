# shellcheck shell=bash
#
# BASH helper functions for working with arrays.

# Determine if an array contains a certain string
array::contains() {
  local needle=${1} array=("${@:2}")

  if [[ " ${array[*]} " =~ [[:space:]]${needle}[[:space:]] ]]; then
    return 0
  else
    return 1
  fi
}
