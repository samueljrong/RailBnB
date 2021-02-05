<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Reservation</title>
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
			
			//Make a SELECT query from the reservations table with all fields from the previosly entered rid
			String query = "SELECT MAX(rid) as maxRid FROM Reservations;";
			
			ResultSet result = stmt.executeQuery(query);
			int rid;
			result.next();
			rid=Integer.parseInt(result.getString("maxRid"));
			rid++;
			
			String userid = request.getParameter("userid");
			String str = request.getParameter("line");
			String[] info=str.split(",");
			String trip = request.getParameter("trip");
			
			out.println(info[0]);
			out.println(info[1]);
			out.println(rid);
			
			String repid=request.getParameter("repid");
			
			query="SELECT S.name FROM Stations S, Routes R WHERE R.rname = '"+info[0]+"' and R.sid=S.sid;";
			ResultSet stations;
			
			%>
	<form method="post" action="crCreatingReservation.jsp">
		<input type="hidden" name="rid" value="<%=rid %>"> 
		<input type="hidden" name="rname" value="<%=info[0] %>"> 
		<input type="hidden" name="departure" value="<%=info[1] %>"> 
		<input type="hidden" name="trip" value="<%=trip%>">
		<input type="hidden" name="userid" value="<%=userid%>">
		<input type="hidden" name="repid" value="<%=repid%>"> 



		<p>
			Select Origin : <select name="origin" id="origin">
				<%
				stations= stmt.executeQuery(query);
			while(stations.next())
			{
			String sname = stations.getString("S.name"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
			</p>
<br>
			
		<p>
			Select Destination : <select name="destination" id="destination">
				<%
				stations= stmt.executeQuery(query);
			while(stations.next())
			{
			String sname = stations.getString("S.name"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
			</p>
		<br>
		 <p>
		Select seat type: <select name="class">
			<option value="economy">Economy Class</option>
			<option value="business">Business Class</option>
			<option value="first">First Class</option>
		</select> 
		
		</p>
		<br> 
		<input type="submit" value="Make Reservation" />
	</form>


	<%


						con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>