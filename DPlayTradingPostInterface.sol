pragma solidity ^0.5.9;

interface DPlayTradingPostInterface {
	
	// Events
	// 이벤트
	event SellResource(uint saleId, uint price, address[] resourceAddresses, uint[] resourceAmounts, string description, uint createTime);
	event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemIds, string description, uint createTime);
	event CancelResourceSale(uint indexed saleId);
	event CancelItemSale(uint indexed saleId);
	event BuyResourceSale(uint indexed saleId, address indexed buyer);
	event BuyItemSale(uint indexed saleId, address indexed buyer);
	
	// Resource sale info
	// 자원 판매 정보
	struct ResourceSale {
		address		seller;
		address[]	resourceAddresses;
		uint[]		resourceAmounts;
		uint		price;
		string		description;
		uint		createTime;
	}
	
	// Item sale info
	// 아이템 판매 정보
	struct ItemSale {
		address		seller;
		address[]	itemAddresses;
		uint[]		itemIds;
		uint		price;
		string		description;
		uint		createTime;
	}
	
	// Returns the number of resource sales.
	// 자원 판매 횟수를 반환합니다.
	function getResourceSaleCount() external view returns (uint);
	
	// Returns the number of item sales.
	// 아이템 판매 횟수를 반환합니다.
	function getItemSaleCount() external view returns (uint);
	
	// Sells resources.
	// 자원을 판매합니다.
	function sellResource(
		address[] calldata	resourceAddresses,
		uint[] calldata		resourceAmounts,
		uint				price,
		string calldata		description
	) external returns (uint);
	
	// Sells items.
	// 아이템을 판매합니다.
	function sellItem(
		address[] calldata	itemAddresses,
		uint[] calldata		itemIds,
		uint				price,
		string calldata		description
	) external returns (uint);
	
	// 특정 주소가 자원 판매자인지 확인합니다.
	function checkIsResourceSeller(address addr, uint saleId) external view returns (bool);
	
	// 특정 주소가 아이템 판매자인지 확인합니다.
	function checkIsItemSeller(address addr, uint saleId) external view returns (bool);
	
	// 특정 판매자가 판매중인 자원 판매 ID들을 가져옵니다.
	function getResourceSaleIds(address seller) external view returns (uint[] memory);
	
	// 특정 판매자가 판매중인 아이템 판매 ID들을 가져옵니다.
	function getItemSaleIds(address seller) external view returns (uint[] memory);
	
	// Returns resource sale info.
	// 자원 판매 정보를 반환합니다.
	function getResourceSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory resourceAddresses,
		uint[] memory resourceAmounts,
		uint price,
		string memory description,
		uint createTime
	);
	
	// Returns item sale info.
	// 아이템 판매 정보를 반환합니다.
	function getItemSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory itemAddresses,
		uint[] memory itemIds,
		uint price,
		string memory description,
		uint createTime
	);
	
	// Cancels a resource sale.
	// 자원 판매를 취소합니다.
	function cancelResourceSale(uint saleId) external;
	
	// Cancels an item sale.
	// 아이템 판매를 취소합니다.
	function cancelItemSale(uint saleId) external;
	
	// Buys resources.
	// 자원을 구매합니다.
	function buyResource(uint saleId) payable external;
	
	// Buys items.
	// 아이템을 구매합니다.
	function buyItem(uint saleId) payable external;
}
