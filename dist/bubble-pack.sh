#!/bin/sh
echo -ne '\033c\033]0;bubble-pack\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/bubble-pack.x86_64" "$@"
