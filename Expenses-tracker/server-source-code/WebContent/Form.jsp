<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<style>
body {
	background-color: #ee5522;
background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 2000 1500'%3E%3Cdefs%3E%3CradialGradient id='a' gradientUnits='objectBoundingBox'%3E%3Cstop offset='0' stop-color='%23FB3'/%3E%3Cstop offset='1' stop-color='%23ee5522'/%3E%3C/radialGradient%3E%3ClinearGradient id='b' gradientUnits='userSpaceOnUse' x1='0' y1='750' x2='1550' y2='750'%3E%3Cstop offset='0' stop-color='%23f7882b'/%3E%3Cstop offset='1' stop-color='%23ee5522'/%3E%3C/linearGradient%3E%3Cpath id='s' fill='url(%23b)' d='M1549.2 51.6c-5.4 99.1-20.2 197.6-44.2 293.6c-24.1 96-57.4 189.4-99.3 278.6c-41.9 89.2-92.4 174.1-150.3 253.3c-58 79.2-123.4 152.6-195.1 219c-71.7 66.4-149.6 125.8-232.2 177.2c-82.7 51.4-170.1 94.7-260.7 129.1c-90.6 34.4-184.4 60-279.5 76.3C192.6 1495 96.1 1502 0 1500c96.1-2.1 191.8-13.3 285.4-33.6c93.6-20.2 185-49.5 272.5-87.2c87.6-37.7 171.3-83.8 249.6-137.3c78.4-53.5 151.5-114.5 217.9-181.7c66.5-67.2 126.4-140.7 178.6-218.9c52.3-78.3 96.9-161.4 133-247.9c36.1-86.5 63.8-176.2 82.6-267.6c18.8-91.4 28.6-184.4 29.6-277.4c0.3-27.6 23.2-48.7 50.8-48.4s49.5 21.8 49.2 49.5c0 0.7 0 1.3-0.1 2L1549.2 51.6z'/%3E%3Cg id='g'%3E%3Cuse href='%23s' transform='scale(0.12) rotate(60)'/%3E%3Cuse href='%23s' transform='scale(0.2) rotate(10)'/%3E%3Cuse href='%23s' transform='scale(0.25) rotate(40)'/%3E%3Cuse href='%23s' transform='scale(0.3) rotate(-20)'/%3E%3Cuse href='%23s' transform='scale(0.4) rotate(-30)'/%3E%3Cuse href='%23s' transform='scale(0.5) rotate(20)'/%3E%3Cuse href='%23s' transform='scale(0.6) rotate(60)'/%3E%3Cuse href='%23s' transform='scale(0.7) rotate(10)'/%3E%3Cuse href='%23s' transform='scale(0.835) rotate(-40)'/%3E%3Cuse href='%23s' transform='scale(0.9) rotate(40)'/%3E%3Cuse href='%23s' transform='scale(1.05) rotate(25)'/%3E%3Cuse href='%23s' transform='scale(1.2) rotate(8)'/%3E%3Cuse href='%23s' transform='scale(1.333) rotate(-60)'/%3E%3Cuse href='%23s' transform='scale(1.45) rotate(-30)'/%3E%3Cuse href='%23s' transform='scale(1.6) rotate(10)'/%3E%3C/g%3E%3C/defs%3E%3Cg transform='rotate(0 0 0)'%3E%3Cg transform='rotate(0 0 0)'%3E%3Ccircle fill='url(%23a)' r='3000'/%3E%3Cg opacity='0.5'%3E%3Ccircle fill='url(%23a)' r='2000'/%3E%3Ccircle fill='url(%23a)' r='1800'/%3E%3Ccircle fill='url(%23a)' r='1700'/%3E%3Ccircle fill='url(%23a)' r='1651'/%3E%3Ccircle fill='url(%23a)' r='1450'/%3E%3Ccircle fill='url(%23a)' r='1250'/%3E%3Ccircle fill='url(%23a)' r='1175'/%3E%3Ccircle fill='url(%23a)' r='900'/%3E%3Ccircle fill='url(%23a)' r='750'/%3E%3Ccircle fill='url(%23a)' r='500'/%3E%3Ccircle fill='url(%23a)' r='380'/%3E%3Ccircle fill='url(%23a)' r='250'/%3E%3C/g%3E%3Cg transform='rotate(0 0 0)'%3E%3Cuse href='%23g' transform='rotate(10)'/%3E%3Cuse href='%23g' transform='rotate(120)'/%3E%3Cuse href='%23g' transform='rotate(240)'/%3E%3C/g%3E%3Ccircle fill-opacity='0.1' fill='url(%23a)' r='3000'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
background-attachment: fixed;
background-size: cover;
}
</style>

