pragma solidity ^0.5.9;

interface DPlayTradingPostInterface {
	
	// 이벤트
	event SellResource(uint saleId, uint price, address[] resourceAddresses, uint[] resourceAmounts, string description, uint createTime);
	event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemIds, string description, uint createTime);
	event CancelResourceSale(uint indexed saleId);
	event CancelItemSale(uint indexed saleId);
	
	// 자원 판매 정보
	struct ResourceSale {
		address		seller;
		address[]	resourceAddresses;
		uint[]		resourceAmounts;
		uint		price;
		string		description;
		uint		createTime;
	}
	
	// 아이템 판매 정보
	struct ItemSale {
		address		seller;
		address[]	itemAddresses;
		uint[]		itemIds;
		uint		price;
		string		description;
		uint		createTime;
	}
	
	// 물품 판매
	// sell
	
	// 물품 구매
	// buy
}