package dao;

import models.Student;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDao {

    public List<Student> getAll() throws SQLException, ClassNotFoundException {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY id DESC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Student(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("university"),
                        rs.getString("major"),
                        rs.getString("level"),
                        rs.getString("email"),
                        rs.getString("image_url")
                ));
            }
        }
        return list;
    }
    
    
    public List<Student> getLatest(int limit) throws Exception {
        String sql = "SELECT * FROM students ORDER BY id DESC LIMIT ?";
        List<Student> list = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Student(
                            rs.getInt("id"),
                            rs.getString("full_name"),
                            rs.getString("university"),
                            rs.getString("major"),
                            rs.getString("level"),
                            rs.getString("email"),
                            rs.getString("image_url") // فقط إذا عندك column image_url
                    ));
                }
            }
        }
        return list;
    }

    

    public Student getById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM students WHERE id = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Student(
                            rs.getInt("id"),
                            rs.getString("full_name"),
                            rs.getString("university"),
                            rs.getString("major"),
                            rs.getString("level"),
                            rs.getString("email"),
                            rs.getString("image_url")
                    );
                }
            }
        }
        return null;
    }

    public void insert(Student s) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO students (full_name, university, major, level, email, image_url) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getFullName());
            ps.setString(2, s.getUniversity());
            ps.setString(3, s.getMajor());
            ps.setString(4, s.getLevel());
            ps.setString(5, s.getEmail());
            ps.setString(6, s.getImageUrl());

            ps.executeUpdate();
        }
    }

    public void update(Student s) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE students SET full_name=?, university=?, major=?, level=?, email=?, image_url=? WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getFullName());
            ps.setString(2, s.getUniversity());
            ps.setString(3, s.getMajor());
            ps.setString(4, s.getLevel());
            ps.setString(5, s.getEmail());
            ps.setString(6, s.getImageUrl());
            ps.setInt(7, s.getId());

            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM students WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int countAll() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM students";
        try (var con = DatabaseConnection.getConnection();
             var ps = con.prepareStatement(sql);
             var rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }
}
