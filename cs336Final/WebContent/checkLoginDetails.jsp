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
		Class.forName("com.mysql.jdbc.Driver");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM Login WHERE userName='" + userid + "' and pass='" + pwd + "'");
		if (rs.next()) {
			session.setAttribute("user", userid); // the username will be stored in the session
			out.println("welcome " + userid);
			out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("success.jsp");
		} else {
			out.println("Invalid password <a href='index.jsp'>try again</a>");
		}

	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
</body>
</html>