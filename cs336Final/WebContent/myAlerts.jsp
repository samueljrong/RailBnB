<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title>My Alerts</title>
</head>
<body>

	<h2>My Alerts</h2>
	<br>
	<form method="post" action="userHomepage.jsp">
		<input class="btn" type="submit" value="Homepage">
	</form>
	<br>

	<%
		try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		
		// Get all alerts (differentiated from questions by lack of cid and eid)
		String alertStr = "SELECT * FROM Questions where cid IS NULL and eid IS NULL";
		//Run the query against the database.
		ResultSet alertResults = stmt1.executeQuery(alertStr);
		
		//Make an HTML table to show the results in:
		out.print("<table border=1>");

		// Row of column headers
		out.print("<tr>");

		out.print("<td>");
		out.print("<b>Reservation Affected</b>");
		out.print("</td>");

		out.print("<td>");
		out.print("<b>Delay</b>");
		out.print("</td>");
		//parse out the results
		while (alertResults.next()) {
			String reserveStr = "SELECT * FROM Reservations where userid='" + session.getAttribute("user").toString() + "' and route_name='" + alertResults.getString("question") + "'";
			ResultSet reservationResults = stmt2.executeQuery(reserveStr);
			while (reservationResults.next()) {
				if (reservationResults.getString("rid").length() > 0) {
					out.print("<tr>");
			
					out.print("<td>");
					out.print(reservationResults.getString("rid"));
					out.print("</td>");
			
					out.print("<td>");
					out.print(alertResults.getString("answer"));
					out.print("</td>");
			
					out.print("</tr>");
				}
			}
		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("query failed");
	}
	%>
</body>
</html>