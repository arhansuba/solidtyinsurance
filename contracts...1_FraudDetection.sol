// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FraudDetectionContract {
    address public owner;
    mapping(address => bool) public isFraudulent;
    mapping(address => uint256) public fraudScore;

    event FraudulentAddressAdded(address indexed fraudulentAddress);
    event FraudScoreUpdated(address indexed user, uint256 score);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addFraudulentAddress(address _address) external onlyOwner {
        isFraudulent[_address] = true;
        emit FraudulentAddressAdded(_address);
    }

    function updateFraudScore(address _user, uint256 _score) external onlyOwner {
        require(!isFraudulent[_user], "Cannot update score for a fraudulent address");
        fraudScore[_user] = _score;
        emit FraudScoreUpdated(_user, _score);
    }

    function checkFraudulent(address _user) external view returns (bool) {
        return isFraudulent[_user];
    }

    function getFraudScore(address _user) external view returns (uint256) {
        return fraudScore[_user];
    }
}
