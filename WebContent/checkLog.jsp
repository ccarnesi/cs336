<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
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
	try{
		ResultSet rs = null;
		
		
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		
		
		
		
		// get params
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		
		if(username.length() == 0 || password.length() ==0){
			out.println("Empty Fields");
		}else{
			
			PreparedStatement ps = con.prepareStatement("SELECT * FROM Accounts WHERE username =? and pass =?");
		
		ps.setString(1, username);
		ps.setString(2, password);
		
		
		 rs = ps.executeQuery();
		
		
		
		if(rs.next()){
			//good login
			out.println("success");
			String userID = request.getParameter("username");
			request.getSession().setAttribute("userID", userID);
			int accessLevel = rs.getInt(3);
			request.getSession().setAttribute("accessLevel", accessLevel);
			response.sendRedirect("index.jsp");
		}else{
			//bad login
			out.println("Fail");
		}
		rs.close();
		ps.close();
	}
				
		
		con.close();
		
		
	}catch(Exception ex){
		out.print(ex);
		out.print("Login Failed");
	}





%>
</body>
</html>