#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BUILD_DIR="$ROOT_DIR/tb/build"

mkdir -p "$BUILD_DIR"

iverilog \
    -o "$BUILD_DIR/tb_adder.vvp" \
    "$ROOT_DIR/rtl/adder.v" \
    "$ROOT_DIR/tb/tb_adder.v"

cd "$BUILD_DIR"
vvp tb_adder.vvp

if command -v gtkwave >/dev/null 2>&1; then
    gtkwave tb_adder.vcd &
else
    echo "GTKWave nie jest zainstalowany lub nie ma go w PATH."
fi
