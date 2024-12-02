package dao;

import config.ConnectionDb;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try {
            Connection conn = ConnectionDb.getConnection();
            System.out.println("Kết nối thành công!");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            if (!rs.isBeforeFirst()) {
                System.out.println("Không có dữ liệu người dùng");
            }
            while (rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                String password = rs.getString("password");
                // Bạn cần thay đổi dòng trên nếu cấu trúc bảng users của bạn khác
                User user = new User(id, email, password);
                userList.add(user);
            }
            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public User getUserById(int id) {
        User user = null;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "SELECT * FROM users WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String email = rs.getString("email");
                String password = rs.getString("password");
                user = new User(id, email, password);
            }

            rs.close();
            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean addUser(User user) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            System.out.println("Adding user: " + user);

            String query = "INSERT INTO users (id, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, user.getId());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                success = true;
            } else {
                System.err.println("No rows inserted.");
            }

            stmt.close();
            ConnectionDb.closeConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }



    public boolean updateUser(User user) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "UPDATE users SET email = ?, password = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setInt(3, user.getId());
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

    public boolean deleteUser(int id) {
        boolean success = false;
        try {
            Connection conn = ConnectionDb.getConnection();
            String query = "DELETE FROM users WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);
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
