package dao;

import models.Job;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDao {

    public List<Job> getAll() throws SQLException, ClassNotFoundException {
        List<Job> list = new ArrayList<>();
        String sql = "SELECT * FROM jobs ORDER BY id ASC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Job(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("company"),
                        rs.getString("location"),
                        rs.getString("job_type"),
                        rs.getString("description"),
                        rs.getString("apply_link")
                ));
            }
        }
        return list;
    }

    public Job getById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM jobs WHERE id = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Job(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("company"),
                            rs.getString("location"),
                            rs.getString("job_type"),
                            rs.getString("description"),
                            rs.getString("apply_link")
                    );
                }
            }
        }
        return null;
    }

    public void insert(Job j) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO jobs (title, company, location, job_type, description, apply_link) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, j.getTitle());
            ps.setString(2, j.getCompany());
            ps.setString(3, j.getLocation());
            ps.setString(4, j.getJobType());
            ps.setString(5, j.getDescription());
            ps.setString(6, j.getApplyLink());

            ps.executeUpdate();
        }
    }

    public void update(Job j) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE jobs SET title=?, company=?, location=?, job_type=?, description=?, apply_link=? WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, j.getTitle());
            ps.setString(2, j.getCompany());
            ps.setString(3, j.getLocation());
            ps.setString(4, j.getJobType());
            ps.setString(5, j.getDescription());
            ps.setString(6, j.getApplyLink());
            ps.setInt(7, j.getId());

            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM jobs WHERE id = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int countAll() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM jobs";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);
        }
    }

    public List<Job> getLatest(int limit) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM jobs ORDER BY id DESC LIMIT ?";
        List<Job> list = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Job(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("company"),
                            rs.getString("location"),
                            rs.getString("job_type"),     // ✅ fixed
                            rs.getString("description"),
                            rs.getString("apply_link")    // ✅ fixed
                    ));
                }
            }
        }
        return list;
    }
}
