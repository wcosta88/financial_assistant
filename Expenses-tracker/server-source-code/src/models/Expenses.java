package models;

public class Expenses {
	private int expenses_id;
	private String expenses_name;
	private String expenses_date;
	private double amount;

	public Expenses(int expenses_id, String expenses_name, String expenses_date, double amount) {
		super();
		this.expenses_name = expenses_name;
		this.expenses_date = expenses_date;
		this.amount = amount;
		this.expenses_id = expenses_id;
	}
	public Expenses( String expenses_name, String expenses_date, double amount) {
		super();
		this.expenses_name = expenses_name;
		this.expenses_date = expenses_date;
		this.amount = amount;
	}
	public String getExpenses_name() {
		return expenses_name;
	}

	public void setExpenses_name(String expenses_nae) {
		this.expenses_name = expenses_nae;
	}

	public String getExpenses_date() {
		return expenses_date;
	}

	public void setExpenses_date(String expenses_date) {
		this.expenses_date = expenses_date;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getExpenses_id() {
		return expenses_id;
	}

	public void setExpenses_id(int expenses_id) {
		this.expenses_id = expenses_id;
	}

}
