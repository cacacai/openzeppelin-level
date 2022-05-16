```
contract Fallout {
  


  /* constructor */
  function Fal1out() public payable {
    owner = msg.sender;
    allocations[owner] = msg.value;
  }

}

```
这个主要是考察识别出构造函和合约名称分不清的情况，或者说该了合约名称没有修改构造函数，导致部署之后直接调用产生的风险。
但是现在的版本构造函数都是使用`constructor`，命名，理论上不会出现这种情况。

# 解决办法
直接调用即可
```
    contract.Fal1out({ from: player, value: toWei(".01", "ether") })
```