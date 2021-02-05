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
	String useridOG = request.getParameter("userid");
	String userid = request.getParameter("userName");
	String pwd = request.getParameter("pass");
	String fname = request.getParameter("fName");
	String lname = request.getParameter("lName");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zip = request.getParameter("zip");
	
	// Username Checks
	if(userid.isEmpty() || userid.length() > 20) {
		out.println("<div class='messageBox'>Invalid username <a href='adminCustomerList.jsp'>Try Again</a></div>");
		return;
	}
	for(int i = 0; i < userid.length(); i++){
		if(Character.isWhitespace(userid.charAt(i))){
			out.println("<div class='messageBox'>Invalid username <a href='adminCustomerList.jsp'>Try Again</a></div>");
			return;
		}
	}
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement userSt = con.createStatement();
		ResultSet userSet = userSt.executeQuery("SELECT t1.userid FROM (SELECT * FROM Customers c WHERE c.userid<>'"+useridOG+"') t1 WHERE t1.userid='" + userid + "'");
		
		if(userSet.next()){
			out.println("<div class='messageBox'>Username already in use. <a href='adminCustomerList.jsp'>Try Again</a></div>");
			return;
		}
		
	} catch(SQLException sql){
		request.setAttribute("error", sql);
		out.println(sql);
		out.print("<div class='messageBox'>There is a problem in updating Record.<br><a href='adminCustomerList.jsp'>Back to Customer List</a></div>");
		return;
	}
	
	// Password Checks
	if(pwd.isEmpty() || pwd.length() > 20) {
		out.println("<div class='messageBox'>Invalid password <a href='adminCustomerList.jsp'>Try Again</a></div>");
		return;
	}
	for(int i = 0; i < pwd.length(); i++){
		if(Character.isWhitespace(pwd.charAt(i))){
			out.println("<div class='messageBox'>Invalid password <a href='adminCustomerList.jsp'>Try Again</a></div>");
			return;
		}
	}
	
	// Email Checks
	if(!email.isEmpty()) {
		Boolean hasAT = false;
		for(int i = 0; i < email.length(); i++){
				if(Character.isWhitespace(email.charAt(i))){
					out.println("Invalid email <a href='adminCustomerList.jsp'>Try Again</a>");
					return;
				}
				if(email.charAt(i) == '@'){
					hasAT = true;
				}		
		}
		 
		if(!hasAT){
		 	out.println("Invalid email <a href='adminCustomerList.jsp'>Try Again</a>");
			return;
		}
	}
	
	// Check Phone
	if(!phone.isEmpty()) {
		if(phone.length() != 10){
			out.println("Invalid Phone Number <a href='adminCustomerList.jsp'>Try Again</a>");
			return;
		}
		
		for(int i = 0; i < phone.length(); i++){
			if(!Character.isDigit(phone.charAt(i))){
				out.println("Invalid Phone Number <a href='adminCustomerList.jsp'>Try Again</a>");
				return;
			}		
		}
	}

	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		PreparedStatement ps = null;
		Class.forName("com.mysql.jdbc.Driver");
		
		String updateStr = "UPDATE Customers SET userid=?,fname=?,lname=?,email=?,phone=?,addr=?,city=?,state=?,zip=?,pass=? where userid='"+useridOG+"'";
		ps = con.prepareStatement(updateStr);
		ps.setString(1, userid);
		ps.setString(2, fname);
		ps.setString(3, lname);
		ps.setString(4, email);
		ps.setString(5, phone);
		ps.setString(6, addr);
		ps.setString(7, city);
		ps.setString(8, state);
		ps.setString(9, zip);
		ps.setString(10, pwd);
		
		int i = ps.executeUpdate();
		
		if(i > 0){
			out.print("<div class='messageBox'>Record Updated Successfully<br><a href='adminCustomerList.jsp'>Back to Customer List</a></div>");
		}else{
			out.print("<div class='messageBox'>There is a problem in updating Record.HERE<br><a href='adminCustomerList.jsp'>Back to Customer List</a></div>");
		}
		con.close();
	}catch(SQLException sql){
		request.setAttribute("error", sql);
		out.println(sql);
		out.print("<div class='messageBox'>There is a problem in updating Record.<br><a href='adminCustomerList.jsp'>Back to Customer List</a></div>");
		return;
	}
%>
</body>
</html>