<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head> 
		<title> Auction Sign Up </title>
	</head>
	<body>

		<h2> Sign Up </h2>
<center>
		<form action="checkSignUp.jsp" method="post">
			<br/>Username:<input type="text" name="username"> 
			<br/>Password:<input type="password" name="password">
			<br/>Confirm Password:<input type="password" name="confirm_password">  
			<br/><input type="submit" value="Submit">

		</form>
	</body>
</html>