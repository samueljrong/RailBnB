<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Creating Employee...</title>
<style>
	.messageBox {
		background-color: #cff0ff;
		margin: 0px 150px;
		padding: 20px;
		width: 250px;
		text-align: center;
	}
</style>
</head>
<body>
	<%
		try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the index.jsp
		String ssn = request.getParameter("ssn");
		String fname = request.getParameter("fName");
		String lname = request.getParameter("lName");
		String userid = request.getParameter("userName");
		String pwd = request.getParameter("pass");
		String role = request.getParameter("role");
		
		
		// Username Checks
		if(userid.isEmpty() || userid.length() > 20) {
			out.println("<div class='messageBox'>Invalid username <a href='adminNewEmployee.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		for(int i = 0; i < userid.length(); i++){
			if(Character.isWhitespace(userid.charAt(i))){
				out.println("<div class='messageBox'>Invalid username <a href='adminNewEmployee.jsp'>Try Again</a></div>");
				con.close();
				return;
			}
		}
		Class.forName("com.mysql.jdbc.Driver");
		Statement userSt = con.createStatement();
		ResultSet userSet = userSt.executeQuery("SELECT * FROM Employees WHERE username='" + userid + "'");
		
		if(userSet.next()){
			out.println("<div class='messageBox'>Username already in use. <a href='adminNewEmployee.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		
		// Password Checks
		if(pwd.isEmpty() || pwd.length() > 20) {
			out.println("<div class='messageBox'>Invalid password <a href='adminNewEmployee.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		for(int i = 0; i < pwd.length(); i++){
			if(Character.isWhitespace(pwd.charAt(i))){
				out.println("<div class='messageBox'>Invalid password <a href='adminNewEmployee.jsp'>Try Again</a></div>");
				con.close();
				return;
			}
		}
		
		// SSN checks
		if(ssn.isEmpty() || ssn.length() != 9) {
			out.println("<div class='messageBox'>Invalid SSN <a href='adminNewEmployee.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		for(int i = 0; i < ssn.length(); i++){
			if(Character.isWhitespace(ssn.charAt(i))){
				out.println("<div class='messageBox'>Invalid SSN <a href='adminNewEmployee.jsp'>Try Again</a></div>");
				con.close();
				return;
			}
		}
		
		int isRep = 0;
		int isMan = 0;
		int isAdmin = 0;
		
		// Fill Role booleans
		if(role.equals("isRep")){
			isRep = 1;
		}else if(role.equals("isManager")){
			isMan = 1;
		}else{
			isAdmin = 1;
		}
		
		Statement st = con.createStatement();
		
		int i = st.executeUpdate("insert into Employees (ssn, fname, lname, username, pass, isRep, isManager, isAdmin) values ('"+ssn+"', '"+fname+"', '"+lname+"', '"+userid+"', '"+pwd+"', '"+isRep+"', '"+isMan+"', '"+isAdmin+"')");

		out.println("<div class='messageBox'>Account Created!<br><a href='adminEmployeeList.jsp'>Back to Employee List</a></div>");
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br><br>Login failed");
	}
	%>
</body>
</html>