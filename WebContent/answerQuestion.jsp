<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		//parameters
		String questionID = request.getParameter("questionID");
		String answer = request.getParameter("answer");
		String user = (String)session.getAttribute("userID");
		
		PreparedStatement ps = con.prepareStatement("SELECT * FROM faq WHERE qID =?");
		ps.setString(1, questionID);
		
		ResultSet rs = ps.executeQuery();
		
		//fail: question does not exist
		if (!(rs.next())) {
			out.print("Error: Invalid question ID");
			
		//success: question will be answered
		} else {
			ps.close();
			ps = con.prepareStatement("UPDATE faq SET answer =?, customerRep =? WHERE qID =?");
			ps.setString(1, answer);
			ps.setString(2, user);
			ps.setString(3, questionID);
			
			ps.executeUpdate();
			response.sendRedirect("repAnswerQuestion.jsp");
		}
	} catch (Exception e) {
		out.print("\nError answering question: ");
		out.print(e);
	}
%>
</body>
</html>