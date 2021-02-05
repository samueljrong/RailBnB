<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>

	<%
		if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in
	<br />
	<a href="index.jsp">Please Login</a>
	<%
		} else {
	%>
	<b>
	Welcome
	</b>
	<%   Object usename = String.valueOf(session.getAttribute("user"));
	     out.print(usename);
	     %>
	<a href='logout.jsp'>Log out</a>
	<%
		}
	%>
	<form id="reservation" method="post" action="sucessReservation.jsp">
	<% 
	//Get the database connection
	out.println("<p><b>Make a reservation</b><br>");
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Get parameters from the HTML form at the index.jsp

	Class.forName("com.mysql.jdbc.Driver");
	Statement st = con.createStatement();
	ResultSet rs;
	String origin = request.getParameter("origin");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String datenow = sdf.format(new Date());
	String Destination = request.getParameter("Destination");
	String Departure_Time = request.getParameter("Departure_Time");
	String Arrival_Time = request.getParameter("Arrival_Time");
	String Fare = request.getParameter("Fare");
	String rname = request.getParameter("rnamess");
	out.print("<input type=\"hidden\" id=\"custId\" name=\"origin\" value="+origin+">");
	out.print("<input type=\"hidden\" id=\"custId\" name=\"rnamess\" value="+rname+">");
	out.print("<input type=\"hidden\" id=\"custId\" name=\"Destination\" value="+Destination+">");
	out.print("<input type=\"hidden\" id=\"custId\" name=\"Fare\" value="+Fare+">");
	out.print("<input type=\"hidden\" id=\"custId\" name=\"Departure_Time\" value="+Departure_Time+">");
	out.print("<input type=\"hidden\" id=\"custId\" name=\"Arrival_Time\" value="+Arrival_Time+">");
	

	
%>
  <br>---<br> 
  <label for="isitweekly">is it a one trip ticket or weekly or monthly : </label>
  <select id="isitweekly" name="type">
  <option value="weekly">weekly</option>
  <option value="monthly">monthly</option>
  <option value="onetrip">onetrip</option>
</select>
 <br>---<br> 

<br> 
<input class="btn" type="submit" value="Make a reservation">
</form>
</body>
</html>