package vn.iotstar.util;

import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

    // Bộ nhớ đệm lưu OTP mới nhất phục vụ kiểm tra và hiển thị gợi ý khi demo không có Internet/SMTP
    private static final Map<String, String> OTP_CACHE = new ConcurrentHashMap<>();

    /**
     * Sinh mã OTP ngẫu nhiên gồm 6 chữ số
     */
    public static String generateOtp() {
        Random random = new Random();
        int number = 100000 + random.nextInt(900000);
        return String.valueOf(number);
    }

    /**
     * Lấy OTP mới nhất theo email (phục vụ hiển thị gợi ý trên UI khi thử nghiệm)
     */
    public static String getLatestOtp(String email) {
        if (email == null) return null;
        return OTP_CACHE.get(email.trim().toLowerCase());
    }

    /**
     * Gửi mã OTP xác nhận tới email của người dùng
     */
    public static boolean sendOtpEmail(String recipientEmail, String otpCode, String subject, String actionName) {
        if (recipientEmail == null || recipientEmail.trim().isEmpty()) {
            return false;
        }

        recipientEmail = recipientEmail.trim().toLowerCase();
        OTP_CACHE.put(recipientEmail, otpCode);

        System.out.println("=================================================================");
        System.out.println("📧 [EMAIL OTP SENDER]");
        System.out.println("   Đến: " + recipientEmail);
        System.out.println("   Mục đích: " + actionName);
        System.out.println("   MÃ OTP CỦA BẠN LÀ: " + otpCode);
        System.out.println("=================================================================");

        // Đọc cấu hình SMTP từ biến môi trường (nếu có cấu hình thực tế)
        String smtpHost = System.getenv().getOrDefault("SMTP_HOST", "smtp.gmail.com");
        String smtpPort = System.getenv().getOrDefault("SMTP_PORT", "587");
        String smtpUser = System.getenv().getOrDefault("SMTP_USER", "");
        String smtpPass = System.getenv().getOrDefault("SMTP_PASS", "");

        if (smtpUser.isEmpty() || smtpPass.isEmpty()) {
            // Không có cấu hình SMTP thực tế, giả lập gửi email thành công (OTP đã lưu cache & in log)
            return true;
        }

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.port", smtpPort);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUser, smtpPass);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(smtpUser, "HCMUTE Web System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);

            String htmlContent = "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; max-width: 500px;'>"
                    + "<h2 style='color: #0d6efd;'>HCMUTE - Xác thực tài khoản</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Bạn vừa thực hiện yêu cầu: <strong>" + actionName + "</strong>.</p>"
                    + "<p>Mã xác thực OTP của bạn là:</p>"
                    + "<div style='background-color: #f8f9fa; padding: 15px; text-align: center; font-size: 28px; font-weight: bold; letter-spacing: 5px; color: #dc3545; border-radius: 5px; border: 1px dashed #dc3545;'>"
                    + otpCode + "</div>"
                    + "<p style='margin-top: 15px; color: #6c757d; font-size: 13px;'>Mã xác thực có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("⚠️ Không gửi được email qua SMTP thực tế: " + e.getMessage() + ". Đã lưu mã OTP vào hệ thống.");
            return true;
        }
    }
}
