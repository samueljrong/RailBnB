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
<title>Logging in...</title>

</head>
<body>
<b>Reservation have been created</b>

<br>
	<%
	
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		Object usename = String.valueOf(session.getAttribute("user"));
		//Get parameters from the HTML form at the index.jsp
		//String userid = request.getParameter("user");

		
        /////////////////
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String datenow = sdf.format(new Date());
		////////
    String origin = request.getParameter("origin");
	String Destination = request.getParameter("Destination");
	String Departure_Time = request.getParameter("Departure_Time");
	String Arrival_Time = request.getParameter("Arrival_Time");
	String type = request.getParameter("type");
	String Fare = request.getParameter("Fare");
	Float fFare; 
	int isitweekly = 0;
	int isitmonthly = 0;
	if(type == "monthly"){
		 fFare = Float.valueOf(Fare) * 30f;
		 out.print("lololo");
	}
	else if(type == "weekly"){
		 fFare = Float.valueOf(Fare) * 7f;
	}else{
		 fFare = Float.valueOf(Fare) ;
	
	}
	String rname = request.getParameter("rnamess");
	
	//if("NECorridorNorth" == request.getParameter("rnamess")){
	//	 rname = "NE Corridor North";
	//}else{
	//	rname = "NE ggggggCorridor North";
	//}
	//out.print(rname);
	Statement st = con.createStatement();
		//Make an insert statement for the Login table:
		int i = st.executeUpdate("INSERT INTO Reservations (route_name,tid,departure_time,sid,userid,origin,destination,repid,booking_fee,total_cost,isWeekly,isMonthly,reserved_date,round_trip,one_way,seat_no) VALUES('NE Corridor North Express','7058','"+Departure_Time+"',11,'"+usename+"','"+origin+"','"+Destination+"','NULL',10,"+fFare+",1,1,'"+datenow+"',1,0,1);");
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		
	%>
		</form>
		<br>
		<form method="post" action="viewReservation.jsp">
		<input class="btn" type="submit" value="view reservations">
	</form>
</body>
</html>