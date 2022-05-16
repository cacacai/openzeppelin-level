# 说明
主要是为了考察`tx.origin` 的区别  `msg.sender`

# 解决方案
这里肯定是调用changeOwner，知识点就在于tx.origin和msg.sender之间的区别。

- tx.origin (address):交易发送方(完整的调用链)；指调用智能合约功能的账户地址，**只有账户地址可以是tx.origin**
- msg.sender (address):消息的发送方(当前调用)  指直接调用**智能合约功能的帐户或智能合约的地址**

可以认为，origin为源ip地址，sender为上一跳地址。

所以思路就是部署一个合约A，我们调用这个合约A，而这个合约A调用题目合约，即可完成利用。