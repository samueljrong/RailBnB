<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin | Reservations</title>
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
		<h2>Reservations</h2><br><br>
		
		<%
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			Class.forName("com.mysql.jdbc.Driver");
			ResultSet rs;
			
			
			%>
			<form class="searchForm" method="post" action="adminReservationsTransits.jsp">
				<label for="transitLines">Choose a Transit Line:</label>
	
				<select name="tline" id="transitLines">
				  
				  <%
				try{ 
					String tlines = "SELECT DISTINCT route_name FROM Reservations";
					
					rs = stmt.executeQuery(tlines);
					while(rs.next()){
					%>
						<option value="<%=rs.getString("route_name")%>"><%=rs.getString("route_name") %></option>
					<% 
				}
				
				} catch (Exception e) {
					e.printStackTrace();
				}
		%>
				</select>
				<br>
				<label for="trainNumber">Train Number:</label>
				
				<select name="tnum" id="trainNumber">
				  
				  <%
				try{ 
					String tlines = "SELECT DISTINCT tid FROM Trains";
					
					rs = stmt.executeQuery(tlines);
					while(rs.next()){
					%>
						<option value="<%=rs.getString("tid")%>"><%=rs.getString("tid") %></option>
					<% 
				}
				
				} catch (Exception e) {
					e.printStackTrace();
				}%>
				</select>
				<br><br>
				<input class="btn" type="submit" value="Search by Train">
			</form>
			<br>
			<hr>
			<br>
			<form  class="searchForm" method="post" action="adminReservationsCustomers.jsp">
				<label for="customers">Choose a Customer:</label>
	
				<select name="userid" id="customers">
				  
				  <%
				try{
					Statement stmt2 = con.createStatement();
					ResultSet users;
					String customers = "SELECT userid FROM Customers";
					
					users = stmt2.executeQuery(customers);
					while(users.next()){
					%>
						<option value=<%=users.getString("userid")%>><%=users.getString("userid") %></option>
					<% 
					
				}
				con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		%>
				</select>
				<br><br>
				<input class="btn" type="submit" value="Search By Customer">
			</form>
	</div>
</body>
</html>