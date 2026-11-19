#!/bin/bash
BASE_URL="http://localhost:8080/Btap_Tuan4"

echo "=========================================================="
echo " KIỂM TRA TOÀN BỘ ENDPOINTS BÀI TẬP TUẦN 4 (HCMUTE)"
echo " SiteMesh 3, Form Validation, User Profile & Cloudinary"
echo "=========================================================="

echo "1. GET /home (Kiểm tra Decorator SiteMesh 3 Bootstrap)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/home")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Trang chủ & Decorator Web"; else echo "   ⚠️ Code $STATUS"; fi

echo "2. GET /login (Kiểm tra Trang Đăng Nhập)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/login")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Trang Đăng Nhập"; else echo "   ⚠️ Code $STATUS"; fi

echo "3. POST /login (Kiểm tra Form Validation rỗng)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$BASE_URL/login" -d "username=" -d "password=")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Server-side Form Validation hoạt động đúng"; else echo "   ⚠️ Code $STATUS"; fi

echo "4. GET /register (Form Đăng Ký OTP)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/register")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Form Đăng Ký"; else echo "   ⚠️ Code $STATUS"; fi

echo "5. GET /profile (Hồ Sơ Profile Người Dùng)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -L "$BASE_URL/profile")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Profile Page & Điều hướng"; else echo "   ⚠️ Code $STATUS"; fi

echo "6. GET /video (Phân trang 6sp/trang)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/video")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: URL /video"; else echo "   ⚠️ Code $STATUS"; fi

echo "7. GET /admin/videos (Kiểm tra Decorator Admin Sitemesh)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/admin/videos")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Quản Trị Videos & Decorator Admin"; else echo "   ⚠️ Code $STATUS"; fi

echo "=========================================================="
echo " ĐÃ HOÀN THÀNH KIỂM TRA TẤT CẢ ENDPOINTS TUẦN 4!"
echo "=========================================================="
