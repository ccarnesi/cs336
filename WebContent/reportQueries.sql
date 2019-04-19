--Total Earnings Report
SELECT sum(win_bid) total, count(*) num
FROM (
	SELECT Auction.auctionID, Auction.title, Bid.user_ID, max(Bid.amt) win_bid
	FROM Auction, Bid
	WHERE Bid.auction_ID = Auction.auctionID
		AND endDate < "current_date_variable"
		AND Bid.amt >= Auction.reservePrice
	GROUP BY auctionID) t