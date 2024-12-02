package dao;

import config.ConnectionDb;
import model.Subject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {
    public List<Subject> getAllSubjects() {
        List<Subject> subjectList = new ArrayList<>();
        try {
            Connection conn = ConnectionDb.getConnection();
            System.out.println("Kết nối thành công!");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM monhoc");
            if (!rs.isBeforeFirst()) {
                System.out.println("Không có dữ liệu môn học");
            }
            while (rs.next()) {
                String mamh = rs.getString("mamh");
                String tenmonhoc = rs.getString("tenmonhoc");
                int sotiet = rs.getInt("sotiet");
                String hinhthucthi = rs.getString("hinhthucthi");
                Subject subject = new Subject(mamh, tenmonhoc, sotiet, hinhthucthi);
                subjectList.add(subject);
            }
            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjectList;
    }

    public boolean addSubject(Subject subject) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "INSERT INTO monhoc (mamh, tenmonhoc, sotiet, hinhthucthi) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, subject.getMamh());
            stmt.setString(2, subject.getTenmonhoc());
            stmt.setInt(3, subject.getSotiet());
            stmt.setString(4, subject.getHinhthucthi());
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

    public Subject getSubjectByMamh(String mamh) {
        Subject subject = null;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "SELECT * FROM monhoc WHERE mamh = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, mamh);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String tenmonhoc = rs.getString("tenmonhoc");
                int sotiet = rs.getInt("sotiet");
                String hinhthucthi = rs.getString("hinhthucthi");
                subject = new Subject(mamh, tenmonhoc, sotiet, hinhthucthi);
            }

            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subject;
    }

    public boolean updateSubject(Subject subject) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "UPDATE monhoc SET tenmonhoc = ?, sotiet = ?, hinhthucthi = ? WHERE mamh = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, subject.getTenmonhoc());
            stmt.setInt(2, subject.getSotiet());
            stmt.setString(3, subject.getHinhthucthi());
            stmt.setString(4, subject.getMamh());
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public boolean deleteSubject(String mamh) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "DELETE FROM monhoc WHERE mamh = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, mamh);
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
