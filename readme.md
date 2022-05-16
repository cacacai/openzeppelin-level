# 项目说明
这是个人在学习 智能合约，理解相关交易操作以及智能合约安全问题过程中的记录
https://ethernaut.openzeppelin.com/level/0x4E73b858fD5D7A5fc1c3455061dE52a53F35d966

基本内容来源于这两个教程
https://www.yijinglab.com/specialized/20211104154206
https://github.com/dmidye/EthernautChallengeSolutions


# 项目部署方式
因为这个练习过程中需要经常使用到自己写合约然后进行合约交互处理，所以最优的方式是通过remix来进行部署开发。
但是在我刚接触remix过程中，直接在网页在开发会比较麻烦，比如合约管理，编写，git代码管理，在线版本的remix只能使用gist，不是完整的git工程项目。

后来发现了可以通过本地使用vscode进行合约开发，结合remix插件，连接到在线的remix环境，就可以直接编辑访问本地的solidity代码
对于在线的remix和本地vscode写的代码都可以无缝衔接，对于一些第三方的文件也不会在编译时候提示报错。

需要在vscode中安装Ethereum Remix 插件，然后在侧边栏中找到remxi下的 `start remixd client`工具，点击start，就可以通过在线的remix https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.6.0+commit.26b70077.js&language=Solidity ，在workspace中切换localhost文件夹，访问本地vscode中的代码，进行直接测试和开发。

主要是为了可以通过git管理代码工程，同时在项目中可以编写不同类型的文件，除了solidity还有md类型，同时也利用remix可以快速切换不同的版本编译器和测试网络。