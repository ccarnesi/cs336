<!-- Code done by Chris Carnesi -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Buy Me</title>
</head>
<body>
<% out.println("Hello " + session.getAttribute("userID"));%>
<center>
	<ul>
		<li>
			<a href = "searchAuctions.jsp" >Search for an Item to Buy</a>
		</li>
		<li>
			<a href = "createAuction.jsp" >Create an auction</a>
		</li>
		<li>
			<a href = "readEmail.jsp" >Email</a>
		</li>
		 <%if ((Integer)session.getAttribute("accessLevel") >= 2) {
			 	//customer rep control panel
				out.println("<li> <a href = \"customerRepControl.jsp\" >Customer Representatives Control Panel</a> </li>");
				if ((Integer)session.getAttribute("accessLevel") == 3) {
					//Admin control panel
					out.println("<li> <a href = \"adminControl.jsp\" >Admin Control</a> </li>");
				}
		}%>
		<li>
		<form method="link" action="logout.jsp">
    		<input type="submit" value="Logout"/>
		</form>
		</li>
	</ul>
</center>	
</body>
</html>