<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Category Earnings Report</title>
</head>
<body>
	<%
	try {
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		//todays date, used to find out which auctions are over
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date dt = new java.util.Date();
		String today = df.format(dt);
		
		//formatting for currency
		NumberFormat nf = NumberFormat.getCurrencyInstance();
		
		PreparedStatement ps = con.prepareStatement("SELECT category, SUM(win_bid) total FROM (SELECT Item.category, MAX(Bid.amt) win_bid FROM Auction, Bid, Item WHERE Bid.Auction_ID = Auction.auctionID AND Auction.item_ID = Item.itemID AND Auction.endDate < ? AND Bid.amt >= Auction.reservePrice GROUP BY Auction.auctionID) t GROUP BY category ORDER BY total DESC");
		ps.setString(1, today);
		ResultSet rs = ps.executeQuery();
		%>
	<table cellpadding="10">
		<tr>
			<td><u>Category</u></td>
			<td><u>Total Earnings</u></td>
		</tr>
		<%while (rs.next()) {%>
		<tr>
			<td><%= rs.getString("category")+ "   "%></td>
			<td><%= nf.format(rs.getDouble("total"))+ "   "%></td>
		</tr>
		<%} 
		rs.close();
		ps.close();
		con.close();%>
	</table>
<%	} catch(Exception e) {
		out.print("\nError generating category earnings report: ");
		out.print(e);
	}
%>
</body>
</html>