// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NoFlushDeployer} from "../src/huff/deployers/NoFlushDeployer.sol";

import "../src/Evaluator7.sol";
import "../src/huff/ILookup.sol";

contract HuffDeployTest is Test {
    ILookup huff_nf;
    ILookup huff_nf1;
    ILookup huff_nf2;
    ILookup huff_nf3;
    ILookup huff_nf4;
    ILookup huff_nf5;
    ILookup huff_f;

    uint th = 3000;

    function setUp() public {
        huff_nf = ILookup(HuffDeployer.deploy("huff/NoFlush"));
        huff_nf1 = ILookup(HuffDeployer.deploy("huff/NoFlush1"));
        huff_nf2 = ILookup(HuffDeployer.deploy("huff/NoFlush2"));
        huff_nf3 = ILookup(HuffDeployer.deploy("huff/NoFlush3"));
        huff_nf4 = ILookup(HuffDeployer.deploy("huff/NoFlush4"));
        huff_nf5 = ILookup(HuffDeployer.deploy("huff/NoFlush5"));
        huff_f = ILookup(HuffDeployer.deploy("huff/Flush"));
    }

    function testShortFlush() public {
        NoFlush1 nf1 = new NoFlush1();
        uint start = 0;
        for (uint i; i < th; i++) {
            uint v = huff_nf.lookup(i + start);
            assertEq(nf1.noflush(i), v);
        }
    }

    function testNoFlushLoop1() public {
        NoFlush1 nf1 = new NoFlush1();
        uint start = 0;
        for (uint i; i < th; i++) {
            uint v = huff_nf1.lookup(i + start);
            assertEq(nf1.noflush(i), v);
        }
    }

    function testNoFlushLoop2() public {
        NoFlush2 nf2 = new NoFlush2();
        uint start = 3000;
        for (uint i; i < th; i++) {
            uint v = huff_nf1.lookup(i + start);
            assertEq(nf2.noflush(i), v);
        }
    }

    function testNoFlushLoop3() public {
        NoFlush3 nf3 = new NoFlush3();
        uint start = 6000;
        for (uint i; i < th; i++) {
            uint v = huff_nf1.lookup(i + start);
            assertEq(nf3.noflush(i), v);
        }
    }

    function testNoFlushLoop4() public {
        NoFlush4 nf4 = new NoFlush4();
        uint start = 9000;
        for (uint i; i < th; i++) {
            uint v = huff_nf1.lookup(i + start);
            assertEq(nf4.noflush(i), v);
        }
    }

    function testNoFlushLoop5() public {
        NoFlush5 nf5 = new NoFlush5();
        uint start = 0;
        for (uint i; i < th; i++) {
            uint v = huff_nf2.lookup(i + start);
            assertEq(nf5.noflush(i), v);
        }
    }

    function testNoFlushLoop6() public {
        NoFlush6 nf = new NoFlush6();
        uint start = 3000;
        for (uint i; i < th; i++) {
            uint v = huff_nf2.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop7() public {
        NoFlush7 nf = new NoFlush7();
        uint start = 6000;
        for (uint i; i < th; i++) {
            uint v = huff_nf2.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop8() public {
        NoFlush8 nf = new NoFlush8();
        uint start = 9000;
        for (uint i; i < th; i++) {
            uint v = huff_nf2.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop9() public {
        NoFlush9 nf = new NoFlush9();
        uint start = 0;
        for (uint i; i < th; i++) {
            uint v = huff_nf3.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop10() public {
        NoFlush10 nf = new NoFlush10();
        uint start = 3000;
        for (uint i; i < th; i++) {
            uint v = huff_nf3.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop11() public {
        NoFlush11 nf = new NoFlush11();
        uint start = 6000;
        for (uint i; i < th; i++) {
            uint v = huff_nf3.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop12() public {
        NoFlush12 nf = new NoFlush12();
        uint start = 9000;
        for (uint i; i < th; i++) {
            uint v = huff_nf3.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop13() public {
        NoFlush13 nf = new NoFlush13();
        uint start = 0;
        for (uint i; i < th; i++) {
            uint v = huff_nf4.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop14() public {
        NoFlush14 nf = new NoFlush14();
        uint start = 3000;
        for (uint i; i < th; i++) {
            uint v = huff_nf4.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop15() public {
        NoFlush15 nf = new NoFlush15();
        uint start = 6000;
        for (uint i; i < th; i++) {
            uint v = huff_nf4.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop16() public {
        NoFlush16 nf = new NoFlush16();
        uint start = 9000;
        for (uint i; i < th; i++) {
            uint v = huff_nf4.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testNoFlushLoop17() public {
        NoFlush17 nf = new NoFlush17();
        uint start = 0;
        for (uint i; i < 1205; i++) {
            uint v = huff_nf5.lookup(i + start);
            assertEq(nf.noflush(i), v);
        }
    }

    function testFlush1() public {
        Flush1 f = new Flush1();
        uint start = 0;
        for (uint i; i < th; i++) {
            uint v = huff_f.lookup(i + start);
            assertEq(f.flush(i), v);
        }
    }

    function testFlush2() public {
        Flush2 f = new Flush2();
        uint start = 3000;
        for (uint i; i < th; i++) {
            uint v = huff_f.lookup(i + start);
            assertEq(f.flush(i), v);
        }
    }

    function testFlush3() public {
        Flush3 f = new Flush3();
        uint start = 6000;
        for (uint i; i < 2192; i++) {
            uint v = huff_f.lookup(i + start);
            assertEq(f.flush(i), v);
        }
    }
}
