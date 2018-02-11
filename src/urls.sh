#!/bin/bash

declare -a _TESTS=(
  # Static file
  "stylesheets/main.css"
  # Tiny php script
  "info.php"
  # Wordpress-like php scripts
  "cpu.php"
  # IO/Wait-idle php scripts
  "io.php"
)

declare -a URLS=( )

for domain in "$@" ; do
  for test in "${_TESTS[@]}"; do
      URLS+=("$domain/$test")
  done
done
