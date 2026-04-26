package controllers;

import dao.TourismDao;
import models.Tourism;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/TourismServlet")
public class TourismServlet extends HttpServlet {

    private final TourismDao tourismDao = new TourismDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new" -> {
                    request.setAttribute("tourism", null);
                    request.getRequestDispatcher("tourism-form.jsp").forward(request, response);
                }
                case "edit" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Tourism t = tourismDao.getById(id);
                    request.setAttribute("tourism", t);
                    request.getRequestDispatcher("tourism-form.jsp").forward(request, response);
                }
                case "delete" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    tourismDao.delete(id);
                    response.sendRedirect(request.getContextPath() + "/TourismServlet");
                }
                default -> {
                    request.setAttribute("tourismList", tourismDao.getAll());
                    request.getRequestDispatcher("manageTourism.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("id");

            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");

            String latStr = request.getParameter("latitude");
            String lngStr = request.getParameter("longitude");

            Double lat = (latStr == null || latStr.isBlank()) ? null : Double.parseDouble(latStr);
            Double lng = (lngStr == null || lngStr.isBlank()) ? null : Double.parseDouble(lngStr);

            Tourism t;
            if (idStr == null || idStr.isBlank()) {
                t = new Tourism(0, name, location, description, imageUrl);
                t.setLatitude(lat);
                t.setLongitude(lng);
                tourismDao.insert(t);
            } else {
                int id = Integer.parseInt(idStr);
                t = new Tourism(id, name, location, description, imageUrl);
                t.setLatitude(lat);
                t.setLongitude(lng);
                tourismDao.update(t);
            }

            response.sendRedirect(request.getContextPath() + "/TourismServlet");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
