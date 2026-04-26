package filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();

        boolean publicPath =
                uri.equals(ctx + "/") ||
                uri.equals(ctx + "/index.jsp") ||
                uri.startsWith(ctx + "/HomeServlet") ||
                uri.startsWith(ctx + "/MapServlet") ||
                uri.startsWith(ctx + "/Public") ||
                uri.startsWith(ctx + "/assets") ||
                uri.startsWith(ctx + "/uploads") ||
                uri.endsWith("login.jsp") ||
                uri.endsWith("register.jsp") ||
                uri.startsWith(ctx + "/login") ||
                uri.startsWith(ctx + "/register") ||
                uri.startsWith(ctx + "/LogoutServlet");

        if (publicPath) {
            chain.doFilter(req, res);
            return;
        }

       
        boolean adminArea =
                uri.endsWith("/admin.jsp") ||
                uri.contains("/StudentServlet") ||
                uri.contains("/TourismServlet") ||
                uri.contains("/JobServlet") ||
                uri.contains("/BusinessServlet") ||
                uri.contains("/AdminUserServlet");

        HttpSession session = request.getSession(false);
        String role = (session == null) ? null : (String) session.getAttribute("role");

        if (adminArea) {
            if (role != null && role.equalsIgnoreCase("ADMIN")) {
                chain.doFilter(req, res);
            } else {
                response.sendRedirect(ctx + "/login.jsp?error=not_admin");
            }
            return;
        }


        chain.doFilter(req, res);
    }
}
