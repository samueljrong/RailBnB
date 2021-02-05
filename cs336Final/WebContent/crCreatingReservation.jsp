<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Making Reservation</title>
</head>
<body>
	<%
	
	
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String rid = request.getParameter("rid");
			String rname = request.getParameter("rname");
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			String trip = request.getParameter("trip");
			String departure = request.getParameter("departure");
			String clas = request.getParameter("class");
			String userid=request.getParameter("userid");
			String repid=request.getParameter("repid");
			
			
			
			String query = "SELECT tid FROM Schedules WHERE route_name='"+rname+"' and departure_time='"+departure+"';";
			//Run the update against the database.
			ResultSet results=stmt.executeQuery(query);
			results.next();
			String tid=results.getString("tid");
			//out.print("tid:"+tid+"--");
			
			query="SELECT (R2.fare-R.fare) as fare, addtime('"+departure+"', R.travel_time_to_get_here) as departure_time FROM Routes R, Stations S, Routes R2, Stations S2 WHERE S.name='"+origin+"' and R.sid=S.sid and R.rname='"+rname+"' and S2.name='"+destination+"' and R2.sid=S2.sid and R2.rname='"+rname+"';";
			
			ResultSet rQuery=stmt.executeQuery(query);
			rQuery.next();
			String f=rQuery.getString("fare");
			float fare=Float.parseFloat(f.trim());
			String departure_time=rQuery.getString("departure_time");
			//out.print("--fare:"+fare+"--");
			
			
			query="SELECT (S.seat_number) as seat_no FROM Seats S WHERE S.seat_class='"+clas+"' and S.trains_tid='"+tid+"' and NOT EXISTS(SELECT * FROM Reservations R WHERE R.seat_no=S.seat_number);";
			ResultSet sQuery=stmt.executeQuery(query);
			sQuery.next();
			String seat_no=sQuery.getString("seat_no");
			//out.print("--seat"+seat_no);
			
			
			int Ccost;
			if(clas.equals("first"))
				Ccost=3;
			else if(clas.equals("business"))
				Ccost=2;
			else 
				Ccost=1;
			
			boolean isMonthly=false, isWeekly=false;
			
			if(trip.equals("isMonthly")){
				isMonthly=true;
				fare=fare*6;
			}
			else if(trip.equals("isWeekly")){
				isWeekly=true;
			    fare=fare*3;
			}
			
			int totalcost=(int)fare+Ccost;
			//out.print("--"+totalcost);
			//out.print("--departure:"+departure_time);
			
			query="INSERT INTO Reservations(rid,route_name,tid,departure_time,origin,destination,userid,booking_fee,total_cost,seat_no,isWeekly,isMonthly,reserved_date,repid)"+
			"VALUES('"+rid+"', '"+rname+"','"+tid+"','"+departure_time+"','"+origin+"','"+destination+"','"+userid+"','1','"+totalcost+"','"+seat_no+"',"+isWeekly+","+isMonthly+",NOW(),'"+repid+"');";
			int n = stmt.executeUpdate(query);
			
			out.print("DONE");
			
			if(trip.equals("round_trip")){}//IDK
			
			

			
			con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>