<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin | Sales Report</title>
	<style>
	*,html {
		margin: 0;
		padding: 0;
	}
	.body {
		color: #fff;
	}
	.container {
		width: 600px;
		margin: 60px 200px;
		padding: 30px;
		font-family: Arial, sans-serif;
		background-color: #cff0ff;
	}
	.container h2 {
		text-align: center;	
	}
	.container h4 {
		text-align: center;
		font-size: 20px;
	}
	.buttonDiv {
		text-align: center;
		margin: 0px auto;
		padding: 5px;
	}
	.logoutDiv {
		text-align: right;
		margin: 0px;
		padding: 5px;
		display: inline-block;
	}
	.backBtnDiv {
		display: inline;
	}
	.btn {
		background-color: #9c9c9c;
		color: #fff;
		padding: 5px;
		cursor: pointer;
	}
	.searchForm {
		text-align: center;
	}
	.searchForm input {
		padding: 3px 3px;
	}
	</style>
</head>
<body>
	<div class="container">
		
		<div class="logoutDiv">
			<form method="post" action="logout.jsp">
				<input class="btn" type="submit" value="Log Out">
			</form>
		</div>
		<div class="backBtnDiv">
			<form method="post" action="admin.jsp">
				<input class="btn" type="submit" value="<- Back">
			</form>
		</div>
		<h2>Sales Report</h2><br><br>
			<form class="searchForm" action="adminSalesReportProcess.jsp" method="post">	
				<label for="date">Enter a Month/Year:</label><br>
				<input name="month" id="month" type="text" maxlength="2" size="2">
				<input name="year" id="year" type="text" maxlength="4" size="4">
				<br><br>
				<input class="btn" type="submit" value="Show Report">
			</form>	
		</div>
</body>
</html>