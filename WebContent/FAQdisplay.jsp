
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<!--close connections -->



<html>
<head> 
<title> FAQ Page </title>
</head>

<table border = "2" style="table-layout: fixed; width: 60%">

		<tr>
			<th> Username </th>
			<th> Question </th>
			<th> Answer </th>
			
		</tr>
<%
ResultSet faqRS = null;

try{
	
	String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
	
	PreparedStatement grabFAQ = con.prepareStatement("Select * from faq");
	//add this to grabFAQ    where qUsername = ?
	
	//grabFAQ.setString(1,session.getAttribute("userID") + "");
	
	 faqRS = grabFAQ.executeQuery();
	
	while(faqRS.next())
	{
		%>
		
		<tr style="outline: thin solid">
		
			<td style="word-wrap: break-word"><%=faqRS.getString(4) %></td>
			<td style="word-wrap: break-word"><%=faqRS.getString(2) %></td>
			
			
		</tr>
		
		<% if(faqRS.getString(3) != null)
		{
			%>
			
			<td style="word-wrap: break-word"><%=faqRS.getString(3) %></td>
			
			<%
		}
		
		%>
		
		<%
	}
	%>
	
	</table>
	
	<% 
}catch(Exception e){
	
	e.printStackTrace();
}

%>


<body>

</body>
</html>
