// SPDX-License-Identifier: MIT

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.18;

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    // constructor(string memory name_, string memory symbol_) {
    //     _name = name_;
    //     _symbol = symbol_;
    // }

    constructor() ERC721("Habit", "HAB") { // Call the constructor of the ERC721 contract with the name and symbol of the NFT.
            s_tokenCounter = 0;

    }

    // The OpenZeppelin implementation of ERC721, which we've imported, has it's own virtual tokenURI function which we'll be overriding.
    function mintNft(string memory tokenUri) public returns(uint256) {
        s_tokenIdToUri[s_tokenCounter] = tokenUri; // Store the token URI in the mapping with the current token counter as the key.
        _safeMint(msg.sender, s_tokenCounter); // An inherited function from ERC721 that mints the NFT and assigns it to the caller.
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) { // Override the tokenURI function to return the URI for the given token ID.
        return s_tokenIdToUri[tokenId];
    }
}
