<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Available Routes</title>

</head>
<body>
	<%
	try {	
		out.print("<form method=\"post\" action=\"searchSchedulesQuery.jsp\">");
		
		
		//Get parameters from the HTML form at the index.jsp
		String origin = request.getParameter("origin");
		String destination = request.getParameter("destination");
		String date = request.getParameter("date");
		
		String origin_asc_desc = request.getParameter("origin_asc_desc");
		String destination_asc_desc = request.getParameter("destination_asc_desc");
		String fare_asc_desc = request.getParameter("fare_asc_desc");
		String departure_asc_desc = request.getParameter("departure_asc_desc");
		String arrival_asc_desc = request.getParameter("arrival_asc_desc");
		
		out.print("<input type = \"hidden\" name=\"origin\" value=\"" + origin + "\">");
		out.print("<input type = \"hidden\" name=\"destination\" value=\"" + destination + "\">");
		out.print("<input type = \"hidden\" name=\"date\" value=\"" + date + "\">");
		
		if(origin.isEmpty() || destination.isEmpty())  {
			out.println(" <a href='searchSchedules.jsp'>Please input origin, destination, and date.</a>");
			return;
		}
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		
		Statement stmt2 = con.createStatement();
		//String str2 = "select t1.rname, t1.name Origin, t2.name Destination, concat('$', t7.fare) Fare, t5.departure_time Departure_Time, t6.arrival_time Arrival_Time from ( select Routes.rname, Stations.name, Routes.stop_number from Routes, Stations where Routes.sid = Stations.sid and Routes.sid = " + origin + " ) t1, ( select Routes.rname, Stations.name, Routes.stop_number from Routes, Stations where Routes.sid = Stations.sid and Routes.sid = " + destination + " ) t2, ( select Routes.rname, Schedules.departure_time sched_depart_time, addtime(addTime(Routes.travel_time_to_get_here, time(Schedules.departure_time)), \"00:00:01\") departure_time, date(Schedules.departure_time) departure_date from Routes, Schedules where Routes.rname = Schedules.route_name and Routes.sid = " + origin + " ) t5, ( select Routes.rname, Schedules.departure_time, addTime(Routes.travel_time_to_get_here, time(Schedules.departure_time)) arrival_time from Routes, Schedules where Routes.rname = Schedules.route_name and Routes.sid = " + destination + " ) t6, ( select t8.rname, t9.fare - t8.fare fare from ( select Routes.rname, Routes.fare from Routes where Routes.sid = " + origin + " ) t8, ( select Routes.rname, Routes.fare from Routes where Routes.sid = " + destination + " ) t9 where t8.rname = t9.rname ) t7 where t1.rname = t2.rname and t1.rname = t5.rname and t1.rname = t6.rname and t5.sched_depart_time = t6.departure_time and t1.rname = t7.rname and t5.departure_date = \"" + date + "\" and t1.rname in (select t3.rname from (select Routes.rname, Routes.stop_number from Routes where Routes.sid = " + origin + " ) t3, (select Routes.rname, Routes.stop_number from Routes where Routes.sid =  " + destination + " ) t4 where t3.rname = t4.rname and t3.stop_number < t4.stop_number ) order by Origin asc, Destination asc, Fare asc, Departure_Time asc, Arrival_Time asc";
		//String str2 = "select t1.rname, t1.name Origin, t2.name Destination, concat('$', t7.fare) Fare, t5.departure_time Departure_Time, t6.arrival_time Arrival_Time from ( select Routes.rname, Stations.name, Routes.stop_number from Routes, Stations where Routes.sid = Stations.sid and Routes.sid = " + origin + " ) t1, ( select Routes.rname, Stations.name, Routes.stop_number from Routes, Stations where Routes.sid = Stations.sid and Routes.sid = " + destination + " ) t2, ( select Routes.rname, Schedules.departure_time sched_depart_time, addtime(addTime(Routes.travel_time_to_get_here, time(Schedules.departure_time)), \"00:00:01\") departure_time, date(Schedules.departure_time) departure_date from Routes, Schedules where Routes.rname = Schedules.route_name and Routes.sid = " + origin + " ) t5, ( select Routes.rname, Schedules.departure_time, addTime(Routes.travel_time_to_get_here, time(Schedules.departure_time)) arrival_time from Routes, Schedules where Routes.rname = Schedules.route_name and Routes.sid = " + destination + " ) t6, ( select t8.rname, t9.fare - t8.fare fare from ( select Routes.rname, Routes.fare from Routes where Routes.sid = " + origin + " ) t8, ( select Routes.rname, Routes.fare from Routes where Routes.sid = " + destination + " ) t9 where t8.rname = t9.rname ) t7 where t1.rname = t2.rname and t1.rname = t5.rname and t1.rname = t6.rname and t5.sched_depart_time = t6.departure_time and t1.rname = t7.rname and t5.departure_date = \"" + date + "\" and t1.rname in (select t3.rname from (select Routes.rname, Routes.stop_number from Routes where Routes.sid = " + origin + " ) t3, (select Routes.rname, Routes.stop_number from Routes where Routes.sid =  " + destination + " ) t4 where t3.rname = t4.rname and t3.stop_number < t4.stop_number ) order by Origin " + origin_asc_desc + ", Destination " + destination_asc_desc + ", Fare " + fare_asc_desc + ", Departure_Time " + departure_asc_desc + ", Arrival_Time " + arrival_asc_desc;
		String str2 = "select t1.rname, t1.name Origin, t2.name Destination, t7.fare Fare, t5.departure_time Departure_Time, t6.arrival_time Arrival_Time from ( select Routes.rname, Stations.name, Routes.stop_number from Routes, Stations where Routes.sid = Stations.sid and Routes.sid = " + origin + " ) t1, ( select Routes.rname, Stations.name, Routes.stop_number from Routes, Stations where Routes.sid = Stations.sid and Routes.sid = " + destination + " ) t2, ( select Routes.rname, Schedules.departure_time sched_depart_time, addtime(addTime(Routes.travel_time_to_get_here, time(Schedules.departure_time)), \"00:00:01\") departure_time, date(Schedules.departure_time) departure_date from Routes, Schedules where Routes.rname = Schedules.route_name and Routes.sid = " + origin + " ) t5, ( select Routes.rname, Schedules.departure_time, addTime(Routes.travel_time_to_get_here, time(Schedules.departure_time)) arrival_time from Routes, Schedules where Routes.rname = Schedules.route_name and Routes.sid = " + destination + " ) t6, ( select t8.rname, t9.fare - t8.fare fare from ( select Routes.rname, Routes.fare from Routes where Routes.sid = " + origin + " ) t8, ( select Routes.rname, Routes.fare from Routes where Routes.sid = " + destination + " ) t9 where t8.rname = t9.rname ) t7 where t1.rname = t2.rname and t1.rname = t5.rname and t1.rname = t6.rname and t5.sched_depart_time = t6.departure_time and t1.rname = t7.rname and t5.departure_date = \"" + date + "\" and t1.rname in (select t3.rname from (select Routes.rname, Routes.stop_number from Routes where Routes.sid = " + origin + " ) t3, (select Routes.rname, Routes.stop_number from Routes where Routes.sid =  " + destination + " ) t4 where t3.rname = t4.rname and t3.stop_number < t4.stop_number )";
		if ((arrival_asc_desc != null && arrival_asc_desc != "") || (departure_asc_desc != null && departure_asc_desc != "") || (origin_asc_desc != null && origin_asc_desc != "") || (destination_asc_desc != null && destination_asc_desc != "") || (fare_asc_desc != null && fare_asc_desc != "")) {
			str2 = str2.concat(" order by ");
		}
		if (arrival_asc_desc != null && arrival_asc_desc != "") { str2 = str2.concat("Arrival_Time " + arrival_asc_desc + ", "); }
		if (departure_asc_desc != null && departure_asc_desc != "") { str2 = str2.concat("Departure_Time " + departure_asc_desc + ", "); }
		if (origin_asc_desc != null && origin_asc_desc != "") { str2 = str2.concat("Origin " + origin_asc_desc + ", "); }
		if (destination_asc_desc != null && destination_asc_desc != "") { str2 = str2.concat("Destination " + destination_asc_desc + ", "); }
		if (fare_asc_desc != null && fare_asc_desc != "") { str2 = str2.concat("Fare " + fare_asc_desc + ", "); }
		//remove the trailing comma
		if (str2.charAt(str2.length() - 1) == ' ') { str2 = str2.substring(0, str2.length()-2); }
		
		out.print(str2 + "\n\n\n");
		ResultSet result2 = stmt2.executeQuery(str2);
		
		//check if there are no results
		if (!result2.first()) {
			out.println(" <a href='searchSchedules.jsp'>There were no routes found to get from the origin to destination.</a>");
			return;
		}
		result2.beforeFirst();
		
		//Table header
		out.println("<h2>Results</h2>");
		
		//Create the table
		out.print("<table border=1>");
		
		// Row of column headers
		out.print("<tr><td><b>Route Name</b></td>");
		out.print("<td><b>Origin</b></td>");
		out.print("<td><b>Destination</b></td>");
		out.print("<td><b>Fare (Dollars)</b></td>");
		out.print("<td><b>Departure Time</b></td>");
		out.print("<td><b>Arrival Time</b></td>");
		out.print("<td><b>Make Reservation</b></td></tr>");
		
		out.print("<tr><td></td>");
		
		out.print("<td><div class=\"custom-select\" type=\"text\" name=\"origin_asc_desc\" style=\"width:200px;\">");
		out.print("<select name=\"origin_asc_desc\">");
		out.print("<option value=\"\">No Ordering</option>");
		out.print("<option value=\"asc\">Ascending Order</option>");
		out.print("<option value=\"desc\">Descending Order</option></select></div></td>");
		
		out.print("<td><div class=\"custom-select\" type=\"text\" name=\"destination_asc_desc\" style=\"width:200px;\">");
		out.print("<select name=\"destination_asc_desc\">");
		out.print("<option value=\"\">No Ordering</option>");
		out.print("<option value=\"asc\">Ascending Order</option>");
		out.print("<option value=\"desc\">Descending Order</option></select></div></td>");
		
		out.print("<td><div class=\"custom-select\" type=\"text\" name=\"fare_asc_desc\" style=\"width:200px;\">");
		out.print("<select name=\"fare_asc_desc\">");
		out.print("<option value=\"\">No Ordering</option>");
		out.print("<option value=\"asc\">Ascending Order</option>");
		out.print("<option value=\"desc\">Descending Order</option></select></div></td>");
		
		out.print("<td><div class=\"custom-select\" type=\"text\" name=\"departure_asc_desc\" style=\"width:200px;\">");
		out.print("<select name=\"departure_asc_desc\">");
		out.print("<option value=\"\">No Ordering</option>");
		out.print("<option value=\"asc\">Ascending Order</option>");
		out.print("<option value=\"desc\">Descending Order</option></select></div></td>");
		
		out.print("<td><div class=\"custom-select\" type=\"text\" name=\"arrival_asc_desc\" style=\"width:200px;\">");
		out.print("<select name=\"arrival_asc_desc\">");
		out.print("<option value=\"\">No Ordering</option>");
		out.print("<option value=\"asc\">Ascending Order</option>");
		out.print("<option value=\"desc\">Descending Order</option></select></div></td></tr>");
		
		//parse out the results
		while (result2.next()) {
			out.print("<form id=\"data\" method=\"post\" action=\"makeAReservation.jsp\">");
			String row_rname = result2.getString("rname");
			String row_rname_no_space = row_rname.replaceAll("\\s", ""); 
			String row_origin = result2.getString("Origin");
			String row_destination = result2.getString("Destination");
			String row_fare = result2.getString("Fare");
			String row_departure_time = result2.getString("Departure_Time");
			String row_arrival_time = result2.getString("Arrival_Time");
			out.print("<tr><td>" + row_rname + "</td>");
			out.print("<td name=\"origin\">" + row_origin + "</td>");
			out.print("<td>" + row_destination + "</td>");
			out.print("<td>" + row_fare + "</td>");
			out.print("<td>" + row_departure_time + "</td>");
			out.print("<td>" + row_arrival_time + "</td>");
			out.print("<input type=\"hidden\" id=\"custId\" name=\"origin\" value="+row_origin+">");
			out.print("<input type=\"hidden\" id=\"custId\" name=\"rnamess\" value="+row_rname_no_space+">");
			out.print("<input type=\"hidden\" id=\"custIddfdffd\" name=\"Destination\" value="+row_destination+">");
			out.print("<input type=\"hidden\" id=\"custIgdgffd\" name=\"Fare\" value="+row_fare+">");
			out.print("<input type=\"hidden\" id=\"custgfdgfgId\" name=\"Departure_Time\" value="+row_departure_time+">");
			out.print("<input type=\"hidden\" id=\"cusgdfgfdgfdgtId\" name=\"Arrival_Time\" value="+row_arrival_time+">");
			//create a button that sends the necessary information (origin, destination, route name, etc.)
			//this doesn't work yet
			//This should help https://stackoverflow.com/questions/547821/two-submit-buttons-in-one-form
			out.print("<td><input class=\"btn\" type=\"submit\" method=\"post\" action=\"success.jsp\"value=\"Reserve Spot!\"></td></tr>");
			Statement stmtII = con.createStatement();
		//	String strII = "INSERT INTO Reservations (route_name,tid,departure_time,sid,userid,origin,destination,repid,booking_fee,total_cost,isWeekly,isMonthly,reserved_date,round_trip,one_way,seat_no) VALUES('" + row_rname + "','7058','2020-04-20 16:00:00',11,'ahmedkoura','"+ row_origin + "','destination','repid',10,100,1,1,'10:10:2010',1,0,1);";
			out.print("</form>");
		}
		out.print("</table>");
		
		out.print("</form>");
		
		Statement stmt = con.createStatement();
		String str = "select t3.rname Route_Name, t3.name Station, t3.Stop - t5.min_stop_number Stop, time(t4.Arrival_Time) Arrival_Time, time(t4.Departure_Time) Departure_Time from ( select r.rname, s.name, r.stop_number Stop from Routes r, Stations s where r.sid = s.sid and r.rname in (select rname from Routes, Stations where Routes.sid = Stations.sid and Stations.sid = " + origin + " ) and r.rname in (select rname from Routes, Stations where Routes.sid = Stations.sid and Stations.sid = " + destination + " ) and r.rname in (select t1.rname from	(select Routes.rname, Routes.stop_number from Routes where Routes.sid = " + origin + " ) t1, (select Routes.rname, Routes.stop_number from Routes where Routes.sid = " + destination + " ) t2 where t1.rname = t2.rname and t1.stop_number < t2.stop_number ) and r.stop_number >= any (select Routes.stop_number from Routes where Routes.sid = " + origin + " and Routes.rname = r.rname ) and r.stop_number <= any (select Routes.stop_number from Routes where Routes.sid = " + destination + " and Routes.rname = r.rname ) order by rname, stop_number ) t3, ( select Routes.rname, Routes.stop_number, addtime(Schedules.departure_time, Routes.travel_time_to_get_here) Arrival_Time, addTime(addTime(Schedules.departure_time, Routes.travel_time_to_get_here), \"00:01:00\") Departure_Time, stop_number Fare from Routes, Schedules where Routes.rname = Schedules.route_name order by Routes.rname, Arrival_Time, Routes.stop_number ) t4, ( select min(Routes.stop_number) as min_stop_number from Routes where Routes.sid = " + destination + " or Routes.sid  = " + origin + " ) t5 where t3.rname = t4.rname and t3.stop= t4.stop_number and \"" + date + "\" = date(t4.Arrival_Time) order by t3.rname, Arrival_Time, Stop";
		ResultSet result = stmt.executeQuery(str);
		//Table header
		out.println("<h3>All Stops for All Routes</h3>");
		
		//Make an HTML table to show the results in:
		out.print("<table border=1>");
		
		// Row of column headers
		out.print("<tr><td><b>Route Name</b></td>");
		out.print("<td><b>Station</b></td>");
		out.print("<td><b>Stop</b></td>");
		out.print("<td><b>Arrival Time</b></td>");
		out.print("<td><b>Departure Time</b></td>");
		
		//parse out the results
		while (result.next()) {
			out.print("<tr>");
			
			out.print("<td>");
			out.print(result.getString("Route_Name"));
			out.print("</td>");
		
			out.print("<td>");
			out.print(result.getString("Station"));
			out.print("</td>");
		
			out.print("<td>");
			out.print(result.getString("Stop"));
			out.print("</td>");
		
			out.print("<td>");
			out.print(result.getString("Arrival_Time"));
			out.print("</td>");
	
			out.print("<td>");
			out.print(result.getString("Departure_Time"));
			out.print("</td>");
		
			out.print("</tr>");
		
		}
		out.print("</table>");
		
		//close the connection.
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br><br>Schedule search failed.<br>");
	}
	%>
</body>
</html>