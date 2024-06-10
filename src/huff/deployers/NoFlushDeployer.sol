// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.7.0 <0.9.0;

import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {console} from "forge-std/console.sol";

contract NoFlushDeployer {
    function deploy() public returns (address) {
        return HuffDeployer.deploy("huff/noFlush/NoFlush");
    }
}
