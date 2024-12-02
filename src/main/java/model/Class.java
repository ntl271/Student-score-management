package model;

public class Class {
    private String malop;
    private String tenlop;
    private String magv;
    private int siso;

    public Class() {
        super();
    }

    public Class(String malop, String tenlop, String magv, int siso) {
        super();
        this.malop = malop;
        this.tenlop = tenlop;
        this.magv = magv;
        this.siso = siso;
    }

    public String getMalop() {
        return malop;
    }

    public void setMalop(String malop) {
        this.malop = malop;
    }

    public String getTenlop() {
        return tenlop;
    }

    public void setTenlop(String tenlop) {
        this.tenlop = tenlop;
    }

    public String getMagv() {
        return magv;
    }

    public void setMagv(String magv) {
        this.magv = magv;
    }

    public int getSiso() {
        return siso;
    }

    public void setSiso(int siso) {
        this.siso = siso;
    }

    @Override
    public String toString() {
        return "Class{" +
                "malop='" + malop + '\'' +
                ", tenlop='" + tenlop + '\'' +
                ", magv='" + magv + '\'' +
                ", siso=" + siso +
                '}';
    }
}
