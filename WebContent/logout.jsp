<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head> 
		<title> Auction Login </title>
	</head>
	<body>
	<%
	session.invalidate();
	response.sendRedirect("login.jsp");
	%>
	</body>
</html>