<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
	String userid=request.getParameter("userid");
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		Class.forName("com.mysql.jdbc.Driver");
		
		int i=stmt.executeUpdate("DELETE FROM Customers WHERE userid='"+userid+"'");
		out.println("Customer Deleted Successfully!<br><br><a href='adminCustomerList.jsp'>Go Back to the Customer List</a>");
		con.close();
	}
	catch(Exception e){
		System.out.print(e);
		e.printStackTrace();
	}
%>