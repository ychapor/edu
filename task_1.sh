#!/bin/bash
#
# Changes the owner of directory and its content.
#
# Arguments:
#   new_owner
#   directory

NEW_OWNER="$1"
DIRECTORY="$2"

# Display errors (if any).
function err() {
  echo "$*" >&2
  exit 1
}

# Checks if user running script has root permitions.
function is_root() {
  if (( $UID != 0 )); then
    err "Only root allowed to run this scenario!"
  fi
}

# Checks if provided <new_owner> exists in system.
function user_exists() {
  if [[ ! $(id ${NEW_OWNER}) ]]; then
    err "Provided user does not exist!"
  fi
}

# Checks if provided <directory> exists.
function dir_exists() {
  if [[ ! -d ${DIRECTORY} ]]; then
    err "Provided directory does not exist or is not a directory!"
  fi
}

function main() {
  is_root
  user_exists
  dir_exists

  chown -R ${NEW_OWNER}:${NEW_OWNER} ${DIRECTORY}
  echo "You have changed the owner of '${DIRECTORY}' to '${NEW_OWNER}'"
}

main "$@"
