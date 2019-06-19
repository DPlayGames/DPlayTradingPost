pragma solidity ^0.5.9;

import "./DPlayTradingPostInterface.sol";
import "./DPlayCoinInterface.sol";
import "./Standard/ERC20.sol";
import "./Standard/ERC721.sol";
import "./Util/NetworkChecker.sol";
import "./Util/SafeMath.sol";

contract DPlayTradingPost is DPlayTradingPostInterface, NetworkChecker {
	using SafeMath for uint;
	
	ResourceSale[] private resourceSales;
	ItemSale[] private itemSales;
	
	mapping(address => uint[]) private sellerToResourceSaleIds;
	mapping(address => uint[]) private sellerToItemSaleIds;
	
	DPlayCoinInterface private dplayCoin;
	
	constructor() NetworkChecker() public {
		
		// Loads the DPlay Coin smart contract.
		// DPlay Coin 스마트 계약을 불러옵니다.
		if (network == Network.Mainnet) {
			//TODO
		} else if (network == Network.Kovan) {
			dplayCoin = DPlayCoinInterface(0x8079bA69E89237a4B739fF57337109fDAbD8CCa0);
		} else if (network == Network.Ropsten) {
			//TODO
		} else if (network == Network.Rinkeby) {
			//TODO
		} else {
			revert();
		}
	}
	
	// Returns the number of resource sales.
	// 자원 판매 횟수를 반환합니다.
	function getResourceSaleCount() external view returns (uint) {
		return resourceSales.length;
	}
	
	// Returns the number of item sales.
	// 아이템 판매 횟수를 반환합니다.
	function getItemSaleCount() external view returns (uint) {
		return itemSales.length;
	}
	
	// Sells resources.
	// 자원을 판매합니다.
	function sellResource(
		address[] calldata	resourceAddresses,
		uint[] calldata		resourceAmounts,
		uint				price,
		string calldata		description
	) external returns (uint) {
		
		// The price must be higher than 0.
		// 판매 가격은 유료여야 합니다.
		require(price > 0);
		
		ERC20[] memory resources = new ERC20[](resourceAddresses.length);
		
		for (uint i = 0; i < resourceAddresses.length; i += 1) {
			resources[i] = ERC20(resourceAddresses[i]);
		}
		
		// Data validification
		// 데이터 검증
		for (uint i = 0; i < resourceAddresses.length; i += 1) {
			
			// The seller's total amount of resources must be equal or more than the amount of the resources to be sold.
			// 판매자가 가진 자원의 양이 판매할 양과 같거나 많아야 합니다.
			require(resources[i].balanceOf(msg.sender) >= resourceAmounts[i]);
			
			// The amount of resources that the trading post is allowed to withdraw must be equal or more than the resources to be sold.
			// 교역소에 인출을 허락한 자원의 양이 판매할 양과 같거나 많아야 합니다.
			require(resources[i].allowance(msg.sender, address(this)) >= resourceAmounts[i]);
		}
		
		for (uint i = 0; i < resourceAddresses.length; i += 1) {
			
			// Moves the resources to be sold to the trading post.
			// 교역소에 자원을 이동합니다.
			resources[i].transferFrom(msg.sender, address(this), resourceAmounts[i]);
		}
		
		uint createTime = now;
		
		// Registers the sales info.
		// 판매 정보를 등록합니다.
		uint saleId = resourceSales.push(ResourceSale({
			seller				: msg.sender,
			resourceAddresses	: resourceAddresses,
			resourceAmounts		: resourceAmounts,
			price				: price,
			description			: description,
			createTime			: createTime
		})).sub(1);
		
		sellerToResourceSaleIds[msg.sender].push(saleId);
		
		emit SellResource(saleId, price, resourceAddresses, resourceAmounts, description, createTime);
		
		return saleId;
	}
	
	// Sells items.
	// 아이템을 판매합니다.
	function sellItem(
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
		uint saleId = itemSales.push(ItemSale({
			seller				: msg.sender,
			itemAddresses	: itemAddresses,
			itemIds			: itemIds,
			price			: price,
			description		: description,
			createTime		: createTime
		})).sub(1);
		
		sellerToItemSaleIds[msg.sender].push(saleId);
		
		emit SellItem(saleId, price, itemAddresses, itemIds, description, createTime);
		
		return saleId;
	}
	
	// Returns resource sales info.
	// 자원 판매 정보를 반환합니다.
	function getResourceSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory resourceAddresses,
		uint[] memory resourceAmounts,
		uint price,
		string memory description,
		uint createTime
	) {
		
		ResourceSale storage sale = resourceSales[saleId];
		
		return (
			sale.seller,
			sale.resourceAddresses,
			sale.resourceAmounts,
			sale.price,
			sale.description,
			sale.createTime
		);
	}
	
	// Returns item sales info.
	// 아이템 판매 정보를 반환합니다.
	function getItemSaleInfo(uint saleId) external view returns (
		address seller,
		address[] memory itemAddresses,
		uint[] memory itemIds,
		uint price,
		string memory description,
		uint createTime
	) {
		
		ItemSale storage sale = itemSales[saleId];
		
		return (
			sale.seller,
			sale.itemAddresses,
			sale.itemIds,
			sale.price,
			sale.description,
			sale.createTime
		);
	}
	
	// Cancels a resources sale.
	// 자원 판매를 취소합니다.
	function cancelResourceSale(uint saleId) external {
		
		ResourceSale memory sale = resourceSales[saleId];
		
		// Checks if the sender is the seller.
		// 판매자인지 확인합니다.
		require(sale.seller == msg.sender);
		
		// Returns the resources to the seller.
		// 자원을 판매자에게 되돌려줍니다.
		for (uint i = 0; i < sale.resourceAddresses.length; i += 1) {
			ERC20(sale.resourceAddresses[i]).transferFrom(address(this), msg.sender, sale.resourceAmounts[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete resourceSales[saleId];
		
		emit CancelResourceSale(saleId);
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
			ERC721(sale.itemAddresses[i]).transferFrom(address(this), msg.sender, sale.itemIds[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete itemSales[saleId];
		
		emit CancelItemSale(saleId);
	}
	
	// Buys resources.
	// 자원을 구매합니다.
	function buyResource(uint saleId) payable external {
		
		ResourceSale memory sale = resourceSales[saleId];
		
		// The balance must be higher than the price.
		// DC 보유량이 가격보다 커야합니다.
		require(dplayCoin.balanceOf(msg.sender) >= sale.price);
		
		// Delivers the resources to the buyer.
		// 자원을 구매자에게 전달합니다.
		for (uint i = 0; i < sale.resourceAddresses.length; i += 1) {
			ERC20(sale.resourceAddresses[i]).transferFrom(address(this), msg.sender, sale.resourceAmounts[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete resourceSales[saleId];
		
		// Transmits the payment to the seller.
		// 판매자에게 DC를 전송합니다.
		dplayCoin.transferFrom(msg.sender, sale.seller, sale.price);
		
		emit BuyResourceSale(saleId, msg.sender);
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
			ERC721(sale.itemAddresses[i]).transferFrom(address(this), msg.sender, sale.itemIds[i]);
		}
		
		// Deletes the sale info.
		// 판매 정보를 삭제합니다.
		delete itemSales[saleId];
		
		// Transmits the payment to the seller.
		// 판매자에게 DC를 전송합니다.
		dplayCoin.transferFrom(msg.sender, sale.seller, sale.price);
		
		emit BuyItemSale(saleId, msg.sender);
	}
}
