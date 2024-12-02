package model;

public class User {
    private int id;
    private String email;
    private String password;

    public User(int id, String email, String password) {
        super();
        this.id = id;
        this.email = email;
        this.password = password;
    }

    public User(String email, String password) {
        super();
        this.email = email;
        this.password = password;
    }

    // Getter and Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter and Setter for password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
