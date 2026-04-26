package dao;

import models.User;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public User loginApprovedUser(String username, String password) throws Exception {
        String sql = "SELECT * FROM users WHERE username=? AND password=? AND status='APPROVED'";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("role"),
                            rs.getString("email"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

    public boolean usernameExists(String username) throws Exception {
        String sql = "SELECT id FROM users WHERE username=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void registerPendingUser(User u) throws Exception {
        String sql = "INSERT INTO users(username,password,role,email,status) VALUES(?,?,?,?,?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getRole());      // USER
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getStatus());    // PENDING
            ps.executeUpdate();
        }
    }
    
    public boolean emailExists(String email) throws Exception {
        String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
    public boolean createResetToken(String email, String token, int minutes)
            throws Exception {

        String sql = "UPDATE users SET reset_token=?, reset_token_expiry=DATE_ADD(NOW(), INTERVAL ? MINUTE) WHERE email=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.setInt(2, minutes);
            ps.setString(3, email);

            return ps.executeUpdate() > 0; // true only if email exists
        }
    }

    public boolean resetPasswordWithToken(String token, String newPassword)
            throws Exception {

        // 1) check token valid + not expired
        String check = "SELECT id FROM users WHERE reset_token=? AND reset_token_expiry > NOW()";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(check)) {

            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return false;
            }

            // 2) update password + clear token
            String upd = "UPDATE users SET password=?, reset_token=NULL, reset_token_expiry=NULL WHERE reset_token=?";
            try (PreparedStatement ps2 = con.prepareStatement(upd)) {
                ps2.setString(1, newPassword); // (you can hash later)
                ps2.setString(2, token);
                return ps2.executeUpdate() > 0;
            }
        }
    }


    public List<User> getAllUsers() throws Exception {
        String sql = "SELECT * FROM users ORDER BY id DESC";
        List<User> list = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getString("status")
                ));
            }
        }
        return list;
    }

    public void approveUser(int id) throws Exception {
        String sql = "UPDATE users SET status='APPROVED' WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void rejectUser(int id) throws Exception {
        String sql = "UPDATE users SET status='REJECTED' WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void deleteUser(int id) throws Exception {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
