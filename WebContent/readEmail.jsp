<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Email</title>
</head>
<body>
Here is a list of Customer Representatives if you need assistance<br>
	<% 
	try {
		ResultSet rs = null;
		
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		PreparedStatement ps = con.prepareStatement("SELECT username FROM Accounts WHERE accessLevel > 1");
		
		rs = ps.executeQuery();
		%>
		<table>
		<tr>
			<td><u>username</u></td>
		</tr>
		<%while (rs.next()) {%>
			<tr>
				<td><%= rs.getString("username") %></td>
				<% } %>
			</tr>
		</table>
		
		<br>Write an Email<br>
		<form action="sendEmail.jsp" method="post">
			<br>recipient:<input type="text" name="recipient" maxlength="20" required>
			<br>subject:<input type="text" name="subject" maxlength="30" required>
			<br>content:<input type="text" name="content" maxlength="100" required>
			<br><input type="submit" value="Send">
		</form>
		
		<br>List of Emails to you<br>
		<%
			rs.close();
			ps.close();
			
			ps = con.prepareStatement("SELECT * FROM Email WHERE recipient =? ORDER BY DandT DESC");
			ps.setString(1, (String)session.getAttribute("userID"));
			
			rs = ps.executeQuery();
		%>
		<table>
		<tr>
			<td><u>sender</u></td>
			<td><u>recipient</u></td>
			<td><u>subject</u></td>
			<td><u>time</u></td>
			<td><u>content</u></td>
		</tr>
		<%while (rs.next()) {%>
			<tr>
				<td><%= rs.getString("sender") %></td>
				<td><%= rs.getString("recipient") %></td>
				<td><%= rs.getString("subj") %></td>
				<td><%= rs.getString("DandT") %></td>
				<td><%= rs.getString("content") %></td>
			</tr>
			<% } %>
		</table>
			
	<%
	rs.close();
	ps.close();
	con.close();
	} catch (Exception e) {
		out.print(e); }%>
</body>
</html>