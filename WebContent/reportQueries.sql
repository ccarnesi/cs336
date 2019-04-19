--MySQL Queries used for generating sales reports
--Joel Kurian

--Total Earnings Report
SELECT sum(win_bid) total, count(*) num
FROM (
	SELECT Auction.auctionID, Auction.title, Bid.user_ID, max(Bid.amt) win_bid
	FROM Auction, Bid
	WHERE Bid.auction_ID = Auction.auctionID
		AND Auction.endDate < "current_date_variable"
		AND Bid.amt >= Auction.reservePrice
	GROUP BY auctionID) t
	
--Most sold items report
SELECT *, count(*) num
FROM (SELECT Item.category, Item.make, Item.model, Item.vehicleYr
	  FROM Auction, Bid, Item
	  WHERE Bid.auction_ID = Auction.auctionID
	  	AND Auction.item_ID = Item.itemID
	  	AND Auction.endDate < "current_date_variable"
	  	AND Bid.amt >= Auction.reservePrice
	  GROUP BY Auction.auctionID) t
GROUP BY category, make, model, vehicleYr
ORDER BY num, category, make, model DESC