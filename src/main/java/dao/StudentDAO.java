package dao;

import config.ConnectionDb;
import model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    public List<Student> getAllStudents() {
        List<Student> studentList = new ArrayList<>();
        try {
            Connection conn = ConnectionDb.getConnection();
            System.out.println("Kết nối thành công!");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM hocsinh");
            if (!rs.isBeforeFirst()) {
                System.out.println("Không có dữ liệu sinh viên");
            }
            while (rs.next()) {
                String mahs = rs.getString("mahs");
                String hovaten = rs.getString("hovaten");
                String ngaysinh = rs.getString("ngaysinh");
                String malop = rs.getString("malop");
                String diachi = rs.getString("diachi");
                String sdt = rs.getString("sdt");
                String gvcn = rs.getString("gvcn");
                Student student = new Student(mahs, hovaten, ngaysinh, malop, diachi, sdt, gvcn);
                studentList.add(student);
            }
            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return studentList;
    }

    public boolean addStudent(Student student) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "INSERT INTO hocsinh (mahs, hovaten, ngaysinh, malop, diachi, sdt, gvcn) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, student.getMahs());
            stmt.setString(2, student.getHovaten());
            stmt.setString(3, student.getNgaysinh());
            stmt.setString(4, student.getMalop());
            stmt.setString(5, student.getDiachi());
            stmt.setString(6, student.getSdt());
            stmt.setString(7, student.getGvcn());
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

    public Student getStudentByMahs(String mahs) {
        Student student = null;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "SELECT * FROM hocsinh WHERE mahs = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, mahs);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hovaten = rs.getString("hovaten");
                String ngaysinh = rs.getString("ngaysinh");
                String malop = rs.getString("malop");
                String diachi = rs.getString("diachi");
                String sdt = rs.getString("sdt");
                String gvcn = rs.getString("gvcn");
                student = new Student(mahs, hovaten, ngaysinh, malop, diachi, sdt, gvcn);
            }

            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }


    public boolean updateStudent(Student student) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "UPDATE hocsinh SET hovaten = ?, ngaysinh = ?, malop = ?, diachi = ?, sdt = ?, gvcn = ? WHERE mahs = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, student.getHovaten());
            stmt.setString(2, student.getNgaysinh());
            stmt.setString(3, student.getMalop());
            stmt.setString(4, student.getDiachi());
            stmt.setString(5, student.getSdt());
            stmt.setString(6, student.getGvcn());
            stmt.setString(7, student.getMahs());
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

    public boolean deleteStudent(String mahs) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "DELETE FROM hocsinh WHERE mahs = ?";
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

//    public List<Student> searchStudent(String searchTerm) {
//        List<Student> studentList = new ArrayList<>();
//        try {
//            Connection conn = ConnectionDb.getConnection();
//            String query = "SELECT * FROM hocsinh WHERE hovaten LIKE ?";
//            PreparedStatement stmt = conn.prepareStatement(query);
//            stmt.setString(1, "%" + searchTerm + "%");
//            ResultSet rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                String mahs = rs.getString("mahs");
//                String hovaten = rs.getString("hovaten");
//                String ngaysinh = rs.getString("ngaysinh");
//                String malop = rs.getString("malop");
//                String diachi = rs.getString("diachi");
//                String sdt = rs.getString("sdt");
//                String gvcn = rs.getString("gvcn");
//                Student student = new Student(mahs, hovaten, ngaysinh, malop, diachi, sdt, gvcn);
//                studentList.add(student);
//            }
//
//            rs.close();
//            stmt.close();
//            ConnectionDb.closeConnection();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return studentList;
//    }
}
