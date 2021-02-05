<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>CS 336 Booking System</title>
	<style>
	*,html {
		margin: 0;
		padding: 0;
	}
	body {
		color: #000;
	}
	.container {
		width: 250px;
		margin: 30px auto;
		padding-top: 100px;
		font-family: Arial, sans-serif;
	}
	.container h2 {
		text-align: center;	
	}
	#page {
		background-color: #8cc8ff;
		width: 250px;
		padding: 10px 20px 30px;
	}
	.tabs {
		width: 200px;
		border-collapse: collapse;
	}
	.cTab {
		background-color: #8cc8ff;
		padding: 10px 15px;
		width: 100px;
		cursor: pointer;
	}
	.eTab {
		background-color: #369fff;
		padding: 10px 15px;
		width: 100px;
		cursor: pointer;
	}
	#createAccountForm {
		text-align: center;
		padding-top: 20px;
		display: block;
	}
	.textInput {
		padding: 3px 5px;
		margin-left: 10px;
		margin-bottom: 5px;
	}
	#page .btn{
		margin-left: 180px;
	}
	.btn, .btn2 {
		background-color: #9c9c9c;
		color: #fff;
		padding: 5px;
		cursor: pointer;
	}
	</style>
	
	<script>
	function showCustomer() {
		document.getElementById("page").style.backgroundColor = "#8cc8ff";
		document.getElementById("createAccountForm").style.display = "block";
		document.getElementById("login").action = "checkUser.jsp";
		document.getElementById("create").action = "newUser.jsp";
	}
	function showEmployee() {
		document.getElementById("page").style.backgroundColor = "#369fff";
		document.getElementById("createAccountForm").style.display = "none";
		document.getElementById("login").action = "checkEmployee.jsp";
	}
	</script>
</head>
<body>
	<div class="container">
		<h2>Login Page</h2>
		<br><br>
		<table class="tabs">
			<tr>    
				<td class="cTab" onclick="showCustomer()">Customer</td><td class="eTab" onclick="showEmployee()">Employee</td>
			</tr>
		</table>
		<div id="page">
		<br>
			<b>Log in:</b>
			<br><br>
			<form id="login" method="post" action="checkUser.jsp">
			<table>
			<tr>
			<td>Username</td>
			</tr>
			<tr>
			<td><input class="textInput" type="text" name="userName"></td>
			</tr>
			<tr>
			<td>Password</td>
			</tr>
			<tr>
			<td><input class="textInput" type="text" name="pass"></td>
			</tr>
			</table>
			<br>
			<input class="btn" type="submit" value="Log In">
			</form>
		<div id="createAccountForm">
		<form id="create" method="post" action="newUser.jsp">
			<input class="btn2" type="submit" value="Create an Account">
			</form>
		</div>
		
		</div>
	</div>
</body>
</html>