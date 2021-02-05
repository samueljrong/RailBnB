<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedules by Station</title>
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

			String station = request.getParameter("station");

			String query = "select t1.rname, t1.name, t1.stop_number, t1.arrival_time, t1.tid from "
			+"(select Routes.rname, Schedules.tid, Stations.name, Routes.stop_number, addtime(Routes.travel_time_to_get_here, Schedules.departure_time) arrival_time, Schedules.route_name, Schedules.departure_time, Routes.fare from Routes, Schedules, Stations where Routes.rname = Schedules.route_name and Routes.sid = Stations.sid and Stations.name='"
					+ station + "' order by Routes.rname, Schedules.departure_time, Routes.stop_number) t1;";

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
			out.print("Station");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Stop");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arrival Time");
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
				out.print(result.getString("t1.name"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("t1.stop_number"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("t1.arrival_time"));
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