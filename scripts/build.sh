#!/usr/bin/env bash
# Usage: scripts/build.sh [thread|address|undefined]
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SANITIZE="${1:-}"

case "$SANITIZE" in
  ""|thread|address|undefined) ;;
  *) echo "Unknown sanitizer '$SANITIZE'. Use: thread, address or undefined." >&2; exit 2 ;;
esac

if [[ -n "$SANITIZE" ]]; then
  BUILD_DIR="${BUILD_DIR:-$ROOT/build-$SANITIZE}"
else
  BUILD_DIR="${BUILD_DIR:-$ROOT/build}"
fi

cmake -S "$ROOT" -B "$BUILD_DIR" -DSANITIZE="$SANITIZE"
cmake --build "$BUILD_DIR" -j "$(nproc)"
ctest --test-dir "$BUILD_DIR" --output-on-failure