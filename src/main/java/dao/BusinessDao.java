package dao;

import models.Business;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BusinessDao {

    public List<Business> getAll() throws SQLException, ClassNotFoundException {
        List<Business> list = new ArrayList<>();

        String sql = "SELECT * FROM business ORDER BY id ASC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Business(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("contact_email") // ✅ FIXED
                ));
            }
        }
        return list;
    }

    public Business getById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM business WHERE id = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Business(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("contact_email") // ✅ FIXED
                );
            }
        }
        return null;
    }

    public void insert(Business b) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO business (name, category, location, description, contact_email) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, b.getName());
            ps.setString(2, b.getCategory());
            ps.setString(3, b.getLocation());
            ps.setString(4, b.getDescription());
            ps.setString(5, b.getContactEmail());

            ps.executeUpdate();
        }
    }

    public void update(Business b) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE business SET name=?, category=?, location=?, description=?, contact_email=? WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, b.getName());
            ps.setString(2, b.getCategory());
            ps.setString(3, b.getLocation());
            ps.setString(4, b.getDescription());
            ps.setString(5, b.getContactEmail());
            ps.setInt(6, b.getId());

            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM business WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int countAll() throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM business";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);
        }
    }

    public List<Business> getLatest(int limit) throws SQLException, ClassNotFoundException {
        List<Business> list = new ArrayList<>();
        String sql = "SELECT * FROM business ORDER BY id DESC LIMIT ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Business(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("contact_email") // ✅ FIXED
                ));
            }
        }
        return list;
    }
}
