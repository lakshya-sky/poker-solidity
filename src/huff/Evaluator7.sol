// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import {DpTables} from "../DpTables.sol";
import "./ILookup.sol";

contract HuffEvaluator7 {
    address public immutable DP_TABLES;
    address public FLUSH_ADDRESS;
    address[5] public NOFLUSH_ADDRESSES;

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

    constructor(address _dpTables, address _flush, address[5] memory _noflushes) {
        DP_TABLES = _dpTables;
        FLUSH_ADDRESS = _flush;
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
            return ILookup(FLUSH_ADDRESS).lookup(sb);
        }

        hsh = hash_quinary(quinary, 13, 7);

        if (hsh < 12000) {
            return ILookup(NOFLUSH_ADDRESSES[0]).lookup(hsh);
        } else if (hsh < 24000) {
            return ILookup(NOFLUSH_ADDRESSES[1]).lookup(hsh - 12000);
        } else if (hsh < 36000) {
            return ILookup(NOFLUSH_ADDRESSES[2]).lookup(hsh - 24000);
        } else if (hsh < 48000) {
            return ILookup(NOFLUSH_ADDRESSES[3]).lookup(hsh - 36000);
        } else {
            return ILookup(NOFLUSH_ADDRESSES[4]).lookup(hsh - 48000);
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
