package controllers;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email == null) email = "";
        email = email.trim();

        try {
            UserDao userDao = new UserDao();

          
            String token = UUID.randomUUID().toString();

            boolean ok = userDao.createResetToken(email, token, 30); 

           
            HttpSession session = request.getSession();

            if (ok) {
                String link = request.getContextPath() + "/reset-password.jsp?token=" +
                        URLEncoder.encode(token, StandardCharsets.UTF_8);
                session.setAttribute("flash",
                        "Reset link created: " + link + " (copy and open it)");
            } else {
                session.setAttribute("flash",
                        "If an account exists for that email, you will receive reset instructions.");
            }

            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
