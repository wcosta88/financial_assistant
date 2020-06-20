
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BE;
import models.Budget;
import models.Datasource;
import models.Expenses;
import models.Income;
import models.expensesGraph;
import models.incomeGraph;

@WebServlet("/")
public class server extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Datasource datasource;
	HttpSession session;

	public server() {
		this.datasource = new Datasource();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();
		// ROUTES
		switch (action) {
		case "/":
			Home(request, response);
			break;
		case "/login":
			try {
				Login(request, response);
			} catch (NullPointerException x) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
			}
			break;
		case "/logout":
			Logout(request, response);
			break;
		case "/signup":
			Signup(request, response);
			break;
		case "/register":
			Register(request, response);
			break;
		case "/app":
			App(request, response);
			break;
		case "/addIncome":
			try {
				AddIncome(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "/addExpenses":
			try {
				AddExpenses(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		case "/addBudget":
			try {
				AddBudget(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "/deleteExpenses":
			try {
				DeleteExpenses(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "/deleteIncome":
			try {
				DeleteIncome(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "/deleteBudget":
			try {
				DeleteBudget(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		case "/editIncome":
			editIncome(request, response);
			break;
		case "/editBudget":
			editBudget(request, response);
			break;
		case "/editExpenses":
			editExpenses(request, response);
			break;
		case "/updateIncome":
			try {
				updateIncome(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "/updateExpenses":
			try {
				updateExpenses(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
		case "/updateBudget":
			try {
				updateBudget(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// TO SHOW THE HOME PAGE :
	protected void Home(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		session.setAttribute("operation", "log-in");
		RequestDispatcher dispatcher = request.getRequestDispatcher("Home.jsp");
		dispatcher.forward(request, response);
	}

	// CHECK THE USER IS REGISTERED :
	protected void Login(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String email_id = request.getParameter("eMail");
		String password = request.getParameter("password");
		boolean auth = datasource.checkAuthentication(email_id, password);
		if (auth) {
			session = request.getSession();
			session.setAttribute("userName", email_id);

			response.sendRedirect("app");
		} else {
			session = request.getSession();
			session.setAttribute("message", "Please enter valid details");
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
		}
	}

	// APPLICATION ROUTE
	protected void App(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email_id = (String) session.getAttribute("userName");
		String security_key = datasource.getSecurityKey(email_id);
		session.setAttribute("security_key", security_key);
		List<BE> be = datasource.expenseAndbudget(security_key);
		List<incomeGraph> IG = datasource.IGgraph(security_key);
		List<expensesGraph> EX = datasource.EXgraph(security_key);
		List<Income> incomey = datasource.selectAllIncomey(security_key);
		List<Expenses> expenses = datasource.selectAllExpenses(security_key);
		List<Budget> budget = datasource.selectAllBudget(security_key);
		List<Income> income = datasource.selectAllIncome(security_key);
		List<Expenses> expensesy = datasource.selectAllExpensesy(security_key);
		System.out.println("___ ");
		double sume = 0;
		for (int i = 0; i < EX.size(); i++) {

			sume = sume + EX.get(i).getAmount();
			System.out.println(sume);
		}
		double sumi = 0;
		for (int i = 0; i < IG.size(); i++) {
			System.out.println(IG.get(i).getIncome());
			sumi = sumi + IG.get(i).getIncome();
			System.out.println(sumi);
		}
		Date date = new Date();
		LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		int month = localDate.getMonthValue();
		request.setAttribute("sumim", IG.get(month-1).getIncome());
		request.setAttribute("sumem", EX.get(month-1).getAmount());
		request.setAttribute("sume", sume);
		request.setAttribute("sumi", sumi);
		request.setAttribute("be", be);
		request.setAttribute("EX", EX);
		request.setAttribute("IG", IG);
		request.setAttribute("expenses", expenses);
		request.setAttribute("budget", budget);
		request.setAttribute("income", income);
		request.setAttribute("incomey", incomey);
		request.setAttribute("expensesy", expensesy);
		RequestDispatcher dispatcher = request.getRequestDispatcher("App.jsp");
		dispatcher.forward(request, response);
	}

	// TO LOGOUT :
	protected void Logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("userName");
		session.invalidate();
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
	}

	// TO SHOW SIGN-UP PAGE:
	protected void Signup(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		session.setAttribute("operation", "sign-up");
		RequestDispatcher dispatcher = request.getRequestDispatcher("Home.jsp");
		dispatcher.forward(request, response);
	}

	// ADD INCOME
	protected void AddIncome(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String email_id = (String) session.getAttribute("userName");
		String security_key = datasource.getSecurityKey(email_id);
		String income_name = request.getParameter("income_name");
		String trasaction_date = request.getParameter("trasaction_date");
		String amount = request.getParameter("amount");
		System.out.println(income_name + " " + trasaction_date + " " + amount + " " + security_key);
		double amount_in_double = Double.parseDouble(amount);
		System.out.println(amount_in_double);
		Income income = new Income(income_name, trasaction_date, amount_in_double);
		datasource.insertIncome(income, security_key);
		response.sendRedirect("app");
	}

	// ADD EXPENSES
	protected void AddExpenses(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String email_id = (String) session.getAttribute("userName");
		String security_key = datasource.getSecurityKey(email_id);
		System.out.println(security_key);
		String income_name = request.getParameter("expenses_name");
		String trasaction_date = request.getParameter("expenses_date");
		String amount = request.getParameter("amount");
		double amount_in_double = Double.parseDouble(amount);
		System.out.println(amount_in_double);
		Expenses expenses = new Expenses(income_name, trasaction_date, amount_in_double);
		datasource.insertExpenses(expenses, security_key);
		response.sendRedirect("app");
	}

	// ADD BUDGET
	protected void AddBudget(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String email_id = (String) session.getAttribute("userName");
		String security_key = datasource.getSecurityKey(email_id);
		System.out.println(security_key);
		String budget_name = request.getParameter("budget_name");
		String starting_date = request.getParameter("starting_date");
		String ending_date = request.getParameter("ending_date");
		String amount = request.getParameter("amount");
		double amount_in_double = Double.parseDouble(amount);

		Budget budget = new Budget(budget_name, starting_date, ending_date, amount_in_double);
		datasource.insertBUDGET(budget, security_key);
		response.sendRedirect("app");
	}

	// DELETE EXPENSES
	protected void DeleteExpenses(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		datasource.deleteExpenses(id);
		response.sendRedirect("app");
	}

	// DLETE BUDGET
	protected void DeleteBudget(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		datasource.deleteBudget(id);
		response.sendRedirect("app");
	}

	// DELETE INCOME
	protected void DeleteIncome(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		datasource.deleteIncome(id);
		response.sendRedirect("app");
	}

	// Edit income
	protected void editIncome(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Income existingIncome = datasource.selectIncome(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
		request.setAttribute("existingIncome", existingIncome);
		if (!response.isCommitted()) {
			dispatcher.forward(request, response);
		}
	}

	// edit budget
	protected void editBudget(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Budget existingBudget = datasource.selectBugdet(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
		request.setAttribute("existingBudget", existingBudget);
		dispatcher.forward(request, response);
	}

	// edit expenses
	protected void editExpenses(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Expenses existingExpenses = datasource.selectExpenses(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
		request.setAttribute("existingExpenses", existingExpenses);
		dispatcher.forward(request, response);
	}

	// UPDATE INCOME
	protected void updateIncome(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int income_id = Integer.parseInt(request.getParameter("income_id"));
		String income_name = request.getParameter("income_name");
		String trasaction_date = request.getParameter("trasaction_date");
		String amount = request.getParameter("amount");
		double amount_in_double = Double.parseDouble(amount);
		System.out.println(income_id + " " + income_name + " " + trasaction_date + " " + amount_in_double);
		Income income = new Income(income_id, income_name, trasaction_date, amount_in_double);
		datasource.updateIncome(income);
		response.sendRedirect("app");
	}

	// UPDATE EXPENSES
	protected void updateExpenses(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int expenses_id = Integer.parseInt(request.getParameter("expenses_id"));
		String expenses_name = request.getParameter("expenses_name");
		String expenses_date = request.getParameter("expenses_date");
		String amount = request.getParameter("amount");
		double amount_in_double = Double.parseDouble(amount);

		Expenses expenses = new Expenses(expenses_id, expenses_name, expenses_date, amount_in_double);
		datasource.updateExpenses(expenses);
		response.sendRedirect("app");
	}

	// update budget
	protected void updateBudget(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int budget_id = Integer.parseInt(request.getParameter("budget_id"));
		String budget_name = request.getParameter("budget_name");
		String starting_date = request.getParameter("starting_date");
		String ending_date = request.getParameter("ending_date");
		String amount = request.getParameter("amount");
		double amount_in_double = Double.parseDouble(amount);
		System.out.println(
				budget_id + " " + budget_name + " " + starting_date + " " + ending_date + " " + amount_in_double);
		Budget budget = new Budget(budget_id, budget_name, starting_date, ending_date, amount_in_double);

		System.out.println(budget.getBudget_name());
		datasource.updateBudget(budget);
		response.sendRedirect("app");
	}

	// REGISTER THE USER
	protected void Register(HttpServletRequest request, HttpServletResponse response) throws IOException {
		session = request.getSession();
		String random;
		String email_id = request.getParameter("eMail");
		String password = request.getParameter("password");
		if (request.getParameter("security_key").length() != 0) {
			random = request.getParameter("security_key");
		} else {
			random = Random();
			System.out.println(email_id + " , " + password);
			System.out.println(datasource.SecurityKeyCheck(random));
			while (datasource.SecurityKeyCheck(random) == true) {
				random = Random();
			}
		}
		System.out.println(random);
		if (email_id.length() != 0 && password.length() != 0) {
			boolean signup = datasource.Register(email_id, password, random);

			if (signup == false) {
				session.setAttribute("message", "User Already exist");
				response.sendRedirect("signup");
			} else {
				session.setAttribute("message", "Successfully logedin");
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
			}

		} else {
			session.setAttribute("message", "please enter Valid data");
			response.sendRedirect("signup");
		}
	}

	// CREATE A RANDOM HEXADECIMAL VALUE
	protected String Random() {
		Random random = new Random();
		int val = random.nextInt();
		String Hex = new String();
		Hex = Integer.toHexString(val);
		System.out.println("Random Hex Byte: " + Hex);
		return Hex;
	}
}
