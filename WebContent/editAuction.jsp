<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		//parameters
		String auctionID = request.getParameter("auctionID");
		String seller = request.getParameter("seller");
		String title = request.getParameter("title");
		String make = request.getParameter("make");
		int Rawcategory = Integer.parseInt(request.getParameter("Category"));
		String category = "";
		String model = request.getParameter("model");
		String year = request.getParameter("year");
		Float startPrice = Float.parseFloat(request.getParameter("startPrice"));
		Float incrementPrice = Float.parseFloat(request.getParameter("incrementPrice"));
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		Float reserve = Float.parseFloat(request.getParameter("secretReservePrice"));
		
		if (Rawcategory == 1) {
			category = "Motorcycle";
		} else if (Rawcategory == 2) {
			category = "Truck";
		} else {
			category = "Sedan";
		}
		
		//query to check if the auction exists
		PreparedStatement ps = con.prepareStatement("SELECT item_ID FROM Auction WHERE auctionID=?");
		ps.setString(1, auctionID);
		ResultSet rs = ps.executeQuery();
		
		//fail: Auction does not exist
		if (!(rs.next())) {
			out.print("Error: Auction does not exist\n");
			
		//The auction exists
		} else {
			String item_ID = rs.getString("item_ID");
			
			//update Auction table
			ps.close();
			ps = con.prepareStatement("UPDATE Auction SET title =?, startDate =?, endDate =?, initialPrice =?, reservePrice =?, minBidRaise =?, seller =? WHERE auctionID =?");
			ps.setString(1, title);
			ps.setString(2, startDate);
			ps.setString(3, endDate);
			ps.setFloat(4, startPrice);
			ps.setFloat(5, reserve);
			ps.setFloat(6, incrementPrice);
			ps.setString(7, seller);
			ps.setString(8, auctionID);
			
			ps.executeUpdate();
			//out.print("Auction updated\n");
			
			//update Item table
			ps.close();
			ps = con.prepareStatement("UPDATE Item SET category =?, make =?, model =?, vehicleYr =? WHERE itemID =?");
			ps.setString(1, category);
			ps.setString(2, make);
			ps.setString(3, model);
			ps.setString(4, year);
			ps.setString(5, item_ID);
			
			ps.executeUpdate();
			//out.print("Item updated\n");
		}
		
		ps.close();
		rs.close();
		con.close();
	} catch (Exception e) {
		out.print(e);
		out.print("\nFailed to edit auction");
	}
%>
</body>
</html>