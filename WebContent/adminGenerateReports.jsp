<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Generate Reports</title>
</head>
<body>
	<ul>
		<li>
			<a href="totalEarningsReport.jsp">Total earnings from all completed auctions</a>
		</li>
		<li>
			<a href="specificEarningsReport.jsp">Earnings per Item/Category/User</a> <%//TODO earnings per things %>
		</li>
		<li>
			<a href="bestSellingReport.jsp">Most sold items</a>
		</li>
		<li>
			<a href="bestBuyerReport.jsp">Users with most won auctions</a> <%//TODO most won auctions %>
		</li>
	</ul>
</body>
</html>