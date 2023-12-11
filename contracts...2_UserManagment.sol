// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserManagementContract {
    address public owner;
    mapping(address => bool) public isUserRegistered;
    mapping(address => string) public userRoles;

    event UserRegistered(address indexed user);
    event UserRoleUpdated(address indexed user, string role);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerUser() external {
        require(!isUserRegistered[msg.sender], "User already registered");
        isUserRegistered[msg.sender] = true;
        emit UserRegistered(msg.sender);
    }

    function updateUserRole(address _user, string memory _role) external onlyOwner {
        require(isUserRegistered[_user], "User not registered");
        userRoles[_user] = _role;
        emit UserRoleUpdated(_user, _role);
    }

    function getUserRole(address _user) external view returns (string memory) {
        require(isUserRegistered[_user], "User not registered");
        return userRoles[_user];
    }

    function loginUser() external view returns (string memory) {
        require(isUserRegistered[msg.sender], "User not registered");
        return userRoles[msg.sender];
    }
}
