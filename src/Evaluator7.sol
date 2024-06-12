// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {DpTables} from "./DpTables.sol";

import {Flush1} from "./flush/Flush1.sol";
import {Flush2} from "./flush/Flush2.sol";
import {Flush3} from "./flush/Flush3.sol";

import {NoFlush1} from "./noFlush/NoFlush1.sol";
import {NoFlush2} from "./noFlush/NoFlush2.sol";
import {NoFlush3} from "./noFlush/NoFlush3.sol";
import {NoFlush4} from "./noFlush/NoFlush4.sol";
import {NoFlush5} from "./noFlush/NoFlush5.sol";
import {NoFlush6} from "./noFlush/NoFlush6.sol";
import {NoFlush7} from "./noFlush/NoFlush7.sol";
import {NoFlush8} from "./noFlush/NoFlush8.sol";
import {NoFlush9} from "./noFlush/NoFlush9.sol";
import {NoFlush10} from "./noFlush/NoFlush10.sol";
import {NoFlush11} from "./noFlush/NoFlush11.sol";
import {NoFlush12} from "./noFlush/NoFlush12.sol";
import {NoFlush13} from "./noFlush/NoFlush13.sol";
import {NoFlush14} from "./noFlush/NoFlush14.sol";
import {NoFlush15} from "./noFlush/NoFlush15.sol";
import {NoFlush16} from "./noFlush/NoFlush16.sol";
import {NoFlush17} from "./noFlush/NoFlush17.sol";

