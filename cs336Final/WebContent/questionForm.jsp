<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title>Ask a Question</title>
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
		<h2>Ask a Question</h2>
		<br> <a href="viewQandA.jsp">All Questions and Answers</a> <br>
		<a href="myQuestions.jsp">My Questions</a> <br>
	</div>
	<div class="container">
		<div id="page">
			<form method="post" action="submitQuestion.jsp">
				<textarea name="question" rows="10" cols="30"></textarea>
				<br> <input type="submit" value="Submit Question">
			</form>
		</div>
	</div>

</body>
</html>