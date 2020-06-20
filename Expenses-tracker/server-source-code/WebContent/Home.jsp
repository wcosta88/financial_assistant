<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 200 200'%3E%3Cdefs%3E%3ClinearGradient id='a' gradientUnits='userSpaceOnUse' x1='100' y1='33' x2='100' y2='-3'%3E%3Cstop offset='0' stop-color='%23000' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%23000' stop-opacity='1'/%3E%3C/linearGradient%3E%3ClinearGradient id='b' gradientUnits='userSpaceOnUse' x1='100' y1='135' x2='100' y2='97'%3E%3Cstop offset='0' stop-color='%23000' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%23000' stop-opacity='1'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cg fill='%23ca481d' fill-opacity='0.6'%3E%3Crect x='100' width='100' height='100'/%3E%3Crect y='100' width='100' height='100'/%3E%3C/g%3E%3Cg fill-opacity='0.5'%3E%3Cpolygon fill='url(%23a)' points='100 30 0 0 200 0'/%3E%3Cpolygon fill='url(%23b)' points='100 100 0 130 0 100 200 100 200 130'/%3E%3C/g%3E%3C/svg%3E");
}
</style>
</head>
<body>
	<div class="container mt-3">
		<div class="row">
			<div class="col-lg-9 col-md-9 col-sm-8 col-xs-6"></div>
			<div class="col-lg-3 col-md-3 col-sm-4 col-xs-6">
			<c:set var="operation" scope="session" value="${operation}" />
				<c:if test="${operation == 'log-in'}">
			<div class="card mt-3" style="width: 18rem;">
  <div class="card-body">
    <h5 class="card-title">Welcome to Finance Assistant</h5>
    <h6 class="card-subtitle mb-2 text-muted">Login to continue</h6>
   <form action="login" method="post" autocomplete="off">
						<input name="eMail" type="email" class="form-control form-control-sm" placeholder="email" required> <input name="password"
						type="password" class="form-control mt-2 form-control-sm" placeholder="password" required>
						<button class="btn btn-success btn-sm mt-2">Login</button>
					</form>
    <a href="signup" class="card-link mt-2 mb-2">Sign up</a>
    <c:if test="${message == 'Please enter valid details'}">	
    <div class="alert alert-warning mt-2" role="alert">
 ${message}
 </div>
 </c:if>

    
  </div>
</div>
			</c:if>
				<c:if test="${operation == 'sign-up'}">		
<div class="card mt-3" style="width: 18rem;">
  <div class="card-body">
    <h5 class="card-title">Welcome!..Its free to sign up</h5>
   <form action="register" method="post" autocomplete="off">
						<input name="eMail" type="email" class="form-control form-control-sm" placeholder="email" required> <input name="password"
							type="password" class="form-control mt-2 form-control-sm" placeholder="password" required>
						<input name="security_key" type="text" class="form-control form-control-sm" placeholder="Security key" >
						<button class="btn btn-success btn-sm mt-2">Sign up</button>
					</form>
    <a href="http://localhost:8080/server-source-code/" class="card-link mt-2">Login</a>
   
    ${message}
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