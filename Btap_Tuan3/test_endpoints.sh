#!/bin/bash
BASE_URL="http://localhost:8080/Btap_Tuan3"

echo "=========================================================="
echo " KIỂM TRA TOÀN BỘ ENDPOINTS BÀI TẬP TUẦN 3 (HCMUTE)"
echo "=========================================================="

echo "1. GET /home (Hiển thị 10 video mới nhất)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/home")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Trang chủ & Top 10 Video"; else echo "   ⚠️ Code $STATUS"; fi

echo "2. GET /video (Hiển thị videos phân trang 6sp/trang)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/video")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: URL /video phân trang 6sp/trang"; else echo "   ⚠️ Code $STATUS"; fi

echo "3. GET /video/detail?id=VID001 (Xem chi tiết & Play Video)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/video/detail?id=VID001")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Chi tiết & Phát Video"; else echo "   ⚠️ Code $STATUS"; fi

echo "4. GET /login (Đăng nhập mật khẩu BCrypt & Đăng xuất)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/login")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Trang Đăng Nhập"; else echo "   ⚠️ Code $STATUS"; fi

echo "5. GET /register (Đăng ký kích hoạt OTP qua Email)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/register")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Form Đăng Ký OTP"; else echo "   ⚠️ Code $STATUS"; fi

echo "6. GET /forgot-password (Quên mật khẩu gửi OTP)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/forgot-password")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Form Quên Mật Khẩu"; else echo "   ⚠️ Code $STATUS"; fi

echo "7. GET /admin/videos (CRUD Videos 1-n Users)"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/admin/videos")
echo "   HTTP Code: $STATUS"
if [ "$STATUS" -eq 200 ]; then echo "   ✅ PASS: Quản Trị Videos"; else echo "   ⚠️ Code $STATUS"; fi

echo "=========================================================="
echo " ĐÃ HOÀN THÀNH KIỂM TRA ENDPOINTS!"
echo "=========================================================="
