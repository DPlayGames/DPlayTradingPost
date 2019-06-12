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
	
	// 자원 판매 횟수를 반환합니다.
	function getResourceSaleCount() external view returns (uint) {
		return resourceSales.length;
	}
	
	// 아이템 판매 횟수를 반환합니다.
	function getItemSaleCount() external view returns (uint) {
		return itemSales.length;
	}
	
	// 자원 판매
	function sellResource(
		address[] calldata	resourceAddresses,
		uint[] calldata		resourceAmounts,
		uint				price,
		string calldata		description
	) external returns (uint) {
		
		// 판매 가격은 유료여야 합니다.
		require(price > 0);
		
		ERC20[] memory resources = new ERC20[](resourceAddresses.length);
		
		for (uint i = 0; i < resourceAddresses.length; i += 1) {
			resources[i] = ERC20(resourceAddresses[i]);
		}
		
		// 데이터 검증
		for (uint i = 0; i < resourceAddresses.length; i += 1) {
			
			// 판매자가 가진 자원의 양이 판매할 양보다 많아야 합니다.
			require(resources[i].balanceOf(msg.sender) >= resourceAmounts[i]);
			
			// 교역소에 인출을 허락한 자원의 양이 판매할 양보다 많아야 합니다.
			require(resources[i].allowance(msg.sender, address(this)) >= resourceAmounts[i]);
		}
		
		for (uint i = 0; i < resourceAddresses.length; i += 1) {
			
			// 교역소에 자원을 이동합니다.
			resources[i].transferFrom(msg.sender, address(this), resourceAmounts[i]);
		}
		
		uint createTime = now;
		
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
	
	// 아이템 판매
	function sellItem(
		address[] calldata	itemAddresses,
		uint[] calldata		itemIds,
		uint				price,
		string calldata		description
	) external returns (uint) {
		
		// 판매 가격은 유료여야 합니다.
		require(price > 0);
		
		ERC721[] memory items = new ERC721[](itemAddresses.length);
		
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			items[i] = ERC721(itemAddresses[i]);
		}
		
		// 데이터 검증
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			
			// 판매자가 아이템의 소유자여야 합니다.
			require(items[i].ownerOf(itemIds[i]) == msg.sender);
			
			// 교역소에 인출을 허락한 아이템인지 확인합니다.
			require(
				msg.sender == items[i].getApproved(itemIds[i]) ||
				items[i].isApprovedForAll(msg.sender, address(this)) == true
			);
		}
		
		for (uint i = 0; i < itemAddresses.length; i += 1) {
			
			// 교역소에 아이템을 이동합니다.
			items[i].transferFrom(msg.sender, address(this), itemIds[i]);
		}
		
		uint createTime = now;
		
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
	
	// 자원 판매를 취소합니다.
	function cancelResourceSale(uint saleId) external {
		
		// 판매자인지 확인합니다.
		require(resourceSales[saleId].seller == msg.sender);
		
		// 자원을 판매자에게 되돌려줍니다.
		for (uint i = 0; i < resourceSales[saleId].resourceAddresses.length; i += 1) {
			ERC20(resourceSales[saleId].resourceAddresses[i]).transferFrom(address(this), msg.sender, resourceSales[saleId].resourceAmounts[i]);
		}
		
		// 판매 정보 삭제
		delete resourceSales[saleId];
		
		emit CancelResourceSale(saleId);
	}
	
	// 아이템 판매를 취소합니다.
	function cancelItemSale(uint saleId) external {
		
		// 판매자인지 확인합니다.
		require(itemSales[saleId].seller == msg.sender);
		
		// 아이템을 판매자에게 되돌려줍니다.
		for (uint i = 0; i < itemSales[saleId].itemAddresses.length; i += 1) {
			ERC721(itemSales[saleId].itemAddresses[i]).transferFrom(address(this), msg.sender, itemSales[saleId].itemIds[i]);
		}
		
		// 판매 정보 삭제
		delete itemSales[saleId];
		
		emit CancelItemSale(saleId);
	}
	
	// 자원을 구매합니다.
	function buyResource(uint saleId) payable public {
		
		ResourceSale memory resourceSale = resourceSales[saleId];
		
		//TODO:
	}
	
	// 아이템을 구매합니다.
	function buyItem(uint saleId) payable public {
		
		ItemSale memory itemSale = itemSales[saleId];
		
		//TODO:
	}
}