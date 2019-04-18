<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit an Account</title>
</head>
<body>
<ul>
	<li>
		<h2>Change an Account's password</h2>
		<form action="changePassword.jsp" method="post">
			<br>Account Username:<input type="text" name="username" maxlength="20" required>
			<br>New Password:<input type="text" name="password" maxlength="20" required>
			<br>Confirm New Password:<input type="text" name="confirm_password" maxlength="20" required>
			<br><input type="submit" value="submit">
		</form>
	</li>
	<li>
		<h2>Delete an Account</h2>
		<form action="deleteAccount.jsp" method="post" required>
			<br>Username:<input type="text" name="username" maxlength="20" required>
			<br>Confirm Username:<input type="text" name="confirm_username" maxlength="20" required>
			<br><input type="submit" value="submit">
		</form>
	</li>
</ul>
</body>
</html>