[![Build Status](https://travis-ci.org/aszxqw/libcppjieba.png?branch=master)](https://travis-ci.org/aszxqw/libcppjieba)
- - -

# libcppjieba

## 简介

从 [CppJieba] 项目里面抽取出来的源代码，单独抽出来成立项目，使得它更容易去理解和使用。  
如果你喜欢该项目，请 `star` [CppJieba] 而不是该项目，以助于 [CppJieba] 的传播和更好的后续改进。多谢。  

## 特性

+ 源代码全是头文件(hpp)，全在 `include/` 目录里。只需要 `#include` 即可使用。 **没有链接，就没有伤害。**
+ 无需安装其他任何依赖库，没错，连 `boost` 也不需要，是不是很酷。
+ 支持 `utf-8` 编码。

## 用法

```
make 
./demo
```

详细示例代码请看 `demo.cpp`

## 常见问题

问题1：   
编译器报错 `can not find tr1/unordered_map` 或者其他关于 tr1 的错误。
解决：    
添加编译选项 `-std=c++0x` （或者 `-std=c++11`），比如 `g++ -o demo -std=c++0x demo.cpp`  

问题2：   
如何设置 logger 级别？  
解决：    
添加编译选项 `-DLOGGER_LEVEL=LL_WARN`  就是设置日志级别为 WARN 及 WARN 以上。
同理可得 `LL_DEBUG`, `LL_INFO`, `LL_ERROR`, `LL_FATAL` 。

## 鸣谢

+ [Jieba]
+ [CppJieba]

## 客服

wuyanyi09@foxmail.com

[CppJieba]:https://github.com/aszxqw/cppjieba
[Jieba]:https://github.com/fxsjy/jieba
