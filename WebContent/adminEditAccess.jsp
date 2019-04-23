<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Access Level</title>
</head>
<body>
	<h2>Edit the access level of a user</h2>
	<h3>admin account cannot be edited</h3>
	<form action="editAccess.jsp" method="post">
		Username:<input type="text" name="username" maxlength="20" required>
		<br>Access level:<select name="level">
			<option value="1">User</option>
			<option value="2">Customer Rep</option>
		</select>
		<br><input type="submit" value="Submit">
	</form>
</body>
</html>