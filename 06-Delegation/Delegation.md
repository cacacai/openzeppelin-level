# 说明
有两个合约，第一个delegate里面有个pwn函数，可以直接获得owner。第二个合约delegation实例化了delegate，并且定义了fallback函数，里面通过delegeatecall调用delegate合约中的函数。

我们经常会使用call函数与合约进行交互，对合约发送数据，当然，call是一个较底层的接口，我们经常会把它封装在其他函数里使用，不过性质是差不多的，这里用到的delegatecall跟call主要的不同在于通过delegatecall调用的目标地址的代码要在当前合约的环境中执行，也就是说它的函数执行在被调用合约部分其实只用到了它的代码，所以这个函数主要是方便我们使用存在其他地方的函数，也是模块化代码的一种方法，然而这也很容易遭到破坏。用于调用其他合约的call类的函数，其中的区别如下：

1、call 的外部调用上下文是外部合约

2、delegatecall 的外部调用上下是调用合约上下文

也就是说，我们在delegation里通过delegatecall调用delegate中的pwn函数，pwn函数运行的上下文其实是delegation的环境。也就是说，此时执行pwn的话，owner其实是delegation的owner而不是delegate的owner。

抽象点理解，call就是正常的call，而delegatecall可以理解为inline函数调用。

在这里我们要做的就是使用delegatecall调用delegate合约的pwn函数，这里就涉及到使用call指定调用函数的操作，当你给call传入的第一个参数是四个字节时，那么合约就会默认这四个字节就是你要调用的函数，它会把这四个字节当作函数的id来寻找调用函数，而一个函数的id在以太坊的函数选择器的生成规则里就是**其函数签名的sha3的前4个bytes**，函数前面就是带有括号括起来的参数类型列表的函数名称。

# 解决方法
```
contract.sendTransaction({data:web3.sha3("pwn()").slice(0,10)});

```
说明
```
web3.utils.sha3("pwn()") = '0xdd365b8b15d5d78ec041b851b68c8b985bee78bee0b87c4acf261024d8beabab'
web3.utils.sha3("pwn()").slice(0,10) = '0xdd365b8b'
```
使用`.slice(0,10)`获得函数签名的sha3的前4个bytes说明
前两个字符0x只是作为标识符; 16进制中，一个字符比如f(15)，为4位byte(1111)表示，所以占半个字节。所以4个字节需要取8为字符