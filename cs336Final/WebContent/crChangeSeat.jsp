<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change trip type</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();


			String rid = request.getParameter("rid");
			String repid = request.getParameter("repid");
			String clas=(request.getParameter("class"));
		
			


			Statement st = con.createStatement();
			
			
			String query="SELECT tid FROM Reservations WHERE rid='"+rid+"'; ";
			ResultSet r=st.executeQuery(query);
			r.next();
			String tid=r.getString("tid");
			
			query="SELECT S.seat_number FROM Seats S WHERE S.seat_class='"+clas+"' and S.trains_tid='"+tid
					+"' and NOT EXISTS (SELECT * FROM Reservations R WHERE R.seat_no=S.seat_number and R.tid=S.trains_tid);";
			
					r=st.executeQuery(query);
					r.next();
					String seat_no=r.getString("S.seat_number");
					
					
					
			String tripUpdate = "UPDATE Reservations SET seat_no='"+seat_no+"' WHERE rid='"+rid+"';";
			int n = st.executeUpdate(tripUpdate);
			
			out.println("Seat Number Updated :"+seat_no);

			con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>