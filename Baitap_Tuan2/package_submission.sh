#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_ZIP="$PROJECT_DIR/Baitap_Tuan2_JPA_HCMUTE.zip"

echo "=== Cleaning previous build artifacts ==="
cd "$PROJECT_DIR"
rm -rf target "$OUTPUT_ZIP"

echo "=== Creating submission ZIP package ==="
cd "$PROJECT_DIR/.."
zip -r "$OUTPUT_ZIP" Baitap_Tuan2 -x "Baitap_Tuan2/target/*" -x "Baitap_Tuan2/.git/*" -x "Baitap_Tuan2/*.war"

echo "✅ Generated submission package at: $OUTPUT_ZIP"
ls -lh "$OUTPUT_ZIP"
