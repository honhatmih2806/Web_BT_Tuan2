#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_ZIP="$PROJECT_DIR/Btap_Tuan3_HCMUTE.zip"

echo "=== Cleaning previous build artifacts ==="
cd "$PROJECT_DIR"
rm -rf target "$OUTPUT_ZIP"

echo "=== Creating submission ZIP package ==="
cd "$PROJECT_DIR/.."
zip -r "$OUTPUT_ZIP" Btap_Tuan3 -x "Btap_Tuan3/target/*" -x "Btap_Tuan3/.git/*" -x "Btap_Tuan3/*.war"

echo "✅ Generated submission package at: $OUTPUT_ZIP"
ls -lh "$OUTPUT_ZIP"
