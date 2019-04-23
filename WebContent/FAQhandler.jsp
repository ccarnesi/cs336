<!-- Code done by Nick Rivy -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>

<title>Create an auction</title>


<!--close connections -->

<%

String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");

PreparedStatement insertQ = con.prepareStatement("Insert into faq (question,qUsername) values(?,?)"); 
insertQ.setString(1, request.getParameter("question") +"");
String user = session.getAttribute("userID") + "";
insertQ.setString(2, user); 


//need to redirect to FAQ display page

%>

</head>
<body>


</body>

</html>
