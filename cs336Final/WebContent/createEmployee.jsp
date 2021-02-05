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
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String userid = request.getParameter("userName");
		String pwd = request.getParameter("pass");
		String role = request.getParameter("role");
		
		
		// Username Checks
		if(userid.isEmpty() || userid.length() > 20) {
			out.println("Invalid username <a href='createEmployee.jsp'>Try Again</a>");
			return;
		}
		for(int i = 0; i < userid.length(); i++){
			if(Character.isWhitespace(userid.charAt(i))){
				out.println("Invalid username <a href='createEmployee.jsp'>Try Again</a>");
				return;
			}
		}
		Class.forName("com.mysql.jdbc.Driver");
		Statement userSt = con.createStatement();
		ResultSet userSet = userSt.executeQuery("SELECT * FROM Employees WHERE username='" + userid + "'");
		
		if(userSet.next()){
			out.println("Username already in use. <a href='createEmployee.jsp'>Try Again</a>");
			return;
		}
		
		// Password Checks
		if(pwd.isEmpty() || pwd.length() > 20) {
			out.println("Invalid password <a href='newEmployee.jsp'>Try Again</a>");
			return;
		}
		for(int i = 0; i < pwd.length(); i++){
			if(Character.isWhitespace(pwd.charAt(i))){
				out.println("Invalid password <a href='newEmployee.jsp'>Try Again</a>");
				return;
			}
		}
		
		// SSN checks
		if(ssn.isEmpty() || ssn.length() != 9) {
			out.println("Invalid SSN <a href='newEmployee.jsp'>Try Again</a>");
			return;
		}
		for(int i = 0; i < ssn.length(); i++){
			if(Character.isWhitespace(ssn.charAt(i))){
				out.println("Invalid SSN <a href='newEmployee.jsp'>Try Again</a>");
				return;
			}
		}
		
		String isRep = "false";
		String isMan = "false";
		String isAdmin = "false";
		
		// Fill Role booleans
		if(role.equals("isRep")){
			isRep = "true";
		}else if(role.equals("isManager")){
			isMan = "true";
		}else{
			isAdmin = "true";
		}
		
		Statement st = con.createStatement();
		
		int i = st.executeUpdate("insert into Employees (ssn, fname, lname, username, pass, isRep, isManager, isAdmin) values ("
									+ssn+", "+fname+", "+lname+","+userid+","+pwd+","+isRep+","+isMan+","+isAdmin+"'");

		out.println("Account Created!<br><a href='index.jsp'>Log In</a>");
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br><br>Login failed");
	}
	%>
</body>
</html>