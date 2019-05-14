<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>                                                
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search By Criteria</title>
</head>
<body>

</body>





<form method="post">



 Category: <input type="text" name="category"> <input type="submit" value="Find Category"><br> 
 Make: <input type="text" name="make"> <input type="submit" value="Find Make"><br> 
 Model: <input type="text" name="model"><input type="submit" value="Find Model"><br> 
 Year: <input type="text" name="year"> <input type="submit" value="Find Year"><br> 



<table border="2">
<tr>
<td>Category</td>
<td>Model</td>
<td>Make</td>
<td>vehicleYr</td>
<td>endDate</td>
<td>startDate</td>
<td>amt</td>
</tr>
<%

try
{
	ResultSet rs = null;

Class.forName("com.mysql.jdbc.Driver");


String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase?zeroDateTimeBehavior=convertToNull";
Connection conn = DriverManager.getConnection(url, "cs336", "cs3362019");


Statement stmt = conn.createStatement();

String category = request.getParameter("category");
String make = request.getParameter("make");
String model = request.getParameter("model");
String year = request.getParameter("year");


if(!category.equals("")){

	
	PreparedStatement pstmt = conn.prepareStatement("select Item.category, Item.make, Item.model, Item.vehicleYr, Auction.endDate, Auction.startDate, Bid.amt from Item, Auction, Bid where Item.itemID = Auction.item_ID and Auction.auctionID = Bid.auction_ID and Item.category='"+category+"'");
	//stmt.setString(1, category);
	
	 rs=pstmt.executeQuery();
}

if(!make.equals("")){

	
	PreparedStatement pstmt = conn.prepareStatement("select Item.category, Item.make, Item.model, Item.vehicleYr, Auction.endDate, Auction.startDate, Bid.amt from Item, Auction, Bid where Item.itemID = Auction.item_ID and Auction.auctionID = Bid.auction_ID and Item.make='"+make+"'");
	//stmt.setString(1, category);
	
	 rs=pstmt.executeQuery();
}


if(!model.equals("")){

	
	PreparedStatement pstmt = conn.prepareStatement("select Item.category, Item.make, Item.model, Item.vehicleYr, Auction.endDate, Auction.startDate, Bid.amt from Item, Auction, Bid where Item.itemID = Auction.item_ID and Auction.auctionID = Bid.auction_ID and Item.model='"+model+"'");
	//stmt.setString(1, category);
	
	 rs=pstmt.executeQuery();
}

if(!year.equals("")){

	
	PreparedStatement pstmt = conn.prepareStatement("select Item.category, Item.make, Item.model, Item.vehicleYr, Auction.endDate, Auction.startDate, Bid.amt from Item, Auction, Bid where Item.itemID = Auction.item_ID and Auction.auctionID = Bid.auction_ID and Item.vehicleYr='"+make+"'");
	//stmt.setString(1, category);
	
	 rs=pstmt.executeQuery();
}

while(rs.next())
{

%>
    <tr>
	    <td><%=rs.getString("category") %></td>
	    <td><%=rs.getString("make") %></td>
	    <td><%=rs.getString("model") %></td>
	    <td><%=rs.getString("vehicleYr") %></td>
	    <td><%=rs.getDate("endDate") %></td>
	    <td><%=rs.getString("startDate") %></td>
	    <td><%=rs.getDouble("amt") %></td>
	
	</tr>
        <%

}
%>
    </table>
    <%
    rs.close();
    conn.close();
    }
catch(Exception e)
{
    e.printStackTrace();
  //  out.print("No results found");
    }




%>
<style>
table {
  width:100%;
}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 15px;
  text-align: left;
}
table#t01 tr:nth-child(even) {
  background-color: #eee;
}
table#t01 tr:nth-child(odd) {
 background-color: #fff;
}
table#t01 th {
  background-color: black;
  color: white;
}
</style>
</form>
</html>