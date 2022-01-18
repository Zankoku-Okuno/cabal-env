# cabal-env

Run this script in a cabal project directory to produce a `bin` subdir populated with all built executables.
Source this script from the same place to put that `bin` dir on the `PATH` and run selected auto-complete scripts.
Echo the names of executables you want to run Optparse bash-completion scripts into `bin/autocomplete` before sourcing.

Installation:

```
# requires my technicolor library on your path:
wget https://raw.githubusercontent.com/Zankoku-Okuno/technicolor/master/technicolor -O ~/bin/technicolor

# then, install env-cabal to your path
wget https://raw.githubusercontent.com/edemko/env-cabal/master/env-cabal.bash -O ~/bin/env-cabal
```
