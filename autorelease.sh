#!/bin/bash -x

set -euo pipefail
IFS=$'\n\t'

VERSION=`grep AC_INIT configure.ac | perl -n -E '$_ =~ /\[([0-9\.]+)\]/ ? say $1 : die "no match!"'`
echo VERSION=$VERSION

if [ -f .git/refs/tags/$VERSION ]; then
  echo tag for $VERSION already exists
fi

bash autoclean.sh

function git_changes {
  expr `git status --porcelain 2> /dev/null| wc -l`
}

if ! [ $(git_changes) == 0 ]; then
  echo repository is not clean
  false
fi

TMPBRANCH=release-$VERSION

git branch   $TMPBRANCH
git checkout $TMPBRANCH

git rm .gitignore
echo "language: c" > .travis.yml

bash autogen.sh
./configure
make dist
mv dontpanic-$VERSION.tar.gz /tmp
rm -rf *
tar zxvf /tmp/dontpanic-$VERSION.tar.gz
mv dontpanic-$VERSION/* .

git add .
git commit -m "release $VERSION"
git tag $VERSION
git checkout main
