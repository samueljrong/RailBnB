<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Tid</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String line = request.getParameter("line");
			String departure = request.getParameter("departure");
			out.print("Line:"+line);
			%><br><%
			out.print(" Departure Time:"+departure);
			%><br><%
		
			
			String tid = request.getParameter("tid");
			
			String update="UPDATE Schedules SET tid='"+tid+"' WHERE route_name='"+line+"' and departure_time='"+departure+"';";
			int n=stmt.executeUpdate(update);
			
			
			out.print("Schedule now operating with train:"+tid);
			con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>