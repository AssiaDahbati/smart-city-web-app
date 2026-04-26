package controllers;

import dao.UserDao;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            UserDao dao = new UserDao();
            User user = dao.loginApprovedUser(username, password);

            if (user == null) {
                response.sendRedirect("login.jsp?error=invalid");
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("userId", user.getId());

            // Admin goes dashboard
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin.jsp?welcome=1");
            } else {
                // normal user goes home
                response.sendRedirect("HomeServlet");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
