package controllers;

import dao.BusinessDao;
import dao.JobDao;
import dao.StudentDao;
import dao.TourismDao;

import models.Business;
import models.Job;
import models.Student;     // ✅ IMPORTANT
import models.Tourism;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            StudentDao studentDao = new StudentDao();
            TourismDao tourismDao = new TourismDao();
            JobDao jobDao = new JobDao();
            BusinessDao businessDao = new BusinessDao();

            List<Student> eduList = studentDao.getLatest(4);
            List<Tourism> tourismList = tourismDao.getLatest(4);
            List<Job> jobList = jobDao.getLatest(4);
            List<Business> businessList = businessDao.getLatest(4);
         
            int studentsCount = studentDao.countAll();
            int tourismCount  = tourismDao.countAll();
            int jobsCount     = jobDao.countAll();
            int businessCount = businessDao.countAll();

            request.setAttribute("eduList", eduList);
            request.setAttribute("tourismList", tourismList);
            request.setAttribute("jobList", jobList);
            request.setAttribute("businessList", businessList);

            request.setAttribute("studentsCount", studentsCount);
            request.setAttribute("tourismCount", tourismCount);
            request.setAttribute("jobsCount", jobsCount);
            request.setAttribute("businessCount", businessCount);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
