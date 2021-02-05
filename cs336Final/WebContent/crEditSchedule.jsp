<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Schedule</title>
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
			String str = request.getParameter("line");
			String[] info = str.split(",");

			
	%><br>
	<%
		//String arrivalQuery="SELECT travel_time_to_get_here FROM Routes WHERE rname="+info[0]+"";
			//ResultSet arrival = stmt.executeQuery(arrivalQuery);

			//String insert ="INSERT INTO Schedules(route_name,departure_time,arrival_time,tid) VALUES("+info[0]+","+departure+","+departure+","+tid+")";
			//int n = stmt.executeUpdate(insert);
			//Statement st = con.createStatement();
			
			String tid="SELECT DISTINCT tid from Trains;";
			ResultSet dropdown=stmt.executeQuery(tid);
			
	%>
	<form method="post" action="crEditScheduleDeparture.jsp">
	<input type="hidden" name="line" value="<%=info[0]%>">
	<input type="hidden" name="origdeparture" value="<%=info[1]%>">
	
		Departure Time(YYYY-MM-DD HH:MM:SS): <input class="textInput" type="text" name="departure"> 
			
			<input type="submit" value="Change Departure Time">
	</form>
	
	<br>
	
	<form method="post" action="crEditScheduleTid.jsp">
	
	<input type="hidden" name="line" value="<%=info[0]%>">
	<input type="hidden" name="departure" value="<%=info[1]%>">

		Select Train ID : <select name="tid" id="tid">
				<%
			
			while(dropdown.next())
			{
			String sname = dropdown.getString("tid"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
			
			<input type="submit" value="Change TrainID">
	</form>	

	<%
		con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>