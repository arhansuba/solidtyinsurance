// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataOracleContract {
    address public owner;
    mapping(string => uint256) public data;

    event DataUpdated(string key, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function updateData(string memory _key, uint256 _value) external onlyOwner {
        data[_key] = _value;
        emit DataUpdated(_key, _value);
    }

    function getData(string memory _key) external view returns (uint256) {
        return data[_key];
    }
}
