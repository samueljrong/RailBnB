<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Admin | Sales Report</title>
	<style>
	*,html {
		margin: 0;
		padding: 0;
	}
	.body {
		color: #fff;
	}
	.container {
		width: 600px;
		margin: 60px 200px;
		padding: 30px;
		font-family: Arial, sans-serif;
		background-color: #cff0ff;
	}
	.container h2 {
		text-align: center;	
	}
	.container h4 {
		text-align: center;
		font-size: 20px;
	}
	.buttonDiv {
		text-align: center;
		margin: 0px auto;
		padding: 5px;
	}
	.logoutDiv {
		text-align: right;
		margin: 0px;
		padding: 5px;
		display: inline-block;
	}
	.backBtnDiv {
		display: inline;
	}
	.btn {
		background-color: #9c9c9c;
		color: #fff;
		padding: 5px;
		cursor: pointer;
	}
	.topCell {
		background-color: #c9c9c9;
	}
	td {
		background-color: #fff;
		padding: 5px 3px;
		font-size: 16px;
		text-align: center;
	}
	.messageBox {
		background-color: #cff0ff;
		margin: 30px 150px;
		padding: 20px;
		width: 250px;
		text-align: center;
	}
	</style>
</head>
<body>
	<div class="container">
		
		<div class="logoutDiv">
			<form method="post" action="logout.jsp">
				<input class="btn" type="submit" value="Log Out">
			</form>
		</div>
		<div class="backBtnDiv">
			<form method="post" action="admin.jsp">
				<input class="btn" type="submit" value="<- Back">
			</form>
		</div>
		<h2>Sales Report</h2>
		
		<%
			String m = request.getParameter("month").toString();
			String y = request.getParameter("year").toString();
			
			if(m.equals(null) || m.isEmpty() || y.equals(null) || y.isEmpty()){
				out.println("<div class='messageBox'>Invalid input.<br> <a href='adminSalesReport.jsp'>Go Back</a></div>");
				return;
			}else{
				if(y.length() != 4){
					out.println("<div class='messageBox'>Please enter year as (YYYY).<br> <a href='adminSalesReport.jsp'>Go Back</a></div>");
					return;
				}
				
				for(int i = 0; i < m.length(); i++){
					if(!Character.isDigit(m.charAt(i))){
						out.println("<div class='messageBox'>Invalid input.<br> <a href='adminSalesReport.jsp'>Go Back</a></div>");
						return;
					}
				}
				for(int i = 0; i < y.length(); i++){
					if(!Character.isDigit(y.charAt(i))){
						out.println("<div class='messageBox'>Invalid input.<br> <a href='adminSalesReport.jsp'>Go Back</a></div>");
						return;
					}
				}
			}
			
			int month = Integer.parseInt(m);
			int year = Integer.parseInt(y);
		
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			
			Class.forName("com.mysql.jdbc.Driver");
			ResultSet rs;
			ResultSet tots;
			
			try{ 
				String total = "SELECT SUM(booking_fee) as total FROM Reservations WHERE MONTH(reserved_date)= "+month+" and YEAR(reserved_date) = "+year;
				tots = stmt2.executeQuery(total);
				if(tots.next()){
				%>
				<h4><%=month %> / <%=year %></h4><br>
				<h4>Total: $<%if(tots.getString("total") == null || tots.getString("total").equals("null")) { out.print("0.0"); }else out.print(tots.getString("total")); %>0</h4>
				<br>
				<%
				
				}
			}catch (Exception e) {
				e.printStackTrace();
				out.println("<div class='messageBox'>Invalid input.<br> <a href='adminSalesReport.jsp'>Go Back</a></div>");
				return;
			}
				
			
			%>
			<table align="center" cellpadding="0" cellspacing="0" border="1">
				<tr>
				<td class="topCell"><b>Transit Name</b></td>
				<td class="topCell"><b>Revenue</b></td>
				</tr>
				<%
					try{ 
						String revenues = "SELECT route_name, SUM(booking_fee) as revenue FROM Reservations WHERE MONTH(reserved_date)="+month+" and YEAR(reserved_date)="+year+" GROUP BY route_name";
						
						rs = stmt.executeQuery(revenues);
						
						
						while(rs.next()){
						%>
							<tr>
							<td><%=rs.getString("route_name") %></td>
							<td>$<%=rs.getString("revenue") %>0</td>
							</tr>
						
						<% 
					}
					con.close();
					} catch (Exception e) {
						e.printStackTrace();
						out.println("<div class='messageBox'>Invalid input.<br> <a href='adminSalesReport.jsp'>Go Back</a></div>");
						return;
					}
		%>
			</table>
	</div>
</body>
</html>