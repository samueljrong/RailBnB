<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin | Revenue</title>
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
	.topCell {
		background-color: #c9c9c9;
	}
	td {
		background-color: #fff;
		padding: 5px 3px;
		font-size: 16px;
		text-align: center;
	}
	.searchForm {
		text-align: center;
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
		<h2>Revenue Listings</h2><br><br>
			<form class="searchForm" method="post" action="adminRevenueTransits.jsp">
				<input class="btn" type="submit" value="By Transit Line">
			</form>
			<br>
			<form class="searchForm" method="post" action="adminRevenueCities.jsp">
				<input class="btn" type="submit" value="By Destination City">
			</form>
			<br>
			<form class="searchForm" method="post" action="adminRevenueUsers.jsp">
				<input class="btn" type="submit" value="By Customer">
			</form>
	</div>
</body>
</html>