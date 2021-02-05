<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative Home</title>
</head>
<body>

<%String repid=request.getParameter("repid"); %>

	<b>Customer Representative Home</b>
	<br>
	<form method="get" action="customerRepAltReservation.jsp"> 
		<input type="hidden" name="repid" value="<%=repid%>"> 
		
		<input type="submit" value="Alter Reservations">
	</form>
	<br>
	<form method="get" action="customerRepSchedules.jsp"> 
		<input type="hidden" name="repid" value="<%=repid%>"> 
		
		<input type="submit" value="Alter Schedules">
	</form>
	<br>
	<form method="get" action="customerRepAnswer.jsp"> 
		<input type="hidden" name="repid" value="<%=repid%>"> 
		
		<input type="submit" value="Answer Customer Questions">
	</form>
	<br>
	<form method="get" action="customerRepSearchSchedules.jsp"> 
		<input type="hidden" name="repid" value="<%=repid%>"> 
		
		<input type="submit" value="Search Train Schedules">
	</form>
	<br>
	<form method="get" action="customerRepReservation.jsp"> 
		<input type="hidden" name="repid" value="<%=repid%>"> 
		
		<input type="submit" value="Search Customer Reservations">
	</form>
	<br>
	
	

</body>
</html>