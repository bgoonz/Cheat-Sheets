#!/usr/bin/env bash
# Tiny script to compile a .c file and execute its output, using gcc

clear
input="$1"
output="${1%.c}"
compiler="gcc"
#compiler="clang"

echo -e "Compiling '$input' with '$compiler'..."
ls -larth $input
$compiler -Wall -Wextra -O2 -std=c99 -pedantic "$input" -o "$output"

ls -larth $output
file $output
echo -e "Compiling '$input' with gcc..."
[ -f "$output" ] && ./"$output"
