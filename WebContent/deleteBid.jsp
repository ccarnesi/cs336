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
		String bidID = request.getParameter("bidID");
		String confirm_bidID = request.getParameter("confirm_bidID");
		
		//fail: not confirmed
		if (!(bidID.equals(confirm_bidID))) {
			out.print("Error: bidIDs do not match");
			
		} else {
			PreparedStatement ps = con.prepareStatement("SELECT * FROM Bid WHERE bidID =?");
			ps.setString(1, bidID);
			
			ResultSet rs = ps.executeQuery();
			
			//fail: bid does not exist
			if (!(rs.next())) {
				out.print("Error: Bid does not exist");
				
			//success: bid will be deleted
			} else {
				ps.close();
				ps = con.prepareStatement("DELETE FROM Bid WHERE bidID =?");
				ps.setString(1, bidID);
				
				ps.executeUpdate();
				out.print("Bid deleted");
			}
			ps.close();
			rs.close();
		}
		con.close();
	} catch (Exception e) {
		out.print("\nError deleting Bid: ");
		out.print(e);
	}
%>
</body>
</html>