<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Reservation</title>
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
			String rid = request.getParameter("rid");
			String repid=request.getParameter("repid");
			//Make a SELECT query from the reservations table with all fields from the previosly entered rid
			String query = "SELECT * FROM Reservations WHERE rid='" + rid + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//parse out the results for reservation
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out origin-destination:
				out.print(result.getString("origin"));
				out.print("-");
				out.print(result.getString("destination"));
				out.print("</td>");
				out.print("<td>");
				//Print out type:
				if (result.getBoolean("isMonthly"))
					out.print("Monthly");
				else if (result.getBoolean("isWeekly"))
					out.print("Weekly");
				else if (result.getBoolean("one_way"))
					out.print("One way");
				else if (result.getBoolean("round_trip"))
					out.print("Round Trip");
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td>");
				//Print out departure time
				out.print("Departure Time:");
				out.print(result.getString("departure_time"));
				out.print("</td>");
				out.print("</tr>");
			}

			String seatsQuery = "SELECT seat_number, seat_class FROM Seats S, Reservations R WHERE R.rid='" + rid + "' and R.seat_no=S.seat_number";
			result = stmt.executeQuery(seatsQuery);

			//parse results for seats
			result.next();
			{
				out.print("<tr>");
				out.print("<td>");
				//Print out seat number
				out.print("Seat Number:");
				out.print(result.getString("seat_number"));
				out.print("</td>");
				out.print("<td>");
				//Print out seat class
				out.print("Class:");
				out.print(result.getString("seat_class"));
				out.print("</td>");
				out.print("</tr>");
			}

			out.print("</table>");
			
			//change addseat to change seat
	%>
	<br>
	<form method="get" action="crChangeSeat.jsp"> 
		<input type="hidden" name="rid" value="<%=rid%>">
		<input type="hidden" name="repid" value="<%=repid%>">
		 
		Select seat type: <select name="class">
			<option value="first">First Class</option>
			<option value="business">Business Class</option>
			<option value="economy">Economy Class</option>
			</select>
		<input type="submit" value="Change Seat Class">
	</form>
	<br>

<%query="SELECT distinct(t1.departure), t1.tid FROM (SELECT addtime(S.departure_time,R.travel_time_to_get_here) as departure , S.tid as tid FROM Schedules S, Reservations C, Routes R, Stations T WHERE C.rid='"+rid+"'and S.route_name=C.route_name and C.origin=T.name and R.sid=T.sid and R.rname=C.route_name)t1;";
 %>
	<br>
	<form method="get" action="crChangeDate.jsp">
	<input type="hidden" name="repid" value="<%=repid%>">
		<input type="hidden" name="rid" value="<%=rid%>"> 
		<p>
			Select Departure DateTime : <select name="date" id="date">
				<%
				result= stmt.executeQuery(query);
			while(result.next())
			{
			String sname = result.getString("t1.departure")+","+result.getString("t1.tid"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
			</p>
		
		 <input type="submit" value="Change Date/Time">
	</form>
	<br>
	<form method="get" action="crChangeTripType.jsp">
	<input type="hidden" name="repid" value="<%=repid%>">
		<input type="hidden" name="rid" value="<%=rid%>"> Select trip
		type: <select name="trip">
			<option value="one_way">One way</option>
			<option value="round_trip">Round</option>
			<option value="isMonthly">Month</option>
			<option value="isWeekly">Week</option>
			</select>
			<input type="submit" value="Change Trip">
	</form>

	<%  //add change origin/destination
		//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>