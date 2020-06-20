package models;

public class Budget {
	private int budget_id;
	private String budget_name;
	private String starting_date;
	private String ending_date;
	private double amount;

	public Budget(int budget_id, String budget_name, String starting_date, String ending_date, double amount) {
		super();
		this.budget_name = budget_name;
		this.starting_date = starting_date;
		this.ending_date = ending_date;
		this.amount = amount;
		this.budget_id = budget_id;
	}

	public Budget(String budget_name, String starting_date, String ending_date, double amount) {
		super();
		this.budget_name = budget_name;
		this.starting_date = starting_date;
		this.ending_date = ending_date;
		this.amount = amount;
	}

	public String getBudget_name() {
		return budget_name;
	}

	public void setBudget_name(String budget_name) {
		this.budget_name = budget_name;
	}

	public String getStarting_date() {
		return starting_date;
	}

	public void setStarting_date(String starting_date) {
		this.starting_date = starting_date;
	}

	public String getEnding_date() {
		return ending_date;
	}

	public void setEnding_date(String ending_date) {
		this.ending_date = ending_date;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getBudget_id() {
		return budget_id;
	}

	public void setBudget_id(int budget_id) {
		this.budget_id = budget_id;
	}

	

}
