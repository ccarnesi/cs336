<!-- Code done by Chris Carnesi -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>

<title>Create an auction</title>
</head>
<body>
<%
	try{
		
		
		
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		
		String title = request.getParameter("title");
		 String make = request.getParameter("make");
		 int Rawcategory = Integer.parseInt(request.getParameter("Category"));
		 String category = "";
		 String model = request.getParameter("model");
		 String year = request.getParameter("year");
		 Float startPrice = Float.parseFloat(request.getParameter("startPrice"));
		 Float incrementPrice = Float.parseFloat(request.getParameter("incrementPrice"));
		 String startDate = request.getParameter("startDate");
		 String endDate = request.getParameter("endDate");
		 Float reserve = Float.parseFloat(request.getParameter("secretReservePrice"));
		String seller = session.getAttribute("userID") + "";
		//HANDLE EMPTY FIELDS
		
		
		
		
		 String stmt = "INSERT INTO Item (category, make, model, vehicleYr) Values(?,?,?,?)";
		 PreparedStatement pst = con.prepareStatement(stmt, Statement.RETURN_GENERATED_KEYS);
			if(Rawcategory == 1){
				category = "Motorcycle";
			}else if (Rawcategory == 2){
				category = "Truck";
			}else{
				category = "Sedan";
			}
			
			
			pst.setString(1, category);
			pst.setString(2, make);
			pst.setString(3, model);
			pst.setString(4, year);
			
			
			ResultSet key = null;
			int rs = pst.executeUpdate();
			if(rs<1){
				out.println("Fail");
			}else{
				out.println("Success");
				key = pst.getGeneratedKeys();
				key.next();
				int itemID = key.getInt(1);
				
				String auctionStmt = "INSERT INTO Auction (title, startDate, endDate, initialPrice, reservePrice, minBidRaise, seller, item_ID) VALUES(?,?,?,?,?,?,?,?)";
				PreparedStatement pstmt = con.prepareStatement(auctionStmt, Statement.RETURN_GENERATED_KEYS);
				pstmt.setString(1, title);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				pstmt.setFloat(4, startPrice);
				pstmt.setFloat(5, reserve);
				pstmt.setFloat(6, incrementPrice);
				pstmt.setString(7, seller);
				pstmt.setInt(8,itemID);
				
				int res = pstmt.executeUpdate();
				if(res<1){
					out.println("Fail");
				}else{
					ResultSet aKey = pstmt.getGeneratedKeys();
					aKey.next();
					int audID = aKey.getInt(1);
					response.sendRedirect("listing.jsp?auctionID=" + audID);
				}
			}
			
			
			pst.close();
			key.close();
			con.close();
		
	}catch(Exception ex){
		out.print(ex);
		out.print("New auction creation failed ");
	}





%>
</body>
</html>