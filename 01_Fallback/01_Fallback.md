这关主要是展示`fallback`函数的特性，
https://ethernaut.openzeppelin.com/level/0x9CB391dbcD447E645D6Cb55dE6ca23164130D008

# Fallback
在solidity中通过`call`调用的时候，如果没有匹配到名称匹配的函数，，就会进入到这个函数中，如果标记了`payenable`就会被接收到以太币

## receive()
一个合约只能有一个receive函数，该函数不能有参数和返回值，需设置为external，payable；

当本合约收到ether但并未被调用任何函数，未接受任何数据，receive函数被触发；

## fallback()
一个合约只能有一个receive函数，该函数不能有参数和返回值，需设置为external；

可设置为payable；

当本合约的其他函数不匹配调用，或调用者未提供任何信息，且没有receive函数，fallback函数被触发；

# 说明
题目的目标是成为这个合约的owner，并且将合约的balance清零。

在源代码中可以看到，成为合约的owner就代表着需要将合约中的owner赋值为我们的address，有三种方式：

1.调用contribute函数

2.调用receive函数

这里需要说明一下，constructor函数是合约的构造函数，是合约在初始化的时候建立的，而sender这个全局变量代表的是当前和合约交互的用户。所以说，contructor函数的sender不可能是除了创建者之外后续用户。

如要调用contribute函数，则需要向合约转账，转入的eth大于1000才可以成为onwer，而且每次只能转小于0.001eth，显然不可行。

那么如果调用receive函数，只需要转账大于0即可成为owner。

也就是说，直接向合约转账，使用`address.send(ether to send)`向某个合约直接转帐时，由于这个行为没有发送任何数据，所以接收合约总是会调用`fallback`函数。或者当调用函数找不到时就会调用fallback函数。

# 解决方案
```
await contract.contribute({value: toWei("0.00001")})
contract.sendTransaction({value: await toWei("0.00001")})
await contract.withdraw()
```