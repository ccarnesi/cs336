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
		String confirm = request.getParameter("confirm_auctionID");
		
		//fail: confirmation doesn't match
		if (!(auctionID.equals(confirm))) {
			out.print("Error: mismatched auctions");
			
		//auction confirmed
		} else {
			PreparedStatement ps = con.prepareStatement("SELECT * FROM Auction WHERE auctionID =?");
			ps.setString(1, auctionID);
			ResultSet rs = ps.executeQuery();
			
			//fail: auction doesn't exist
			if (!(rs.next())) {
				out.print("Error: Auction does not exist");
				
			//success: auction will be deleted
			} else {
				ps.close();
				ps = con.prepareStatement("DELETE FROM Auction WHERE auctionID =?");
				ps.setString(1, auctionID);
				
				ps.executeUpdate();
				out.print("Auction deleted");
			}
			ps.close();
			rs.close();
		}
		con.close();
	} catch (Exception e) {
		out.print("\nError deleting Auction: ");
		out.print(e);
	}
%>
</body>
</html>