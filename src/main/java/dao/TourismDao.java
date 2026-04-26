package dao;

import models.Tourism;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TourismDao {

    // -------------------- READ --------------------
    public List<Tourism> getAll() throws SQLException, ClassNotFoundException {
        List<Tourism> list = new ArrayList<>();
        String sql = "SELECT * FROM tourism ORDER BY id ASC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Tourism getById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM tourism WHERE id = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public int countAll() throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM tourism";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);
        }
    }

    public List<Tourism> getLatest(int limit) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM tourism ORDER BY id DESC LIMIT ?";
        List<Tourism> list = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // -------------------- WRITE + SYNC --------------------

    public void insert(Tourism t) throws Exception {
        String sql = "INSERT INTO tourism (name, location, description, image_url, latitude, longitude) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, t.getName());
            ps.setString(2, t.getLocation());
            ps.setString(3, t.getDescription());
            ps.setString(4, t.getImageUrl());
            ps.setObject(5, t.getLatitude());   // Double or null
            ps.setObject(6, t.getLongitude());  // Double or null

            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    int newId = keys.getInt(1);

                    // ✅ sync into city_places
                    upsertCityPlace("TOURISM", newId,
                            t.getName(),
                            "Tourism",
                            t.getLocation(),      // goes into address
                            t.getDescription(),
                            t.getLatitude(),
                            t.getLongitude()
                    );
                }
            }
        }
    }

    private void upsertCityPlace(String sourceType, int newId, String name, String category, String location,
			String description, Object latitude, Object longitude) {
		// TODO Auto-generated method stub
		
	}

	public void update(Tourism t) throws Exception {
        String sql = "UPDATE tourism SET name=?, location=?, description=?, image_url=?, latitude=?, longitude=? WHERE id=?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getName());
            ps.setString(2, t.getLocation());
            ps.setString(3, t.getDescription());
            ps.setString(4, t.getImageUrl());
            ps.setObject(5, t.getLatitude());
            ps.setObject(6, t.getLongitude());
            ps.setInt(7, t.getId());

            ps.executeUpdate();
        }

        // ✅ sync into city_places after update
        upsertCityPlace("TOURISM", t.getId(),
                t.getName(),
                "Tourism",
                t.getLocation(),
                t.getDescription(),
                t.getLatitude(),
                t.getLongitude()
        );
    }

    public void delete(int id) throws Exception {
        // ✅ delete from city_places first
        deleteCityPlace("TOURISM", id);

        String sql = "DELETE FROM tourism WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // -------------------- CITY PLACES SYNC HELPERS --------------------

    private void upsertCityPlace(String sourceType, int sourceId,
                                 String name, String category, String address,
                                 String description, Double lat, Double lng) throws Exception {

        String sql =
                "INSERT INTO city_places (source_type, source_id, name, category, address, description, latitude, longitude) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE " +
                "name=VALUES(name), category=VALUES(category), address=VALUES(address), description=VALUES(description), " +
                "latitude=VALUES(latitude), longitude=VALUES(longitude)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sourceType);
            ps.setInt(2, sourceId);
            ps.setString(3, name);
            ps.setString(4, category);
            ps.setString(5, address);
            ps.setString(6, description);
            ps.setObject(7, lat);
            ps.setObject(8, lng);

            ps.executeUpdate();
        }
    }

    private void deleteCityPlace(String sourceType, int sourceId) throws Exception {
        String sql = "DELETE FROM city_places WHERE source_type=? AND source_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sourceType);
            ps.setInt(2, sourceId);
            ps.executeUpdate();
        }
    }

    // -------------------- MAP ROW --------------------
    private Tourism mapRow(ResultSet rs) throws SQLException {
        Tourism t = new Tourism(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("location"),
                rs.getString("description"),
                rs.getString("image_url")
        );

        // If your Tourism model supports lat/lng:
        try {
            double lat = rs.getDouble("latitude");
            if (!rs.wasNull()) t.setLatitude(lat);

            double lng = rs.getDouble("longitude");
            if (!rs.wasNull()) t.setLongitude(lng);
        } catch (SQLException ignore) {
            // column not found -> ignore
        }

        return t;
    }
}
