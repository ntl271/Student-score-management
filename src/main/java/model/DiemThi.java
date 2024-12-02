package model;

public class DiemThi {
    private String mahs;
    private String namhoc;
    private String tenmonhoc;
    private double diem15pki1;
    private double diemgiuaki1;
    private double diemcuoiki1;
    private double diemtbki1;
    private double diem15pki2;
    private double diemgiuaki2;
    private double diemcuoiki2;
    private double diemtbki2;

    // Constructor
    public DiemThi(String mahs, String namhoc, String tenmonhoc,
                   double diem15pki1, double diemgiuaki1, double diemcuoiki1, double diemtbki1,
                   double diem15pki2, double diemgiuaki2, double diemcuoiki2, double diemtbki2) {
        this.mahs = mahs;
        this.namhoc = namhoc;
        this.tenmonhoc = tenmonhoc;
        this.diem15pki1 = diem15pki1;
        this.diemgiuaki1 = diemgiuaki1;
        this.diemcuoiki1 = diemcuoiki1;
        this.diemtbki1 = diemtbki1;
        this.diem15pki2 = diem15pki2;
        this.diemgiuaki2 = diemgiuaki2;
        this.diemcuoiki2 = diemcuoiki2;
        this.diemtbki2 = diemtbki2;
    }

    // Getters and Setters
    public String getMahs() {
        return mahs;
    }

    public void setMahs(String mahs) {
        this.mahs = mahs;
    }

    public String getNamhoc() {
        return namhoc;
    }

    public void setNamhoc(String namhoc) {
        this.namhoc = namhoc;
    }

    public String getTenmonhoc() {
        return tenmonhoc;
    }

    public void setTenmonhoc(String tenmonhoc) {
        this.tenmonhoc = tenmonhoc;
    }

    public double getDiem15pki1() {
        return diem15pki1;
    }

    public void setDiem15pki1(double diem15pki1) {
        this.diem15pki1 = diem15pki1;
    }

    public double getDiemgiuaki1() {
        return diemgiuaki1;
    }

    public void setDiemgiuaki1(double diemgiuaki1) {
        this.diemgiuaki1 = diemgiuaki1;
    }

    public double getDiemcuoiki1() {
        return diemcuoiki1;
    }

    public void setDiemcuoiki1(double diemcuoiki1) {
        this.diemcuoiki1 = diemcuoiki1;
    }

    public double getDiemtbki1() {
        return diemtbki1;
    }

    public void setDiemtbki1(double diemtbki1) {
        this.diemtbki1 = diemtbki1;
    }

    public double getDiem15pki2() {
        return diem15pki2;
    }

    public void setDiem15pki2(double diem15pki2) {
        this.diem15pki2 = diem15pki2;
    }

    public double getDiemgiuaki2() {
        return diemgiuaki2;
    }

    public void setDiemgiuaki2(double diemgiuaki2) {
        this.diemgiuaki2 = diemgiuaki2;
    }

    public double getDiemcuoiki2() {
        return diemcuoiki2;
    }

    public void setDiemcuoiki2(double diemcuoiki2) {
        this.diemcuoiki2 = diemcuoiki2;
    }

    public double getDiemtbki2() {
        return diemtbki2;
    }

    public void setDiemtbki2(double diemtbki2) {
        this.diemtbki2 = diemtbki2;
    }
}

