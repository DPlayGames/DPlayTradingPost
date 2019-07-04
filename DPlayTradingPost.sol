pragma solidity ^0.5.9;

import "./DPlayTradingPostInterface.sol";
import "./DPlayCoinInterface.sol";
import "./Standard/ERC20.sol";
import "./Standard/ERC721.sol";
import "./Util/NetworkChecker.sol";
import "./Util/SafeMath.sol";

contract DPlayTradingPost is DPlayTradingPostInterface, NetworkChecker {
	using SafeMath for uint;
	
	ItemSale[] private itemSales;
	UniqueItemSale[] private uniqueItemSales;
	
	mapping(address => uint[]) private sellerToItemSaleIds;
	mapping(address => uint[]) private sellerToUniqueItemSaleIds;
	
	DPlayCoinInterface private dplayCoin;
	
	constructor() NetworkChecker() public {
		
		// Loads the DPlay Coin smart contract.
		// DPlay Coin 스마트 계약을 불러옵니다.
		if (network == Network.Mainnet) {
			//TODO
		} else if (network == Network.Kovan) {
			dplayCoin = DPlayCoinInterface(0x3D8E940e9b7cD7ae52BFce54b1C92C4b33EE6b82);
		} else if (network == Network.Ropsten) {
			//TODO
		} else if (network == Network.Rinkeby) {
			//TODO
		} else {
			revert();
		}
	}
	
	// Returns the number of item sales.
	// 아이템 판매 횟수를 반환합니다.
	function getItemSaleCount() external view returns (uint) {
		return itemSales.length;
	}
	
	// 유니크 아이템 판매 횟수를 반환합니다.
	function getUniqueItemSaleCount() external view returns (uint) {
		return uniqueItemSales.length;
	}
	
	// Sells items.
	// 아이템을 판매합니다.
	function sellItem(
		address[] calldata	itemAddresses,
		uint[] calldata		itemAmounts,
		uint				price,
		string calldata		description
	) external returns (uint) {
		
		// The price must be higher than 0.
		// 판매 가격은 유료여야 합니다.
		require(price > 0);
		
		ERC20[] memory resources = new ERC20[](itemAddresses.length);
		
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			resources[i] = ERC20(itemAddresses[i]);
		}
		
		// Data validification
		// 데이터 검증
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			
			// 판매자가 가진 아이템의 양이 판매할 양과 같거나 많아야 합니다.
			require(resources[i].balanceOf(msg.sender) >= itemAmounts[i]);
			
			// 교역소에 인출을 허락한 아이템의 양이 판매할 양과 같거나 많아야 합니다.
			require(resources[i].allowance(msg.sender, address(this)) >= itemAmounts[i]);
		}
		
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			
			// 교역소에 아이템을 이동합니다.
			resources[i].transferFrom(msg.sender, address(this), itemAmounts[i]);
		}
		
		uint createTime = now;
		
		// Registers the sales info.
		// 판매 정보를 등록합니다.
		uint saleId = itemSales.push(ItemSale({
			seller			: msg.sender,
			itemAddresses	: itemAddresses,
			itemAmounts		: itemAmounts,
			price			: price,
			description		: description,
			createTime		: createTime
		})).sub(1);
		
		sellerToItemSaleIds[msg.sender].push(saleId);
		
		emit SellItem(saleId, price, itemAddresses, itemAmounts, description, createTime);
		
		return saleId;
	}
	
	// 유니크 아이템을 판매합니다.
	function sellUniqueItem(
		address[] calldata	itemAddresses,
		uint[] calldata		itemIds,
		uint				price,
		string calldata		description
	) external returns (uint) {
		
		// The price must be higher than 0.
		// 판매 가격은 유료여야 합니다.
		require(price > 0);
		
		ERC721[] memory items = new ERC721[](itemAddresses.length);
		
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			items[i] = ERC721(itemAddresses[i]);
		}
		
		// data validification
		// 데이터 검증
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			
			// The seller must own the items to be sold.
			// 판매자가 아이템의 소유자여야 합니다.
			require(items[i].ownerOf(itemIds[i]) == msg.sender);
			
			// The items to be sold must be allowed to be withdrawn by the trading post.
			// 교역소에 인출을 허락한 아이템인지 확인합니다.
			require(
				msg.sender == items[i].getApproved(itemIds[i]) ||
				items[i].isApprovedForAll(msg.sender, address(this)) == true
			);
		}
		
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			
			// Moves the items to be sold to the trading post.
			// 교역소에 아이템을 이동합니다.
			items[i].transferFrom(msg.sender, address(this), itemIds[i]);
		}
		
		uint createTime = now;
		
		// Registers the sales info.
		// 판매 정보를 등록합니다.
		uint saleId = uniqueItemSales.push(UniqueItemSale({
			seller			: msg.sender,
			itemAddresses	: itemAddresses,
			itemIds			: itemIds,
			price			: price,
			description		: description,
			createTime		: createTime
		})).sub(1);
		
		sellerToUniqueItemSaleIds[msg.sender].push(saleId);
		
		emit SellUniqueItem(saleId, price, itemAddresses, itemIds, description, createTime);
		
		return saleId;
	}
	
	// Checks if the given address is the item seller.
	// 특정 주소가 아이템 판매자인지 확인합니다.
	function checkIsItemSeller(address addr, uint saleId) external view returns (bool) {
		return itemSales[saleId].seller == addr;
	}
	
	// 특정 주소가 유니크 아이템 판매자인지 확인합니다.
	function checkIsUnqiueItemSeller(address addr, uint saleId) external view returns (bool) {
		return uniqueItemSales[saleId].seller == addr;
	}
	
	// Gets the sale IDs of the items sold by the given seller.
	// 특정 판매자가 판매중인 아이템 판매 ID들을 가져옵니다.
	function getItemSaleIds(address seller) external view returns (uint[] memory) {
		return sellerToItemSaleIds[seller];
	}
	// 특정 판매자가 판매중인 유니크 아이템 판매 ID들을 가져옵니다.
	function getUniqueItemSaleIds(address seller) external view returns (uint[] memory) {
		return sellerToUniqueItemSaleIds[seller];
	}
	
	// Returns item sales info.
	// 아이템 판매 정보를 반환합니다.
	function getItemSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory itemAddresses,
		uint[] memory itemAmounts,
		uint price,
		string memory description,
		uint createTime
	) {
		
		ItemSale storage sale = itemSales[saleId];
		
		return (
			sale.seller,
			sale.itemAddresses,
			sale.itemAmounts,
			sale.price,
			sale.description,
			sale.createTime
		);
	}
	
	// 유니크 아이템 판매 정보를 반환합니다.
	function getUniqueItemSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory itemAddresses,
		uint[] memory itemIds,
		uint price,
		string memory description,
		uint createTime
	) {
		
		UniqueItemSale storage sale = uniqueItemSales[saleId];
		
		return (
			sale.seller,
			sale.itemAddresses,
			sale.itemIds,
			sale.price,
			sale.description,
			sale.createTime
		);
	}
	
	// Cancels an item sale.
	// 아이템 판매를 취소합니다.
	function cancelItemSale(uint saleId) external {
		
		ItemSale memory sale = itemSales[saleId];
		
		// Checks if the sender is the seller.
		// 판매자인지 확인합니다.
		require(sale.seller == msg.sender);
		
		// Returns the items to the seller.
		// 아이템을 판매자에게 되돌려줍니다.
		for (uint i = 0; i < sale.itemAddresses.length; i += 1) {
			ERC20(sale.itemAddresses[i]).transferFrom(address(this), msg.sender, sale.itemAmounts[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete itemSales[saleId];
		
		emit CancelItemSale(saleId);
	}
	
	// 유니크 아이템 판매를 취소합니다.
	function cancelUniqueItemSale(uint saleId) external {
		
		UniqueItemSale memory sale = uniqueItemSales[saleId];
		
		// Checks if the sender is the seller.
		// 판매자인지 확인합니다.
		require(sale.seller == msg.sender);
		
		// Returns the items to the seller.
		// 아이템을 판매자에게 되돌려줍니다.
		for (uint i = 0; i < sale.itemAddresses.length; i += 1) {
			ERC721(sale.itemAddresses[i]).transferFrom(address(this), msg.sender, sale.itemIds[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete uniqueItemSales[saleId];
		
		emit CancelUniqueItemSale(saleId);
	}
	
	// Buys items.
	// 아이템을 구매합니다.
	function buyItem(uint saleId) payable external {
		
		ItemSale memory sale = itemSales[saleId];
		
		// The balance must be higher than the price.
		// DC 보유량이 가격보다 커야합니다.
		require(dplayCoin.balanceOf(msg.sender) >= sale.price);
		
		// Delivers the items to the buyer.
		// 아이템을 구매자에게 전달합니다.
		for (uint i = 0; i < sale.itemAddresses.length; i += 1) {
			ERC20(sale.itemAddresses[i]).transferFrom(address(this), msg.sender, sale.itemAmounts[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete itemSales[saleId];
		
		// Transmits the payment to the seller.
		// 판매자에게 DC를 전송합니다.
		dplayCoin.transferFrom(msg.sender, sale.seller, sale.price);
		
		emit BuyItemSale(saleId, msg.sender);
	}
	
	// 유니크 아이템을 구매합니다.
	function buyUniqueItem(uint saleId) payable external {
		
		UniqueItemSale memory sale = uniqueItemSales[saleId];
		
		// The balance must be higher than the price.
		// DC 보유량이 가격보다 커야합니다.
		require(dplayCoin.balanceOf(msg.sender) >= sale.price);
		
		// Delivers the items to the buyer.
		// 아이템을 구매자에게 전달합니다.
		for (uint i = 0; i < sale.itemAddresses.length; i += 1) {
			ERC721(sale.itemAddresses[i]).transferFrom(address(this), msg.sender, sale.itemIds[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete uniqueItemSales[saleId];
		
		// Transmits the payment to the seller.
		// 판매자에게 DC를 전송합니다.
		dplayCoin.transferFrom(msg.sender, sale.seller, sale.price);
		
		emit BuyUniqueItemSale(saleId, msg.sender);
	}
}
