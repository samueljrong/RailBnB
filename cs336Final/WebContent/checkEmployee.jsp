<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging in...</title>

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
		
		if(userid.isEmpty() || userid.length() > 20) {
			out.println("Invalid username <a href='index.jsp'>Try Again</a>");
			return;
		}
		for(int i = 0; i < userid.length(); i++){
			if(Character.isWhitespace(userid.charAt(i))){
				out.println("Invalid username <a href='index.jsp'>Try Again</a>");
				con.close();
				return;
			}
		}
		
		if(pwd.isEmpty() || pwd.length() > 20) {
			out.println("Invalid password <a href='index.jsp'>Try Again</a>");
			con.close();
			return;
		}
		for(int i = 0; i < pwd.length(); i++){
			if(Character.isWhitespace(pwd.charAt(i))){
				out.println("Invalid password <a href='index.jsp'>Try Again</a>");
				con.close();
				return;
			}
		}
		
		Class.forName("com.mysql.jdbc.Driver");
		Statement st = con.createStatement();
		ResultSet rs;

		rs = st.executeQuery("SELECT * FROM Employees WHERE username='" + userid + "' and pass='" + pwd + "'");

		if (rs.next()) {
			Boolean isAdmin = rs.getBoolean("isAdmin");
			Boolean isManager = rs.getBoolean("isManager");
			Boolean isRep = rs.getBoolean("isRep");
			
			if(isAdmin){
				session.setAttribute("user", userid); // the username will be stored in the session
				session.setAttribute("role", "admin");
				out.println("Welcome " + userid);
				out.println("<a href='logout.jsp'>Log out</a>");
				response.sendRedirect("admin.jsp");
			}else if(isManager) {
				session.setAttribute("user", userid); // the username will be stored in the session
				session.setAttribute("role", "manager");
				out.println("Welcome " + userid);
				out.println("<a href='logout.jsp'>Log out</a>");
				response.sendRedirect("admin.jsp");
			}else {
				session.setAttribute("repid", rs.getString("ssn")); // the username will be stored in the session
				out.println("Welcome " + userid);
				out.println("<a href='logout.jsp'>Log out</a>");
				response.sendRedirect("customerRepHome.jsp?repid="+rs.getString("ssn"));
			}
			
			
		} else {
			out.println("Invalid password <a href='index.jsp'>Try Again</a>");
		}
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
</body>
</html>