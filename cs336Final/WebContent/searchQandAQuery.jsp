<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question and Answer Search Results</title>

</head>
<body>
	<h2>Question and Answer Search Results</h2>
	<form method="post" action="userHomepage.jsp">
		<input class="btn" type="submit" value="Homepage">
	</form>
	<a href="viewQandA.jsp">All Questions and Answers</a>
	<br> <br>

	<%
		try {

		String questionPhrase = request.getParameter("questionPhrase");
		String answerPhrase = request.getParameter("answerPhrase");

		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String str = "SELECT * FROM Questions WHERE cid IS NOT NULL";

		if (questionPhrase.length() > 0 && answerPhrase.length() > 0) { // Question and answer specified
			str = str.concat(" and question like '%" + questionPhrase + "%' and answer like '%" + answerPhrase + "%'");
		} else if (questionPhrase.length() > 0) { // No answer specified
			str = str.concat(" and question like '%" + questionPhrase + "%'");
		} else if (answerPhrase.length() > 0) { // No question specified
			str = str.concat(" and answer like '%" + answerPhrase + "%'");
		} else { // No parameters specified
		}
		// String str = "SELECT * FROM Questions WHERE question like '%" + questionPhrase + "%' and answer like '%"
		// + answerPhrase + "%'";

		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		//Make an HTML table to show the results in:
		out.print("<table border=1>");

		// Row of column headers
		out.print("<tr>");

		out.print("<td>");
		out.print("<b>Question ID</b>"); //qid
		out.print("</td>");

		out.print("<td>");
		out.print("<b>Question</b>");
		out.print("</td>");

		out.print("<td>");
		out.print("<b>Answer</b>");
		out.print("</td>");

		out.print("<td>");
		out.print("<b>Asked by</b>"); //cid
		out.print("</td>");

		out.print("<td>");
		out.print("<b>Answered by</b>"); //eid
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			// A row of a question, answer, and identifying info
			out.print("<tr>");

			// Print question id
			out.print("<td>");
			out.print(result.getString("qid"));
			out.print("</td>");

			out.print("<td>");
			out.print(result.getString("question"));
			out.print("</td>");

			out.print("<td>");
			out.print(result.getString("answer"));
			out.print("</td>");

			// Print customer id
			out.print("<td>");
			out.print(result.getString("cid"));
			out.print("</td>");

			// Print employee id
			out.print("<td>");
			out.print(result.getString("eid"));
			out.print("</td>");

			out.print("</tr>");

		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("query failed");
	}
	%>
</body>
</html>
