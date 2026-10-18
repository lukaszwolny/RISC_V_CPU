#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BUILD_DIR="$ROOT_DIR/tb/build"

mkdir -p "$BUILD_DIR"

iverilog \
    -o "$BUILD_DIR/tb_cpu.vvp" \
    "$ROOT_DIR/rtl/adder.v" \
    "$ROOT_DIR/rtl/alu_decoder.v" \
    "$ROOT_DIR/rtl/alu.v" \
    "$ROOT_DIR/rtl/control_unit.v" \
    "$ROOT_DIR/rtl/data_mem.v" \
    "$ROOT_DIR/rtl/datapath.v" \
    "$ROOT_DIR/rtl/imm_gen.v" \
    "$ROOT_DIR/rtl/instr_mem.v" \
    "$ROOT_DIR/rtl/main_decoder.v" \
    "$ROOT_DIR/rtl/mux2.v" \
    "$ROOT_DIR/rtl/mux3.v" \
    "$ROOT_DIR/rtl/mux4.v" \
    "$ROOT_DIR/rtl/pc.v" \
    "$ROOT_DIR/rtl/reg_file.v" \
    "$ROOT_DIR/rtl/single_cycle_cpu.v" \
    "$ROOT_DIR/tb/tb_cpu.v"

cd "$BUILD_DIR"
vvp tb_cpu.vvp

if command -v gtkwave >/dev/null 2>&1; then
    gtkwave tb_cpu.vcd &
else
    echo "GTKWave nie jest zainstalowany lub nie ma go w PATH."
fi
