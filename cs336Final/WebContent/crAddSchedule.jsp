<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Schedule</title>
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
	String line = request.getParameter("line");
	String tid = request.getParameter("tid");
	String departure = request.getParameter("departure");
	
	
	%><br><%
	
	String arrivalQuery="SELECT addtime('"+departure+"',travel_time_to_get_here)as arrival_time FROM Routes WHERE rname='"+line+"' ORDER BY stop_number DESC;";
	ResultSet arrival = stmt.executeQuery(arrivalQuery);
	arrival.next();
	String arrival_time=arrival.getString("arrival_time");
	
	String insert ="INSERT INTO Schedules(route_name,departure_time,arrival_time,tid) VALUES('"+line+"','"+departure+"','"+arrival_time+"','"+tid+"');";
	int n = stmt.executeUpdate(insert);
	
	out.print("Schedule added- Route:"+line+" departure:"+departure+" arrival:"+arrival+" Train ID:"+tid);

	

	
	
	con.close();

} catch (Exception e) {
}
%>




</body>
</html>