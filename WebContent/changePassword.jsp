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
		
		//getting parameters
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");
		
		//fail: password mismatch
		if (!(password.equals(confirm_password))) {
			out.print("Error: Passwords do not match\n");
			
		//fail: admin account	
		} else if (username.equals("admin")) {
			out.print("Error: Cannot edit admin account\n");
			
		//success: will change account password
		} else {
			PreparedStatement ps = con.prepareStatement("UPDATE Accounts SET pass =? WHERE username =?");
			ps.setString(1, password);
			ps.setString(2, username);
			
			ps.executeUpdate();
			out.print("Password changed");
			ps.close();
		}
		con.close();
	} catch(Exception e) {
		out.print(e);
		out.print("\nAn Error occurred");
	}
%>
</body>
</html>