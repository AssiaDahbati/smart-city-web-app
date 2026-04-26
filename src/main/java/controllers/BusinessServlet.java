package controllers;

import dao.BusinessDao;
import models.Business;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/BusinessServlet")
public class BusinessServlet extends HttpServlet {

    private final BusinessDao dao = new BusinessDao();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    req.getRequestDispatcher("business-form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Business b = dao.getById(id);
                    req.setAttribute("business", b);
                    req.getRequestDispatcher("business-form.jsp").forward(req, resp);
                    break;

                case "delete":
                    dao.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("BusinessServlet");
                    break;

                default:
                    List<Business> list = dao.getAll();
                    req.setAttribute("businessList", list);
                    req.getRequestDispatcher("manageBusiness.jsp").forward(req, resp);
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        Business b = new Business(
            req.getParameter("name"),
            req.getParameter("category"),
            req.getParameter("location"),
            req.getParameter("description"),
            req.getParameter("contactEmail")
        );

        try {
            if (id == null || id.isEmpty()) {
                dao.insert(b);
            } else {
                b.setId(Integer.parseInt(id));
                dao.update(b);
            }
            resp.sendRedirect("BusinessServlet");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
