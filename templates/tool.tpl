;; sh

#!/bin/bash

set -Eeuo pipefail


USAGE=""

usage() {
    echo "usage: ${USAGE}"
}

help() {
cat <<help
DESCRIPTION

    A script that

USAGE

    ${USAGE}

OPTIONS

    -h, --help      display this message

help
}


while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      help
      exit 0
      ;;
    *|-*|--*)
      usage
      exit 1
      ;;
  esac
done

