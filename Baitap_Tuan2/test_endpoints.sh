#!/bin/bash
BASE_URL="http://localhost:8080/Baitap_Tuan2"

echo "=== Testing Baitap_Tuan2 (JPA 3.0 CRUD Category) Endpoints ==="

echo "1. GET /admin/categories"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/admin/categories")
echo "   Status: $STATUS"
if [ "$STATUS" -eq 200 ]; then
    echo "   ✅ Category list loaded successfully"
else
    echo "   ⚠️ Expected 200, got $STATUS"
fi

echo "2. GET /admin/category/add"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/admin/category/add")
echo "   Status: $STATUS"
if [ "$STATUS" -eq 200 ]; then
    echo "   ✅ Add form loaded successfully"
else
    echo "   ⚠️ Expected 200, got $STATUS"
fi

echo "3. POST /admin/category/insert (Add Category)"
RAND_NAME="Category_Test_$(date +%s)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$BASE_URL/admin/category/insert" \
    -F "categoryname=$RAND_NAME" \
    -F "status=1")
echo "   Status: $STATUS"
if [ "$STATUS" -eq 302 ]; then
    echo "   ✅ Inserted successfully (redirected 302)"
else
    echo "   ⚠️ Expected 302 redirect, got $STATUS"
fi

echo "4. GET /image?fname=avatar.png"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/image?fname=avatar.png")
echo "   Status: $STATUS"
if [ "$STATUS" -eq 200 ]; then
    echo "   ✅ Image / placeholder loaded successfully"
else
    echo "   ⚠️ Expected 200, got $STATUS"
fi

echo "=== All Endpoint Tests Finished ==="
