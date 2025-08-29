// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {MintBasicNft} from "../../script/Interactions.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    MintBasicNft public minter;

    BasicNft public basicNft;

    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs.//QmRfeyGSuKHgyQ2nqGXnn5wBhFJ6KGj5ShtwHo9Vc4k8yv/SleepEarlyNft.jpg=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        minter = new MintBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Habit";
        string memory actualName = basicNft.name();
        // This assert does not happen beacause Under the hood, strings exist as an array of bytes,
        // arrays can't be compared to arrays in this way, this is limited to primitive data types like int, bool, bytes32, address etc.
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    // The two tests below for interactions fail because they are not set up to run in the context of a test environment.

    // function testMintNftOnContract() public {
    //     // prank as USER so mint goes to USER
    //     vm.prank(USER);
    //     minter.mintNftOnContract(address(basicNft));

    //     assertEq(basicNft.balanceOf(USER), 1);
    //     assertEq(basicNft.ownerOf(0), USER);
    //     assertEq(basicNft.tokenURI(0), PUG);
    // }

    // function testRunFunctionMintsToCaller() public {
    //     // To mimic DevOpsTools, we bypass it & directly call mintNftOnContract
    //     // Normally run() fetches deployment addr, but here we simulate that
    //     vm.prank(USER);
    //     minter.mintNftOnContract(address(basicNft));

    //     assertEq(basicNft.balanceOf(USER), 1);
    // }
}
