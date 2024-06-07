# 介绍
`MeowTool.ahk`是一个简洁小巧的、用于快速执行一系列命令的工具。
通过输入自定义命令，传递给自定义处理器来执行一些繁琐的事情。

---
包结构：
```text
│  .gitignore
│  MeowTool.ahk        启动脚本
│  README.md
│
├─cfg                  配置文件
├─core 
│      handleMgr.ahk   处理器管理
│      historyMgr.ahk  历史记录管理
│      keywords.ahk    关键字替换
│      parse.ahk       解析命令
│
├─handle               处理器
│  │  baseHandle.ahk
│  └─buildIn           内置处理器
└─ui                   图形界面
      main.ahk
```
---

它的工作流程如下：
- 接收输入
- 替换关键字
- 检查输入是否合法
- 调用处理器
- 回显结果

# 接受输入
`ui/main.ahk`显示一个输入框，用于接受输入。

它是唯一的ui界面。

# 关键字替换 
`core/keywords.ahk`用于替换关键字。 

对于`$$`内的字符串会被当作别名（用于缩短命令长度），可以使用转义符转移`$`，可以添加自定义别名。  
一个示例如：```code $desktop$/a`$.ahk```，它将`desktop`替换为桌面路径，并将`$`符转义。

# 命令规范
`core/parse.ahk`用于解析输入的命令。

它接受以下形式的命令：
```
命令 -参数 -键=值 目标 额外信息
```

> 注意：脚本只负责解析，将解析结果传给处理器，具体命令如何处理由处理器决定。

# 处理器
`handle`目录下包含所有处理器。

## baseHandle.ahk
它是所有处理器的父类，包含`Handle`和两个返回值方法`Fail,Succ`，以及`Echo`用于提供帮助文档，静态变量`nullable`指定是否
接受空执行目标（默认为`false`）。

## 自定义处理器  
所有的处理器都需要继承自baseHandle，它帮助在注册时检查是否为合法的处理器；  
在处理命令时，会自动调用对应处理器的handle方法（这使得不用再关心应该如何调用处理器）。

> 在处理器中，大量使用了配置文件的形式，由CustomFs.ahk提供读取功能。

因为所有的配置文件都是git忽略的，一个示例配置文件如下：
```text
# for [code] command

remote : g:\AHK\

this : $remote$MeowTool
main : $remote$scripts\main.ahk
test : $remote$_DEV\Test\_.ahk
```

调用命令：`code this`，使用vscode打开此工具目录。

具体的使用规则，看CustomFs.ahk的描述（另一个仓库）。

## 创建自定义处理器的流程
创建并使用一个自定义处理器只需要两步：
- 创建
- 注册

以code.ahk为例子：
- 创建脚本
  + 在handle下创建code.ahk
  + 继承于baseHandle
  + 实现Handle方法，它接受一个parsed命令解析对象
  + 根据自己定义的规则返回`this.Succ()`或`this.Fail()`

- 注册命令
  + 在`handle\index.ahk`中导入脚本，并写入：`Mgr.register('code', Code)`

# 结语
现在，启动`MeowTool.ahk`，键入`echo hello $_$!`吧~