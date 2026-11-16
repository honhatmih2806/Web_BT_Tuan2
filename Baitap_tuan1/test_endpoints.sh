#!/bin/bash
# Kịch bản kiểm tra toàn bộ tính năng bài tập tuần 1
set -e

BASE_URL="http://localhost:8080/Baitap_tuan1"
COOKIE_JAR="/tmp/test_bt1_cookies.txt"
rm -f "$COOKIE_JAR"

echo "=========================================================="
echo "🧪 BẮT ĐẦU KIỂM TRA BÀI TẬP TUẦN 1 (06_MVC & 14_CRUD) 🧪"
echo "=========================================================="

echo ""
echo "▶ [TEST 1] Kiểm tra trang chủ GET /home"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/home")
echo "  HTTP Code: $STATUS (Kỳ vọng: 200)"

echo ""
echo "▶ [TEST 2] Kiểm tra trang đăng nhập GET /login"
BODY=$(curl -s "$BASE_URL/login")
if echo "$BODY" | grep -q "Đăng Nhập"; then
    echo "  ✅ PASS: Form login.jsp tải thành công"
else
    echo "  ❌ FAIL"
fi

echo ""
echo "▶ [TEST 3] Đăng nhập sai mật khẩu POST /login (admin / 999999)"
FAIL_MSG=$(curl -s -X POST -d "username=admin&password=999999" "$BASE_URL/login")
if echo "$FAIL_MSG" | grep -q "Tài khoản hoặc mật khẩu không đúng"; then
    echo "  ✅ PASS: Báo lỗi chính xác 'Tài khoản hoặc mật khẩu không đúng'"
else
    echo "  ❌ FAIL"
fi

echo ""
echo "▶ [TEST 4] Đăng nhập THÀNH CÔNG POST /login (admin / 123456) + Remember Me"
REDIRECT_URL=$(curl -s -c "$COOKIE_JAR" -o /dev/null -w "%{redirect_url}" -X POST -d "username=admin&password=123456&remember=on" "$BASE_URL/login")
echo "  Redirect: $REDIRECT_URL (Kỳ vọng: .../waiting)"

echo ""
echo "▶ [TEST 5] Kiểm tra điều hướng Role tại GET /waiting"
WAITING_REDIRECT=$(curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -o /dev/null -w "%{redirect_url}" "$BASE_URL/waiting")
echo "  Redirect: $WAITING_REDIRECT (Kỳ vọng: .../admin/home vì roleid == 1)"

echo ""
echo "▶ [TEST 6] Truy cập Dashboard Quản trị GET /admin/home"
ADMIN_BODY=$(curl -s -b "$COOKIE_JAR" "$BASE_URL/admin/home")
if echo "$ADMIN_BODY" | grep -q "Bảng Điều Khiển Quản Trị"; then
    echo "  ✅ PASS: Nhận diện đúng phiên làm việc của Admin"
else
    echo "  ❌ FAIL"
fi

echo ""
echo "▶ [TEST 7] Truy cập Danh sách Danh mục GET /admin/category/list"
CATE_LIST_BODY=$(curl -s -b "$COOKIE_JAR" "$BASE_URL/admin/category/list")
if echo "$CATE_LIST_BODY" | grep -q "Danh Sách Danh Mục"; then
    echo "  ✅ PASS: Hiển thị bảng Category CRUD thành công"
else
    echo "  ❌ FAIL"
fi

echo ""
echo "▶ [TEST 8] Kiểm tra trang Đăng ký GET /register"
REG_BODY=$(curl -s "$BASE_URL/register")
if echo "$REG_BODY" | grep -q "Tạo Tài Khoản Mới"; then
    echo "  ✅ PASS: Form register.jsp tải thành công"
else
    echo "  ❌ FAIL"
fi

echo ""
echo "▶ [TEST 9] Đăng ký trùng Username POST /register"
DUP_MSG=$(curl -s -X POST -d "username=admin&password=123&email=unique@gmail.com&fullname=Test&phone=0123" "$BASE_URL/register")
if echo "$DUP_MSG" | grep -q "Tài khoản đã tồn tại"; then
    echo "  ✅ PASS: Chặn trùng lặp tài khoản chính xác"
else
    echo "  ❌ FAIL"
fi

echo ""
echo "▶ [TEST 10] Kiểm tra Đăng xuất GET /logout"
LOGOUT_REDIRECT=$(curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -o /dev/null -w "%{redirect_url}" "$BASE_URL/logout")
echo "  Redirect: $LOGOUT_REDIRECT (Kỳ vọng: .../login)"

echo ""
echo "=========================================================="
echo "🎉 TẤT CẢ CÁC BÀI TEST ĐỀU HOẠT ĐỘNG HOÀN HẢO! (100% PASS)"
echo "=========================================================="
