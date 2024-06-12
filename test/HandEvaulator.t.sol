// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Evaluator7.sol";
import "../src/huff/Evaluator7.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IEvaluator7} from "../src/interfaces/IEvaluator7.sol";

contract HandEvaluatorTest is Test {
    Evaluator7 evaluator;
    HuffEvaluator7 huffEvaluator;

    function setUp() public {
        address[3] memory flushAddrs = initFlush();
        address[17] memory noFlushAddrs = initNoFlush();
        DpTables dpTables = new DpTables();
        evaluator = new Evaluator7(address(dpTables), flushAddrs, noFlushAddrs);

        initHuff();
    }

    function initHuff() private {
        address[5] memory noFlushAddrs;
        noFlushAddrs[0] = HuffDeployer.deploy("huff/NoFlush1");
        noFlushAddrs[1] = HuffDeployer.deploy("huff/NoFlush2");
        noFlushAddrs[2] = HuffDeployer.deploy("huff/NoFlush3");
        noFlushAddrs[3] = HuffDeployer.deploy("huff/NoFlush4");
        noFlushAddrs[4] = HuffDeployer.deploy("huff/NoFlush5");

        address flushAddr = HuffDeployer.deploy("huff/Flush");

        DpTables dpTables = new DpTables();

        huffEvaluator = new HuffEvaluator7(
            address(dpTables),
            flushAddr,
            noFlushAddrs
        );
    }

    function initFlush() private returns (address[3] memory flushAddrs) {
        Flush1 flush1 = new Flush1();
        Flush2 flush2 = new Flush2();
        Flush3 flush3 = new Flush3();
        flushAddrs[0] = address(flush1);
        flushAddrs[1] = address(flush2);
        flushAddrs[2] = address(flush3);
    }

    function initNoFlush() private returns (address[17] memory noFlushAddrs) {
        {
            NoFlush1 noFlush1 = new NoFlush1();
            noFlushAddrs[0] = address(noFlush1);
            NoFlush2 noFlush2 = new NoFlush2();
            noFlushAddrs[1] = address(noFlush2);
            NoFlush3 noFlush3 = new NoFlush3();
            noFlushAddrs[2] = address(noFlush3);
            NoFlush4 noFlush4 = new NoFlush4();
            noFlushAddrs[3] = address(noFlush4);
            NoFlush5 noFlush5 = new NoFlush5();
            noFlushAddrs[4] = address(noFlush5);
            NoFlush6 noFlush6 = new NoFlush6();
            noFlushAddrs[5] = address(noFlush6);
        }
        {
            NoFlush7 noFlush7 = new NoFlush7();
            noFlushAddrs[6] = address(noFlush7);
            NoFlush8 noFlush8 = new NoFlush8();
            noFlushAddrs[7] = address(noFlush8);
            NoFlush9 noFlush9 = new NoFlush9();
            noFlushAddrs[8] = address(noFlush9);
            NoFlush10 noFlush10 = new NoFlush10();
            noFlushAddrs[9] = address(noFlush10);
            NoFlush11 noFlush11 = new NoFlush11();
            noFlushAddrs[10] = address(noFlush11);
        }
        {
            NoFlush12 noFlush12 = new NoFlush12();
            noFlushAddrs[11] = address(noFlush12);
            NoFlush13 noFlush13 = new NoFlush13();
            noFlushAddrs[12] = address(noFlush13);
            NoFlush14 noFlush14 = new NoFlush14();
            noFlushAddrs[13] = address(noFlush14);
            NoFlush15 noFlush15 = new NoFlush15();
            noFlushAddrs[14] = address(noFlush15);
            NoFlush16 noFlush16 = new NoFlush16();
            noFlushAddrs[15] = address(noFlush16);
            NoFlush17 noFlush17 = new NoFlush17();
            noFlushAddrs[16] = address(noFlush17);
        }
    }

    function testHandEval() public {
        uint handRank = IEvaluator7(address(evaluator)).handRank(
            0,
            4,
            8,
            12,
            16,
            20,
            24
        );

        vm.breakpoint('a');

        uint huffHandRank = IEvaluator7(address(huffEvaluator)).handRank(
            0,
            4,
            8,
            12,
            16,
            20,
            24
        );
        assertEq(handRank, huffHandRank);

        // 13, 32, 39, 40, 50, 21, 48,
        // 5h, 8s, Jc, Qs, Ad, 5h, As,
        handRank = IEvaluator7(address(evaluator)).handRank(
            13,
            32,
            39,
            40,
            50,
            21,
            48
        );
        console.log("HandRank: %d", handRank);

        huffHandRank = IEvaluator7(address(huffEvaluator)).handRank(
            13,
            32,
            39,
            40,
            50,
            21,
            48
        );

        assertEq(handRank, huffHandRank);
    }
}
