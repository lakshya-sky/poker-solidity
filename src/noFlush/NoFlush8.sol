// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract NoFlush8 {
    uint[] public noflush;

    function append(bytes calldata arrBytes) public {
        uint[1000] memory arr = abi.decode(arrBytes, (uint[1000]));
        for (uint i; i < 1000; i++) {
            noflush.push(arr[i]);
        }
    }
}

