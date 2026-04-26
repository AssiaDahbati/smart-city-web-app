package controllers;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ctx = request.getContextPath();

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm");

        if (token == null) token = "";
        if (password == null) password = "";
        if (confirm == null) confirm = "";

        token = token.trim();

        if (!password.equals(confirm)) {
            response.sendRedirect(ctx + "/reset-password.jsp?token=" + token + "&error=Passwords do not match");
            return;
        }

        if (password.length() < 6) {
            response.sendRedirect(ctx + "/reset-password.jsp?token=" + token + "&error=Password must be at least 6 characters");
            return;
        }

        try {
            UserDao userDao = new UserDao();
            boolean ok = userDao.resetPasswordWithToken(token, password);

            if (ok) {
                response.sendRedirect(ctx + "/login.jsp?msg=Password updated successfully. Please login.");
            } else {
                response.sendRedirect(ctx + "/reset-password.jsp?token=" + token + "&error=Invalid or expired reset link");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
