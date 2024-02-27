// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;
import "./Authentication.sol";
import "./NFTFactory.sol";

// Import ERC721 interface
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// Social Media Contract
contract SocialMedia {
    address public admin;
    Authentication public authContract;
    NFTFactory public nftFactory;

    struct User {
        string username;
        address userAddress;
        string[] groups;
        bool isAdmin;
    }

    mapping(address => User) public users;
    mapping(address => mapping(uint256 => bool)) public hasInteracted;

    event UserRegistered(address indexed userAddress, string username);
    event NFTShared(address indexed userAddress, uint256 tokenId);
    event GroupCreated(string groupName);
    event GroupJoined(address indexed userAddress, string groupName);
    event ContentDiscovered(uint256[] tokenIds);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyAuthenticated() {
        require(authContract.authenticatedUsers(msg.sender), "User not authenticated");
        _;
    }

    modifier onlyRegisteredUser() {
        require(bytes(users[msg.sender].username).length > 0, "User not registered");
        _;
    }

    modifier onlyAuthorized() {
        require(users[msg.sender].isAdmin || authContract.authenticatedUsers(msg.sender), "Unauthorized user");
        _;
    }

    constructor(address _authContract, address _nftFactory) {
        admin = msg.sender;
        authContract = Authentication(_authContract);
        nftFactory = NFTFactory(_nftFactory);
    }

    function registerUser(string memory _username) external {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(bytes(users[msg.sender].username).length == 0, "User already registered");

        users[msg.sender] = User(_username, msg.sender, new string[](0), false);
        emit UserRegistered(msg.sender, _username);
    }

    function shareNFT(string memory _metadata) external onlyAuthenticated onlyRegisteredUser {
        uint256 tokenId = nftFactory.createNFT(msg.sender, _metadata);
        emit NFTShared(msg.sender, tokenId);
    }

    function createGroup(string memory _groupName) external onlyAuthenticated onlyRegisteredUser {
        // Implement group creation functionality
        emit GroupCreated(_groupName);
    }

    function joinGroup(string memory _groupName) external onlyAuthenticated onlyRegisteredUser {
        // Implement joining a group functionality
        emit GroupJoined(msg.sender, _groupName);
    }

    function discoverContent() external onlyAuthorized view returns (uint256[] memory) {
        // Implement content discovery functionality
        uint256[] memory tokenIds;
        emit ContentDiscovered(tokenIds);
        return tokenIds;
    }

    // Other functionalities like commenting on NFTs, gasless transactions, etc. can be implemented similarly

    // Admin functions
    function setAdmin(address _newAdmin) external onlyAdmin {
        admin = _newAdmin;
    }
}
