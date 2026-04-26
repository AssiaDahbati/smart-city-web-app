package controllers;

import dao.CityPlaceDao;
import models.CityPlace;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/MapServlet")
public class MapServlet extends HttpServlet {

    private final CityPlaceDao dao = new CityPlaceDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setCharacterEncoding("UTF-8");

            String q = request.getParameter("q");
            if (q == null) q = "";

            List<CityPlace> places;
            if (q.trim().isEmpty()) {
                places = dao.getAll();
            } else {
                places = dao.search(q.trim());
            }

            request.setAttribute("q", q);
            request.setAttribute("places", places);

            request.getRequestDispatcher("map.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
