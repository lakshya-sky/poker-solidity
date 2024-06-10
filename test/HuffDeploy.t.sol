// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {NoFlush1Deployer} from "../src/huff/deployers/NoFlush1Deployer.sol";
import {NoFlushDeployer} from "../src/huff/deployers/NoFlushDeployer.sol";

import {NoFlush1} from "../src/noFlush/NoFlush1.sol";

interface INoFlush {
    function lookup_single(uint256) external returns (uint256);

    function lookup_double(uint256) external returns (uint256, uint256);
}

contract HuffDeployTest is Test {
    INoFlush huff_no_flush_1;
    NoFlush1 nf1;
    INoFlush huff_nf;

    function setUp() public {
        NoFlush1Deployer deployer = new NoFlush1Deployer();
        address noflush_1_addr = deployer.deploy();
        huff_no_flush_1 = INoFlush(noflush_1_addr);
        nf1 = new NoFlush1();

        NoFlushDeployer noFlushdeployer = new NoFlushDeployer();
        huff_nf = INoFlush(noFlushdeployer.deploy());
    }

    // function testHuffDeploy() public {
    //     for (uint i; i < 3000; i++) {
    //         assertEq(nf1.noflush(i), huff_no_flush_1.lookup_single(i));
    //     }
    // }

    // function testNoFlushLoop() public {
    //     for (uint i; i < 3000; i++) {
    //         (uint v, uint d) = huff_nf.lookup_double(i);
    //         assertEq(nf1.noflush(i), v);
    //     }
    // }

    function testNoFlushLoop() public {
        for (uint i; i < 3; i++) {
            uint v = huff_nf.lookup_single(i);
            assertEq(nf1.noflush(i), v);
        }
    }
}
