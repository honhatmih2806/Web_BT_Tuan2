package vn.iotstar.filter;

import java.io.ByteArrayOutputStream;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

@WebFilter(filterName = "SiteMeshFilter", urlPatterns = { "/*" }, dispatcherTypes = { DispatcherType.REQUEST, DispatcherType.FORWARD })
public class SiteMeshFilter implements Filter {

    private static final String ALREADY_APPLIED = "SITEMESH_ALREADY_APPLIED";
    private static final Pattern TITLE_PATTERN = Pattern.compile("<title>(.*?)</title>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
    private static final Pattern HEAD_PATTERN = Pattern.compile("<head>(.*?)</head>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
    private static final Pattern BODY_PATTERN = Pattern.compile("<body[^>]*>(.*?)</body>", Pattern.CASE_INSENSITIVE | Pattern.DOTALL);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = (contextPath != null && uri.startsWith(contextPath)) ? uri.substring(contextPath.length()) : uri;

        if (shouldExclude(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Only decorate on FORWARD to JSPs or direct REQUEST to JSPs/pages, not on initial controller REQUEST that forwards
        DispatcherType dispatcherType = req.getDispatcherType();
        if (dispatcherType == DispatcherType.REQUEST && !path.endsWith(".jsp") && !path.contains(".")) {
            // Controller servlet handling initial request: let it forward to JSP
            chain.doFilter(request, response);
            return;
        }

        if (req.getAttribute(ALREADY_APPLIED) != null) {
            chain.doFilter(request, response);
            return;
        }

        req.setAttribute(ALREADY_APPLIED, Boolean.TRUE);

        CharResponseWrapper responseWrapper = new CharResponseWrapper(resp);
        try {
            chain.doFilter(request, responseWrapper);
        } finally {
            req.removeAttribute(ALREADY_APPLIED);
        }

        if (responseWrapper.isRedirect()) {
            return;
        }

        String originalHtml = responseWrapper.getCapturedOutput();
        if (originalHtml == null || originalHtml.trim().isEmpty()) {
            return;
        }

        String contentType = responseWrapper.getContentType();
        if (contentType != null && !contentType.toLowerCase().contains("text/html") && !contentType.toLowerCase().contains("application/xhtml")) {
            writeOutput(resp, originalHtml);
            return;
        }

        String title = extract(TITLE_PATTERN, originalHtml);
        String head = extract(HEAD_PATTERN, originalHtml);
        String body = extract(BODY_PATTERN, originalHtml);

        if (body == null || body.trim().isEmpty()) {
            body = originalHtml;
        }

        if (head != null) {
            head = head.replaceAll("(?is)<title>.*?</title>", "").trim();
        }

        String decoratorPath = (path.contains("/admin/") || uri.contains("/admin/")) ? "/decorators/admin.jsp" : "/decorators/web.jsp";

        req.setAttribute("pageTitle", title != null ? title : "HCMUTE Video Portal");
        req.setAttribute("pageHead", head != null ? head : "");
        req.setAttribute("pageBody", body);

        CharResponseWrapper decoratorWrapper = new CharResponseWrapper(resp);
        try {
            req.setAttribute(ALREADY_APPLIED, Boolean.TRUE);
            req.getRequestDispatcher(decoratorPath).include(req, decoratorWrapper);
            req.removeAttribute(ALREADY_APPLIED);

            String decoratedHtml = decoratorWrapper.getCapturedOutput();
            decoratedHtml = replaceSitemeshTags(decoratedHtml, title, head, body);

            resp.setContentType("text/html;charset=UTF-8");
            writeOutput(resp, decoratedHtml);
        } catch (Exception e) {
            resp.setContentType("text/html;charset=UTF-8");
            writeOutput(resp, originalHtml);
        }
    }

    private void writeOutput(HttpServletResponse resp, String html) throws IOException {
        try {
            resp.getWriter().write(html);
            resp.getWriter().flush();
        } catch (IllegalStateException e) {
            byte[] bytes = html.getBytes(StandardCharsets.UTF_8);
            resp.getOutputStream().write(bytes);
            resp.getOutputStream().flush();
        }
    }

    private boolean shouldExclude(String path) {
        if (path == null) return true;
        String lower = path.toLowerCase();
        return lower.startsWith("/decorators/") ||
               lower.startsWith("/image") ||
               lower.startsWith("/media") ||
               lower.endsWith(".css") ||
               lower.endsWith(".js") ||
               lower.endsWith(".png") ||
               lower.endsWith(".jpg") ||
               lower.endsWith(".jpeg") ||
               lower.endsWith(".gif") ||
               lower.endsWith(".svg") ||
               lower.endsWith(".ico") ||
               lower.endsWith(".mp4");
    }

    private String extract(Pattern pattern, String content) {
        Matcher matcher = pattern.matcher(content);
        if (matcher.find()) {
            return matcher.group(1).trim();
        }
        return null;
    }

    private String replaceSitemeshTags(String template, String title, String head, String body) {
        if (template == null) return "";
        template = template.replaceAll("(?is)<sitemesh:write[^>]*property=[\"']title[\"'][^>]*>.*?</sitemesh:write>", title != null ? Matcher.quoteReplacement(title) : "");
        template = template.replaceAll("(?is)<sitemesh:write[^>]*property=[\"']head[\"'][^>]*>.*?</sitemesh:write>", head != null ? Matcher.quoteReplacement(head) : "");
        template = template.replaceAll("(?is)<sitemesh:write[^>]*property=[\"']body[\"'][^>]*>.*?</sitemesh:write>", body != null ? Matcher.quoteReplacement(body) : "");
        return template;
    }

    @Override
    public void destroy() {}

    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private final CharArrayWriter charWriter = new CharArrayWriter();
        private final PrintWriter printWriter = new PrintWriter(charWriter);
        private ByteArrayOutputStream byteStream;
        private ServletOutputStream servletStream;
        private boolean isRedirect = false;

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
        }

        @Override
        public boolean isCommitted() {
            return false;
        }

        @Override
        public void flushBuffer() throws IOException {
            printWriter.flush();
            if (byteStream != null) {
                byteStream.flush();
            }
        }

        @Override
        public void setContentLength(int len) {
            // suppress setting content length before decoration
        }

        @Override
        public void setContentLengthLong(long len) {
            // suppress setting content length before decoration
        }

        @Override
        public PrintWriter getWriter() {
            return printWriter;
        }

        @Override
        public ServletOutputStream getOutputStream() {
            if (byteStream == null) {
                byteStream = new ByteArrayOutputStream();
                servletStream = new ServletOutputStream() {
                    @Override
                    public boolean isReady() { return true; }
                    @Override
                    public void setWriteListener(WriteListener writeListener) {}
                    @Override
                    public void write(int b) { byteStream.write(b); }
                    @Override
                    public void write(byte[] b, int off, int len) { byteStream.write(b, off, len); }
                };
            }
            return servletStream;
        }

        @Override
        public void sendRedirect(String location) throws IOException {
            this.isRedirect = true;
            super.sendRedirect(location);
        }

        public boolean isRedirect() {
            return isRedirect;
        }

        public String getCapturedOutput() {
            printWriter.flush();
            if (charWriter.size() > 0) {
                return charWriter.toString();
            }
            if (byteStream != null && byteStream.size() > 0) {
                return byteStream.toString(StandardCharsets.UTF_8);
            }
            return "";
        }
    }
}
