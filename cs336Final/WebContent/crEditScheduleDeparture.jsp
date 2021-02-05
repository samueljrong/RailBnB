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

		String line = request.getParameter("line");
		String origdeparture = request.getParameter("origdeparture");

		String departure = request.getParameter("departure");

		String query = "SELECT addtime('" + departure
		+ "',travel_time_to_get_here)as arrival_time FROM Routes WHERE rname='" + line
		+ "' ORDER BY stop_number DESC;";

		ResultSet results = stmt.executeQuery(query);
		results.next();
		String arrival_time = results.getString("arrival_time");

		query = "UPDATE Schedules SET departure_time='" + departure + "',arrival_time='" + arrival_time
		+ "' WHERE route_name='" + line + "' and departure_time='" + origdeparture + "';";
		int n = stmt.executeUpdate(query);

		out.print("Schedule Updated- Departure Time:" + departure + " Arrival Time:" + arrival_time);

		// Create new alert for the delay
		//Make an insert statement for the Questions table:
		String insert = "INSERT INTO Questions(question, answer)" + "VALUES (?, ?)";

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, line); // 
		ps.setString(2, "Delay: " + line + ". New departure time: " + departure + ". New arrival time: " + arrival_time);
		//Run the query against the DB
		ps.executeUpdate();

		con.close();

	} catch (Exception e) {
	}
	%>




</body>
</html>