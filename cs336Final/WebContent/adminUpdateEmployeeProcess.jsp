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
	String ssnOG = request.getParameter("ssnOG");
	String ssn = request.getParameter("ssn");
	String fname = request.getParameter("fName");
	String lname = request.getParameter("lName");
	String userid = request.getParameter("userName");
	String pwd = request.getParameter("pass");
	String role = request.getParameter("role");
	
	// Username Checks
	if(userid.isEmpty() || userid.length() > 20) {
		out.println("<div class='messageBox'>Invalid username <a href='adminEmployeeList.jsp'>Try Again</a></div>");
		return;
	}
	for(int i = 0; i < userid.length(); i++){
		if(Character.isWhitespace(userid.charAt(i))){
			out.println("<div class='messageBox'>Invalid username <a href='adminEmployeeList.jsp'>Try Again</a></div>");
			return;
		}
	}
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement userSt = con.createStatement();
		ResultSet userSet = userSt.executeQuery("SELECT t1.username FROM (SELECT * FROM Employees e WHERE e.ssn<>'"+ssnOG+"') t1 WHERE t1.username='" + userid + "'");
		
		if(userSet.next()){
			out.println("<div class='messageBox'>Username already in use. <a href='adminEmployeeList.jsp'>Try Again</a></div>");
			return;
		}
		
	} catch(SQLException sql){
		request.setAttribute("error", sql);
		out.println(sql);
		out.print("<div class='messageBox'>There is a problem in updating Record.<br><a href='adminEmployeeList.jsp'>Back to Employee List</a></div>");
		return;
	}
	
	// Password Checks
	if(pwd.isEmpty() || pwd.length() > 20) {
		out.println("<div class='messageBox'>Invalid password <a href='adminEmployeeList.jsp'>Try Again</a></div>");
		return;
	}
	for(int i = 0; i < pwd.length(); i++){
		if(Character.isWhitespace(pwd.charAt(i))){
			out.println("<div class='messageBox'>Invalid password <a href='adminEmployeeList.jsp'>Try Again</a></div>");
			return;
		}
	}
	
	// SSN checks
	if(ssn.isEmpty() || ssn.length() != 9) {
		out.println("<div class='messageBox'>Invalid SSN <a href='adminEmployeeList.jsp'>Try Again</a></div>");
		return;
	}
	for(int i = 0; i < ssn.length(); i++){
		if(Character.isWhitespace(ssn.charAt(i))){
			out.println("<div class='messageBox'>Invalid SSN <a href='adminEmployeeList.jsp'>Try Again</a></div>");
			return;
		}
	}
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement userSt = con.createStatement();
		ResultSet userSet = userSt.executeQuery("SELECT t1.ssn FROM (SELECT * FROM Employees e WHERE e.ssn<>'"+ssnOG+"') t1 WHERE t1.ssn='" + ssn + "'");
		
		if(userSet.next()){
			out.println("<div class='messageBox'>SSN already in use. <a href='adminEmployeeList.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
	} catch(SQLException sql){
		request.setAttribute("error", sql);
		out.println(sql);
		out.print("<div class='messageBox'>There is a problem in updating Record.<br><a href='adminEmployeeList.jsp'>Back to Employee List</a></div>");
		return;
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

	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		PreparedStatement ps = null;
		Class.forName("com.mysql.jdbc.Driver");
		
		String updateStr = "UPDATE Employees SET ssn=?,fname=?,lname=?,username=?,pass=?,isRep=?,isManager=?,isAdmin=? where ssn="+ssnOG;
		ps = con.prepareStatement(updateStr);
		ps.setString(1, ssn);
		ps.setString(2, fname);
		ps.setString(3, lname);
		ps.setString(4, userid);
		ps.setString(5, pwd);
		ps.setInt(6, isRep);
		ps.setInt(7, isMan);
		ps.setInt(8, isAdmin);
		
		int i = ps.executeUpdate();
		
		if(i > 0){
			out.print("<div class='messageBox'>Record Updated Successfully<br><a href='adminEmployeeList.jsp'>Back to Employee List</a></div>");
		}else{
			out.print("<div class='messageBox'>There is a problem in updating Record.HERE<br><a href='adminEmployeeList.jsp'>Back to Employee List</a></div>");
		}
		
		con.close();
	}catch(SQLException sql){
		request.setAttribute("error", sql);
		out.println(sql);
		out.print("<div class='messageBox'>There is a problem in updating Record.<br><a href='adminEmployeeList.jsp'>Back to Employee List</a></div>");
		return;
	}
%>
</body>
</html>