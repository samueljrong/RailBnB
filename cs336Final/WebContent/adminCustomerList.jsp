<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin | Customer List</title>
	<style>
	*,html {
		margin: 0;
		padding: 0;
	}
	.body {
		color: #fff;
	}
	.container {
		width: 1100px;
		margin: 30px 150px;
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
		<h2>Customer Management</h2><br><br>
		
		<%
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			Class.forName("com.mysql.jdbc.Driver");
			ResultSet rs;
			
			%>
			<table align="center" cellpadding="0" cellspacing="0" border="1">
				<tr>
				<td class="topCell"><b>Username</b></td>
				<td class="topCell"><b>Password</b></td>
				<td class="topCell"><b>First Name</b></td>
				<td class="topCell"><b>Last Name</b></td>
				<td class="topCell"><b>Email</b></td>
				<td class="topCell"><b>Phone</b></td>
				<td class="topCell"><b>Address</b></td>
				<td class="topCell"><b>City</b></td>
				<td class="topCell"><b>State</b></td>
				<td class="topCell"><b>Zip Code</b></td>
				<td class="topCell"></td>
				<td class="topCell"></td>
				</tr>
				<%
				try{ 
					String customers = "SELECT * FROM Customers";
					
					rs = stmt.executeQuery(customers);
					while(rs.next()){ //=rs.getInt("isRep")
					%>
						<tr>
						<td><%=rs.getString("userid") %></td>
						<td><%=rs.getString("pass") %></td>
						<td><%if(rs.getString("fname") == null || rs.getString("fname").isEmpty() || rs.getString("fname").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("fname"));
						}
						%></td>
						<td><%if(rs.getString("lname") == null || rs.getString("lname").isEmpty() || rs.getString("lname").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("lname"));
						}
						%></td>
						<td><%if(rs.getString("email") == null || rs.getString("email").isEmpty() || rs.getString("email").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("email"));
						}
						%></td>
						<td><%if(rs.getString("phone") == null || rs.getString("phone").isEmpty() || rs.getString("phone").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("phone"));
						}
						%></td>
						<td><%if(rs.getString("addr") == null || rs.getString("addr").isEmpty() || rs.getString("addr").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("addr"));
						}
						%></td>
						<td><%if(rs.getString("city") == null || rs.getString("city").isEmpty() || rs.getString("city").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("city"));
						}
						%></td>
						<td><%if(rs.getString("state") == null || rs.getString("state").isEmpty() || rs.getString("state").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("state"));
						}
						%></td>
						<td><%if(rs.getString("zip") == null || rs.getString("zip").isEmpty() || rs.getString("zip").equals("null")){
							out.print("N/A");
						} else {
							out.print(rs.getString("zip"));
						}
						%></td>
						<td>
						<a href="adminUpdateUser.jsp?userid=<%=rs.getString("userid") %>">Update</a>
						</td>
						<td>
						<a href="adminRemoveUser.jsp?userid=<%=rs.getString("userid") %>">Remove</a>
						</td>
						</tr>
					<% 
					
				}
				con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		%>
			</table>
			<br><br>
			<div class="buttonDiv">
			<form method="post" action="adminNewUser.jsp">
				<input class="btn" type="submit" value="Add Customer">
			</form>
			</div>
	</div>
</body>
</html>