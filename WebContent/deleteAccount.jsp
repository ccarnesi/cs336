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
		String user = request.getParameter("username");
		String confirm_user = request.getParameter("confirm_username");
		
		//fail: not confirmed
		if (!(user.equals(confirm_user))) {
			out.print("Error: Usernames do not match\n");
			
		//fail: cant delete admin
		} else if (user.equalsIgnoreCase("admin")) {
			out.print("Error: Cannot delete admin account\n");
			
		} else {
			PreparedStatement ps = con.prepareStatement("SELECT username FROM Accounts WHERE username =? AND accessLevel > 1");
			ps.setString(1, user);
			
			ResultSet rs = ps.executeQuery();
			
			//fail: Customer rep cannot delete other Customer reps
			if (rs.next()) {
				out.print("Error: You do not have permission to delete this account\n");
				
			//success: Account will be deleted
			} else {
				ps.close();
				ps = con.prepareStatement("DELETE FROM Accounts WHERE username =?");
				ps.setString(1, user);
				
				ps.executeUpdate();
				out.print("Account deleted");
			}
			ps.close();
			rs.close();
		}
		con.close();
	} catch (Exception e) {
		out.print(e);
		out.print("\nAn Error occurred");
	}
%>
</body>
</html>