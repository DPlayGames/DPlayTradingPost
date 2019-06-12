pragma solidity ^0.5.9;

interface DPlayTradingPostInterface {
	
	// 이벤트
	event SellResource(uint saleId, uint price, address[] resourceAddresses, uint[] resourceAmounts, string description, uint createTime);
	event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemIds, string description, uint createTime);
	event CancelResourceSale(uint indexed saleId);
	event CancelItemSale(uint indexed saleId);
	event BuyResourceSale(uint indexed saleId, address indexed buyer);
	event BuyItemSale(uint indexed saleId, address indexed buyer);
	
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
	
	// 자원 판매 횟수를 반환합니다.
	function getResourceSaleCount() external view returns (uint);
	
	// 아이템 판매 횟수를 반환합니다.
	function getItemSaleCount() external view returns (uint);
	
	// 자원 판매
	function sellResource(
		address[] calldata	resourceAddresses,
		uint[] calldata		resourceAmounts,
		uint				price,
		string calldata		description
	) external returns (uint);
	
	// 아이템 판매
	function sellItem(
		address[] calldata	itemAddresses,
		uint[] calldata		itemIds,
		uint				price,
		string calldata		description
	) external returns (uint);
	
	// 자원 판매 정보를 반환합니다.
	function getResourceSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory resourceAddresses,
		uint[] memory resourceAmounts,
		uint price,
		string memory description,
		uint createTime
	);
	
	// 아이템 판매 정보를 반환합니다.
	function getItemSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory itemAddresses,
		uint[] memory itemIds,
		uint price,
		string memory description,
		uint createTime
	);
	
	// 자원 판매를 취소합니다.
	function cancelResourceSale(uint saleId) external;
	
	// 아이템 판매를 취소합니다.
	function cancelItemSale(uint saleId) external;
	
	// 자원을 구매합니다.
	function buyResource(uint saleId) payable external;
	
	// 아이템을 구매합니다.
	function buyItem(uint saleId) payable external;
}