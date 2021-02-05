<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Creating User...</title>
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
			out.println("<div class='messageBox'>Invalid username <a href='adminNewUser.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		for(int i = 0; i < userid.length(); i++){
			if(Character.isWhitespace(userid.charAt(i))){
				out.println("<div class='messageBox'>Invalid username <a href='adminNewUser.jsp'>Try Again</a></div>");
				con.close();
				return;
			}
		}
		Class.forName("com.mysql.jdbc.Driver");
		Statement userSt = con.createStatement();
		ResultSet userSet = userSt.executeQuery("SELECT * FROM Customers WHERE userid='" + userid + "'");
		
		if(userSet.next()){
			out.println("<div class='messageBox'>Username already in use. <a href='adminNewUser.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		
		// Password Checks
		if(pwd.isEmpty() || pwd.length() > 20) {
			out.println("<div class='messageBox'>Invalid password <a href='adminNewUser.jsp'>Try Again</a></div>");
			con.close();
			return;
		}
		for(int i = 0; i < pwd.length(); i++){
			if(Character.isWhitespace(pwd.charAt(i))){
				out.println("<div class='messageBox'>Invalid password <a href='adminNewUser.jsp'>Try Again</a></div>");
				con.close();
				return;
			}
		}
		
		// Email Checks
		if(!email.isEmpty()) {
			Boolean hasAT = false;
			for(int i = 0; i < email.length(); i++){
					if(Character.isWhitespace(email.charAt(i))){
						out.println("<div class='messageBox'>Invalid email <a href='adminNewUser.jsp'>Try Again</a></div>");
						con.close();
						return;
					}
					if(email.charAt(i) == '@'){
						hasAT = true;
					}		
			}
			 
			if(!hasAT){
			 	out.println("<div class='messageBox'>Invalid email <a href='adminNewUser.jsp'>Try Again</a></div>");
			 	con.close();
				return;
			}
		}
		
		// Check Phone
		if(!phone.isEmpty()) {
			if(phone.length() != 10){
				out.println("<div class='messageBox'>Invalid Phone Number <a href='adminNewUser.jsp'>Try Again</a></div>");
				con.close();
				return;
			}
			
			for(int i = 0; i < phone.length(); i++){
				if(!Character.isDigit(phone.charAt(i))){
					out.println("<div class='messageBox'>Invalid Phone Number <a href='adminNewUser.jsp'>Try Again</a></div>");
					con.close();
					return;
				}		
			}
		}
		
		Statement st = con.createStatement();
		// #insert into Customers (userid, fname, lname, email, phone, addr, city, state, zip, pass) values ('ab1491', 'Alex', 'Baranowski', 'ab1491@rutgers.edu', '6096664455', '505 Help St', 'New Brunswick', 'NJ', '08901', 'cs336')
		int i = st.executeUpdate("insert into Customers (userid, fname, lname, email, phone, addr, city, state, zip, pass) values ('"+userid+"', '"+fname+"', '"+lname+"', '"+email+"', '"+phone+"', '"+addr+"', '"+city+"', '"+state+"', '"+zip+"', '"+pwd+"')");
		
		out.println("<div class='messageBox'>Account Created!<br><a href='adminCustomerList.jsp'>Go Back to Customer List</a></div>");
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("<br><br>Account Creation Failed<br>");
		
	}
	%>
</body>
</html>