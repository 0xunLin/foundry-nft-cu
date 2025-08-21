// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";


contract HabitNft is ERC721 {
    string private s_sleepEarlySvgImageUri;
    string private s_dontSmokeSvgImageUri;
    uint256 private s_tokenCounter;
    
    enum Habit {
        SLEEPEARLY,
        DONTSMOKE
    }

    mapping(uint256 => Habit) private s_tokenIdToHabit;

    constructor(string memory sleepEarlySvgImageUri, string memory dontSmokeSvgImageUri) ERC721("Find Her","FH") {
        s_tokenCounter = 0;
        s_sleepEarlySvgImageUri = sleepEarlySvgImageUri;
        s_dontSmokeSvgImageUri= dontSmokeSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToHabit[s_tokenCounter] = Habit.SLEEPEARLY; // Default habit
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory) {
        string memory imageURI;
        if(s_tokenIdToHabit[tokenId] == Habit.SLEEPEARLY) {
            imageURI = s_sleepEarlySvgImageUri;
        } else if (s_tokenIdToHabit[tokenId] == Habit.DONTSMOKE) {
            imageURI = s_dontSmokeSvgImageUri;
        } else {
            revert("Habit not recognized");
        }

        string memory tokenMetaData = string.concat(
            abi.encodePacked(
                _baseURI(), Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name: "',
                            name(),
                            '", description: "An NFT that shows Habits to follow!", "attributes": [{"trait_type": "Habit", "value": 100}], "image": ',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}