contract Evaluator7 {
    address public immutable DP_TABLES;
    address[3] public FLUSH_ADDRESSES;
    address[17] public NOFLUSH_ADDRESSES;

    uint8 STRAIGHT_FLUSH = 0;
    uint8 FOUR_OF_A_KIND = 1;
    uint8 FULL_HOUSE = 2;
    uint8 FLUSH = 3;
    uint8 STRAIGHT = 4;
    uint8 THREE_OF_A_KIND = 5;
    uint8 TWO_PAIR = 6;
    uint8 ONE_PAIR = 7;
    uint8 HIGH_CARD = 8;

    uint256[52] public binaries_by_id = [
        // 52
        0x1, 0x1, 0x1, 0x1,
        0x2, 0x2, 0x2, 0x2,
        0x4, 0x4, 0x4, 0x4,
        0x8, 0x8, 0x8, 0x8,
        0x10, 0x10, 0x10, 0x10,
        0x20, 0x20, 0x20, 0x20,
        0x40, 0x40, 0x40, 0x40,
        0x80, 0x80, 0x80, 0x80,
        0x100, 0x100, 0x100, 0x100,
        0x200, 0x200, 0x200, 0x200,
        0x400, 0x400, 0x400, 0x400,
        0x800, 0x800, 0x800, 0x800,
        0x1000, 0x1000, 0x1000, 0x1000
    ];

    uint256[52] public suitbit_by_id = [
        // 52
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200,
        0x1, 0x8, 0x40, 0x200
    ];

    constructor(address _dpTables, address[3] memory _flushes, address[17] memory _noflushes) {
        DP_TABLES = _dpTables;

        for (uint256 i = 0; i < _flushes.length; i++) {
            FLUSH_ADDRESSES[i] = _flushes[i];
        }

        for (uint256 j = 0; j < _noflushes.length; j++) {
            NOFLUSH_ADDRESSES[j] = _noflushes[j];
        }
    }

    function handRank(uint256 a, uint256 b, uint256 c, uint256 d, uint256 e, uint256 f, uint256 g)
        public
        view
        returns (uint, uint)
    {
        uint256 val = evaluate(a, b, c, d, e, f, g);

        uint256 rank;
        if (val > 6185) rank = HIGH_CARD; // 1277 high card
        else if (val > 3325) rank = ONE_PAIR; // 2860 one pair
        else if (val > 2467) rank = TWO_PAIR; //  858 two pair
        else if (val > 1609) rank = THREE_OF_A_KIND; //  858 three-kind
        else if (val > 1599) rank = STRAIGHT; //   10 straights
        else if (val > 322) rank = FLUSH; // 1277 flushes
        else if (val > 166) rank = FULL_HOUSE; //  156 full house
        else if (val > 10) rank = FOUR_OF_A_KIND; //  156 four-kind
        else rank = STRAIGHT_FLUSH; //   10 straight-flushes
        return (rank, val);
    }

    function evaluate(uint256 a, uint256 b, uint256 c, uint256 d, uint256 e, uint256 f, uint256 g)
        public
        view
        returns (uint256)
    {
        uint256 suit_hash = 0;
        uint256[4] memory suit_binary = [uint256(0), uint256(0), uint256(0), uint256(0)]; // 4
        uint8[13] memory quinary = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 13
        uint256 hsh;

        suit_hash += suitbit_by_id[a];
        quinary[(a >> 2)]++;
        suit_hash += suitbit_by_id[b];
        quinary[(b >> 2)]++;
        suit_hash += suitbit_by_id[c];
        quinary[(c >> 2)]++;
        suit_hash += suitbit_by_id[d];
        quinary[(d >> 2)]++;
        suit_hash += suitbit_by_id[e];
        quinary[(e >> 2)]++;
        suit_hash += suitbit_by_id[f];
        quinary[(f >> 2)]++;
        suit_hash += suitbit_by_id[g];
        quinary[(g >> 2)]++;

        uint256 suits = DpTables(DP_TABLES).suits(suit_hash);

        if (suits > 0) {
            suit_binary[a & 0x3] |= binaries_by_id[a];
            suit_binary[b & 0x3] |= binaries_by_id[b];
            suit_binary[c & 0x3] |= binaries_by_id[c];
            suit_binary[d & 0x3] |= binaries_by_id[d];
            suit_binary[e & 0x3] |= binaries_by_id[e];
            suit_binary[f & 0x3] |= binaries_by_id[f];
            suit_binary[g & 0x3] |= binaries_by_id[g];

            uint256 sb = suit_binary[suits - 1];

            if (sb < 3000) {
                return Flush1(FLUSH_ADDRESSES[0]).flush(sb);
            } else if (sb < 6000) {
                return Flush2(FLUSH_ADDRESSES[1]).flush(sb);
            } else {
                return Flush3(FLUSH_ADDRESSES[2]).flush(sb);
            }
        }

        hsh = hash_quinary(quinary, 13, 7);

        if (hsh < 3000) {
            return NoFlush1(NOFLUSH_ADDRESSES[0]).noflush(hsh);
        } else if (hsh < 6000) {
            return NoFlush2(NOFLUSH_ADDRESSES[1]).noflush(hsh - 3000);
        } else if (hsh < 9000) {
            return NoFlush3(NOFLUSH_ADDRESSES[2]).noflush(hsh - 6000);
        } else if (hsh < 12000) {
            return NoFlush4(NOFLUSH_ADDRESSES[3]).noflush(hsh - 9000);
        } else if (hsh < 15000) {
            return NoFlush5(NOFLUSH_ADDRESSES[4]).noflush(hsh - 12000);
        } else if (hsh < 18000) {
            return NoFlush6(NOFLUSH_ADDRESSES[5]).noflush(hsh - 15000);
        } else if (hsh < 21000) {
            return NoFlush7(NOFLUSH_ADDRESSES[6]).noflush(hsh - 18000);
        } else if (hsh < 24000) {
            return NoFlush8(NOFLUSH_ADDRESSES[7]).noflush(hsh - 21000);
        } else if (hsh < 27000) {
            return NoFlush9(NOFLUSH_ADDRESSES[8]).noflush(hsh - 24000);
        } else if (hsh < 30000) {
            return NoFlush10(NOFLUSH_ADDRESSES[9]).noflush(hsh - 27000);
        } else if (hsh < 33000) {
            return NoFlush11(NOFLUSH_ADDRESSES[10]).noflush(hsh - 30000);
        } else if (hsh < 36000) {
            return NoFlush12(NOFLUSH_ADDRESSES[11]).noflush(hsh - 33000);
        } else if (hsh < 39000) {
            return NoFlush13(NOFLUSH_ADDRESSES[12]).noflush(hsh - 36000);
        } else if (hsh < 42000) {
            return NoFlush14(NOFLUSH_ADDRESSES[13]).noflush(hsh - 39000);
        } else if (hsh < 45000) {
            return NoFlush15(NOFLUSH_ADDRESSES[14]).noflush(hsh - 42000);
        } else if (hsh < 48000) {
            return NoFlush16(NOFLUSH_ADDRESSES[15]).noflush(hsh - 45000);
        } else {
            return NoFlush17(NOFLUSH_ADDRESSES[16]).noflush(hsh - 48000);
        }
    }

    function hash_quinary(uint8[13] memory q, uint256 len, uint256 k) public view returns (uint256 sum) {
        for (uint256 i = 0; i < len; i++) {
            sum += DpTables(DP_TABLES).dp(q[i], (len - i - 1), k);

            k -= q[i];

            if (k <= 0) break;
        }
    }
}
