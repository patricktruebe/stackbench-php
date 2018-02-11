#!/bin/bash
set -e

if [ ! -f "$HERE/wrk2/wrk" ] ; then
  set -x
  echo "wrk2 not found. This will clone and build https://github.com/giltene/wrk2.git. Ok?"
  read cmd
  git clone https://github.com/giltene/wrk2.git || true
  pushd wrk2/
  make -j$(nproc)
  popd
fi

set +x
