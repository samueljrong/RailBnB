<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change trip type</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			//Statement stmt = con.createStatement();
			//Get the rid from the customerRepAltReservations.jsp
			String rid = request.getParameter("rid");
			String trip=(request.getParameter("trip"));
			


			Statement st = con.createStatement();
			String tripUpdate = "UPDATE Reservations SET one_way=false, round_trip=false, isMonthly=false, isWeekly=false WHERE rid='"+rid+"';";
			int n = st.executeUpdate(tripUpdate);

			tripUpdate = "UPDATE Reservations SET "+trip+"=true  WHERE rid='"+rid+"';";
			n = st.executeUpdate(tripUpdate);
			
			out.println("Trip Updated to: " +trip );

			con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>