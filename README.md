# cabal-env

Run this script in a cabal project directory to produce a `bin` subdir populated with all built executables.
Source this script from the same place to put that `bin` dir on the `PATH` and run selected auto-complete scripts.
Echo the names of executables you want to run Optparse bash-completion scripts into `bin/autocomplete`.

Installation:

```
git clone https://github.com/Zankoku-Okuno/env-cabal
cd env-cabal
ln `pwd`/env-cabal.bash ~/bin/env-cabal

# requires my technicolor library:
wget https://raw.githubusercontent.com/Zankoku-Okuno/technicolor/master/technicolor -O ~/bin/technicolor
```
