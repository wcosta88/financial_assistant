<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">

</head>
<body style="background-color: #F8F9FA;">
	<%
		response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("Progma", "no-cache");
	response.setHeader("Expires", "0");

	if (session.getAttribute("userName") == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/"));
	}
	%>
	<div class="container">
		<nav class="navbar navbar-light bg-light">
			<h3>Personal Finance Assistant</h3>
			<div class="dropdown">
				<a class="btn btn-secondary dropdown-toggle" href="#" role="button"
					id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> ${userName } </a>

				<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					<span class="dropdown-item">My Security key ${security_key }</span>
					<a class="dropdown-item" href="logout">logout</a>
				</div>
			</div>
		</nav>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
				INCOME:
				<canvas id="myChart"></canvas>
				<hr>
				EXPENSES:
				<canvas id="chart"></canvas>
				<hr>
				EXPENSES VS INCOME:
				<canvas id="lineChart"></canvas>
			</div>
			<div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">




				<div class="accordion" id="accordionExample">
					<div class="card">
						<div class="card-header" id="headingOne">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left" type="button"
									data-toggle="collapse" data-target="#collapseOne"
									aria-expanded="true" aria-controls="collapseOne">
									Income</button>
							</h2>
						</div>

						<div id="collapseOne" class="collapse show"
							aria-labelledby="headingOne" data-parent="#accordionExample">
							<div class="card-body">
								<h6>Add income :</h6>
								<form action="addIncome" method="post">
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Income
												name</span>
										</div>
										<input type="text" class="form-control" name="income_name"
											placeholder="income name" required>
									</div>
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Date</span>
										</div>
										<input class="form-control" name="trasaction_date"
											placeholder="trasaction date" type="date" required>
									</div>
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Amount</span>
										</div>
										<input class="form-control" name="amount" placeholder="amount"
											type="number" min="0" required>
									</div>
									<button class="btn btn-primary btn-sm">Add income</button>
								</form>
								<hr>
								<h6>Income details :</h6>
								<nav>
									<div class="nav nav-tabs" id="nav-tab" role="tablist">
										<a class="nav-item nav-link active" id="nav-home-tab"
											data-toggle="tab" href="#nav-home" role="tab"
											aria-controls="nav-home" aria-selected="true">For this
											year</a> <a class="nav-item nav-link" id="nav-profile-tab"
											data-toggle="tab" href="#nav-profile" role="tab"
											aria-controls="nav-profile" aria-selected="false">For
											this month</a>
									</div>
								</nav>
								<div class="tab-content" id="nav-tabContent">
									<div class="tab-pane fade show active" id="nav-home"
										role="tabpanel" aria-labelledby="nav-home-tab">

										<table id="tbl4" class="table table2excel">
											<thead>
												<tr>
													<th scope="col">Income name</th>
													<th scope="col">Date</th>
													<th scope="col">Amount</th>
													<th scope="col">Delete</th>
													<th scope="col">Edit</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="incomey" items="${incomey }">
													<tr>
														<th>${incomey.income_name}</th>
														<th>${incomey.trasaction_date}</th>
														<th>${incomey.amount}</th>
														<th><a href="deleteIncome?id=${incomey.income_id}">Delete</a></th>
														<th><a href="editIncome?id=${incomey.income_id}">Edit</a></th>
													</tr>
												</c:forEach>
												<tr>
													<td></td>
													<th>Total</th>
													
													<td>${sumi }</td>
												</tr>
											</tbody>
										</table>
										<button class="btn btn-success btn-sm"
											onclick="tablesToExcel(['tbl4'], ['ProductDay1'], 'Income.xls', 'Excel')">Export
											to Excel</button>

									</div>
									<div class="tab-pane fade" id="nav-profile" role="tabpanel"
										aria-labelledby="nav-profile-tab">

										<table id="tbl2" class="table table2excel">
											<thead>
												<tr>
													<th scope="col">Income name</th>
													<th scope="col">Date</th>
													<th scope="col">Amount</th>
													<th scope="col">Delete</th>
													<th scope="col">Edit</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="income" items="${income }">
													<tr>
														<th>${income.income_name}</th>
														<th>${income.trasaction_date}</th>
														<th>${income.amount}</th>
														<th><a href="deleteIncome?id=${income.income_id}">Delete</a></th>
														<th><a href="editIncome?id=${income.income_id}">Edit</a></th>
													</tr>
												</c:forEach>
												<tr>
													<td></td>
													<th>Total</th>
													<td>${sumim }</td>
													<td></td>
												</tr>
											</tbody>
										</table>
										<button class="btn btn-success btn-sm"
											onclick="tablesToExcel(['tbl2'], ['ProductDay1'], 'Income.xls', 'Excel')">Export
											to Excel</button>
									</div>

								</div>


							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" id="headingTwo">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left collapsed"
									type="button" data-toggle="collapse" data-target="#collapseTwo"
									aria-expanded="false" aria-controls="collapseTwo">
									Expenses</button>
							</h2>
						</div>
						<div id="collapseTwo" class="collapse"
							aria-labelledby="headingTwo" data-parent="#accordionExample">
							<div class="card-body">


								<h6>Add Expenses :</h6>
								<form action="addExpenses" method="post">
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Expenses
												name</span>
										</div>
										<input class="form-control" name="expenses_name"
											placeholder="expenses name" required>
									</div>
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Date</span>
										</div>
										<input class="form-control" name="expenses_date"
											placeholder="expenses date" type="date" required>
									</div>
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Amount</span>
										</div>
										<input class="form-control" name="amount" placeholder="amount"
											type="number" min="0" required>
									</div>
									<button class="btn btn-primary btn-sm">Add expenses</button>
								</form>
								<hr>
								<h6>Expenses details :</h6>
								<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
									<li class="nav-item" role="presentation"><a
										class="nav-link active" id="pills-home-tab" data-toggle="pill"
										href="#pills-home" role="tab" aria-controls="pills-home"
										aria-selected="true">For this year</a></li>
									<li class="nav-item" role="presentation"><a
										class="nav-link" id="pills-profile-tab" data-toggle="pill"
										href="#pills-profile" role="tab" aria-controls="pills-profile"
										aria-selected="false">For this month</a></li>

								</ul>
								<div class="tab-content" id="pills-tabContent">
									<div class="tab-pane fade show active" id="pills-home"
										role="tabpanel" aria-labelledby="pills-home-tab">
										<table id="tbl7" class="table table2excel">
											<thead>
												<tr>
													<th scope="col">Expenses name</th>
													<th scope="col">Date</th>
													<th scope="col">Amount</th>
													<th scope="col">Delete</th>
													<th scope="col">Edit</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="expensesy" items="${expensesy }">
													<tr>
														<th>${expensesy.expenses_name}</th>
														<th>${expensesy.expenses_date}</th>
														<th>${expensesy.amount}</th>
														<th><a
															href="deleteExpenses?id=${expensesy.expenses_id}">Delete</a></th>
														<th><a
															href="editExpenses?id=${expensesy.expenses_id}">Edit</a></th>
													</tr>
												</c:forEach>
												<tr>
												<td></td>
												<th>Total</th>
													<td>${sume }</td>
												</tr>
											</tbody>
										</table>
										<button class="btn btn-success btn-sm"
											onclick="tablesToExcel(['tbl7'], ['ProductDay1'], 'Expenses.xls', 'Excel')">Export
											to Excel</button>
									</div>
									<div class="tab-pane fade" id="pills-profile" role="tabpanel"
										aria-labelledby="pills-profile-tab">
										<table id="tbl6" class="table table2excel">
											<thead>
												<tr>
													<th scope="col">Expenses name</th>
													<th scope="col">Date</th>
													<th scope="col">Amount</th>
													<th scope="col">Delete</th>
													<th scope="col">Edit</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="expenses" items="${expenses }">
													<tr>
														<th>${expenses.expenses_name}</th>
														<th>${expenses.expenses_date}</th>
														<th>${expenses.amount}</th>
														<th><a
															href="deleteExpenses?id=${expenses.expenses_id}">Delete</a></th>
														<th><a href="editExpenses?id=${expenses.expenses_id}">Edit</a></th>
													</tr>

												</c:forEach>
												<tr>
												<td></td>
												<th>Total</th>
													<td>${sumem }</td>
												</tr>
											</tbody>
										</table>
										<button class="btn btn-success btn-sm"
											onclick="tablesToExcel(['tbl6'], ['ProductDay1'], 'Expenses.xls', 'Excel')">Export
											to Excel</button>
									</div>
								</div>


							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" id="headingThree">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left collapsed"
									type="button" data-toggle="collapse"
									data-target="#collapseThree" aria-expanded="false"
									aria-controls="collapseThree">Budget</button>
							</h2>
						</div>
						<div id="collapseThree" class="collapse"
							aria-labelledby="headingThree" data-parent="#accordionExample">
							<div class="card-body">
								<h6>Add budget :</h6>
								<form action="addBudget" method="post">
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Budget
												name</span>
										</div>
										<input class="form-control" name="budget_name"
											placeholder="budget name" required>
									</div>

									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Starting
												date</span>
										</div>
										<input class="form-control" name="starting_date"
											placeholder="starting date" type="date" required>
									</div>
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Ending
												date</span>
										</div>
										<input class="form-control" type="date" name="ending_date"
											placeholder="ending date" required>
									</div>
									<div class="input-group input-group-sm mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text" id="inputGroup-sizing-sm">Amount</span>
										</div>
										<input class="form-control" name="amount" placeholder="amount"
											type="number" min="0" required>
									</div>

									<button class="btn btn-primary btn-sm">Add budget</button>
								</form>
								<hr>
								<h6>Budget details :</h6>
								<table id="tbl3" class="table table2excel">
									<thead>
										<tr>
											<th scope="col">Expenses name</th>
											<th scope="col">Starting date</th>
											<th scope="col">Ending date</th>
											<th scope="col">Amount</th>
											<th scope="col">Delete</th>
											<th scope="col">Edit</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="budget" items="${budget }">
											<tr>
												<td>${budget.budget_name}</td>
												<td>${budget.starting_date}</td>
												<td>${budget.ending_date}</td>
												<td>${budget.amount}</td>
												<td><a href="deleteBudget?id=${budget.budget_id}">Delete</a></td>
												<td><a href="editBudget?id=${budget.budget_id}">Edit</a></td>
											</tr>

										</c:forEach>
									</tbody>
								</table>
								<button class="btn btn-success btn-sm"
									onclick="tablesToExcel(['tbl3'], ['ProductDay1'], 'Budget.xls', 'Excel')">Export
									to Excel</button>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" id="headingFour">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left collapsed"
									type="button" data-toggle="collapse"
									data-target="#collapseFour" aria-expanded="false"
									aria-controls="collapseTwo">Budget vs Expenses</button>
							</h2>
						</div>
						<div id="collapseFour" class="collapse"
							aria-labelledby="headingFour" data-parent="#accordionExample">
							<div class="card-body">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">Budget name</th>
											<th scope="col">Expenses</th>
											<th scope="col">Budget</th>
											<th scope="col">Budget-Expenses</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="be" items="${be }">
											<tr>
												<td>${be.name}</td>

												<td>${be.eamount}</td>
												<td>${be.bamount}</td>
												<c:if test="${be.remain<=0 }">
													<td style="color: red;">${be.remain}<br> <i>
															Exceeding limit</i></td>
												</c:if>
												<c:if test="${be.remain>0 }">
													<td style="color: blue;">${be.remain}</td>
												</c:if>

											</tr>
											<tr>
												<td colspan="4"><c:if test="${be.remain<=0 }">
														<span class="progress"> <span
															class="progress-bar bg-danger" role="progressbar"
															style="width: <c:out value="${be.eamount/be.bamount*100 }"/>%"
															aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"><c:out
																	value="${be.eamount/be.bamount*100 }" />%</span>
														</span>
													</c:if> <c:if test="${be.remain>0 }">
														<span class="progress"> <span
															class="progress-bar bg-success" role="progressbar"
															style="width: <c:out value="${be.eamount/be.bamount*100 }"/>%"
															aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"><c:out
																	value="${be.eamount/be.bamount*100 }" />%</span>
														</span>
													</c:if></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
								<canvas id="lineChart2"></canvas>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header" id="headingTwo">
							<h2 class="mb-0">
								<button class="btn btn-link btn-block text-left collapsed"
									type="button" data-toggle="collapse"
									data-target="#collapseFive" aria-expanded="false"
									aria-controls="collapseTwo">saving</button>
							</h2>
						</div>
						<div id="collapseFive" class="collapse"
							aria-labelledby="headingFive" data-parent="#accordionExample">
							<div class="card-body">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">Month</th>
											<th scope="col">Expenses</th>
											<th scope="col">Income</th>
											<th scope="col">saving</th>

										</tr>
									</thead>
									<tbody>
										<tr>
											<th>January</th>
											<td><c:out value="${EX[0].amount }" /></td>
											<td><c:out value="${IG[0].income }" /></td>
											<td><c:out value="${IG[0].income -EX[0].amount }" /></td>
										</tr>
										<tr>
											<th>February</th>
											<td><c:out value="${EX[1].amount }" /></td>
											<td><c:out value="${IG[1].income }" /></td>
											<td><c:out value="${IG[1].income -EX[1].amount }" /></td>
										</tr>
										<tr>
											<th>March</th>
											<td><c:out value="${EX[2].amount }" /></td>
											<td><c:out value="${IG[2].income }" /></td>
											<td><c:out value="${IG[2].income -EX[2].amount }" /></td>
										</tr>
										<tr>
											<th>April</th>
											<td><c:out value="${EX[3].amount }" /></td>
											<td><c:out value="${IG[3].income }" /></td>
											<td><c:out value="${IG[3].income -EX[3].amount }" /></td>
										</tr>
										<tr>
											<th>May</th>
											<td><c:out value="${EX[4].amount }" /></td>
											<td><c:out value="${IG[4].income }" /></td>
											<td><c:out value="${IG[4].income -EX[4].amount }" /></td>
										</tr>
										<tr>
											<th>June</th>
											<td><c:out value="${EX[5].amount }" /></td>
											<td><c:out value="${IG[5].income }" /></td>
											<td><c:out value="${IG[5].income -EX[5].amount }" /></td>
										</tr>
										<tr>
											<th>July</th>
											<td><c:out value="${EX[6].amount }" /></td>
											<td><c:out value="${IG[6].income }" /></td>
											<td><c:out value="${IG[6].income -EX[6].amount }" /></td>
										</tr>
										<tr>
											<th>August</th>
											<td><c:out value="${EX[7].amount }" /></td>
											<td><c:out value="${IG[7].income }" /></td>
											<td><c:out value="${IG[7].income -EX[7].amount }" /></td>
										</tr>
										<tr>
											<th>September</th>
											<td><c:out value="${EX[8].amount }" /></td>
											<td><c:out value="${IG[8].income }" /></td>
											<td><c:out value="${IG[8].income -EX[8].amount }" /></td>
										</tr>
										<tr>
											<th>October</th>
											<td><c:out value="${EX[9].amount }" /></td>
											<td><c:out value="${IG[9].income }" /></td>
											<td><c:out value="${IG[9].income -EX[9].amount }" /></td>
										</tr>
										<tr>
											<th>November</th>
											<td><c:out value="${EX[10].amount }" /></td>
											<td><c:out value="${IG[10].income }" /></td>
											<td><c:out value="${IG[10].income -EX[10].amount }" /></td>
										</tr>
										<tr>
											<th>December</th>
											<td><c:out value="${EX[11].amount }" /></td>
											<td><c:out value="${IG[11].income }" /></td>
											<td><c:out value="${IG[11].income -EX[11].amount }" /></td>
										</tr>
										<tr>
											<th></th>
											<td></td>
											<th>Total</th>
											<td><c:out value="${sumi-sume }" /></td>
										</tr>
									</tbody>
								</table>

							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>




	<script>
	let myChart = document.getElementById('myChart').getContext('2d');
    let barChart = new Chart(myChart, {
        type: 'bar',
        data: {
            labels: ['January', 'February', 'March', 'April','May','June','July','August','September','October','November','December'],
            datasets: [{
                label: 'Income in rupees',
                data: [
                	<c:forEach var="IG" items="${IG }">
                	${IG.income},
                	</c:forEach>,
                	0
                ],
                backgroundColor: 
                    'rgba(75,192,192,0.6)'

                
            }]
        },
        options: {}
    });
    
    let chart = document.getElementById('chart').getContext('2d');
    let bChart = new Chart(chart, {
        type: 'bar',
        data: {
            labels: ['January', 'February', 'March', 'April','May','June','July','August','September','October','November','December'],
            datasets: [{
                label: 'Income in rupees',
                data: [
                	<c:forEach var="EX" items="${EX }">
                	${EX.amount},
                	</c:forEach>,
                	0
                ],
                backgroundColor: 
                    'rgba(255,99,132,0.6)'

                
            }]
        },
        options: {}
    });
    let chart2 = document.getElementById("lineChart").getContext('2d');
    var mixedChart = new Chart(chart2, {
        type: 'bar',
        data: {
            datasets: [{
                label: 'Income in rupees',
                data: [
                	<c:forEach var="IG" items="${IG }">
                	${IG.income},
                	</c:forEach>,
                	0
                ],backgroundColor: 
                    'rgba(255,206,86,0.6)',
                order: 1
            }, {
                label: 'Expenses in rupees',
                data: [
                	<c:forEach var="EX" items="${EX }">
                	${EX.amount},
                	</c:forEach>,
                	0
                ],backgroundColor: 
                    'rgba(54,162,235,0.6)',
                type: 'line',
                order: 2
            }],
            labels: ['January', 'February', 'March', 'April','May','June','July','August','September','October','November','December']
        },
        options: {}
    });
    let chart3 = document.getElementById("lineChart2").getContext('2d');
    var mixedChart = new Chart(chart3, {
        type: 'bar',
        data: {
            datasets: [{
                label: 'Budget',
                data: [
                	<c:forEach var="be" items="${be }">
                	'${be.bamount}',
                	</c:forEach>
                ],backgroundColor: 
                    'rgba(255,206,86,0.6)',
                    
                order: 1
            }, {
                label: 'Expenses',
                data: [
                	<c:forEach var="be" items="${be }">
                	'${be.eamount}',
                	</c:forEach>
                ],backgroundColor: 
                    'rgba(153,102,255,0.6)',
                type: 'line',
                order: 2
            }],
            labels: [
            	<c:forEach var="be" items="${be }">
            	'${be.name}',
            	</c:forEach>
            ]
        },
        options: {}
    });
    //EXCEL
    
    var tablesToExcel = (function() {
    var uri = 'data:application/vnd.ms-excel;base64,'
    , tmplWorkbookXML = '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?><Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
      + '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"><Author>Axel Richter</Author><Created>{created}</Created></DocumentProperties>'
      + '<Styles>'
      + '<Style ss:ID="Currency"><NumberFormat ss:Format="Currency"></NumberFormat></Style>'
      + '<Style ss:ID="Date"><NumberFormat ss:Format="Medium Date"></NumberFormat></Style>'
      + '</Styles>' 
      + '{worksheets}</Workbook>'
    , tmplWorksheetXML = '<Worksheet ss:Name="{nameWS}"><Table>{rows}</Table></Worksheet>'
    , tmplCellXML = '<Cell{attributeStyleID}{attributeFormula}><Data ss:Type="{nameType}">{data}</Data></Cell>'
    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
    return function(tables, wsnames, wbname, appname) {
      var ctx = "";
      var workbookXML = "";
      var worksheetsXML = "";
      var rowsXML = "";

      for (var i = 0; i < tables.length; i++) {
        if (!tables[i].nodeType) tables[i] = document.getElementById(tables[i]);
        for (var j = 0; j < tables[i].rows.length; j++) {
          rowsXML += '<Row>'
          for (var k = 0; k < tables[i].rows[j].cells.length-2; k++) {
            var dataType = tables[i].rows[j].cells[k].getAttribute("data-type");
            var dataStyle = tables[i].rows[j].cells[k].getAttribute("data-style");
            var dataValue = tables[i].rows[j].cells[k].getAttribute("data-value");
            dataValue = (dataValue)?dataValue:tables[i].rows[j].cells[k].innerHTML;
            var dataFormula = tables[i].rows[j].cells[k].getAttribute("data-formula");
            dataFormula = (dataFormula)?dataFormula:(appname=='Calc' && dataType=='DateTime')?dataValue:null;
            ctx = {  attributeStyleID: (dataStyle=='Currency' || dataStyle=='Date')?' ss:StyleID="'+dataStyle+'"':''
                   , nameType: (dataType=='Number' || dataType=='DateTime' || dataType=='Boolean' || dataType=='Error')?dataType:'String'
                   , data: (dataFormula)?'':dataValue
                   , attributeFormula: (dataFormula)?' ss:Formula="'+dataFormula+'"':''
                  };
            rowsXML += format(tmplCellXML, ctx);
          }
          rowsXML += '</Row>'
        }
        ctx = {rows: rowsXML, nameWS: wsnames[i] || 'Sheet' + i};
        worksheetsXML += format(tmplWorksheetXML, ctx);
        rowsXML = "";
      }

      ctx = {created: (new Date()).getTime(), worksheets: worksheetsXML};
      workbookXML = format(tmplWorkbookXML, ctx);



      var link = document.createElement("A");
      link.href = uri + base64(workbookXML);
      link.download = wbname || 'Workbook.xls';
      link.target = '_blank';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  })();
    
    
    //var table1=getElementById("tbl2"),sumval1=0;
    //for(vat i=1;i<table.row.length;i++){
    	//sumval1=sumval1+parseInt(table.row[i].cells(2).innerHTML);
    //}
    //console.log(sumval1);
    //document.getElementById("totalIncome").innerHTML=sumval1;
</script>
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