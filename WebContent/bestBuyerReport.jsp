<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Best Buyers Report</title>
</head>
<body>
<%
	try {
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		//todays date, used to find out which items were actually sold in an auction
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date dt = new java.util.Date();
		String today = df.format(dt);
		
		PreparedStatement ps = con.prepareStatement("SELECT user_ID, count(*) num FROM (SELECT Bid.user_ID FROM Auction, Bid WHERE Bid.auction_ID = Auction.auctionID AND Auction.endDate < ? AND Bid.amt >= Auction.reservePrice GROUP BY auctionID) t GROUP BY user_ID ORDER BY num DESC");
		ps.setString(1, today);
		ResultSet rs = ps.executeQuery();
		%>
	<table>
		<tr>
			<td><u>User ID</u></td>
			<td><u># of Auctions won</u></td>
		</tr>
		<%while (rs.next()) { %>
		<tr>
			<td><%= rs.getString("user_ID") %></td>
			<td><%= rs.getString("num") %></td>
		</tr>
		<%} 
		rs.close();
		ps.close();
		con.close();%>
	</table>
<%	} catch(Exception e) {
		out.print("\nError generating buyer sales report: ");
		out.print(e);
	}
%>
</body>
</html>