// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract NoFlush17 {
    uint[] public noflush;

    function append(bytes calldata arrBytes) public {
        uint[1205] memory arr = abi.decode(arrBytes, (uint[1205]));
        for (uint i; i < arr.length; i++) {
            noflush.push(arr[i]);
        }
    }
}
