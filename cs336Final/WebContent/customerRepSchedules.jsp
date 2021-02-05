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

<%
try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Make a SELECT query of stations for drop down menu
	String dropdown = "SELECT route_name, departure_time FROM Schedules";
	//Run the query against the database.
	ResultSet lines; %>

<br>

<form method="post" action="crEditSchedule.jsp">
		<p>
			Select Line : <select name="line" id="line">
				<%
			lines = stmt.executeQuery(dropdown);
			while(lines.next())
			{
			String sname = lines.getString("route_name")+", "+lines.getString("departure_time") ; 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>

<input type="submit" value="Edit Schedule">
</form>

<form method="post" action="crDeleteSchedule.jsp">
		<p>
			Select Line : <select name="line" id="line">
				<%
			lines = stmt.executeQuery(dropdown);
			while(lines.next())
			{
			String sname = lines.getString("route_name")+", "+lines.getString("departure_time") ; 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>

<input type="submit" value="Remove Schedule">
</form>
<%
	String route="SELECT DISTINCT rname from Routes;";
	String tid="SELECT DISTINCT tid from Trains;";

%>
<form method="post" action="crAddSchedule.jsp">
		<p>
			Select Line : <select name="line" id="line">
				<%
			lines = stmt.executeQuery(route);
			while(lines.next())
			{
			String sname = lines.getString("rname"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>
				<p>
			Select Train ID : <select name="tid" id="tid">
				<%
			lines = stmt.executeQuery(tid);
			while(lines.next())
			{
			String sname = lines.getString("tid"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>
		
		Departure Time(YYYY-MM-DD HH:MM:SS): <input class="textInput" type="text" name="departure">

<input type="submit" value="Create Schedule">
</form>


<%		con.close();

} catch (Exception e) {
} %>

</body>
</html>