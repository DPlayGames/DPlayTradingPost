pragma solidity ^0.5.9;

interface DPlayTradingPostInterface {
	
	// 거래 정보
	struct Trade {
		string title;
		string description;
		string price;
		
		// 자원(ERC-20)은 최대 4개까지 지정 가능합니다.
		address resource1Address;
		uint resource1Amount;
		address resource2Address;
		uint resource2Amount;
		address resource3Address;
		uint resource3Amount;
		address resource4Address;
		uint resource4Amount;
		
		// 자원(ERC-721)은 최대 9개까지 지정 가능합니다.
		address item1Address;
		address item2Address;
		address item3Address;
		address item4Address;
		address item5Address;
		address item6Address;
		address item7Address;
		address item8Address;
		address item9Address;
	}
	
	// 물품 등록
	// sell
	
	// 물품 구매
	// buy
}