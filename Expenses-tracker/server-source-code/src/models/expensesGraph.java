package models;

public class expensesGraph {
	private int month;
	private double amount;
	public expensesGraph(int month, double amount) {
		super();
		this.month = month;
		this.amount = amount;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	
}
