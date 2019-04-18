<!-- Code done by Chris Carnesi -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head> 
		<title> Listing </title>
	</head>
	<body>
<% 
	ResultSet auctionRS = null;
	ResultSet itemRS = null;
	ResultSet bidRS = null;
	int AuctionID = 0;
	float price = 0;
	String topBidder = "Nobody";
	Connection con = null;
	try{
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		
		AuctionID = Integer.parseInt(request.getParameter("auctionID"));
		PreparedStatement auctionQuery = con.prepareStatement("Select * from Auction where auctionID = ?");
		auctionQuery.setInt(1, AuctionID);
		auctionRS = auctionQuery.executeQuery();
		
		
		
		
		if(!auctionRS.next()){
			out.println("error auction");
		}
		PreparedStatement itemQuery = con.prepareStatement("Select * from Item where itemID = ?");
		
		int itemID = auctionRS.getInt(9);

		itemQuery.setInt(1,itemID);
		itemRS = itemQuery.executeQuery();
		if(!itemRS.next()){
			out.println("error item");
		}
		
		PreparedStatement bidQuery = con.prepareStatement("Select * from Bid where auction_ID = ? ORDER BY amt DESC");
		bidQuery.setInt(1, AuctionID);
		bidRS = bidQuery.executeQuery();
		
		if(!bidRS.next()){
			//no one has bid so set price to start price
			price = auctionRS.getFloat(5);
			
		}else{
			price = bidRS.getFloat(4);
			topBidder = bidRS.getString(3);
		}
		
		
		
	}catch(Exception ex){
		out.println(ex);
		out.println("An error has occurred");
	}
	java.util.Date today = new java.util.Date();
	java.util.Date endDate = auctionRS.getTimestamp(4);
	java.util.Date startDate = auctionRS.getTimestamp(3);
	today.setHours(today.getHours() - 4);
	Boolean end = true;
	if(today.before(endDate)){
		end = false;
	}
if(startDate.before(today)){
%>
		<h2> <%= auctionRS.getString(2) %> </h2>
			<br/>Category: <%= itemRS.getString(2) %>
			<br/>Make: <%= itemRS.getString(3) %>
			<br/>Model: <%= itemRS.getString(4) %>
			<br/>Year: <%= itemRS.getString(5) %>
			<br/>Current Price: $<%= price %>0
			<br/> Current Top Bid Holder: <%= topBidder %>
			<br/>Increment Price: $<%= auctionRS.getFloat(7) %>
			<br/>Start Date: <%= auctionRS.getTimestamp(3) %>
			<br/>End Date: <%= auctionRS.getTimestamp(4) %>
			<br/>Seller: <%= auctionRS.getString(8) %>
		<form action="setNotificationHandler.jsp?auctionID=<%= AuctionID %>" method="post">
			<br/>Set alert when this becomes availble: <input type= "text" name="bidAttempt"/>
			<br/><input type="submit" value="Set Alert">
		</form>
<%
}else if(end == false){
	
%>

		<h2> <%= auctionRS.getString(2) %> </h2>
			<br/>Category: <%= itemRS.getString(2) %>
			<br/>Make: <%= itemRS.getString(3) %>
			<br/>Model: <%= itemRS.getString(4) %>
			<br/>Year: <%= itemRS.getString(5) %>
			<br/>Current Price: $<%= price %>0
			<br/> Current Top Bid Holder: <%= topBidder %>
			<br/>Increment Price: $<%= auctionRS.getFloat(7) %>
			<br/>Start Date: <%= auctionRS.getTimestamp(3) %>
			<br/>End Date: <%= auctionRS.getTimestamp(4) %>
			<br/>Seller: <%= auctionRS.getString(8) %>
		<form action="bidHandler.jsp?auctionID=<%= AuctionID %>&seller=<%= auctionRS.getString(8) %>&incPrice=<%= auctionRS.getFloat(7) %>&currentPrice=<%= price%>&manOrAuto=0" method="post">
			<br/>Make a bid: <input type= "text" name="bidAttempt"/>
			<br/><input type="submit" value="Make Bid">
		</form>
		<form action="bidHandler.jsp?auctionID=<%= AuctionID %>&seller=<%= auctionRS.getString(8) %>&incPrice=<%= auctionRS.getFloat(7) %>&currentPrice=<%= price%>&manOrAuto=1" method="post">
			<br/> Automatic Bidding
			<br/>Set up upper limit: <input type= "text" name="bidUpperLimit"/>
			<br/><input type="submit" value="Auto Bid">
		</form>
	</body>
</html>
<%
}else{
%>
	<h2> Auction has Ended </h2>
			<%
				if(price>auctionRS.getFloat(6)&& price>auctionRS.getFloat(5)){// is a winner
			%>	
					<p>This auction has ended and was won by <%= topBidder %> for $<%= price %></p>>
					
			<%
				}else{
			%>
					<p>This auction has ended and was won by nobody because either the reserve wasn't met or there were no bidders</p>
			
			<%
				}
			%>
	</body>
</html>


<%
}
%>




