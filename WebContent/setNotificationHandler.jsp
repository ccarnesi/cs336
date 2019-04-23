<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>



<title>Aces Auction</title>
</head>
<body>
<%

	//Sets notifictions for startDate of auction

		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		int auctionID = Integer.parseInt(request.getParameter("auctionID"));
		String user = session.getAttribute("userID") + "";
		//java.util.Date startDate = request.getParameter("startDate");
		
		
		
			//insert into the auctionStartNotific table 
			PreparedStatement insertNotific = con.prepareStatement("Insert auctionStartNotific (notificUser,auctionStart_ID) values(?,?)");
			insertNotific.setString(1,user);
			insertNotific.setInt(2,auctionID);
			insertNotific.executeUpdate();
			response.sendRedirect("listing.jsp?auctionID=" + auctionID);
		
			con.close();
%>
		</body>
		