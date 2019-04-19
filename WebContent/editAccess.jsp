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
		String username = request.getParameter("username");
		int level = Integer.parseInt(request.getParameter("level"));
		
		PreparedStatement ps = con.prepareStatement("SELECT * from Accounts WHERE username =?");
		ps.setString(1, username);
		ResultSet rs = ps.executeQuery();
		
		//fail: user does not exist
		if (!(rs.next())) {
			out.print("Error: user does not exist\n");
			
		//fail: admin account	
		} else if (username.equalsIgnoreCase("admin")) {
			out.print("Error: cannot edit admin account"); 
			
		//success: will change access level of the account
		} else {
			ps.close();
			ps = con.prepareStatement("UPDATE Accounts SET accessLevel =? WHERE username =?");
			ps.setInt(1, level);
			ps.setString(2, username);
			
			ps.executeUpdate();
			out.print("Access level changed");
		}
		ps.close();
		rs.close();
		con.close();
	} catch (Exception e) {
		out.print("\nError editing access level: ");
		out.print(e);
	}
%>
</body>
</html>