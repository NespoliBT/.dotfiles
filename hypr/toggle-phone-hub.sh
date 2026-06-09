#!/usr/bin/env bash
# Find the most recent phone-hub quickshell instance and toggle it

SOCKET=$(find /run/user/1000/quickshell -name "ipc.sock" -type s 2>/dev/null | head -1)
if [ -z "$SOCKET" ]; then
    echo "phone-hub not running" >&2
    exit 1
fi

qs ipc -p "$(dirname "$SOCKET")" call phonehub toggle
