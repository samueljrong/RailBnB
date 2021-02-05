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
			String lineQuery = "SELECT DISTINCT rname FROM Routes;";
			//Run the query against the database.
			//ResultSet line  = stmt.executeQuery(lineQuery);
			String trainQuery = "SELECT DISTINCT tid FROM Trains;";
			//Run the query against the database.
			//ResultSet train  = stmt.executeQuery(trainQuery);
					
			%>



	<form method="post" action="crListCustomers.jsp">
	
	<%ResultSet line  = stmt.executeQuery(lineQuery);%>

		<p>
			Select Train Line : <select name="line" id="line">
				<%
			while(line.next())
			{
			String sname = line.getString("rname"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
		</p>


		<%ResultSet train  = stmt.executeQuery(trainQuery); %>
		<p>
			Select Train ID : <select name="tid" id="tid">
				<%
			while(train.next())
			{
			String sname = train.getString("tid"); 
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