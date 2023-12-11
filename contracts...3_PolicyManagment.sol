// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PolicyManagementContract {
    address public owner;
    mapping(address => Policy) public policies;

    struct Policy {
        string policyType;
        uint256 coverageAmount;
        uint256 premium;
        uint256 startDate;
        uint256 endDate;
        bool isFraudulent;
    }

    event PolicyRegistered(address indexed user, string policyType);
    event PolicyUpdated(address indexed user, string policyType, bool isFraudulent);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerPolicy(
        address _user,
        string memory _policyType,
        uint256 _coverageAmount,
        uint256 _premium,
        uint256 _startDate,
        uint256 _endDate
    ) external onlyOwner {
        policies[_user] = Policy({
            policyType: _policyType,
            coverageAmount: _coverageAmount,
            premium: _premium,
            startDate: _startDate,
            endDate: _endDate,
            isFraudulent: false
        });

        emit PolicyRegistered(_user, _policyType);
    }

    function updatePolicyFraudStatus(address _user, bool _isFraudulent) external onlyOwner {
        require(policies[_user].startDate != 0, "Policy not registered for the user");
        policies[_user].isFraudulent = _isFraudulent;

        emit PolicyUpdated(_user, policies[_user].policyType, _isFraudulent);
    }

    function getPolicy(address _user) external view returns (Policy memory) {
        require(policies[_user].startDate != 0, "Policy not registered for the user");
        return policies[_user];
    }
}
