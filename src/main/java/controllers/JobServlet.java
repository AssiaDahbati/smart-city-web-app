package controllers;

import dao.JobDao;
import models.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/JobServlet")
public class JobServlet extends HttpServlet {

    private final JobDao dao = new JobDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    request.getRequestDispatcher("job-form.jsp")
                           .forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    Job j = dao.getById(editId);
                    request.setAttribute("job", j);
                    request.getRequestDispatcher("job-form.jsp")
                           .forward(request, response);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    dao.delete(deleteId);
                    response.sendRedirect("JobServlet");
                    break;

                case "list":
                default:
                    List<Job> list = dao.getAll();
                    request.setAttribute("jobList", list);
                    request.getRequestDispatcher("manageJobs.jsp")
                           .forward(request, response);
                    break;
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        String title      = request.getParameter("title");
        String company    = request.getParameter("company");
        String location   = request.getParameter("location");
        String jobType    = request.getParameter("jobType");
        String description = request.getParameter("description");
        String applyLink  = request.getParameter("applyLink");

        Job j = new Job(title, company, location, jobType, description, applyLink);

        try {
            if (idStr == null || idStr.isEmpty()) {
                // INSERT
                dao.insert(j);
            } else {
                // UPDATE
                j.setId(Integer.parseInt(idStr));
                dao.update(j);
            }

            response.sendRedirect("JobServlet");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
