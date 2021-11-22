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
err() {
  echo "$*" >&2
  exit 1
}

# Checks if user running script has root permitions.
is_root() {
  if (( $UID != 0 )); then
    err "Only root allowed to run this scenario!"
  fi
}

# Checks if provided <new_owner> exists in system.
user_exists() {
  if [[ ! $(id ${NEW_OWNER}) ]]; then
    err "User does not exist!"
  fi
}

# Checks if provided <directory> exists.
dir_exists() {
  if [[ ! -d ${DIRECTORY} ]]; then
    err "Directory does not exist or is not a directory!"
  fi
}

main() {
  is_root
  user_exists
  dir_exists

  chown -R ${NEW_OWNER}:${NEW_OWNER} ${DIRECTORY}
}

main "$@"
