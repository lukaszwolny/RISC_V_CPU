#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BUILD_DIR="$ROOT_DIR/tb/build"

mkdir -p "$BUILD_DIR"

iverilog \
    -o "$BUILD_DIR/tb_mux.vvp" \
    "$ROOT_DIR/rtl/mux2.v" \
    "$ROOT_DIR/rtl/mux3.v" \
    "$ROOT_DIR/rtl/mux4.v" \
    "$ROOT_DIR/tb/tb_mux.v"

cd "$BUILD_DIR"
vvp tb_mux.vvp

if command -v gtkwave >/dev/null 2>&1; then
    gtkwave tb_mux.vcd &
else
    echo "GTKWave nie jest zainstalowany lub nie ma go w PATH."
fi
