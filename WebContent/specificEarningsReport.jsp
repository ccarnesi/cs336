<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Specific Earnings Reports</title>
</head>
<body>
	<h2>If a report is blank, there are no earnings</h2>
	<h3>If a value is missing it has not produced any earnings</h3>
	<ul>
		<li>
			<h3>Earnings per item report</h3>
			<form action="earningsForItemReport.jsp" method="post">
				<input type="submit" value="Generate Report">
			</form>
		</li>
		<li>
			<h3>Earnings per category report</h3>
			<form action="earningsForCategoryReport.jsp" method="post">
				<input type="submit" value="Generate Report">
			</form>
		</li>
		<li>
			<h3>Earnings per user report</h3>
			<form action="earningsForUserReport.jsp" method="post">
				<input type="submit" value="Generate Report">
			</form>
		</li>
	</ul>
</body>
</html>