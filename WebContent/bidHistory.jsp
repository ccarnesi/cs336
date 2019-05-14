<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>                                                
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid History</title>
</head>
<body>

</body>
<form method="post">

<table border="2">
<tr>
<td>title</td>
<td>startDate</td>
<td>endDate</td>
<td>initialPrice</td>
<td>reservePrice</td>
<td>minBidRaise</td>
<td>seller</td>
<td>username</td>
<td>amt</td>

</tr>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");
int auction = Integer.parseInt(request.getParameter("auctionID"));
String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase?zeroDateTimeBehavior=convertToNull";
Connection conn = DriverManager.getConnection(url, "cs336", "cs3362019");
PreparedStatement stmt = conn.prepareStatement("select Auction.title, Auction.startDate, Auction.endDate, Auction.initialPrice, Auction.reservePrice, Auction.minBidRaise, Auction.seller, Accounts.username, Bid.amt from Auction, Accounts, Bid where  Accounts.username= Bid.user_ID and Auction.auctionID = Bid.auction_ID and Auction.auctionID=?");
stmt.setInt(1, auction);
ResultSet rs=stmt.executeQuery();
while(rs.next())
{

%>
    <tr>
	    <td><%=rs.getString("title") %></td>
	    <td><%=rs.getDate("startDate") %></td>
	    <td><%=rs.getDate("endDate") %></td>
	    	    <td><%=rs.getDouble("initialPrice") %></td>
	    	    <td><%=rs.getDouble("reservePrice") %></td>
	    	    <td><%=rs.getDouble("minBidRaise") %></td>
	    	    	    <td><%=rs.getString("seller") %></td>
	    	   <td><%=rs.getString("username") %></td>
	    	    	    
	    	    	    <td><%=rs.getDouble("amt") %></td>
	    
	</tr>
        <%

}
%>
    </table>
    <%
    rs.close();
    stmt.close();
    conn.close();
    }
catch(Exception e)
{
    e.printStackTrace();
    }




%>

</form>
</html>