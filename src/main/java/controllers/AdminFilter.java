package controllers;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter(urlPatterns = {
        "/admin.jsp",
        "/StudentServlet",
        "/TourismServlet",
        "/JobServlet",
        "/BusinessServlet"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);

        boolean ok = (session != null
                && session.getAttribute("role") != null
                && "ADMIN".equalsIgnoreCase(String.valueOf(session.getAttribute("role"))));

        if (!ok) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
