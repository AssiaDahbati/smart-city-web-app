package controllers;

import dao.StudentDao;
import models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet("/StudentServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1MB
        maxFileSize = 5 * 1024 * 1024,       // 5MB
        maxRequestSize = 8 * 1024 * 1024     // 8MB
)
public class StudentServlet extends HttpServlet {

    private final StudentDao studentDao = new StudentDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");
            if (action == null) action = "list";

            switch (action) {
                case "new":
                    request.getRequestDispatcher("addStudent.jsp").forward(request, response);
                    break;

                case "edit": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Student s = studentDao.getById(id);
                    request.setAttribute("student", s);
                    request.getRequestDispatcher("addStudent.jsp").forward(request, response);
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    studentDao.delete(id);
                    response.sendRedirect(request.getContextPath() + "/StudentServlet");
                    break;
                }

                default: { // list
                    List<Student> students = studentDao.getAll();
                    request.setAttribute("students", students);
                    request.getRequestDispatcher("manageStudents.jsp").forward(request, response);
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
            request.setCharacterEncoding("UTF-8");

            String idStr = request.getParameter("id");
            boolean editing = (idStr != null && !idStr.trim().isEmpty());

            String fullName = request.getParameter("fullName");
            String university = request.getParameter("university");
            String major = request.getParameter("major");
            String level = request.getParameter("level");
            String email = request.getParameter("email");

            
            String oldImageUrl = request.getParameter("existingImageUrl");

           
            String savedImageUrl = handleUpload(request, "imageFile"); // returns "/uploads/edu/xxx.jpg" or null

            String finalImageUrl = (savedImageUrl != null) ? savedImageUrl : oldImageUrl;

            Student s = new Student();
            s.setFullName(fullName);
            s.setUniversity(university);
            s.setMajor(major);
            s.setLevel(level);
            s.setEmail(email);
            s.setImageUrl(finalImageUrl);

            if (editing) {
                s.setId(Integer.parseInt(idStr));
                studentDao.update(s);
            } else {
                studentDao.insert(s);
            }

            response.sendRedirect(request.getContextPath() + "/StudentServlet");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String handleUpload(HttpServletRequest request, String partName) throws IOException, ServletException {
        Part part = request.getPart(partName);
        if (part == null || part.getSize() == 0) return null;

        String submitted = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        if (submitted == null || submitted.trim().isEmpty()) return null;

        String lower = submitted.toLowerCase();
        if (!(lower.endsWith(".png") || lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".webp"))) {
            
            return null;
        }

       
        String uploadFolder = request.getServletContext().getRealPath("/uploads/edu");
        File dir = new File(uploadFolder);
        if (!dir.exists()) dir.mkdirs();

        String ext = lower.substring(lower.lastIndexOf('.'));
        String fileName = UUID.randomUUID().toString().replace("-", "") + ext;

        File saved = new File(dir, fileName);
        part.write(saved.getAbsolutePath());

        return request.getContextPath() + "/uploads/edu/" + fileName;
    }
}
