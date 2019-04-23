<!-- Code written by Nick Rivy -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
	<head>
		<title> BuyMe Auction </title>
	</head>
	<body>

	<%

	ResultSet autoRS = null;
	ResultSet outbidRS = null;
	ResultSet itemWait = null;

	String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		%>


		<h1> Notifications </h1>

		<h2>Someone outbid you!</h2>
		<%
			PreparedStatement outbid = con.prepareStatement("Select manAuctionID from manNotific where usersID = ?");
			outbid.setString(1,session.getAttribute("userID") + "");
			outbidRS = outbid.executeQuery();

			//int manOutBid = outbidRS.getInt(3);
		%>

<%
		while(outbidRS.next()){
			%>
		
			<br/><a href = "listing.jsp?auctionID=<%=outbidRS.getInt(1) %>"> Bid again! </a>
		

		<%
			}
		
		%>
		<h2>Someone bid higher than upper limit!</h2>

		<%
			PreparedStatement autoNotific = con.prepareStatement("Select autoBidAuctionID from autoBidNotific where autoBid_username = ?");
		String user = session.getAttribute("userID") + "";
		autoNotific.setString(1,user);
			autoRS = autoNotific.executeQuery();

		%>

				

		<%
		while(autoRS.next())
		{
			%>
			<br/> <a href = "listing.jsp?auctionID=<%=autoRS.getInt(1) %>"> Update your upper limit!</a>
			
				<%
			}
		
				%>


		<h2>Here's that item you were waiting for!</h2>
		<%

		PreparedStatement item = con.prepareStatement("Select auctionStart_ID from auctionStartNotific where notificUser = ?");
		item.setString(1,session.getAttribute("userID") + "");
		itemWait = item.executeQuery();
		while(itemWait.next()){

			PreparedStatement getAuctionDate = con.prepareStatement("Select startDate from Auction where auctionID = ?");
			getAuctionDate.setInt(1, itemWait.getInt(1));
			ResultSet checkDate = getAuctionDate.executeQuery();
			if(!checkDate.next()){

			}else{

			java.util.Date startDate = checkDate.getTimestamp(1);
			java.util.Date today = new java.util.Date();
			today.setHours(today.getHours() - 4);

			if(startDate.before(today)){
				%>

					<br/> <a href = "listing.jsp?auctionID=<%=itemWait.getInt(1) %>"> Auction</a>
				<%
			}

			}

		}

		con.close();
		%>


	</body>
</html>
