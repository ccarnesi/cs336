<!-- Joel Kurian -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<ul>
	<li>
		<h2>Edit an Auction</h2>
		<h4>You must fill out everything, even the things you do not want to change</h4>
		<h6>AuctionID is used to identify an Auction</h6>
		<form action="editAuction.jsp" method="POST">
			AuctionID:<input type="text" name="auctionID" required>
			<br>sellerID:<input type="text" name="seller" required>
			<br>Category: <select name="Category">
   	 			<option value="1">Motorcycle</option>
   	 			<option value="2">Truck</option>
    			<option value="3">Sedan</option>
 			</select>
 			<br/>Title: <input type="text" name="title" required>
 			<br/>Make:<input type="text" name="make" required> 
			<br/>Model:<input type="text" name="model" required> 
 			<br/>Year:<input type="text" name="year" required> 
 			<br/>Start Price:<input placeholder = "0.00" step="0.01" type="number" name="startPrice" required> 
 			<br/>Increment Price:<input placeholder = "0.00" step="0.01" type="number" name="incrementPrice" required> 
 			<br/>Start Date and Time:<input placeholder= "yyyy-mm-dd --:--:--" type="datetime-local" name="startDate" required>
 			<br/>End Date and Time:<input placeholder= "yyyy-mm-dd --:--:--" type="datetime-local" name="endDate" required>
 			<br/> If you do not wish to set a reserve please enter 0 in the box below otherwise enter reserve
 			<br/>Secret Reserve Price:<input placeholder = "0.00" step="0.01" type="number" name="secretReservePrice" required> 
 			<br/><input type="submit" value="Submit">
		</form>
	</li>
	
	<li>
		<h2>Delete an Auction</h2> <% //TODO Delete Auction %>
		<form action="deleteAuction.jsp" method="post">
			
		</form>
	</li>
</ul>
</body>
</html>