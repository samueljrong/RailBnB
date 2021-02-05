<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Questions and Answers</title>
<style>
*, html {
	margin: 0;
	padding: 0;
}

.body {
	color: #000;
}

.container {
	width: 300px;
	margin: 0 400px;
	padding: 50px 0px;
	font-family: Arial, sans-serif;
}

.container h2 {
	text-align: center;
}

#page {
	background-color: #8cc8ff;
	width: 300px;
	padding: 10px 20px 30px;
	text-align: center;
}

.textInput {
	padding: 3px 5px;
	margin-left: 10px;
	margin-bottom: 5px;
}

#page .btn {
	margin-left: 180px;
}

.btn {
	background-color: #9c9c9c;
	color: #fff;
	padding: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		<h2>
			Search Questions and Answers<br>
			<form method="post" action="userHomepage.jsp">
				<input class="btn" type="submit" value="Homepage">
			</form>
		</h2>
		<br>
		<div id="page">
			<br>
			<form method="post" action="searchQandAQuery.jsp">
				<table>
					<tr>
						<td>Question contains the phrase:</td>
					</tr>
					<tr>
						<td><input class="textInput" type="text"
							name="questionPhrase" maxlength="50"></td>
					</tr>
					<tr>
						<td>Answer contains the phrase:</td>
					</tr>
					<tr>
						<td><input class="textInput" type="text" name="answerPhrase"
							maxlength="50"></td>
					</tr>
				</table>
				<br> <input class="btn" type="submit" value="Search">
			</form>
		</div>
	</div>
</body>
</html>
