package dao;

import config.ConnectionDb;
import model.DiemThi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiemThiDAO {

    public List<DiemThi> getAllDiemThi() {
        List<DiemThi> diemThiList = new ArrayList<>();
        try (Connection conn = ConnectionDb.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM diemthi")) {

            while (rs.next()) {
                String mahs = rs.getString("mahs");
                String namhoc = rs.getString("namhoc");
                String tenmonhoc = rs.getString("tenmonhoc");
                double diem15pki1 = rs.getDouble("diem15pki1");
                double diemgiuaki1 = rs.getDouble("diemgiuaki1");
                double diemcuoiki1 = rs.getDouble("diemcuoiki1");
                double diemtbki1 = rs.getDouble("diemtbki1");
                double diem15pki2 = rs.getDouble("diem15pki2");
                double diemgiuaki2 = rs.getDouble("diemgiuaki2");
                double diemcuoiki2 = rs.getDouble("diemcuoiki2");
                double diemtbki2 = rs.getDouble("diemtbki2");
                DiemThi diemThi = new DiemThi(mahs, namhoc, tenmonhoc, diem15pki1, diemgiuaki1, diemcuoiki1, diemtbki1, diem15pki2, diemgiuaki2, diemcuoiki2, diemtbki2);
                diemThiList.add(diemThi);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diemThiList;
    }

    public DiemThi getDiemThiByMahs(String mahs) {
        DiemThi diemThi = null;
        String query = "SELECT * FROM diemthi WHERE mahs = ?";
        try (Connection conn = ConnectionDb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, mahs);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String namhoc = rs.getString("namhoc");
                    String tenmonhoc = rs.getString("tenmonhoc");
                    double diem15pki1 = rs.getDouble("diem15pki1");
                    double diemgiuaki1 = rs.getDouble("diemgiuaki1");
                    double diemcuoiki1 = rs.getDouble("diemcuoiki1");
                    double diemtbki1 = rs.getDouble("diemtbki1");
                    double diem15pki2 = rs.getDouble("diem15pki2");
                    double diemgiuaki2 = rs.getDouble("diemgiuaki2");
                    double diemcuoiki2 = rs.getDouble("diemcuoiki2");
                    double diemtbki2 = rs.getDouble("diemtbki2");
                    diemThi = new DiemThi(mahs, namhoc, tenmonhoc, diem15pki1, diemgiuaki1, diemcuoiki1, diemtbki1, diem15pki2, diemgiuaki2, diemcuoiki2, diemtbki2);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diemThi;
    }

    public List<String> getDistinctNamHoc(String mahs) {
        List<String> namhocList = new ArrayList<>();
        String query = "SELECT DISTINCT namhoc FROM diemthi WHERE mahs = ?";
        try (Connection conn = ConnectionDb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, mahs);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    namhocList.add(rs.getString("namhoc"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return namhocList;
    }

    public List<DiemThi> getDiemThiByMahsAndNamhoc(String mahs, String namhoc) {
        List<DiemThi> diemThiList = new ArrayList<>();
        String query = "SELECT * FROM diemthi WHERE mahs = ? AND namhoc = ?";
        try (Connection conn = ConnectionDb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, mahs);
            stmt.setString(2, namhoc);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String tenmonhoc = rs.getString("tenmonhoc");
                    double diem15pki1 = rs.getDouble("diem15pki1");
                    double diemgiuaki1 = rs.getDouble("diemgiuaki1");
                    double diemcuoiki1 = rs.getDouble("diemcuoiki1");
                    double diemtbki1 = rs.getDouble("diemtbki1");
                    double diem15pki2 = rs.getDouble("diem15pki2");
                    double diemgiuaki2 = rs.getDouble("diemgiuaki2");
                    double diemcuoiki2 = rs.getDouble("diemcuoiki2");
                    double diemtbki2 = rs.getDouble("diemtbki2");
                    DiemThi diemThi = new DiemThi(mahs, namhoc, tenmonhoc, diem15pki1, diemgiuaki1, diemcuoiki1, diemtbki1, diem15pki2, diemgiuaki2, diemcuoiki2, diemtbki2);
                    diemThiList.add(diemThi);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return diemThiList;
    }

    public boolean addDiemThi(DiemThi diemThi) {
        String query = "INSERT INTO diemthi (mahs, namhoc, tenmonhoc, diem15pki1, diemgiuaki1, diemcuoiki1, diemtbki1, diem15pki2, diemgiuaki2, diemcuoiki2, diemtbki2) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionDb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, diemThi.getMahs());
            stmt.setString(2, diemThi.getNamhoc());
            stmt.setString(3, diemThi.getTenmonhoc());
            stmt.setDouble(4, diemThi.getDiem15pki1());
            stmt.setDouble(5, diemThi.getDiemgiuaki1());
            stmt.setDouble(6, diemThi.getDiemcuoiki1());
            stmt.setDouble(7, diemThi.getDiemtbki1());
            stmt.setDouble(8, diemThi.getDiem15pki2());
            stmt.setDouble(9, diemThi.getDiemgiuaki2());
            stmt.setDouble(10, diemThi.getDiemcuoiki2());
            stmt.setDouble(11, diemThi.getDiemtbki2());

            int rowsInserted = stmt.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean updateDiemThi(DiemThi diemThi) {
        String sql = "UPDATE diemthi SET diem15pki1 = ?, diemgiuaki1 = ?, diemcuoiki1 = ?, diemtbki1 = ?, diem15pki2 = ?, diemgiuaki2 = ?, diemcuoiki2 = ?, diemtbki2 = ? WHERE mahs = ? AND namhoc = ? AND tenmonhoc = ?";
        try (Connection conn = ConnectionDb.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, diemThi.getDiem15pki1());
            stmt.setDouble(2, diemThi.getDiemgiuaki1());
            stmt.setDouble(3, diemThi.getDiemcuoiki1());
            stmt.setDouble(4, calculateAverage(diemThi.getDiem15pki1(), diemThi.getDiemgiuaki1(), diemThi.getDiemcuoiki1()));
            stmt.setDouble(5, diemThi.getDiem15pki2());
            stmt.setDouble(6, diemThi.getDiemgiuaki2());
            stmt.setDouble(7, diemThi.getDiemcuoiki2());
            stmt.setDouble(8, calculateAverage(diemThi.getDiem15pki2(), diemThi.getDiemgiuaki2(), diemThi.getDiemcuoiki2()));
            stmt.setString(9, diemThi.getMahs());
            stmt.setString(10, diemThi.getNamhoc());
            stmt.setString(11, diemThi.getTenmonhoc());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private double calculateAverage(double score1, double score2, double score3) {
        return (score1 + score2 + score3) / 3.0;
    }

    public boolean deleteDiemThi(String mahs) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "DELETE FROM diemthi WHERE mahs = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, mahs);
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
