<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Updating Customer Account</title>
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
	String userid=request.getParameter("userid");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	Class.forName("com.mysql.jdbc.Driver");
	ResultSet rs;
	
	try{ 
		String customer = "SELECT * FROM Customers WHERE userid='"+userid+"'";
		
		String fname = null;
		String lname = null;
		String username = null;
		String pass = null;
		String email = null;
		String phone = null;
		String addr = null;
		String city = null;
		String state = null;
		String zip = null;
		
		rs = stmt.executeQuery(customer);
		while(rs.next()){
			fname = rs.getString("fname");
			lname=rs.getString("lname");
			username=rs.getString("userid");
			pass=rs.getString("pass");
			email = rs.getString("email");
			phone = rs.getString("phone");
			addr = rs.getString("addr");
			city = rs.getString("city");
			state = rs.getString("state");
			zip = rs.getString("zip");
			
		}
	%>


	<div class="container">
		<h2>Update Employee<br> Account</h2>
		<br><br>
		<div id="page">
		<br>
			<b>Required fields(*):</b>
			<br><br>
			<form method="post" action="adminUpdateUserProcess.jsp?userid=<%=userid %>">
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
			<td>Email</td></tr><tr>
			<td><input class="textInput" type="text" name="email" maxlength="50" value="<%=email %>"></td>
			</tr>
			<tr>
			<td>Phone Number</td></tr><tr>
			<td><input class="textInput" type="text" name="phone" maxlength="10" value="<%=phone %>"></td>
			</tr>
			<tr>    
			<td>Street Address</td></tr><tr>
			<td><input class="textInput" type="text" name="addr" maxlength="50" value="<%=addr %>"></td>
			</tr>
			<tr>
			<td>City</td></tr><tr>
			<td><input class="textInput" type="text" name="city" maxlength="50" value="<%=city %>"></td>
			</tr>
			<tr>    
			<td>State</td></tr><tr>
			<td><input class="textInput" type="text" name="state" maxlength="2" value="<%=state %>"></td>
			</tr>
			<tr>
			<td>Zip Code</td></tr><tr>
			<td><input class="textInput" type="text" name="zip" maxlength="5" value="<%=zip %>"></td>
			</tr>
			</table>
			<br>
			<input class="btn" type="submit" value="Update">
			</form>
			<%
			con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			%>
		</div>
	</div>
</body>
</html>