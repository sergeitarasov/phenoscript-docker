#!/bin/bash
set -euo pipefail

INPUT_FILE="${PHS_FILE:?Error: PHS_FILE environment variable is not set}"

echo "=== PhenoScript → OWL conversion ==="
echo "Input file : ${INPUT_FILE}"

# phenospy requires all three files in the same directory:
#   <input>.phs / <input>.yphs
#   phs-config.yaml
#   phs-snippets.json
mkdir -p /app/work

cp "/app/input/${INPUT_FILE}"    /app/work/
cp /app/input/phs-config.yaml    /app/work/
cp /app/snippets/phs-snippets.json /app/work/

echo "Running phenospy..."
# Strip extension to get output basename (e.g. my_species.yphs → my_species)
BASENAME="${INPUT_FILE%.*}"
cd /app/work
# Use relative path ../output/<basename> so phenospy writes
# /app/work/../output/<basename>.owl  →  /app/output/<basename>.owl  (the mounted volume)
phenospy yphs2owl "${INPUT_FILE}" "../output/${BASENAME}"

echo "=== Done. Output written to output/owl_init/ ==="
