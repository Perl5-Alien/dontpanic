#!/bin/bash -x

set -euo pipefail
IFS=$'\n\t'

if [ -f configure ]; then
  if ! [ -f Makefile ]; then
    ./configure
  fi
fi

if [ -f Makefile ]; then
  make clean;
fi

rm -f aclocal.m4 config.* configure Makefile Makefile.in stamp-h1 src/Makefile src/Makefile.in;
rm -Rf autom4te.cache libtool;
rm -Rf m4 config src/.deps src/dontpanic.pc;

