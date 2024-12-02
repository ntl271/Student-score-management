package model;

public class Student {
    String mahs;
    String hovaten;
    String ngaysinh;
    String malop;
    String diachi;
    String sdt;
    String gvcn;

    public Student(String mahs, String hovaten, String ngaysinh, String malop, String diachi, String sdt, String gvcn) {
        super();
        this.mahs = mahs;
        this.hovaten = hovaten;
        this.ngaysinh = ngaysinh;
        this.malop = malop;
        this.diachi = diachi;
        this.sdt = sdt;
        this.gvcn = gvcn;
    }

    public Student( String hovaten, String ngaysinh, String malop, String diachi, String sdt, String gvcn) {
        super();
        this.hovaten = hovaten;
        this.ngaysinh = ngaysinh;
        this.malop = malop;
        this.diachi = diachi;
        this.sdt = sdt;
        this.gvcn = gvcn;
    }

    public String getMahs() {
        return mahs;
    }

    public void setMahs(String mahs) {
        this.mahs = mahs;
    }

    public String getHovaten() {
        return hovaten;
    }

    public void setHovaten(String hovaten) {
        this.hovaten = hovaten;
    }

    public String getNgaysinh() {
        return ngaysinh;
    }

    public void setNgaysinh(String ngaysinh) {
        this.ngaysinh = ngaysinh;
    }

    public String getMalop() {
        return malop;
    }

    public void setMalop(String malop) {
        this.malop = malop;
    }

    public String getDiachi() {
        return diachi;
    }

    public void setDiachi(String diachi) {
        this.diachi = diachi;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getGvcn() {
        return gvcn;
    }

    public void setGvcn(String gvcn) {
        this.gvcn = gvcn;
    }

    @Override
    public String toString() {
        return "Student{" +
                "mahs='" + mahs + '\'' +
                ", hovaten='" + hovaten + '\'' +
                ", ngaysinh='" + ngaysinh + '\'' +
                ", malop='" + malop + '\'' +
                ", diachi='" + diachi + '\'' +
                ", sdt='" + sdt + '\'' +
                ", gvcn='" + gvcn + '\'' +
                '}';
    }
}
