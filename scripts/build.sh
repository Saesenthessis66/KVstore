#!/usr/bin/env bash
# Configure, build and test the whole project.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-$ROOT/build}"

cmake -S "$ROOT" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR" -j "$(nproc)"
ctest --test-dir "$BUILD_DIR" --output-on-failure