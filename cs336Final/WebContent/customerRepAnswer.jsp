<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Questions</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the rid from the customerRepAltReservations.jsp
			String repid=request.getParameter("repid");
			//Make a SELECT query from the reservations table with all fields from the previosly entered rid
			//String query = "SELECT * FROM Reservations WHERE rid='" + rid + "'";
			//Run the query against the database.
			

			//Make an HTML table to show the results in:
			
			String query="SELECT qid, question, cid FROM Questions WHERE answer IS NULL;";
			ResultSet result = stmt.executeQuery(query);
			
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("QID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("CID");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Question");
			out.print("</td>");		

			out.print("</tr>");
			
			while (result.next()) {
				//make a row
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getString("qid"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("cid"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("question"));
				out.print("</td>");		

			}
			out.print("</table>");
			
			
			result = stmt.executeQuery(query);
			
 %>
	<br>
	<form method="get" action="crAnswerQuestion.jsp">
	<input type="hidden" name="repid" value="<%=repid%>">
		 
		<p>
			Select Question to Answer : <select name="qid">
				<%
				result= stmt.executeQuery(query);
			while(result.next())
			{
			String sname = result.getString("qid"); 
			%>
				<option value="<%=sname %>"><%=sname %></option>
				<%
			}
			%>
			</select>
			</p>
			<br>
			Answer:<input class="textInput" type="text" name="answer" size="50">
			<input type="submit" value="Answer">
		</form>
		 

	<%  
			con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>