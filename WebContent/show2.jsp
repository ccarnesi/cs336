<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
			List<String> list = new ArrayList<String>();
			try {
	
			
				
			String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
			
			Statement stmt = con.createStatement();
			
			String entity = request.getParameter("command");
			
			String str = "SELECT * FROM " + entity;
			
			ResultSet result = stmt.executeQuery(str);
			
			out.print("<table>");
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
		<tr>    
			<td>Name</td>
			<td>
				<%if (entity.equals("beers"))
					out.print("manf");
				else
					out.print("addr");
				%>
			</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("name") %></td>
					<td>
						<% if (entity.equals("beers")){ %>
							<%= result.getString("manf")%>
						<% }else{ %>
							<%= result.getString("addr")%>
						<% } %>
					</td>
				</tr>
				

			<% }
			//close the connection.
			//db.closeConnection(con);
			result.close();
			stmt.close();
			con.close();
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>