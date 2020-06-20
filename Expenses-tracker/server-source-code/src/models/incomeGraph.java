package models;


public class incomeGraph {
	private int month;
	private double income;
	public incomeGraph(int month, double income) {
		super();
		this.month = month;
		this.income = income;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public double getIncome() {
		return income;
	}
	public void setIncome(double income) {
		this.income = income;
	}
	
}
