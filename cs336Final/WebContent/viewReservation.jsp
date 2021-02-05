<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title><b>Your reservations</b></title>
</head>
<body>
<%
		try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Object usename = String.valueOf(session.getAttribute("user"));
		String koko = request.getParameter("rid_to_be_deleted");
		if(koko !=null){
			//String str2 = "DELETE  FROM BookingSystem.Reservations where rid = "+koko+" ;";
			int i = stmt.executeUpdate("DELETE  FROM BookingSystem.Reservations where rid = "+koko+" ;");
		}
		String str = "SELECT * FROM BookingSystem.Reservations where userid = '"+usename+"' ;";
		ResultSet result = stmt.executeQuery(str);

		//Run the query against the database.
		

		//Make an HTML table to show the results in:
		out.print("<table border=1>");

		// Row of column headers
		out.print("<tr>");

		out.print("<td>");
		out.print("<b>Reservation ID</b>"); //qid
		out.print("</td>");

		out.print("<td>");
		out.print("<b>customer ID </b>"); //qid
		out.print("</td>");
		
		out.print("<td>");
		out.print("<b>Departure time</b>");
		out.print("</td>");

		out.print("<td>");
		out.print("<b>origin</b>");
		out.print("</td>");

		out.print("<td>");
		out.print("<b>Destination</b>"); //cid
		out.print("</td>");


		out.print("<td>");
		out.print("<b>roundtrip</b>");
		out.print("</td>"); 
		
		out.print("<td>");
		out.print("<b>totalcost</b>"); //eid
		out.print("</td>");
		
		out.print("</tr>");
//	18	NE Corridor North Express	7058	2017-05-01 00:00:00	11	f	Hamilton	New_brunswick	repid	10	100	1	1	2020-05-01	1	0	1
		//parse out the results
		while (result.next()) {
			// A row of a question, answer, and identifying info
			out.print("<tr>");

			// Print question id
			out.print("<td>");
			out.print(result.getInt("rid"));
			out.print("</td>");

			out.print("<td>");
			out.print(result.getString("userid"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(result.getString("departure_time"));
			out.print("</td>");

			out.print("<td>");
			out.print(result.getString("origin"));
			out.print("</td>");

			
			out.print("<td>");
			out.print(result.getString("destination"));
			out.print("</td>");

			out.print("<td>");
			if(result.getInt("round_trip")== 1){
				out.print("yes");
			}else{
				out.print("no");	
			};
			out.print("</td>");  
			
			// Print employee id
			out.print("<td>");
			out.print(result.getString("total_cost"));
			out.print("</td>");
			out.print("<td>");
			
            %>
	        <form method="post" action="viewReservation.jsp">
	        <%
	        out.print("<input type=\"hidden\" id=\"custId\" name=\"rid_to_be_deleted\" value="+result.getInt("rid")+">");
	        
	        %>
			<input class="btn" type="submit" value="cancel reservation">
		    </form>
            <% 
            out.print("</td>");
            out.print("</tr>");
		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("query failed");
	}
	%>
</body>
</html>