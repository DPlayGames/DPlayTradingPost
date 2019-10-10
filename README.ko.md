# DPlay 교역소

## 계약 주소
- Mainnet: 0x6242C1f2a80420576e14F239C9500Fc39438E880
- Kovan: 0x80BB9F94cC7d437F322Ebb76BA694F74F0F2A8AC
- Ropsten: 0x04db52D39f971074af8a6c248b909a36f133e862
- Rinkeby: 0xff0ba06ec3b482dEdD8B4C3c1C348615b81EDBa8

## 테스트 여부
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event SellResource(uint saleId, uint price, address resourceAddresses, uint resourceAmount, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event SellItem(uint saleId, uint price, address[] itemAddresses, uint[] itemAmounts, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event SellUniqueItem(uint saleId, uint price, address[] uniqueItemAddresses, uint[] uniqueItemIds, string description, uint createTime)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event UpdateResourceSaleDescription(uint indexed saleId, string description)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event UpdateItemSaleDescription(uint indexed saleId, string description)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event UpdateUniqueItemSaleDescription(uint indexed saleId, string description)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event RemoveResourceSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event RemoveItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event RemoveUniqueItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event CancelResourceSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event CancelItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event CancelUniqueItemSale(uint indexed saleId)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event ChangeResourceSaleAmount(uint indexed saleId, uint amount)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event BuyResource(uint indexed saleId, uint amount, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event BuyItem(uint indexed saleId, address indexed buyer)`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `event BuyUniqueItem(uint indexed saleId, address indexed buyer)`
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
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function updateResourceSaleDescription(uint saleId, string calldata description) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function updateItemSaleDescription(uint saleId, string calldata description) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function updateUniqueItemSaleDescription(uint saleId, string calldata description) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function cancelResourceSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function cancelItemSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function cancelUniqueItemSale(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function buyResource(uint saleId, uint amount) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function buyItem(uint saleId) external`
- ![테스트 여부](https://img.shields.io/badge/테스트%20여부-yes-brightgreen.svg) `function buyUniqueItem(uint saleId) external`

## License
[MIT](LICENSE)