</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("Progma", "no-cache");
	response.setHeader("Expires", "0");

	if (session.getAttribute("userName") == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
	}
	%>
	<div class="container">
		<div class="row mt-3">
			<div class="col-lg-9 col-md-9 col-sm-8 col-xs-6"></div>
			<div class="col-lg-3 col-md-3 col-sm-4 col-xs-6">
				<c:if test="${existingIncome!=null }">
					<div class="card mt-3" style="width: 18rem;">
						<div class="card-body">
							<h5 class="card-title">EDIT INCOME</h5>

							<form action="updateIncome" method="post">
								<input value="${existingIncome.income_id }" type="hidden"
									name="income_id">

								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Income
											Name</span>
									</div>
									<input type="text" class="form-control"
										aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingIncome.income_name }" name="income_name">
								</div>
								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Trasaction
											Date</span>
									</div>
									<input class="form-control" aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingIncome.trasaction_date }" type="date"
										name="trasaction_date">
								</div>
								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Amount</span>
									</div>
									<input type="text" class="form-control"
										aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingIncome.amount }" type="number" name="amount"
										min="0">
								</div>
								<button class="btn btn-success btn-sm">Submit</button>
							</form>

							<a href="app" class="card-link">Back</a>
						</div>
					</div>


				</c:if>
				<c:if test="${existingBudget!=null }">
					<div class="card mt-3 pt-3" style="width: 18rem;">
						<div class="card-body">
							<h5 class="card-title">EDIT BUDGET</h5>
							<form action="updateBudget" method="post">

								<input value="${existingBudget.budget_id }" type="hidden"
									name="budget_id">

								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Budget
											Name</span>
									</div>
									<input type="text" class="form-control"
										aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingBudget.budget_name }" name="budget_name">
								</div>
								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Starting
											Date</span>
									</div>
									<input class="form-control" aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingBudget.starting_date }" type="date"
										name="starting_date">
								</div>

								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Ending
											Date</span>
									</div>
									<input class="form-control" aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingBudget.ending_date }" type="date"
										name="ending_date">
								</div>

								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Amount</span>
									</div>
									<input type="text" class="form-control"
										aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingBudget.amount }" type="number" min="0"
										name="amount">
								</div>
								<button class="btn btn-success btn-sm">Submit</button>
							</form>
							<a href="app" class="card-link">Back</a>
						</div>
					</div>

				</c:if>
				<c:if test="${existingExpenses!=null }">
					<div class="card" style="width: 18rem;">
						<div class="card-body mt-3">
							<h5 class="card-title">EDIT EXPENSES</h5>

							<form action="updateExpenses" method="post">
								<input value="${existingExpenses.expenses_id }" type="hidden"
									name="expenses_id">
								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Expenses
											Name</span>
									</div>
									<input type="text" class="form-control"
										aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingExpenses.expenses_name }"
										name="expenses_name">
								</div>
								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Expenses
											Date</span>
									</div>
									<input class="form-control" aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingExpenses.expenses_date }" type="date"
										name="expenses_date">
								</div>
								<div class="input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">Amount</span>
									</div>
									<input type="text" class="form-control"
										aria-label="Sizing example input"
										aria-describedby="inputGroup-sizing-sm"
										value="${existingExpenses.amount }" type="number" min="0"
										name="amount">
								</div>

								<button class="btn btn-success btn-sm">Submit</button>
							</form>
							<a href="app" class="card-link">Back</a>
						</div>
					</div>

				</c:if>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
		integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
		crossorigin="anonymous"></script>
</body>
</html>