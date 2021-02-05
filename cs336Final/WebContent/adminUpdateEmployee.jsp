<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Updating Employee Account</title>
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
		margin: 0px 400px;
		padding-top: 50px;
		font-family: Arial, sans-serif;
	}
	.container h2 {
		text-align: center;	
	}
	#page {
		background-color: #369fff;
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
	<%
	String ssn=request.getParameter("ssn");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	Class.forName("com.mysql.jdbc.Driver");
	ResultSet rs;
	
	try{ 
		String employee = "SELECT * FROM Employees WHERE ssn='"+ssn+"'";
		
		String fname = null;
		String lname = null;
		String username = null;
		String pass = null;
		Boolean isRep = false;
		
		rs = stmt.executeQuery(employee);
		while(rs.next()){
			fname = rs.getString("fname");
			lname=rs.getString("lname");
			username=rs.getString("username");
			pass=rs.getString("pass");
			
			if(rs.getInt("isRep") == 1){
				isRep = true;
			}else {
				isRep = false;
			}
		}
	%>


	<div class="container">
		<h2>Update Employee<br> Account</h2>
		<br><br>
		<div id="page">
		<br>
			<b>Required fields(*):</b>
			<br><br>
			<form method="post" action="adminUpdateEmployeeProcess.jsp?ssnOG=<%=ssn %>">
			<table>
			<tr>    
			<td>Username(*)</td>
			</tr>
			<tr>
			<td><input class="textInput" type="text" name="userName" maxlength="20" value="<%=username %>"></td>
			</tr>
			<tr>
			<td>Password(*)</td></tr><tr>
			<td><input class="textInput" type="text" name="pass" maxlength="20" value="<%=pass %>"></td>
			</tr>
			<tr>    
			<td>First Name</td></tr>
			<tr><td><input class="textInput" type="text" name="fName" maxlength="20" value="<%=fname %>"></td>
			</tr>
			<tr>
			<td>Last Name</td></tr>
			<tr><td><input class="textInput" type="text" name="lName" maxlength="20" value="<%=lname %>"></td>
			</tr>
			<tr>    
			<td>SSN(*)</td></tr><tr>
			<td><input class="textInput" type="text" name="ssn" maxlength="9" value="<%=ssn %>"></td>
			</tr>
			<tr>
			<td>Employee Role(*)</td></tr><tr>
			<td>
			<% 
				if(isRep){
					%>
					<input type="radio" name="role" value="isManager"><label for="isManager">Manager</label><br>
					<input type="radio" name="role" value="isRep" checked><label for="isRep">Customer Representative</label>
					<% 
				}else{
					%>
					<input type="radio" name="role" value="isManager" checked><label for="isManager">Manager</label><br>
					<input type="radio" name="role" value="isRep"><label for="isRep">Customer Representative</label>
					<% 
				}
			con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			%>
			</td>
			</tr>
			</table>
			<br>
			<input class="btn" type="submit" value="Update">
			</form>
		</div>
	</div>
</body>
</html>