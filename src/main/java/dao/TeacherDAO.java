package dao;

import config.ConnectionDb;
import model.Teacher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {

    public List<Teacher> getAllTeachers() {
        List<Teacher> teacherList = new ArrayList<>();
        try {
            Connection conn = ConnectionDb.getConnection();
            System.out.println("Kết nối thành công!");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM giaovien");
            if (!rs.isBeforeFirst()) {
                System.out.println("Không có dữ liệu giáo viên");
            }
            while (rs.next()) {
                String magv = rs.getString("magv");
                String hoten = rs.getString("hoten");
                String ngaysinh = rs.getString("ngaysinh");
                String monday = rs.getString("monday");
                String email = rs.getString("email");
                String sdt = rs.getString("sdt");
                Teacher teacher = new Teacher(magv, hoten, ngaysinh, monday, email, sdt);
                teacherList.add(teacher);
            }
            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacherList;
    }

    public boolean addTeacher(Teacher teacher) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "INSERT INTO giaovien (magv, hoten, ngaysinh, monday, email, sdt) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, teacher.getMagv());
            stmt.setString(2, teacher.getHoten());
            stmt.setString(3, teacher.getNgaysinh());
            stmt.setString(4, teacher.getMonday());
            stmt.setString(5, teacher.getEmail());
            stmt.setString(6, teacher.getSdt());
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

    public Teacher getTeacherByMagv(String magv) {
        Teacher teacher = null;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "SELECT * FROM giaovien WHERE magv = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, magv);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hoten = rs.getString("hoten");
                String ngaysinh = rs.getString("ngaysinh");
                String monday = rs.getString("monday");
                String email = rs.getString("email");
                String sdt = rs.getString("sdt");
                teacher = new Teacher(magv, hoten, ngaysinh, monday, email, sdt);
            }

            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacher;
    }

    public boolean updateTeacher(Teacher teacher) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "UPDATE giaovien SET hoten = ?, ngaysinh = ?, monday = ?, email = ?, sdt = ? WHERE magv = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, teacher.getHoten());
            stmt.setString(2, teacher.getNgaysinh());
            stmt.setString(3, teacher.getMonday());
            stmt.setString(4, teacher.getEmail());
            stmt.setString(5, teacher.getSdt());
            stmt.setString(6, teacher.getMagv());
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

    public boolean deleteTeacher(String magv) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "DELETE FROM giaovien WHERE magv = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, magv);
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
