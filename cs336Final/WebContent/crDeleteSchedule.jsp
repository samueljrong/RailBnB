<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Departure</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = request.getParameter("line");
			String[] info = str.split(",");
			
			String query = "DELETE FROM Schedules WHERE route_name='"+info[0]+"' and departure_time='"+info[1]+"';";
			//Run the update against the database.
			int n = stmt.executeUpdate(query);
			out.print("Schedule"+info[0]+" "+info[1]+"deleted");
			
			con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>