pragma solidity ^0.5.9;

interface DPlayTradingPostInterface {
	
	// 이벤트
	// Events
	event SellResource(uint saleId, uint price, address[] resourceAddresses, uint[] resourceAmounts, string description, uint createTime);
	event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemIds, string description, uint createTime);
	event CancelResourceSale(uint indexed saleId);
	event CancelItemSale(uint indexed saleId);
	event BuyResourceSale(uint indexed saleId, address indexed buyer);
	event BuyItemSale(uint indexed saleId, address indexed buyer);
	
	// 자원 판매 정보
	// Resource sale info
	struct ResourceSale {
		address		seller;
		address[]	resourceAddresses;
		uint[]		resourceAmounts;
		uint		price;
		string		description;
		uint		createTime;
	}
	
	// 아이템 판매 정보
	// Item sale info
	struct ItemSale {
		address		seller;
		address[]	itemAddresses;
		uint[]		itemIds;
		uint		price;
		string		description;
		uint		createTime;
	}
	
	// 자원 판매 횟수를 반환합니다.
	// Returns the number of resource sales.
	function getResourceSaleCount() external view returns (uint);
	
	// 아이템 판매 횟수를 반환합니다.
	// Returns the number of item sales.
	function getItemSaleCount() external view returns (uint);
	
	// 자원 판매
	// Sells resources.
	function sellResource(
		address[] calldata	resourceAddresses,
		uint[] calldata		resourceAmounts,
		uint				price,
		string calldata		description
	) external returns (uint);
	
	// 아이템 판매
	// Sells items.
	function sellItem(
		address[] calldata	itemAddresses,
		uint[] calldata		itemIds,
		uint				price,
		string calldata		description
	) external returns (uint);
	
	// 자원 판매 정보를 반환합니다.
	// Returns resource sale info.
	function getResourceSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory resourceAddresses,
		uint[] memory resourceAmounts,
		uint price,
		string memory description,
		uint createTime
	);
	
	// 아이템 판매 정보를 반환합니다.
	// Returns item sale info.
	function getItemSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory itemAddresses,
		uint[] memory itemIds,
		uint price,
		string memory description,
		uint createTime
	);
	
	// 자원 판매를 취소합니다.
	// Cancels a resource sale.
	function cancelResourceSale(uint saleId) external;
	
	// 아이템 판매를 취소합니다.
	// Cancels an item sale.
	function cancelItemSale(uint saleId) external;
	
	// 자원을 구매합니다.
	// Buys resources.
	function buyResource(uint saleId) payable external;
	
	// 아이템을 구매합니다.
	// Buys items.
	function buyItem(uint saleId) payable external;
}
