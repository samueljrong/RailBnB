<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedules by Origin to Destination</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String origin = (request.getParameter("origin"));

			String destination = (request.getParameter("destination"));

			String query = "select t1.rname, t1.origin, t1.destination, t1.stops, t1.departure_time, t1.arrival_time, t1.fare, t1.tid from (select R.rname, S.name origin, S2.name destination, (R2.stop_number-R.stop_number) as stops, addtime(R.travel_time_to_get_here, C.departure_time) departure_time, addtime(R2.travel_time_to_get_here, C.departure_time)arrival_time, (R2.fare-R.fare) as fare, C.tid from Routes R, Schedules C, Stations S, Routes R2, Stations S2 where R.rname = C.route_name and R.sid = S.sid and S.name='"
					+ origin + "' and R2.rname = C.route_name and R2.sid = S2.sid and S2.name='" + destination
					+ "' and R.stop_number<R2.stop_number and R.rname=R2.rname order by R.rname, departure_time, R.stop_number) t1;";

			ResultSet result = stmt.executeQuery(query);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("Route");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Origin");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Destination");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Stops");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Deparure Time");
			out.print("</td>");
			
			//make a column
			out.print("<td>");
			out.print("Arrival Time");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Fare");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Train ID");
			out.print("</td>");

			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("t1.rname"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("t1.origin"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("t1.destination"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("t1.stops"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("t1.departure_time"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("t1.arrival_time"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("t1.fare"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("t1.tid"));
				out.print("</td>");

				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>