package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class Datasource {
	// DATABASE
	private static String URL = "jdbc:mysql://localhost:3306/buget_manager?useSSL=false";
	private static String USER = "root";
	private static String PASSWORD = "root";

	public Datasource() {

	}

	// GET CONNECTION
	protected Connection GetConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

	// CHECK AUTHENTICATION IS IN DATABASE
	public boolean checkAuthentication(String email_id, String password) {
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT email,password FROM user WHERE email=? AND password=md5(?);");) {
			preparedStatement.setString(1, email_id);
			preparedStatement.setString(2, password);
			ResultSet rs = preparedStatement.executeQuery();
			int i = 0;
			while (rs.next()) {
				i++;
			}
			if (i == 1) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// CHECK THE SECURITY KEY ALREADY EXIST
	public boolean SecurityKeyCheck(String security_key) {
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT security_key FROM user WHERE security_key=?;");) {
			preparedStatement.setString(1, security_key);
			ResultSet rs = preparedStatement.executeQuery();
			int i = 0;
			while (rs.next()) {
				i++;
			}
			if (i == 1) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
	}

	// CHECK THE USER ALREADY EXIST
	public boolean AlreadyExistUser(String email_id) {
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT * FROM user WHERE email=?;");) {
			preparedStatement.setString(1, email_id);
			ResultSet rs = preparedStatement.executeQuery();
			int i = 0;
			while (rs.next()) {
				i++;
			}
			if (i == 1) {
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// REGISTER THE USER
	public boolean Register(String email_id, String password, String random) {
		if (AlreadyExistUser(email_id) == false) {
			try (Connection connection = GetConnection();
					PreparedStatement preparedStatement = connection
							.prepareStatement("INSERT INTO user(email,password,security_key) VALUES(?,md5(?),?);");) {
				preparedStatement.setString(1, email_id);
				preparedStatement.setString(2, password);
				preparedStatement.setString(3, random);
				preparedStatement.executeUpdate();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		} else {
			return false;
		}
	}

	// GET SECURITY KEY
	public String getSecurityKey(String email_id) {

		String security_key = "ERROR";
		try {
			Connection connection = GetConnection();
			PreparedStatement preparedStatement = connection
					.prepareStatement("SELECT security_key FROM user WHERE email='" + email_id + "';");
			// preparedStatement.setString(1, email_id);
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				security_key = rs.getString("security_key");
			}
			System.out.println(security_key);
		} catch (Exception e) {
			e.getStackTrace();

		}
		return security_key;
	}

	// SELECT INCOME ,EXPENSES & BUDGET
	// ______________________________________________________________________________________________________________________________
	// GET THE INCOME
	public List<Income> selectAllIncome(String security_key) {
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		System.out.println(" Month : " + month);
		List<Income> income = new ArrayList<>();
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT income_id,income_name,trasaction_date, amount FROM income WHERE  security_key=? AND MONTH(trasaction_date)=?");) {
			preparedStatement.setString(1, security_key);
			preparedStatement.setInt(2, month);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int income_id = rs.getInt("income_id");
				String income_name = rs.getString("income_name");
				String transaction_date = rs.getString("trasaction_date");
				double amount = rs.getDouble("amount");
				System.out.println(income_id + " " + income_name + " " + transaction_date + " " + amount);
				income.add(new Income(income_id, income_name, transaction_date, amount));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return income;
	}

	// GET THE BUGET
	public List<Budget> selectAllBudget(String security_key) {
		List<Budget> budget = new ArrayList<>();
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT budget_id, budget_name,starting_date, ending_date,amount FROM budget WHERE  security_key=?");) {
			preparedStatement.setString(1, security_key);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int budget_id = rs.getInt("budget_id");
				String budget_name = rs.getString("budget_name");
				String starting_date = rs.getString("starting_date");
				String ending_date = rs.getString("ending_date");
				double amount = rs.getDouble("amount");
				budget.add(new Budget(budget_id, budget_name, starting_date, ending_date, amount));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return budget;
	}

	// GET THE EXPENSES
	public List<Expenses> selectAllExpenses(String security_key) {
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		List<Expenses> expenses = new ArrayList<>();
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT *FROM expenses WHERE  security_key='" + security_key
								+ "'AND MONTH(transaction_date)=" + month + " GROUP BY expenses_name;");) {
			// preparedStatement.setString(1, security_key);
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int expenses_id = rs.getInt("expenses_id");
				String expenses_name = rs.getString("expenses_name");
				String transaction_date = rs.getString("transaction_date");
				double amount = rs.getDouble("amount");
				System.out.println(expenses_id + " " + expenses_name + " " + transaction_date + " " + amount);
				expenses.add(new Expenses(expenses_id, expenses_name, transaction_date, amount));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return expenses;
	}

	// ______________________________________________________________________________________________________________________________
	// GET ONLY SELECT EXPENSES,INCOME&BUDGET
	// ______________________________________________________________________________________________________________________________
	// GET THE SELECTED INCOME
	public Income selectIncome(int income_id) {
		Income income = null;
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT income_id,income_name,trasaction_date, amount FROM income WHERE income_id=?");) {
			preparedStatement.setInt(1, income_id);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int incomeId = rs.getInt("income_id");
				String income_name = rs.getString("income_name");
				String trasaction_date = rs.getString("trasaction_date");
				double amount = rs.getDouble("amount");
				income = new Income(incomeId, income_name, trasaction_date, amount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return income;
	}

	// GET THE SELECTED BUDGET
	public Budget selectBugdet(int budget_id) {
		Budget budget = null;
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT budget_id,budget_name, starting_date, ending_date,amount FROM budget WHERE budget_id=?");) {
			preparedStatement.setInt(1, budget_id);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int budgetId = rs.getInt("budget_id");
				String budget_name = rs.getString("budget_name");
				String starting_date = rs.getString("starting_date");
				String ending_date = rs.getString("ending_date");
				double amount = rs.getDouble("amount");
				System.out.print(budgetId + " " + budget_name + " " + starting_date + " " + ending_date + " " + amount);
				budget = new Budget(budgetId, budget_name, starting_date, ending_date, amount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return budget;
	}

	// GET THE SELECTED EXPENSES
	public Expenses selectExpenses(int expenses_id) {
		Expenses expenses = null;
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT expenses_id,expenses_name, transaction_date,  amount FROM expenses WHERE expenses_id=?");) {
			preparedStatement.setInt(1, expenses_id);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int expensesId = rs.getInt("expenses_id");
				String expenses_name = rs.getString("expenses_name");
				String transaction_date = rs.getString("transaction_date");
				double amount = rs.getDouble("amount");
				expenses = new Expenses(expensesId, expenses_name, transaction_date, amount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return expenses;
	}

	// ______________________________________________________________________________________________________________________________
	// INSERT INTO THE DATABASE
	// ______________________________________________________________________________________________________________________________
	// INSERT INTO INCOME
	public void insertIncome(Income income, String security_key) throws SQLException {
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement("INSERT INTO income(income_name,trasaction_date,amount,security_key) VALUES('"
								+ income.getIncome_name() + "','" + income.getTrasaction_date() + "',"
								+ income.getAmount() + ",'" + security_key + "');")) {
//			preparedStatement.setString(1, income.getIncome_name());
//			preparedStatement.setString(2, income.getTrasaction_date());
//			preparedStatement.setDouble(3, income.getAmount());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// INSERT INTO EXPENSES
	public void insertExpenses(Expenses expenses, String security_key) throws SQLException {
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"INSERT INTO expenses(expenses_name,transaction_date,amount,security_key) VALUES('"
								+ expenses.getExpenses_name() + "','" + expenses.getExpenses_date() + "',"
								+ expenses.getAmount() + ",'" + security_key + "');")) {
//			preparedStatement.setString(1, expenses.getExpenses_name());
//			preparedStatement.setString(2, expenses.getExpenses_date());
//			preparedStatement.setDouble(3, expenses.getAmount());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (

		Exception e) {
			e.printStackTrace();
		}
	}

	// INSERT INTO BUDGET
	public void insertBUDGET(Budget budget, String security_key) throws SQLException {
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"INSERT INTO budget(budget_name,starting_date,ending_date,amount,security_key) VALUES('"
								+ budget.getBudget_name() + "','" + budget.getStarting_date() + "','"
								+ budget.getEnding_date() + "'," + budget.getAmount() + ",'" + security_key + "');")) {
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ______________________________________________________________________________________________________________________________
	// UPDATE THE SELECTED
	// ______________________________________________________________________________________________________________________________
	// UPDATE INCOME
	public boolean updateIncome(Income income) throws SQLException {
		boolean rowUpdated;
		try (Connection connection = GetConnection();
				PreparedStatement statement = connection.prepareStatement(
						"UPDATE income SET income_name=?,trasaction_date=?,amount=? WHERE income_id=?")) {
			statement.setString(1, income.getIncome_name());
			statement.setString(2, income.getTrasaction_date());
			statement.setDouble(3, income.getAmount());
			statement.setInt(4, income.getIncome_id());
			System.out.println(statement);
			rowUpdated = statement.executeUpdate() > 0;
		}
		return rowUpdated;
	}

	// UPDATE BUDGET
	public boolean updateBudget(Budget budget) throws SQLException {
		boolean rowUpdated;
		try (Connection connection = GetConnection();
				PreparedStatement statement = connection.prepareStatement(
						"UPDATE budget SET budget_name='" + budget.getBudget_name() + "',starting_date='"
								+ budget.getStarting_date() + "',ending_date='" + budget.getEnding_date() + "',amount="
								+ budget.getAmount() + " WHERE budget_id=" + budget.getBudget_id() + "")) {
//			statement.setString(1, budget.getBudget_name());
//			statement.setString(2, budget.getStarting_date());
//			statement.setString(3, budget.getEnding_date());
//			statement.setDouble(4, budget.getAmount());
//			statement.setInt(5, budget.getBudget_id());
			System.out.println(statement);
			rowUpdated = statement.executeUpdate() > 0;
		}
		return rowUpdated;
	}

	// UPDATE EXPENSES
	public boolean updateExpenses(Expenses expenses) throws SQLException {
		boolean rowUpdated;
		try (Connection connection = GetConnection();
				PreparedStatement statement = connection.prepareStatement(
						"UPDATE expenses SET expenses_name=?,transaction_date=?,amount=? WHERE expenses_id=?")) {
			statement.setString(1, expenses.getExpenses_name());
			statement.setString(2, expenses.getExpenses_date());
			statement.setDouble(3, expenses.getAmount());
			statement.setInt(4, expenses.getExpenses_id());
			rowUpdated = statement.executeUpdate() > 0;
		}
		return rowUpdated;
	}

	// ______________________________________________________________________________________________________________________________
	// DELETE DETAILS
	// ______________________________________________________________________________________________________________________________
	// DELETE INCOME
	public boolean deleteIncome(int income_id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = GetConnection();
				PreparedStatement statement = connection.prepareStatement("DELETE FROM income WHERE income_id=?");) {
			statement.setInt(1, income_id);
			rowDeleted = statement.executeUpdate() > 0;
		}
		return rowDeleted;
	}

	// DELETE EXPENSES
	public boolean deleteExpenses(int expenses_id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = GetConnection();
				PreparedStatement statement = connection
						.prepareStatement("DELETE FROM expenses WHERE expenses_id=?");) {
			statement.setInt(1, expenses_id);
			rowDeleted = statement.executeUpdate() > 0;
		}
		return rowDeleted;
	}

	// DELETE BUDGET
	public boolean deleteBudget(int budget_id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = GetConnection();
				PreparedStatement statement = connection.prepareStatement("DELETE FROM budget WHERE budget_id=?");) {
			statement.setInt(1, budget_id);
			rowDeleted = statement.executeUpdate() > 0;
		}
		return rowDeleted;
	}

	// ______________________________________________________________________________________________________________________________
	// FOR GRAPH
	// ______________________________________________________________________________________________________________________________
	public List<incomeGraph> IGgraph(String security_key) {
		List<incomeGraph> IG = new ArrayList<>();
		try {
			Connection connection = GetConnection();
			for (int i = 1; i < 13; i++) {
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT SUM(amount) FROM income WHERE security_key='" + security_key
								+ "' AND MONTH(trasaction_date)=" + i + ";");
				System.out.println(preparedStatement);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					int month = i;
					double income = rs.getDouble("SUM(amount)");
					System.out.println(i + " " + income);
					IG.add(new incomeGraph(month, income));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return IG;
	}

	public List<expensesGraph> EXgraph(String security_key) {
		List<expensesGraph> EX = new ArrayList<>();
		try {
			Connection connection = GetConnection();
			for (int i = 1; i < 13; i++) {
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT SUM(amount) FROM expenses WHERE security_key='" + security_key
								+ "' AND MONTH(transaction_date)=" + i + ";");
				System.out.println(preparedStatement);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					int month = i;
					double expenses = rs.getDouble("SUM(amount)");
					EX.add(new expensesGraph(month, expenses));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return EX;
	}

	// Year calculation
	public List<Income> selectAllIncomey(String security_key) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		int year = calendar.get(Calendar.YEAR);
		List<Income> income = new ArrayList<>();
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT income_id,income_name,trasaction_date, amount FROM income WHERE  security_key=? AND YEAR(trasaction_date)=?");) {
			preparedStatement.setString(1, security_key);
			preparedStatement.setInt(2, year);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int income_id = rs.getInt("income_id");
				String income_name = rs.getString("income_name");
				String transaction_date = rs.getString("trasaction_date");
				double amount = rs.getDouble("amount");
				System.out.println(income_id + " " + income_name + " " + transaction_date + " " + amount);
				income.add(new Income(income_id, income_name, transaction_date, amount));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return income;
	}

	public List<Expenses> selectAllExpensesy(String security_key) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		int year = calendar.get(Calendar.YEAR);
		List<Expenses> expenses = new ArrayList<>();
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection
						.prepareStatement("SELECT *FROM expenses WHERE  security_key='" + security_key
								+ "'AND YEAR(transaction_date)=" + year + " GROUP BY expenses_name;");) {
			// preparedStatement.setString(1, security_key);
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				int expenses_id = rs.getInt("expenses_id");
				String expenses_name = rs.getString("expenses_name");
				String transaction_date = rs.getString("transaction_date");
				double amount = rs.getDouble("amount");
				System.out.println(expenses_id + " " + expenses_name + " " + transaction_date + " " + amount);
				expenses.add(new Expenses(expenses_id, expenses_name, transaction_date, amount));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return expenses;
	}

	// get combined data for expenses and
	public List<BE> expenseAndbudget(String security_key) {
		List<BE> be = new ArrayList<>();
		try (Connection connection = GetConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(
						"SELECT expenses.expenses_name,SUM(expenses.amount) as eamount,SUM(budget.amount) as bamount,budget.budget_name FROM expenses INNER JOIN budget ON expenses.expenses_name=budget.budget_name WHERE expenses.security_key='"
								+ security_key + "' GROUP BY expenses.expenses_name ;");) {
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				String name = rs.getString("expenses_name");
				double eamount = rs.getDouble("eamount");
				double bamount = rs.getDouble("bamount");
				be.add(new BE(name, eamount, bamount));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return be;
	}
	
}
