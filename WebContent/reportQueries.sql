--MySQL Queries used for generating sales reports
--Joel Kurian

--Total Earnings Report
SELECT sum(win_bid) total, count(*) num
FROM (
	SELECT Auction.auctionID, Auction.title, Bid.user_ID, max(Bid.amt) win_bid
	FROM Auction, Bid
	WHERE Bid.auction_ID = Auction.auctionID
		AND Auction.endDate < ? --innsert current date
		AND Bid.amt >= Auction.reservePrice
	GROUP BY auctionID) t
	
--Most sold items report
SELECT *, count(*) num
FROM (SELECT Item.category, Item.make, Item.model, Item.vehicleYr
	  FROM Auction, Bid, Item
	  WHERE Bid.auction_ID = Auction.auctionID
	  	AND Auction.item_ID = Item.itemID
	  	AND Auction.endDate < ? --insert current date
	  	AND Bid.amt >= Auction.reservePrice
	  GROUP BY Auction.auctionID) t
GROUP BY category, make, model, vehicleYr
ORDER BY num DESC

--Users with most won Auctions
SELECT user_ID, count(*) num 
FROM (SELECT Bid.user_ID 
	  FROM Auction, Bid 
	  WHERE Bid.auction_ID = Auction.auctionID 
	  	AND Auction.endDate < ? --insert current date
	  	AND Bid.amt >= Auction.reservePrice 
	  GROUP BY auctionID) t 
GROUP BY user_ID 
ORDER BY num DESC

--Total earnings for a specific item
SELECT category, make, model, vehicleYr, SUM(win_bid) total 
FROM (SELECT Item.category, Item.make, Item.model, Item.vehicleYr, MAX(Bid.amt) win_bid 
	  FROM Auction, Bid, Item 
	  WHERE Bid.Auction_ID = Auction.auctionID 
	  	AND Auction.item_ID = Item.itemID 
	  	AND Auction.endDate < ? --insert current date
	  	AND Bid.amt >= Auction.reservePrice 
	  GROUP BY Auction.auctionID) t 
WHERE category =? --insert vehicle category
	AND make =? --insert vehicle make
	AND model =? --insert vehicle model
	AND vehicleYr =? --insert vehicle year
GROUP BY category, make, model, vehicleYr 
ORDER BY total DESC

--Total earnings for a specific category
SELECT category, SUM(win_bid) total 
FROM (SELECT Item.category, MAX(Bid.amt) win_bid 
	  FROM Auction, Bid, Item 
	  WHERE Bid.Auction_ID = Auction.auctionID 
	  	AND Auction.item_ID = Item.itemID 
	  	AND Auction.endDate < ? --insert current date
	  	AND Bid.amt >= Auction.reservePrice 
	  GROUP BY Auction.auctionID) t 
WHERE category =? --insert vehicle category
GROUP BY category
ORDER BY total DESC