package controllers;

import dao.BusinessDao;
import models.Business;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/PublicBusinessServlet")
public class PublicBusinessServlet extends HttpServlet {

    private final BusinessDao dao = new BusinessDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Business> list = dao.getAll();
            request.setAttribute("businessList", list);
            request.getRequestDispatcher("public-business.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException(e);
        }
    }
}
