// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Test } from "forge-std/Test.sol";
import { BasicNft } from "../src/BasicNft.sol";
import { DeployBasicNft } from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    string public constant PUG = "ipfs.//QmRfeyGSuKHgyQ2nqGXnn5wBhFJ6KGj5ShtwHo9Vc4k8yv/SleepEarlyNft.jpg=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Habit";
        string memory actualName = basicNft.name();
        // This assert does not happen beacause Under the hood, strings exist as an array of bytes, 
        // arrays can't be compared to arrays in this way, this is limited to primitive data types like int, bool, bytes32, address etc.
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCaqnMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}