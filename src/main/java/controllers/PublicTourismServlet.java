package controllers;

import dao.TourismDao;
import models.Tourism;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/PublicTourismServlet")
public class PublicTourismServlet extends HttpServlet {

    private final TourismDao dao = new TourismDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Tourism> list = dao.getAll();
            request.setAttribute("tourismList", list);
            request.getRequestDispatcher("public-tourism.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException(e);
        }
    }
}
