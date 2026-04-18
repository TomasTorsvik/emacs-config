#!/usr/bin/env sh

set -e

# You should update this variable to your liking! 
PREFIX="$HOME/dev/emacs-install-dir"
mkdir -p "$PREFIX"

echo "Running autogen.."
./autogen.sh

echo "Running configure.."
./configure --enable-checking='yes,glyphs' \
    --enable-check-lisp-object-type \
    --prefix "$PREFIX" \
    --with-native-compilation \
    --with-json \
    --with-pgtk

echo "Running make.."
make -j "$(nproc)"

echo "Installing to $PREFIX .."
make install
