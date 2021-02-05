<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Answer</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the rid from the customerRepAltReservations.jsp
			String repid=request.getParameter("repid");
			String qid=request.getParameter("qid");
			String answer=request.getParameter("answer");
			//Make a SELECT query from the reservations table with all fields from the previosly entered rid
			//String query = "SELECT * FROM Reservations WHERE rid='" + rid + "'";
			//Run the query against the database.
			String update="UPDATE Questions SET eid='"+repid+"', answer='"+answer+"' WHERE qid='"+qid+"';";
			int n=stmt.executeUpdate(update);
			
			out.print("Answer Sent");
			
			
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>