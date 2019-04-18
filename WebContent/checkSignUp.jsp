<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up</title>
</head>
<body>
<%
	try{
		
		
		
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		
		
		
		
		// get params
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");
		
		if(username.length() == 0 || password.length()==0){
			out.print("Empty Fields");
		}else{
			
		
		if(!(password.equals(confirm_password))){
			//fail
			out.println("Passwords don't match");
		}else{
			PreparedStatement ps = con.prepareStatement("SELECT username, pass FROM Accounts WHERE username =?");
			ps.setString(1, username);
			
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				//fail
				out.println("Already has account with username");
			}else{
				//insert into db
				PreparedStatement pst = con.prepareStatement("INSERT INTO Accounts Values(?,?,?)");
				pst.setString(1, username);
				pst.setString(2, password);
				pst.setInt(3,1);
				pst.executeUpdate();
				
				
				pst.close();
				request.getSession().setAttribute("userID", username);
				response.sendRedirect("index.jsp");
				
			}
			rs.close();
			ps.close();
		}
	}
		con.close();
		
	}catch(Exception ex){
		out.print(ex);
		out.print("Login Failed");
	}





%>
</body>
</html>