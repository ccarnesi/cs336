<!-- Code done by Chris Carnesi -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>

<title>Create an auction</title>
</head>
<body>
<%
	ResultSet bidRS = null;
	try{
		int auctionID = 0;
		
		
		String url = "jdbc:mysql://cs336db.c0apsnxemine.us-east-2.rds.amazonaws.com:3306/AuctionDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "cs336", "cs3362019");
		//check if it was manual or auto
		int manOrAuto = Integer.parseInt(request.getParameter("manOrAuto"));
		
		if(manOrAuto == 0){//man bid
			//place bid and check to see if auto bid is set; if is then put autobid bid in bid table
			auctionID = Integer.parseInt(request.getParameter("auctionID"));
			float bidAttempt = Float.parseFloat(request.getParameter("bidAttempt"));
			float currentPrice = Float.parseFloat(request.getParameter("currentPrice"));
			float incrementPrice = Float.parseFloat(request.getParameter("incPrice"));
			String seller = request.getParameter("seller");
			String bidder = session.getAttribute("userID") + "";
			
			//make sure bidder isnt seller
			if(!bidder.equals(seller)){
				//check that bidder has made bid bigger or equal to inc
				if(bidAttempt - currentPrice >= incrementPrice){
					//good bid
					//grab highest bid userID BEFORE new bid is placed
					PreparedStatement bidQuery = con.prepareStatement("Select * from Bid where auction_ID = ? ORDER BY amt DESC");
					bidQuery.setInt(1, auctionID);
					bidRS = bidQuery.executeQuery(); 
					
					if(bidRS.next()){
						String oldTopUserID = bidRS.getString(3); //user who was outbid and will be notified
						int isAuto = bidRS.getInt(5);
						if(isAuto ==0){
							PreparedStatement manNotificInsert = con.prepareStatement("Insert into manNotific (usersID,manAuctionID) values (?,?)");
							manNotificInsert.setString(1,oldTopUserID);
							manNotificInsert.setInt(2,auctionID);
						
							manNotificInsert.executeUpdate();
						}
						//insert info to notifiy user they have bid outbid on their manual bid
						else
							{
							PreparedStatement autoNotific = con.prepareStatement("Insert into autoBidNotific (autoBid_username,autoBidAuctionID) values (?,?)");
							autoNotific.setString(1, oldTopUserID);
							autoNotific.setInt(2,auctionID);
							autoNotific.executeUpdate();
							
							}
						
					}
					
					
					PreparedStatement pst = con.prepareStatement("INSERT INTO Bid (auction_ID, user_ID, amt, manOrAuto) Values(?,?,?,?)");
					pst.setInt(1, auctionID);
					pst.setString(2, bidder);
					pst.setFloat(3,bidAttempt);
					pst.setInt(4,0);
					
					int res = pst.executeUpdate();
					if(res<1){
						out.println("fail1");
					}
					
					PreparedStatement autoBidpst = con.prepareStatement("SELECT * FROM AutoBid where auction_ID=? AND upperLimit>=? ORDER BY upperLimit DESC");
					autoBidpst.setInt(1, auctionID);
					autoBidpst.setFloat(2, bidAttempt + incrementPrice);
					ResultSet result = autoBidpst.executeQuery();
					
					if(!result.next()){
						//no autobid setup so dont do anything
						//NICK CODE GOES HERE
						//bid table will have if auto or not...grab highestAuto.next and check if the bid was an auto bid or not
						PreparedStatement checkUpper = con.prepareStatement("SELECT * FROM Bid where auction_ID=? ORDER BY amt DESC");
						checkUpper.setInt(1, auctionID);
						ResultSet highestAuto = checkUpper.executeQuery();
						
						if(highestAuto.next()) //then there is another row
						{
							int isAuto = highestAuto.getInt(5);
						//grab user to be notified
							String username = highestAuto.getString(3); 
							if(isAuto == 1)
							{
								
								PreparedStatement outbidUpper = con.prepareStatement("Insert into autoBidNotific (autoBid_username, autoBidAuctionID) Values(?,?)");
								outbidUpper.setInt(2, auctionID);
								outbidUpper.setString(1, username);
								outbidUpper.executeUpdate();
								
							}
						}
					}else{
						//autobid takes over so make bid
						PreparedStatement Bidpst = con.prepareStatement("INSERT INTO Bid (auction_ID, user_ID, amt) Values(?,?,?,?)");
						//grab these vals from result
						Bidpst.setInt(1, auctionID);
						Bidpst.setString(2, result.getString(4));
						Bidpst.setFloat(3, bidAttempt + incrementPrice);
						Bidpst.setInt(4,1);
						
						int BidpstRS = Bidpst.executeUpdate();
						if(BidpstRS<1){
							out.println("fail2");
						}
					}
				}
			}
		}else{//auto bid set
			
			//compare to other autobids
			auctionID = Integer.parseInt(request.getParameter("auctionID"));
			float incrementPrice = Float.parseFloat(request.getParameter("incPrice"));
			String seller = request.getParameter("seller");
			float upperLimit = Float.parseFloat(request.getParameter("bidUpperLimit"));
			float currentPrice = Float.parseFloat(request.getParameter("currentPrice"));
			String bidder = session.getAttribute("userID") + "";
			
			
			if(!bidder.equals(seller)){
			
				PreparedStatement autoBidpst = con.prepareStatement("SELECT * FROM AutoBid where auction_ID=? ORDER BY upperLimit DESC");
				autoBidpst.setInt(1, auctionID);
				ResultSet result = autoBidpst.executeQuery();
				if(!result.next()){
					
					// place bid that is inc from current price and store autoBid in table
					if(currentPrice + incrementPrice <= upperLimit){
						PreparedStatement autoOutbidMan = con.prepareStatement("Select user_ID from Bid where auction_ID = ? ORDER BY amt DESC");
						autoOutbidMan.setInt(1, auctionID);
						ResultSet rs = autoOutbidMan.executeQuery();
						if(!rs.next()){
							out.print("fail here");
						}else{
							String oldTopUserID = rs.getString(1); //user who was outbid and will be notified
							//insert info to notifiy user they have bid outbid on their manual bid
							PreparedStatement manNotificInsert = con.prepareStatement("Insert into manNotific (usersID,manAuctionID) values (?,?)");
							manNotificInsert.setString(1,oldTopUserID);
							manNotificInsert.setInt(2,auctionID);
							manNotificInsert.executeUpdate();
							
						}
						
						PreparedStatement stmt = con.prepareStatement("INSERT INTO Bid (auction_ID, user_ID, amt, manOrAuto) Values(?,?,?,?)");
						stmt.setInt(1, auctionID);
						stmt.setString(2, bidder);
						stmt.setFloat(3, currentPrice + incrementPrice);
						stmt.setInt(4,1);
						
						int res = stmt.executeUpdate();
						if(res<1){
							out.println("Fail3");
						}
						//now insert into autoBid table
						PreparedStatement autoStmt = con.prepareStatement("INSERT INTO AutoBid (auction_ID, upperLimit, user_ID) Values(?,?,?)");
						autoStmt.setInt(1, auctionID);
						autoStmt.setFloat(2, upperLimit);
						autoStmt.setString(3, bidder);
						
						int answer = autoStmt.executeUpdate();
						if(answer<1){
							out.println("Fail4");
						}
					
				}
			}else{
				// make sure upper limit set is higher than current by inc
				if(upperLimit>currentPrice + incrementPrice){
					
				
					
					float topAutoBid = result.getFloat(3);
					if(topAutoBid>=upperLimit){
						//set it to the upperlimit and award it to the person that holds topautobid
						
						//make bid at upper limit with bidder to the person who holds topautoBid
						PreparedStatement stmt = con.prepareStatement("INSERT INTO Bid (auction_ID, user_ID, amt, manOrAuto) Values(?,?,?,?)");
						stmt.setInt(1, auctionID);
						stmt.setString(2, result.getString(4));
						stmt.setFloat(3, upperLimit);
						stmt.setInt(4,1);
						int res = stmt.executeUpdate();
						if(res<1){
							out.println("Fail5");
						}
						
						//insert into autodb the upperlimit
						PreparedStatement autoStmt = con.prepareStatement("INSERT INTO AutoBid (auction_ID, upperLimit, user_ID) Values(?,?,?)");
						autoStmt.setInt(1, auctionID);
						autoStmt.setFloat(2, upperLimit);
						autoStmt.setString(3, bidder);
						
						int answer = autoStmt.executeUpdate();
						if(answer<1){
							out.println("Fail6");
						}
					}else if(topAutoBid<upperLimit){
						//set it to the topautobid and award the bid to the one that holds upperlimit
						//insert into autodb the upperlimit
						//make bid at topautoBid for person with topautobid
						//make sure topautobid is greater than current price
						
						String oldTopAutoUser = result.getString(4);
					
						if(topAutoBid> currentPrice){
							PreparedStatement bidQuery = con.prepareStatement("Select * from Bid where auction_ID = ? ORDER BY amt DESC");
							bidQuery.setInt(1, auctionID);
							bidRS = bidQuery.executeQuery(); 
							
							if(bidRS.next()){
							String oldTopUserID = bidRS.getString(3); //user who was outbid and will be notified
							//insert info to notifiy user they have bid outbid on their manual bid
							int isAuto = bidRS.getInt(5);
							if(isAuto == 0)
							{
							PreparedStatement manNotificInsert = con.prepareStatement("Insert into manNotific (usersID,manAuctionID) values (?,?)");
							manNotificInsert.setString(1,oldTopUserID);
							manNotificInsert.setInt(2,auctionID);
							
							manNotificInsert.executeUpdate();
							}
							else
							{
							PreparedStatement autoNotific = con.prepareStatement("Insert into autoBidNotific (autoBid_username,autoBidAuctionID) values (?,?)");
							autoNotific.setString(1, oldTopUserID);
							autoNotific.setInt(2,auctionID);
							autoNotific.executeUpdate();
							
							}
						
						}
							//make bid at upper limit for person with topautobid
							PreparedStatement stmt = con.prepareStatement("INSERT INTO Bid (auction_ID, user_ID, amt, manOrAuto) Values(?,?,?,?)");
							stmt.setInt(1, auctionID);
							stmt.setString(2, bidder);
							stmt.setFloat(3, topAutoBid + incrementPrice);
							stmt.setInt(4,1);
							
							//insert notifiction for user whos upper limit was outbid 
							/* PreparedStatement notific = con.prepareStatement("INSERT INTO autoBidNotific (autoBid_username, autoBidAuctionID) Values(?,?)");
							notific.setString(1, oldTopAutoUser);
							notific.setInt(2, auctionID);
							notific.executeUpdate(); */
							
							int res = stmt.executeUpdate();
							if(res<1){
								out.println("Fail7");
							}
							
						}else{
							//check to see if theres bids
							//if yes check if it was auto or man
							//notify accordingly
							
							
							
							
							//make bid at current price plus incPrice for person with upperlimit
							PreparedStatement stmt = con.prepareStatement("INSERT INTO Bid (auction_ID, user_ID, amt, manOrAuto) Values(?,?,?,?)");
							stmt.setInt(1, auctionID);
							stmt.setString(2, bidder);
							stmt.setFloat(3, currentPrice + incrementPrice);
							stmt.setInt(4,1);
							int res = stmt.executeUpdate();
							if(res<1){
								out.println("Fail8");
							}
						}
						PreparedStatement autoStmt = con.prepareStatement("INSERT INTO AutoBid (auction_ID, upperLimit, user_ID) Values(?,?,?)");
						autoStmt.setInt(1, auctionID);
						autoStmt.setFloat(2, upperLimit);
						autoStmt.setString(3, bidder);
						
						int answer = autoStmt.executeUpdate();
						if(answer<1){
							out.println("Fail9");
						}
						
							 
					}
				}
			}
		}
	}
		con.close();
		response.sendRedirect("listing.jsp?auctionID=" + auctionID);
		
	}catch(Exception ex){
		out.print(ex);
		out.print("Bid Placement failed ");
	}
%>
</body>
</html>