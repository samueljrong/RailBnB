<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alter Reservations</title>
</head>
<body>
<%String repid=request.getParameter("repid"); %>

<form method="post" action="customerRepEditReservation.jsp">
<input type="hidden" name="repid" value="<%=repid%>"> 
Reservation ID: <input class="textInput" type="text" name="rid">
<input type="submit" value="Edit Reservation">
</form>

<form method="post" action="crDeleteReservation.jsp">
Reservation ID: <input class="textInput" type="text" name="rid">
<input type="submit" value="Delete Reservation">
</form>
<%
try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Make a SELECT query of stations for drop down menu
	String dropdown = "SELECT route_name, departure_time FROM Schedules;";
	//Run the query against the database.
	ResultSet lines = stmt.executeQuery(dropdown); %>

<br>
<form method="post" action="customerRepCreateReservation.jsp">
<input type="hidden" name="repid" value="<%=repid%>"> 
User ID: <input class="textInput" type="text" name="userid">
	
		<p>
			Select Line : <select name="line" id="line">
				<%
			while(lines.next())
			{
			String sname = lines.getString("route_name")+","+lines.getString("departure_time"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>
		
Select trip type: <select name="trip">
			<option value="one_way">One way</option>
			<option value="round_trip">Round</option>
			<option value="isMonthly">Month</option>
			<option value="isWeekly">Week</option>
			</select>
			

<input type="submit" value="New Reservation">
</form>

<%		con.close();

} catch (Exception e) {
} %>

</body>
</html>