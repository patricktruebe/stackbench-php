#!/bin/bash

LINE='----------------------------------------'

COOLDOWN=20
TIMEOUT=60
DURATION=30
RPS=10000

HERE="${BASH_SOURCE%/*}"
if [[ ! -d "$HERE" ]]; then HERE="$PWD"; fi
. "$HERE/src/setup.sh"
. "$HERE/src/urls.sh"
wrk="$HERE/wrk2/wrk"

for url in "${URLS[@]}" ; do
  for c in 8 16 64 128 ; do
    printf "%s %s [Connections]\n" "$c" "${LINE:${#c}}"
    $wrk -t 4 -R $RPS --timeout $TIMEOUT -d $DURATION "$url" -c $c
    sleep $COOLDOWN
  done
done
