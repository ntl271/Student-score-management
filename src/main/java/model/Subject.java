package model;

public class Subject {
    String mamh;
    String tenmonhoc;
    int sotiet;
    String hinhthucthi;

    public Subject(String mamh, String tenmonhoc, int sotiet, String hinhthucthi) {
        super();
        this.mamh = mamh;
        this.tenmonhoc = tenmonhoc;
        this.sotiet = sotiet;
        this.hinhthucthi = hinhthucthi;
    }

    public Subject(String tenmonhoc, int sotiet, String hinhthucthi) {
        super();
        this.tenmonhoc = tenmonhoc;
        this.sotiet = sotiet;
        this.hinhthucthi = hinhthucthi;
    }

    public String getMamh() {
        return mamh;
    }

    public void setMamh(String mamh) {
        this.mamh = mamh;
    }

    public String getTenmonhoc() {
        return tenmonhoc;
    }

    public void setTenmonhoc(String tenmonhoc) {
        this.tenmonhoc = tenmonhoc;
    }

    public int getSotiet() {
        return sotiet;
    }

    public void setSotiet(int sotiet) {
        this.sotiet = sotiet;
    }

    public String getHinhthucthi() {
        return hinhthucthi;
    }

    public void setHinhthucthi(String hinhthucthi) {
        this.hinhthucthi = hinhthucthi;
    }

    @Override
    public String toString() {
        return "Subject{" +
                "mamh='" + mamh + '\'' +
                ", tenmonhoc='" + tenmonhoc + '\'' +
                ", sotiet=" + sotiet +
                ", hinhthucthi='" + hinhthucthi + '\'' +
                '}';
    }
}
