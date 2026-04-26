package controllers;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminUserServlet")
public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");
            if (action == null) action = "list";

            UserDao dao = new UserDao();

            switch (action) {
                case "approve":
                    dao.approveUser(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect("AdminUserServlet");
                    return;

                case "reject":
                    dao.rejectUser(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect("AdminUserServlet");
                    return;

                case "delete":
                    dao.deleteUser(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect("AdminUserServlet");
                    return;

                case "list":
                default:
                    request.setAttribute("users", dao.getAllUsers());
                    request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
