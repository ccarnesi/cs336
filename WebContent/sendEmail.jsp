<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		ResultSet rs = null;
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		//Email parameters
		String sender = (String)session.getAttribute("userID");
		String recipient = request.getParameter("recipient");
		String subj = request.getParameter("subject");
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String DandT = df.format(cal.getTime());
		String content = request.getParameter("content");
		
		PreparedStatement ps = con.prepareStatement("SELECT * FROM Accounts WHERE username =?");
		ps.setString(1, recipient);
		rs = ps.executeQuery();
		
		if(rs.next()) { //recipient exists
			ps.close();
			
			ps = con.prepareStatement("INSERT INTO Email VALUES (?, ?, ?, ?, ?)");
			ps.setString(1, sender);
			ps.setString(2, recipient);
			ps.setString(3, subj);
			ps.setString(4, DandT);
			ps.setString(5, content);
			ps.executeUpdate();
			
			response.sendRedirect("readEmail.jsp");
		} else { //invalid recipient
			out.println("Recipient does not exist");
		}
		
		rs.close();
		ps.close();	
		con.close();
	} catch(Exception e) {
		out.println(e);
		out.print("Error sending email");
	}
%>
</body>
</html>