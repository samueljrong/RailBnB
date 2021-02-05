<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin | Customer Reservations</title>
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
	.header {
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
			<form method="post" action="adminReservations.jsp">
				<input class="btn" type="submit" value="<- Back">
			</form>
		</div>
		<%
		String userid = request.getParameter("userid");
		%>
		<h2>Reservations for</h2>
		<%	
		out.print("<div class='header'><b>"+userid+"</b></div>");
		%>
		<br><br>
		
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
				<td class="topCell"><b>Reservation ID</b></td>
				<td class="topCell"><b>Username</b></td>
				<td class="topCell"><b>Date Reserved</b></td>
				<td class="topCell"><b>Transit Line</b></td>
				<td class="topCell"><b>Train Number</b></td>
				<td class="topCell"><b>Departure Time</b></td>
				<td class="topCell"><b>Customer Representative</b></td>
				<td class="topCell"><b>Origin</b></td>
				<td class="topCell"><b>Destination</b></td>
				<td class="topCell"><b>Seat Number</b></td>
				<td class="topCell"><b>Seat Class</b></td>
				<td class="topCell"><b>Booking Fee</b></td>
				<td class="topCell"><b>Total Cost</b></td>
				</tr>
				<%
				try{
					String reservations;

					reservations = "SELECT * FROM Reservations r, Seats s WHERE r.userid='"+userid+"' and r.tid = s.trains_tid and r.seat_no = s.seat_number";					
					
					rs = stmt.executeQuery(reservations);
					while(rs.next()){ //=rs.getInt("isRep")
					%>
						<tr>
						<td><%=rs.getString("rid") %></td>
						<td><%=rs.getString("userid") %></td>
						<td><%=rs.getString("reserved_date") %></td>
						<td><%=rs.getString("route_name") %></td>
						<td><%=rs.getString("tid") %></td>
						<td><%=rs.getString("departure_time") %></td>
						<td><%=rs.getString("repid") %></td>
						<td><%=rs.getString("origin") %></td>
						<td><%=rs.getString("destination") %></td>
						<td><%=rs.getString("seat_no") %></td>
						<td><%=rs.getString("seat_class") %></td>
						<td><%=rs.getString("booking_fee") %></td>
						<td><%=rs.getString("total_cost") %></td>
					
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
	</div>
</body>
</html>