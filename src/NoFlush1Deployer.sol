// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.7.0 <0.9.0;

import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {console} from "forge-std/console.sol";

interface INoFlush {
    // function noFlush(uint256) external;
    function setNumber(uint256) external;

    function getNumber() external returns (uint256);
}

contract HuffDeployerExample {
    function deploy() public {
        address addr = HuffDeployer.deploy("NoFlush");
        INoFlush number = INoFlush(addr);
        number.setNumber(777);
        console.logUint(number.getNumber());
    }
}
