// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Flush {
    uint[] public flush;

    function append(bytes calldata arrBytes) public {
        uint[] memory arr = abi.decode(arrBytes, (uint[]));
        for (uint i; i < arr.length; i++) {
            flush.push(arr[i]);
        }
    }
}
