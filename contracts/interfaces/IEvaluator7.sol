// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface IEvaluator7 {
    function handRank(
        uint,
        uint,
        uint,
        uint,
        uint,
        uint,
        uint
    ) external view returns (uint8);
}
