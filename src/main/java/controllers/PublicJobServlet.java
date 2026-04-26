package controllers;

import dao.JobDao;
import models.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/PublicJobServlet")
public class PublicJobServlet extends HttpServlet {

    private final JobDao dao = new JobDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Job> list = dao.getAll();
            request.setAttribute("jobList", list);
            request.getRequestDispatcher("public-jobs.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException(e);
        }
    }
}
