#!/bin/bash

# TODO so, this may not be super robust, but it works on my machine for now
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
  is_sourced=1
else
  is_sourced=0
fi

if [ $is_sourced -eq 0 ]; then set -e; fi

main() {
  local cabalFile exeName
  mkdir -p bin/
  # find executables
  if ls 2>/dev/null 1>&2 ./*.cabal; then
    for cabalFile in *.cabal; do
      echo >&2 "searching $cabalFile:"
      while read -r exeName; do
        # link binary into bin
        findAndLinkExe "$exeName"
      done < <(\
        (grep -Pi '^executable\s+[a-zA-Z0-9_-]+$' "$cabalFile" || echo '') \
        | sed -r 's/^executable\s+//i')
    done
    if [ $is_sourced -eq 1 ]; then
      # adjust PATH
      if ! echo "$PATH" | grep -F "${PWD}/bin" >/dev/null 2>&1 ; then
        echo >&2 "adjusting path"
        export PATH="${PATH}:${PWD}/bin"
      fi
      # load autocompletion
      if [ -f bin/autocomplete ]; then
        while read -r exeName; do
          echo >&2 "autocompletion for $exeName"
          source <("$exeName" --bash-completion-script "$(which "$exeName")")
        done < bin/autocomplete
      elif ls 2>/dev/null 1>&2 bin/*; then
        technicolor fa0 "echo binaries to bin/autocomplete to enable autocompletion"
      fi
    else
      technicolor f0a "source this script to setup PATH and autocompletion"
    fi
  else
    technicolor f00 "no cabal files found"
    exit 1
  fi

}

findAndLinkExe() {
  local exeName exePath thisTime latestTime candidate
  exeName=$1
  # remove existing link
  if [ -h bin/"$exeName" ]; then
    rm bin/"$exeName"
  fi
  # find latest build
  latestTime=-1
  exePath=''
  while read -r candidate; do
    thisTime=$(stat --format '%Y' "$candidate")
    if [ "$thisTime" -gt "$latestTime" ]; then
      latestTime=$thisTime
      exePath=$candidate
    fi
  done < <(find dist-newstyle/ -type f -executable -name "$exeName")
  # link latest build, or warn nothing found
  if [ -z "$exePath" ]; then
    echo >&2 "$(technicolor fa0 "$exeName: binary not found"), try \`cabal build $exeName\`"
  else
    ln -sv "$PWD/$exePath" bin/
  fi
}

main
