package model;

public class Teacher {
    String magv;
    String hoten;
    String ngaysinh;
    String monday;
    String email;
    String sdt;

    public Teacher(String magv, String hoten, String ngaysinh, String monday, String email, String sdt) {
        super();
        this.magv = magv;
        this.hoten = hoten;
        this.ngaysinh = ngaysinh;
        this.monday = monday;
        this.email = email;
        this.sdt = sdt;
    }

    public Teacher(String hoten, String ngaysinh, String monday, String email, String sdt) {
        super();
        this.hoten = hoten;
        this.ngaysinh = ngaysinh;
        this.monday = monday;
        this.email = email;
        this.sdt = sdt;
    }

    public String getMagv() {
        return magv;
    }

    public void setMagv(String magv) {
        this.magv = magv;
    }

    // Getter and Setter for hoten
    public String getHoten() {
        return hoten;
    }

    public void setHoten(String hoten) {
        this.hoten = hoten;
    }

    // Getter and Setter for ngaysinh
    public String getNgaysinh() {
        return ngaysinh;
    }

    public void setNgaysinh(String ngaysinh) {
        this.ngaysinh = ngaysinh;
    }

    // Getter and Setter for monday
    public String getMonday() {
        return monday;
    }

    public void setMonday(String monday) {
        this.monday = monday;
    }

    // Getter and Setter for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter and Setter for sdt
    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String toString() {
        return "Teacher{" +
                "magv='" + magv + '\'' +
                ", hoten='" + hoten + '\'' +
                ", ngaysinh='" + ngaysinh + '\'' +
                ", monday='" + monday + '\'' +
                ", email='" + email + '\'' +
                ", sdt='" + sdt + '\'' +
                '}';
    }
}
