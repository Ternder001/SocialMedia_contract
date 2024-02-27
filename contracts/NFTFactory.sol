// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;


// Import ERC721 interface
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// NFT Factory contract
contract NFTFactory {
    ERC721 public nftContract;

    event NFTCreated(uint256 indexed tokenId);

    constructor(address _nftContract) {
        nftContract = ERC721(_nftContract);
    }

    function createNFT(address _owner, string memory _metadata) external  returns (uint256) {
        uint256 tokenId = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, _metadata)));
        nftContract._safeMint(_owner, tokenId);
        emit NFTCreated(tokenId);
        return tokenId;
    }
}