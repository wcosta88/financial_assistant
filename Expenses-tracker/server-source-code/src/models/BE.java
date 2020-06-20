package models;

public class BE {
	private String name;
	private double eamount;
	private double bamount;
	private double remain;
	public double getRemain() {
		return remain;
	}

	public void setRemain(double remain) {
		this.remain = remain;
	}

	public BE(String name, double eamount, double bamount) {
		super();
		this.name = name;
		this.eamount = eamount;
		this.bamount = bamount;
		remain=this.bamount-this.eamount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getEamount() {
		return eamount;
	}

	public void setEamount(double eamount) {
		this.eamount = eamount;
	}

	public double getBamount() {
		return bamount;
	}

	public void setBamount(double bamount) {
		this.bamount = bamount;
	}

}
