<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alter a Bid</title>
</head>
<body>
<ul>
	<li>
		<h2>Remove a Bid</h2>
		<form action="deleteBid.jsp" method="post">
			BidID:<input type="text" name="bidID" required>
			<br>Confirm BidID:<input type="text" name="confirm_bidID" required>
			<br><input type="submit" value="Submit">
		</form>
	</li>
</ul>
</body>
</html>