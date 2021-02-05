<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Question</title>
</head>
<body>
	<h2>Submit Question</h2>
	<%
		try {
		String newQuestion = request.getParameter("question");
		if (newQuestion.length() <= 0) {
			out.println("Please specify a question.");
		} else {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Get parameter from the HTML form at questionForm.jsp

			//Make an insert statement for the Login table:
			String insert = "INSERT INTO Questions(question, cid)" + "VALUES (?, ?)";

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, newQuestion);
			ps.setString(2, session.getAttribute("user").toString());
			//Run the query against the DB
			ps.executeUpdate();

			con.close();

			out.println("Question created!");
		}
	%>
	<br>
	<a href="viewQandA.jsp">Go Back to All Questions and Answers</a>
	<%
		} catch (Exception ex) {
		out.println(ex);
		out.println("Insert failed.");
	}
	%>
</body>
</html>
