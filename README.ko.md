# DPlay 교역소

## 계약 주소
- Kovan: 0x0B7D367900d0fB627C2Fa22C245a51A6B3d8885c

## 테스트 여부
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event SellResource(uint saleId, uint price, address[] resourceAddresses, uint[] resourceAmounts, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemIds, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event CancelResourceSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event CancelItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event BuyResourceSale(uint indexed saleId, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event BuyItemSale(uint indexed saleId, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function getResourceSaleCount() external view returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function getItemSaleCount() external view returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function sellResource(address[] calldata resourceAddresses, uint[] calldata resourceAmounts, uint price, string calldata description) external returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function sellItem(address[] calldata itemAddresses, uint[] calldata itemIds, uint price, string calldata description) external returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function checkIsResourceSeller(address addr, uint saleId) external view returns (bool)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function checkIsItemSeller(address addr, uint saleId) external view returns (bool)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function getResourceSaleIds(address seller) external view returns (uint[] memory)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function getItemSaleIds(address seller) external view returns (uint[] memory)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function getResourceSaleInfo(uint saleId) external view returns (address seller, address[] memory resourceAddresses, uint[] memory resourceAmounts, uint price, string memory description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function getItemSaleInfo(uint saleId) external view returns (address seller, address[] memory itemAddresses, uint[] memory itemIds, uint price, string memory description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function cancelResourceSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function cancelItemSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function buyResource(uint saleId) payable external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function buyItem(uint saleId) payable external`