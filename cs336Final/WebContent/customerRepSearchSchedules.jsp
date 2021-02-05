<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Schedules</title>
</head>
<body>

	<%
		//List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query of stations for drop down menu
			String dropdown = "SELECT * FROM Stations";
			//Run the query against the database.
			ResultSet stations = stmt.executeQuery(dropdown);
					
			%>



	<form method="post" action="customerRepStation.jsp">
		<p>
			Select Station : <select name="station">
				<%
			while(stations.next())
			{
			String sname = stations.getString("name"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>
		<input type="submit" value="Search">
	</form>

	<br>







	<form method="post" action="customerRepOrgDest.jsp">

		<% 
	stations = stmt.executeQuery(dropdown);
	%>
		<p>
			Select Origin : <select name="origin" id="origin">
				<%
			while(stations.next())
			{
			String sname = stations.getString("name"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>


		<% 
	stations = stmt.executeQuery(dropdown);
	%>
		<p>
			Select Destination : <select name="destination" id="destination">
				<%
			while(stations.next())
			{
			String sname = stations.getString("name"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>

		<input type="submit" value="Search" />
	</form>


	<%
			
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>