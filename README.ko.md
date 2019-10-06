# DPlay 교역소

## 계약 주소
- Kovan: 0x980f391C9C36BD6d95F5676dDfa7a3B414404570

## 테스트 여부
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event SellResource(uint saleId, uint price, address resourceAddresses, uint resourceAmount, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemAmounts, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event SellUniqueItem(uint saleId, uint price, address[] uniqueItemAddresses, uint[] uniqueItemIds, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event UpdateResourceSaleDescription(uint indexed saleId, string description)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event UpdateItemSaleDescription(uint indexed saleId, string description)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event UpdateUniqueItemSaleDescription(uint indexed saleId, string description)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event CancelResourceSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event CancelItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event CancelUniqueItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event ChangeResourceSaleAmount(uint indexed saleId, uint amount)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event BuyResource(uint indexed saleId, uint amount, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event BuyItem(uint indexed saleId, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `event BuyUniqueItem(uint indexed saleId, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getResourceSaleCount() external view returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getItemSaleCount() external view returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getUniqueItemSaleCount() external view returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function sellResource(address resourceAddress, uint resourceAmount, uint price, string calldata description) external returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function sellItem(address[] calldata itemAddresses, uint[] calldata itemAmounts, uint price, string calldata description) external returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function sellUniqueItem(address[] calldata itemAddresses, uint[] calldata itemIds, uint price, string calldata description) external returns (uint)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function checkIsResourceSeller(address addr, uint saleId) external view returns (bool)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function checkIsItemSeller(address addr, uint saleId) external view returns (bool)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function checkIsUniqueItemSeller(address addr, uint saleId) external view returns (bool)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getResourceSaleIds(address seller) external view returns (uint[] memory)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getItemSaleIds(address seller) external view returns (uint[] memory)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getUniqueItemSaleIds(address seller) external view returns (uint[] memory)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getResourceSaleInfo(uint saleId) external view returns (address seller, address resourceAddress, uint resourceAmount, uint price, string memory description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getItemSaleInfo(uint saleId) external view returns (address seller, address[] memory itemAddresses, uint[] memory itemAmounts, uint price, string memory description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function getUniqueItemSaleInfo(uint saleId) external view returns (address seller, address[] memory itemAddresses, uint[] memory itemIds, uint price, string memory description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function updateResourceSaleDescription(uint saleId, string calldata description) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function updateItemSaleDescription(uint saleId, string calldata description) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function updateUniqueItemSaleDescription(uint saleId, string calldata description) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function cancelResourceSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function cancelItemSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function cancelUniqueItemSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function buyResource(uint saleId, uint amount) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function buyItem(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-no-red.svg) `function buyUniqueItem(uint saleId) external`

## License
[MIT](LICENSE)