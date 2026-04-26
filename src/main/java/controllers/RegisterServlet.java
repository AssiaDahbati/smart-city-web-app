package controllers;

import dao.UserDao;
import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");

            UserDao dao = new UserDao();

            if (dao.usernameExists(username)) {
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            // New user is pending approval
            User u = new User(username, password, "USER", email, "PENDING");
            dao.registerPendingUser(u);

            response.sendRedirect("login.jsp?msg=registered");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
