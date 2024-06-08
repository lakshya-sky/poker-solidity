// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {HuffDeployerExample} from "../src/NoFlush1Deployer.sol";

contract HuffDeployTest is Test {
    function setUp() public {}

    function testHuffDeploy() public {
        HuffDeployerExample deployer = new HuffDeployerExample();
        deployer.deploy();
    }
}
