<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Select a Route</title>
	<style>
	*,html {
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
	#page .btn{
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
		<h2>Search for Schedules<br></h2>
		<br><br>
		<div id="page">
		<br>
			<form method="post" action="searchSchedulesQuery.jsp">
				<table>
					<tr>    
						<td>Select an Origin</td>
					</tr>
					<tr>
						<td>
							<div class="custom-select" type="text" name="origin" style="width:200px;">
								<select name="origin">
									<option value="">No Selection</option>
									<option value="0">Trenton</option>
									<option value="1">Hamilton</option>
									<option value="2">Princeton Junction</option>
									<option value="3">New Brunswick</option>
									<option value="4">Edison</option>
									<option value="5">Elizabeth</option>
									<option value="6">Metuchen</option>
									<option value="7">Metropark</option>
									<option value="8">Rahway</option>
									<option value="9">Linden</option>
									<option value="10">Newark International Airport</option>
									<option value="11">Newark Penn</option>
									<option value="12">Secaucus Junction</option>
									<option value="13">Kingsland</option>
									<option value="14">Lyndhurst</option>
									<option value="15">Delawanna</option>
									<option value="16">Passaic</option>
									<option value="17">Clifton</option>
									<option value="18">Paterson</option>
									<option value="19">Hawthorne</option>
									<option value="20">Glen Rock</option>
									<option value="21">Radburn</option>
									<option value="22">Broadway</option>
									<option value="23">Plauderville</option>
									<option value="24">Garfield</option>
									<option value="25">Wesmont</option>
									<option value="26">Rutherford</option>
									<option value="27">Jersey Ave</option>
									<option value="28">North Elizabeth</option>	
								</select>
							</div>
						</td>
					</tr>
					<tr>
					<td>Select a Destination</td></tr><tr>
					<td>
					<div class="custom-select" type="text" name="destination" style="width:200px;">
								<select name="destination">
									<option value="">No Selection</option>
									<option value="0">Trenton</option>
									<option value="1">Hamilton</option>
									<option value="2">Princeton Junction</option>
									<option value="3">New Brunswick</option>
									<option value="4">Edison</option>
									<option value="5">Elizabeth</option>
									<option value="6">Metuchen</option>
									<option value="7">Metropark</option>
									<option value="8">Rahway</option>
									<option value="9">Linden</option>
									<option value="10">Newark International Airport</option>
									<option value="11">Newark Penn</option>
									<option value="12">Secaucus Junction</option>
									<option value="13">Kingsland</option>
									<option value="14">Lyndhurst</option>
									<option value="15">Delawanna</option>
									<option value="16">Passaic</option>
									<option value="17">Clifton</option>
									<option value="18">Paterson</option>
									<option value="19">Hawthorne</option>
									<option value="20">Glen Rock</option>
									<option value="21">Radburn</option>
									<option value="22">Broadway</option>
									<option value="23">Plauderville</option>
									<option value="24">Garfield</option>
									<option value="25">Wesmont</option>
									<option value="26">Rutherford</option>
									<option value="27">Jersey Ave</option>
									<option value="28">North Elizabeth</option>	
								</select>
							</div>
					</td>
					</tr>
					<tr>    
					<td>Date of Travel</td></tr>
					<tr>
					<td>
					<div class="custom-select" type="text" name="date" style="width:200px;">
								<select name="date">
									<option value="2020-04-30">2020-04-30</option>
									<option value="2020-05-01">2020-05-01</option>
								</select>
							</div>
					</td>
					</tr>
				</table>
			<br>
			<input class="btn" type="submit" value="Create">
			</form>
		</div>
	</div>
</body>
</html>
