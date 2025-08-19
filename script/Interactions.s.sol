// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant TOKENURI =
        "ipfs://QmRfeyGSuKHgyQ2nqGXnn5wBhFJ6KGj5ShtwHo9Vc4k8yv/SleepEarlyNft.jpg=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recently_deployed(
            // Remember, if you don't recall which parameters are required for a function like get_most_recent_deployment 
            // you can ctrl + left-click (cmd + click) to be brought to the function definition.
            "BasicNft",
            block.chainid
        );

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOncOntract(address contractAddress) public {
        vm.startBroadcast();
        // BasicNft basicNft = BasicNft(contractAddress);
        // basicNft.mintNft(TOKENURI);
        BasicNft(contractAddress).mintNft(TOKENURI); // .mintNft is a public function, so we can call it directly on the contract instance.
        vm.stopBroadcast();
    }
}
