package controllers;

import dao.StudentDao;
import models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/PublicEducationServlet")
public class PublicEducationServlet extends HttpServlet {

    private StudentDao studentDao;

    @Override
    public void init() {
        studentDao = new StudentDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // All educational places
            List<Student> eduList = studentDao.getAll();

            request.setAttribute("eduList", eduList);
            request.getRequestDispatcher("/publicEducation.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
