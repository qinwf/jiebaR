# 介绍

["结巴"中文分词]的R语言版本，支持最大概率法（Maximum Probability），隐式马尔科夫模型（Hidden Markov Model），索引模型（QuerySegment），混合模型（MixSegment），共四种分词模式，同时有词性标注，关键词提取，文本Simhash相似度比较等功能。项目使用了[Rcpp]和[CppJieba]进行开发。

你还可以试试支持中文编程的 Julia 分词 [Jieba.jl](https://github.com/qinwf/Jieba.jl)。

## 特性

+ 支持 Windows，Linux，Mac 操作系统。
+ 通过 Rcpp 实现同时加载多个分词系统,可以分别使用不同的分词模式和词库。
+ 支持多种分词模式、中文姓名识别、关键词提取、词性标注以及文本Simhash相似度比较等功能。
+ 支持加载自定义用户词库，设置词频、词性。
+ 同时支持简体中文、繁体中文分词。
+ 支持自动判断编码模式。
+ 比原["结巴"中文分词]速度快，是其他R分词包的5-20倍。
+ 安装简单，无需复杂设置。
+ 可以通过[Rpy2]，[jvmr]等被其他语言调用。
+ 基于MIT协议。

["结巴"中文分词]:https://github.com/fxsjy/jieba
[Rcpp]:https://github.com/RcppCore/Rcpp
[Cppjieba]:https://github.com/aszxqw/cppjieba
[Rtools]:http://mirrors.xmu.edu.cn/CRAN/bin/windows/Rtools
[深蓝词库转换]:https://github.com/studyzy/imewlconverter
[开发版]:https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master/artifacts
[Rpy2]:http://rpy.sourceforge.net/
[jvmr]:http://dahl.byu.edu/software/jvmr/
[imewlconverter]:https://github.com/studyzy/imewlconverter