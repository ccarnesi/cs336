<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head> 
		<title> Auction Login </title>
	</head>
	<body>

		<h2> Login Credentials </h2>
<center>
		<form action="checkLog.jsp" method="post">
			<br/>Username:<input type="text" name="username"> 
			<br/>Password:<input type="password" name="password"> 
			<br/><input type="submit" value="Submit">
			<a href = "signUp.jsp" >Sign Up!</a>
		</form>
</center>
	</body>
</html>