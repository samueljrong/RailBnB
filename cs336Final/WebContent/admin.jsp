<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin Homepage</title>
	<style>
	*,html {
		margin: 0;
		padding: 0;
	}
	body {
		color: #000000;
	}
	.container {
		width: 600px;
		margin: 30px 400px 30px 400px;
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
		padding: 5px;
	}
	.logoutDiv {
		text-align: right;
		padding: 5px;
	}
	.btn {
		background-color: #9c9c9c;
		color: #fff;
		padding: 5px;
		cursor: pointer;
	}
	.topCell {
		background-color: #c9c9c9;
		text-align: center;
		padding: 5px 3px;
	}
	.dataCell {
		background-color: #fff;
		padding: 5px 3px;
		font-size: 16px;
		text-align: center;
	}
	.messageBox {
		background-color: #cff0ff;
		margin: 30px 150px;
		padding: 20px;
		width: 250px;
		text-align: center;
	}
	</style>
</head>
<body>
<%
	String permStr = null;
	String permRole = null;	

	if(session == null || session.getAttribute("user") == null || session.getAttribute("role") == null || session.getAttribute("user").toString() == null || session.getAttribute("role").toString() == null){
		out.println("<div class='messageBox'> <b>Restricted Area.</b> <br>Please log in with the correct credentials.<br> <a href='index.jsp'>Try Again</a></div>");
		return;
	} else {
		permStr = session.getAttribute("user").toString();
		permRole = session.getAttribute("role").toString();
	}
	
	if(!permRole.equals("manager") && !permRole.equals("admin")){
		out.println("<div class='messageBox'> Restricted Area. Please log in with the correct credentials.<br> <a href='index.jsp'>Try Again</a></div>");
		return;
	}
	
	Boolean access = false;	

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement permissions = con.createStatement();
	Class.forName("com.mysql.jdbc.Driver");

	try{ 
		String checkPerms = "SELECT e.username FROM Employees e WHERE e.isManager=1 or e.isAdmin=1";
		
		ResultSet perms = permissions.executeQuery(checkPerms);
		
		while(perms.next()){
			if(perms.getString("username").equals(permStr)){
				access = true;
			}
		}
		
		if(!access){
			out.println("<div class='messageBox'> Restricted Area. Please log in with the correct credentials.<br> <a href='index.jsp'>Try Again</a></div>");
			return;
		}
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println("<div class='messageBox'>An error occurred.<br> <a href='index.jsp'>Try Again</a></div>");
		return;
	}
		
%>
	<div class="container">
		<div class="logoutDiv">
			<form method="post" action="logout.jsp">
				<input class="btn" type="submit" value="Log Out">
			</form>
		</div>
		<h2>Welcome <%=session.getAttribute("user")%></h2><br><br>
		<table align="center" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td>
					<div class="buttonDiv">
						<form method="post" action="adminEmployeeList.jsp">
							<input class="btn" type="submit" value="Manage Employees">
						</form>
					</div>
				</td>
				<td>
					<div class="buttonDiv">
						<form method="post" action="adminCustomerList.jsp">
							<input class="btn" type="submit" value="Manage Customers">
						</form>
					</div>
				</td>
			</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" border="0">
			<tr>
			<td>
				<div class="buttonDiv">
					<form method="post" action="adminSalesReport.jsp">
						<input class="btn" type="submit" value="Sales Report">
					</form>
				</div>
			</td>
			<td>
				<div class="buttonDiv">
					<form method="post" action="adminReservations.jsp">
						<input class="btn" type="submit" value="Reservations">
					</form>
				</div>
			</td>
			<td>
				<div class="buttonDiv">
					<form method="post" action="adminRevenue.jsp">
						<input class="btn" type="submit" value="Revenue">
					</form>
				</div>
			</td>
			</tr>
		</table>
		<br><br>
		
		<%
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			
			Class.forName("com.mysql.jdbc.Driver");
			ResultSet bc;
			ResultSet topFive;
			
			%>
			<h4>Best Customer</h4><br>
			<table align="center" cellpadding="0" cellspacing="0" border="1">
				<tr>
				<td class="topCell"><b>Username</b></td>
				<td class="topCell"><b>Full Name</b></td>
				</tr>
				<%
				try{ 
					String bestCustomer = "SELECT c.userid, c.fname, c.lname FROM (SELECT userid as username, SUM(booking_fee) as total FROM Reservations r GROUP BY username ORDER BY total DESC LIMIT 1) t1, Customers c WHERE c.userid = t1.username LIMIT 1";
					
					bc = stmt.executeQuery(bestCustomer);
					while(bc.next()){
				%>
						<tr>
						<td class="dataCell"><%=bc.getString("userid") %></td>
						<td class="dataCell"><%=bc.getString("fname") %>&nbsp;<%=bc.getString("lname") %></td>
						</tr>
					
				<% 
				}
				
				} catch (Exception e) {
					e.printStackTrace();
				}
				%>
			</table>
			<br><br>
			<h4>Top 5 Most Active Transit Lines</h4><br>
			<table align="center" cellpadding="0" cellspacing="0" border="1">
				<tr>
				<td class="topCell"><b>Transit Line</b></td>
				<td class="topCell"><b>Total Reservations</b></td>
				</tr>
				<%
				try{ 
					String top5 = "SELECT * FROM (SELECT r.route_name as names, COUNT(*) as total FROM Reservations r WHERE MONTH(r.reserved_date) = MONTH(NOW()) and YEAR(r.reserved_date) = YEAR(NOW()) GROUP BY r.route_name) t1 ORDER BY t1.total DESC LIMIT 5";
					
					topFive = stmt2.executeQuery(top5);
					while(topFive.next()){
				%>
						<tr>
						<td class="dataCell"><%=topFive.getString("names") %></td>
						<td class="dataCell"><%=topFive.getInt("total") %></td>
						</tr>
					
				<% 
					}
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				%>
			</table>
	</div>
</body>
</html>