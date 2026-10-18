#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BUILD_DIR="$ROOT_DIR/tb/build"

mkdir -p "$BUILD_DIR"

iverilog \
    -o "$BUILD_DIR/tb_control_unit.vvp" \
    "$ROOT_DIR/rtl/control_unit.v" \
    "$ROOT_DIR/rtl/main_decoder.v" \
    "$ROOT_DIR/rtl/alu_decoder.v" \
    "$ROOT_DIR/tb/tb_control_unit.v"

cd "$BUILD_DIR"
vvp tb_control_unit.vvp

if command -v gtkwave >/dev/null 2>&1; then
    gtkwave tb_control_unit.vcd &
else
    echo "GTKWave nie jest zainstalowany lub nie ma go w PATH."
fi
