// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// User authentication contract
contract Authentication {
    mapping(address => bool) public authenticatedUsers;

    event UserAuthenticated(address indexed user);

    modifier onlyAuthenticated() {
        require(authenticatedUsers[msg.sender], "User not authenticated");
        _;
    }

    function authenticateUser() external {
        authenticatedUsers[msg.sender] = true;
        emit UserAuthenticated(msg.sender);
    }
}
