<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customers by Line</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String line = (request.getParameter("line"));

			String tid = (request.getParameter("tid"));

			String query = "SELECT DISTINCT C.fname, C.lname FROM Customers C, Reservations R WHERE C.userid=R.userid and R.tid='"+tid+"' and R.route_name='"+line+"';"; 

			ResultSet result = stmt.executeQuery(query);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("First");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Last");
			out.print("</td>");

			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("C.fname"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("C.lname"));
				out.print("</td>");
						

				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>