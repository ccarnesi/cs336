<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Questions</title>
</head>
<body>
<%
	try {
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		PreparedStatement ps = con.prepareStatement("SELECT qid, question FROM faq WHERE answer IS NULL");
		
		ResultSet rs = ps.executeQuery();
%>
	<br>Answer a question<br>
	<form action="answerQuestion.jsp" method="post">
		<br>QuestionID:<input type="text" name="questionID" required>
		<br>Answer:<input type="text" name="answer" maxlength="250" required>
		<br><input type="submit" value="Answer Question">
	</form>
	
	<table cellpadding="5">
		<tr>
			<td><u>Question ID</u></td>
			<td><u>Question</u></td>
		</tr>
		<%while (rs.next()) { %>
		<tr>
			<td><%= rs.getString("qID")%></td>
			<td><%= rs.getString("question") %></td>
		</tr>
		<% } %>
	</table>
<%
	rs.close();
	ps.close();
	con.close();
	} catch (Exception e) {
		out.print("\nError retrieving questions:");
		out.print(e);
	}
%>
</body>
</html>