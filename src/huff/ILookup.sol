// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface ILookup {
    function lookup(uint256) view external returns (uint256);
}
