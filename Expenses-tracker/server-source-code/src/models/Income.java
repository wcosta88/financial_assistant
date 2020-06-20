package models;

public class Income {
	private int income_id;
	private String income_name;
	private String trasaction_date;
	private double amount;

	public Income(int income_id, String income_name, String trasaction_date, double amount) {
		super();
		this.income_id = income_id;
		this.income_name = income_name;
		this.trasaction_date = trasaction_date;
		this.amount = amount;
	}

	public Income(String income_name, String trasaction_date, double amount) {
		super();
		this.income_name = income_name;
		this.trasaction_date = trasaction_date;
		this.amount = amount;
	}

	public String getIncome_name() {
		return income_name;
	}

	public void setIncome_name(String income_name) {
		this.income_name = income_name;
	}

	public String getTrasaction_date() {
		return trasaction_date;
	}

	public void setTrasaction_date(String trasaction_date) {
		this.trasaction_date = trasaction_date;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getIncome_id() {
		return income_id;
	}

	public void setIncome_id(int income_id) {
		this.income_id = income_id;
	}

}
