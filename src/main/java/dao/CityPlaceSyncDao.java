package dao;

import utils.DatabaseConnection;
import java.sql.*;

public class CityPlaceSyncDao {

    public void upsert(
            String sourceType,
            int sourceId,
            String name,
            String category,
            String address,
            Double lat,
            Double lng,
            String imageUrl
    ) throws Exception {

        String sql =
          "INSERT INTO city_places " +
          "(source_type, source_id, name, category, address, latitude, longitude, image_url) " +
          "VALUES (?, ?, ?, ?, ?, ?, ?, ?) " +
          "ON DUPLICATE KEY UPDATE " +
          "name=VALUES(name), " +
          "category=VALUES(category), " +
          "address=VALUES(address), " +
          "latitude=VALUES(latitude), " +
          "longitude=VALUES(longitude), " +
          "image_url=VALUES(image_url)";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sourceType);
            ps.setInt(2, sourceId);
            ps.setString(3, name);
            ps.setString(4, category);
            ps.setString(5, address);
            ps.setObject(6, lat);
            ps.setObject(7, lng);
            ps.setString(8, imageUrl);

            ps.executeUpdate();
        }
    }

    public void delete(String sourceType, int sourceId) throws Exception {
        String sql = "DELETE FROM city_places WHERE source_type=? AND source_id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, sourceType);
            ps.setInt(2, sourceId);
            ps.executeUpdate();
        }
    }
}
