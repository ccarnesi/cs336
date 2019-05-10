<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>                                                
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Browse Items</title>
</head>
<body>
		<li>
			<a href = "SearchByCriteria.jsp" >Search Items</a>
		</li>
		<li>
			<a href = "SortByType.jsp" >Sort Items</a>
		</li>
		<li>
			<a href = "bidHistory.jsp" >Bid History</a>
		</li>
		<li>
			<a href = "AuctionHistory.jsp" >Auction History</a>
		</li>
		<li>
			<a href = "specificAuction.jsp" >Specific Auction</a>
		</li>
		<li>
			<a href = "SpecificBuyer.jsp" >Specific Buyer</a>
		</li>
		<li>
			<a href = "SimilarItems.jsp" >Similar Items</a>
		</li>
		
		
</body>
<form method="post">

<table border="2">
<tr>
<td>category</td>
<td>make</td>
<td>model</td>
<td>vehicleYr</td>
<td>endDate</td>
<td>amt</td>
</tr>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase?zeroDateTimeBehavior=convertToNull";
String query="select Item.category, Item.make, Item.model, Item.vehicleYr, Auction.endDate, Bid.amt from Item, Auction, Bid where Item.itemID = Auction.item_ID and Auction.auctionID = Bid.auction_ID";
Connection conn = DriverManager.getConnection(url, "cs336", "cs3362019");
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

%>
    <tr>
	    <td><%=rs.getString("category") %></td>
	    <td><%=rs.getString("make") %></td>
	    <td><%=rs.getString("model") %></td>
	    	    <td><%=rs.getString("vehicleYr") %></td>
	    
	    	    <td><%=rs.getDate("endDate") %></td>
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