<!-- Code done by Chris Carnesi -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head> 
		<title> Auction Login </title>
	</head>
	<body>

		<h2> Create Auction </h2>
<form action="createAuctionHandler.jsp" method="POST">
	Category: <select name="Category">
    	<option value="1">Motorcycle</option>
    	<option value="2">Truck</option>
    	<option value="3">Sedan</option>
 	</select>
 	<br/>Title: <input type="text" name="title" Required>
 	<br/>Make:<input type="text" name="make" Required> 
	<br/>Model:<input type="text" name="model" Required> 
 	<br/>Year:<input type="text" name="year" Required> 
 	<br/>Start Price:<input placeholder = "0.00" step="0.01" type="number" name="startPrice" Required> 
 	<br/>Increment Price:<input placeholder = "0.00" step="0.01" type="number" name="incrementPrice" Required> 
 	<br/>Start Date and Time:<input placeholder= "mm/dd/yyyy, --:-- --"type="datetime-local" name="startDate" Required>
 	<br/>End Date and Time:<input placeholder= "mm/dd/yyyy, --:-- --" type="datetime-local" name="endDate" Required>
 	<br/> If you do not wish to set a reserve please enter 0 in the box below otherwise enter reserve
 	<br/>Secret Reserve Price:<input placeholder = "0.00" step="0.01" type="number" name="secretReservePrice" Required> 
 	<br/><input type="submit" value="Submit">
</form>
	</body>
</html>