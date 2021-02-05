<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>New Customer Account</title>
	<style>
	*,html {
		margin: 0;
		padding: 0;
	}
	.body {
		color: #000;
	}
	.container {
		width: 300px;
		margin: 0 400px;
		padding: 50px 0px;
		font-family: Arial, sans-serif;
	}
	.container h2 {
		text-align: center;	
	}
	#page {
		background-color: #8cc8ff;
		width: 300px;
		padding: 10px 20px 30px;
		text-align: center;
	}
	.textInput {
		padding: 3px 5px;
		margin-left: 10px;
		margin-bottom: 5px;
	}
	#page .btn{
		margin-left: 180px;
	}
	.btn {
		background-color: #9c9c9c;
		color: #fff;
		padding: 5px;
		cursor: pointer;
	}
	</style>
</head>
<body>
	<div class="container">
		<h2>Create a New Customer<br> Account</h2>
		<br><br>
		<div id="page">
		<br>
			<b>Fill in all the fields:</b>
			<br><br>
			<form method="post" action="createUser.jsp">
			<table>
			<tr>    
			<td>Username</td>
			</tr>
			<tr>
			<td><input class="textInput" type="text" name="userName" maxlength="20"></td>
			</tr>
			<tr>
			<td>Password</td></tr><tr>
			<td><input class="textInput" type="text" name="pass" maxlength="20"></td>
			</tr>
			<tr>    
			<td>First Name</td></tr>
			<tr><td><input class="textInput" type="text" name="fName" maxlength="20"></td>
			</tr>
			<tr>
			<td>Last Name</td></tr>
			<tr><td><input class="textInput" type="text" name="lName" maxlength="20"></td>
			</tr>
			<tr>    
			<td>Email</td></tr><tr>
			<td><input class="textInput" type="text" name="email" maxlength="50"></td>
			</tr>
			<tr>
			<td>Phone Number</td></tr><tr>
			<td><input class="textInput" type="text" name="phone" maxlength="10"></td>
			</tr>
			<tr>    
			<td>Street Address</td></tr><tr>
			<td><input class="textInput" type="text" name="addr" maxlength="50"></td>
			</tr>
			<tr>
			<td>City</td></tr><tr>
			<td><input class="textInput" type="text" name="city" maxlength="50"></td>
			</tr>
			<tr>    
			<td>State</td></tr><tr>
			<td><input class="textInput" type="text" name="state" maxlength="2"></td>
			</tr>
			<tr>
			<td>Zip Code</td></tr><tr>
			<td><input class="textInput" type="text" name="zip" maxlength="5"></td>
			</tr>
			</table>
			<br>
			<input class="btn" type="submit" value="Create">
			</form>
		</div>
	</div>
</body>
</html>