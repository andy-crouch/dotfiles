#!/bin/bash
#
# The test.sh script will find all 
#
# This script was taken from Jess Frazelle's dotfiles repo (https://github.com/jessfraz/dotfiles/"

set -e
set -o pipefail

ERRORS=()

# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' -not -name "yubitouch.sh" | sort -u); do
  if file "$f" | grep --quiet shell; then
  {
    shellcheck "$f" && echo "[OK]: successfully linted $f"
  } || {
    # add to errors
    ERRORS+=("$f")
  }
  fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "No errors, hooray"
else
  echo "These files failed shellcheck: ${ERRORS[*]}"
  exit 1
fi
