package dao;

import models.CityPlace;
import utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CityPlaceDao {

    public List<CityPlace> getAll() throws Exception {
        List<CityPlace> list = new ArrayList<>();
        String sql = "SELECT * FROM city_places ORDER BY id DESC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public List<CityPlace> search(String q) throws Exception {
        List<CityPlace> list = new ArrayList<>();

        String sql =
                "SELECT * FROM city_places " +
                "WHERE LOWER(name) LIKE ? " +
                "   OR LOWER(category) LIKE ? " +
                "   OR LOWER(address) LIKE ? " +
                "   OR LOWER(description) LIKE ? " +
                "ORDER BY id DESC";

        String like = "%" + (q == null ? "" : q.toLowerCase()) + "%";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            ps.setString(4, like);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
    private CityPlace mapRow(ResultSet rs) throws Exception {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String category = rs.getString("category");
        String address = rs.getString("address");
        String description = rs.getString("description");

        double lat = rs.getDouble("latitude");
        double lng = rs.getDouble("longitude");

        return new CityPlace(id, name, category, address, description, lat, lng);
    }


    private double toDouble(Object value) {
        if (value == null) return 0.0;

        if (value instanceof Double) return (Double) value;
        if (value instanceof Float) return ((Float) value).doubleValue();
        if (value instanceof Integer) return ((Integer) value).doubleValue();
        if (value instanceof Long) return ((Long) value).doubleValue();
        if (value instanceof BigDecimal) return ((BigDecimal) value).doubleValue();

        // fallback (rare)
        return Double.parseDouble(value.toString());
    }
}
