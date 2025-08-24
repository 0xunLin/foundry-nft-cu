// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvg = '<svg xmlns="http://www.w3.org/2000/svg" height="500" width="500"><text x="50%" y="50%" fill="yellow" dominant-baseline="middle" text-anchor="middle">:)</text></svg>';
        string memory sadSvg   = '<svg xmlns="http://www.w3.org/2000/svg" height="500" width="500"><text x="50%" y="50%" fill="blue" dominant-baseline="middle" text-anchor="middle">:(</text></svg>';

        vm.startBroadcast();

        MoodNft moodNft = new MoodNft(happySvg, sadSvg);

        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

}
