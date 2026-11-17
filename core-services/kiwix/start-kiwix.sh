#!/bin/sh
set -eu

echo "Discovering ZIM archives..."

set --

while IFS= read -r zim; do
    [ -n "$zim" ] && set -- "$@" "$zim"
done <<EOF
$(find /data -type f -name '*.zim')
EOF

if [ "$#" -eq 0 ]; then
    echo "ERROR: No ZIM archives found."
    exit 1
fi

echo "Found $# ZIM archive(s):"

for zim do
    echo "  $zim"
done

echo "Starting Kiwix server..."

exec /usr/local/bin/kiwix-serve --port=8080 "$@"