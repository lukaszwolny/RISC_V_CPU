#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BUILD_DIR="$ROOT_DIR/tb/build"

mkdir -p "$BUILD_DIR"

iverilog \
    -o "$BUILD_DIR/tb_alu.vvp" \
    "$ROOT_DIR/rtl/alu.v" \
    "$ROOT_DIR/tb/tb_alu.v"

cd "$BUILD_DIR"
vvp tb_alu.vvp

if command -v gtkwave >/dev/null 2>&1; then
    gtkwave tb_alu.vcd &
else
    echo "GTKWave nie jest zainstalowany lub nie ma go w PATH."
fi
