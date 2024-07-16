#!/usr/bin/env bash
#
# A script to create backup tarballs from local files and directories.

# shellcheck source=lib/log.sh
. lib/log.sh

# shellcheck source=lib/package.sh
. lib/package.sh

# ----------------------
#   'help' usage function
# ----------------------
function backup::usage() {
  echo
  echo "Usage: $(basename "${0}") <SOURCE> <NAME> <DESTINATION>"
  echo
  echo "help    - Print this usage information"
  echo "deps    - Show the required dependencies to run this script"
  echo
}

# ----------------------
#   'deps' function
# ----------------------
function backup::deps() {
  local deps=(tar)

  package::is_executable "${deps[0]}"
  rc=$?

  if [ $rc -ne 0 ]; then
    log::red "Could not find package '${deps[0]}' in system PATH. Please install '${deps[0]}' to proceed!"
    exit 1
  fi

  log::green "Found package '${deps[0]}' in system PATH. Ready to proceed!"
}


# ----------------------
#   'run' function
# ----------------------
function backup::run() {
  local source_path=${1} backup_name=${2} destination_path=${3:-"${HOME}/Backups"} curdate=$(date '+%d-%m-%Y+%T')

  if [ ! -e "$source_path" ]; then
    log::red "Cannot backup directory $source_path. No such file or directory."
    exit 1
  fi

  [ ! -e "$destination_path" ] && mkdir -p "$destination_path"
  tar -vczf "$destination_path/$backup_name-$curdate.tar.gz"
}


# --------------------------------
#   MAIN
# --------------------------------
function main() {
  local cmd=${1}

  case "${cmd}" in
  help)
    backup::usage
    return $?
    ;;
  deps)
    backup::deps
    return $?
    ;;
  *)
    backup::run "$@"
    return 1
    ;;
  esac
}

# ------------
# 'main' call
# ------------
main "$@"