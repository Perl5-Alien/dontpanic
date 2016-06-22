#!/bin/bash -x

set -euo pipefail
IFS=$'\n\t'

mkdir -p config m4
autoreconf --force --install -I config -I m4
