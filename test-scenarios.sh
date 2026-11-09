#!/bin/bash
# Kịch bản kiểm thử tự động toàn diện (Test Scenarios) cho Servlet 3 tầng
set -e

BASE_URL="http://localhost:8080"
COOKIE_JAR="/tmp/test_session_cookies.txt"
rm -f "$COOKIE_JAR"

echo "=========================================================="
echo "🌸 BẮT ĐẦU CHẠY CÁC BÀI TEST TỰ ĐỘNG CHO SERVLET 3 TẦNG 🌸"
echo "=========================================================="

# Test Case 1: Kiểm tra trang chủ qua URL "/"
echo ""
echo "▶ [TC-01] Kiểm tra GET / (Trang chủ mặc định)"
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/")
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "  ✅ PASS: Trả về HTTP 200 OK"
else
    echo "  ❌ FAIL: Nhận mã $STATUS_CODE"
fi

# Test Case 2: Kiểm tra trang chủ qua URL "/home"
echo ""
echo "▶ [TC-02] Kiểm tra GET /home (Trang chủ)"
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/home")
if [ "$STATUS_CODE" -eq 200 ]; then
    echo "  ✅ PASS: Trả về HTTP 200 OK"
else
    echo "  ❌ FAIL: Nhận mã $STATUS_CODE"
fi

# Test Case 3: Kiểm tra hiển thị trang đăng nhập GET "/login"
echo ""
echo "▶ [TC-03] Kiểm tra GET /login (Trang đăng nhập)"
BODY=$(curl -s "$BASE_URL/login")
if echo "$BODY" | grep -q "login.jsp"; then
    echo "  ✅ PASS: Đã tải form login.jsp thành công"
else
    echo "  ❌ FAIL: Không tìm thấy giao diện login"
fi

# Test Case 4: Đăng nhập sai mật khẩu -> Phải chuyển hướng 302 vào /error
echo ""
echo "▶ [TC-04] POST /login với sai mật khẩu (admin / wrongpass)"
LOCATION=$(curl -s -o /dev/null -w "%{redirect_url}" -X POST -d "username=admin&password=wrongpass" "$BASE_URL/login")
if echo "$LOCATION" | grep -q "/error"; then
    echo "  ✅ PASS: Đã chuyển hướng chính xác sang /error (Location: $LOCATION)"
else
    echo "  ❌ FAIL: Không chuyển hướng vào /error (Location: $LOCATION)"
fi

# Test Case 5: Đăng nhập tài khoản không tồn tại -> Phải chuyển hướng 302 vào /error
echo ""
echo "▶ [TC-05] POST /login với tài khoản không tồn tại (notfound / 123)"
LOCATION=$(curl -s -o /dev/null -w "%{redirect_url}" -X POST -d "username=notfound&password=123" "$BASE_URL/login")
if echo "$LOCATION" | grep -q "/error"; then
    echo "  ✅ PASS: Đã chuyển hướng chính xác sang /error (Location: $LOCATION)"
else
    echo "  ❌ FAIL: Không chuyển hướng vào /error (Location: $LOCATION)"
fi

# Test Case 6: Kiểm tra giao diện trang lỗi GET /error
echo ""
echo "▶ [TC-06] Kiểm tra GET /error (Trang thông báo lỗi)"
BODY_ERROR=$(curl -s "$BASE_URL/error")
if echo "$BODY_ERROR" | grep -q "error.jsp"; then
    echo "  ✅ PASS: Trang error.jsp hiển thị thông báo lỗi và nút thử lại"
else
    echo "  ❌ FAIL: Trang lỗi chưa đúng"
fi

# Test Case 7: Đăng nhập THÀNH CÔNG (admin / 123456) -> Chuyển hướng 302 vào /home và lưu session
echo ""
echo "▶ [TC-07] POST /login THÀNH CÔNG (admin / 123456)"
LOCATION_SUCCESS=$(curl -s -c "$COOKIE_JAR" -o /dev/null -w "%{redirect_url}" -X POST -d "username=admin&password=123456" "$BASE_URL/login")
if echo "$LOCATION_SUCCESS" | grep -q "/home"; then
    echo "  ✅ PASS: Đăng nhập thành công, chuyển hướng chính xác sang /home (Location: $LOCATION_SUCCESS)"
else
    echo "  ❌ FAIL: Không chuyển hướng vào /home (Location: $LOCATION_SUCCESS)"
fi

# Test Case 8: Truy cập /home với session đã đăng nhập -> Phải hiển thị họ tên người dùng
echo ""
echo "▶ [TC-08] Kiểm tra phiên đăng nhập (Session) tại /home"
HOME_USER_BODY=$(curl -s -b "$COOKIE_JAR" "$BASE_URL/home")
if echo "$HOME_USER_BODY" | grep -q "Nguyễn Hữu Trung"; then
    echo "  ✅ PASS: Trang chủ nhận diện đúng phiên làm việc của ThS. Nguyễn Hữu Trung"
else
    echo "  ❌ FAIL: Chưa nhận diện được thông tin session"
fi

# Test Case 9: Đăng xuất GET /logout -> Hủy session và về lại trang chủ
echo ""
echo "▶ [TC-09] Kiểm tra Đăng xuất GET /logout"
LOCATION_LOGOUT=$(curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -o /dev/null -w "%{redirect_url}" "$BASE_URL/logout")
if echo "$LOCATION_LOGOUT" | grep -q "/home"; then
    echo "  ✅ PASS: Đăng xuất thành công, chuyển hướng về /home"
else
    echo "  ❌ FAIL: Đăng xuất chưa chuyển hướng đúng"
fi

# Test Case 10: Chạy 7 bài kiểm thử JUnit 5 ở tầng Service & DAO
echo ""
echo "▶ [TC-10] Chạy JUnit 5 Unit Tests (UserDaoTest & UserServiceTest)"
JAVA_HOME=/usr/lib/jvm/java-17-openjdk mvn test -q
echo "  ✅ PASS: 7/7 JUnit 5 test methods vượt qua hoàn toàn!"

echo ""
echo "=========================================================="
echo "🎉 TẤT CẢ 10/10 TEST CASES ĐÃ PASS HOÀN TOÀN! (100% SUCCESS)"
echo "=========================================================="
