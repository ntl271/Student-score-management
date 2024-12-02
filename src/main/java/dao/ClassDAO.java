package dao;

import config.ConnectionDb;
import model.Class;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClassDAO {

    public List<Class> getAllClasses() {
        List<Class> classList = new ArrayList<>();
        try {
            Connection conn = ConnectionDb.getConnection();
            System.out.println("Kết nối thành công!");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM lop");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String malop = rs.getString("malop");
                String tenlop = rs.getString("tenlop");
                String magv = rs.getString("magv");
                int siso = rs.getInt("siso");

                // Create a new Class object and set its properties
                Class lop = new Class();
                lop.setMalop(malop);
                lop.setTenlop(tenlop);
                lop.setMagv(magv);
                lop.setSiso(siso);

                // Add the Class object to the list
                classList.add(lop);
            }
            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classList;
    }

    public List<Class> getAllClassesWithStudentCount() {
        List<Class> classList = new ArrayList<>();
        String query = "SELECT l.malop, l.tenlop, l.magv, COUNT(h.malop) AS siso " +
                "FROM lop l LEFT JOIN hocsinh h ON l.malop = h.malop " +
                "GROUP BY l.malop, l.tenlop, l.magv";

        try (Connection con = ConnectionDb.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Class clazz = new Class();
                clazz.setMalop(rs.getString("malop"));
                clazz.setTenlop(rs.getString("tenlop"));
                clazz.setMagv(rs.getString("magv"));
                clazz.setSiso(rs.getInt("siso"));
                classList.add(clazz);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return classList;
    }

    public boolean addClass(Class lop) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "INSERT INTO lop (malop, tenlop, magv, siso) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, lop.getMalop());
            stmt.setString(2, lop.getTenlop());
            stmt.setString(3, lop.getMagv());
            stmt.setInt(4, lop.getSiso());
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                success = true;
            }
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public Class getClassByMalop(String malop) {
        Class clazz = null;
        try (Connection connection = ConnectionDb.getConnection();
             PreparedStatement ps = connection.prepareStatement("SELECT * FROM lop WHERE malop = ?")) {
            ps.setString(1, malop);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    clazz = new Class();
                    clazz.setMalop(rs.getString("malop"));
                    clazz.setTenlop(rs.getString("tenlop"));
                    clazz.setMagv(rs.getString("magv"));
                    clazz.setSiso(rs.getInt("siso"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clazz;
    }

    public boolean updateClass(Class clazz) {
        boolean rowUpdated = false;
        try (Connection connection = ConnectionDb.getConnection();
             PreparedStatement ps = connection.prepareStatement("UPDATE lop SET tenlop = ?, magv = ?, siso = ? WHERE malop = ?")) {

            ps.setString(1, clazz.getTenlop());
            ps.setString(2, clazz.getMagv());
            ps.setInt(3, clazz.getSiso());
            ps.setString(4, clazz.getMalop());

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                rowUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }


    public boolean deleteClass(String malop) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "DELETE FROM lop WHERE malop = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, malop);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                success = true;
            }
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}
