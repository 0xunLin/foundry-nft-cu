// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {HabitNft} from "../src/HabitNft.sol";

contract HabitNftTest is Test {
    HabitNft habitNft;
    address USER = makeAddr("USER");

    function setUp() public {
        habitNft = new HabitNft(SLEEPEARLY_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        habitNft.mintNft();
        console.log(habitNft.tokenURI(0));
    }
}