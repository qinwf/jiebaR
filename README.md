# jiebaR 中文分词 [![DOI](https://zenodo.org/badge/8525/qinwf/jiebaR.svg)](http://dx.doi.org/10.5281/zenodo.13729)

Linux : [![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=master)](https://travis-ci.org/qinwf/jiebaR)　Mac : [![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=osx)](https://travis-ci.org/qinwf/jiebaR)　Win : [![Build status](https://ci.appveyor.com/api/projects/status/k8swxpkue1caiiwi/branch/master?svg=true)](https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master)

["结巴"中文分词]的R语言版本，支持最大概率法（Maximum Probability），隐式马尔科夫模型（Hidden Markov Model），索引模型（QuerySegment），混合模型（MixSegment），共四种分词模式，同时有词性标注，关键词提取，文本Simhash相似度比较等功能。项目使用了[Rcpp]和[CppJieba]进行开发。

细胞词库转换可以使用 [cidian](https://github.com/qinwf/cidian) 包 ：https://github.com/qinwf/cidian/

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


## 安装

通过CRAN安装:

```r
install.packages("jiebaR")
library("jiebaR")
```

同时还可以通过Github安装[开发版]，建议使用 gcc >= 4.6 编译，Windows需要安装 [Rtools](http://cran.r-project.org/bin/windows/Rtools/) ：

```r
library(devtools)
install_github("qinwf/jiebaRD")
install_github("qinwf/jiebaR")
library("jiebaR")
```

## 使用指南 与 演示

[使用指南](http://qinwenfeng.com/jiebaR/) ：http://qinwenfeng.com/jiebaR/

[Shiny 演示](https://qinwf.shinyapps.io/jiebaR-shiny/) ：https://qinwf.shinyapps.io/jiebaR-shiny/

[细胞词库转换](https://github.com/qinwf/cidian) ：https://github.com/qinwf/cidian/

## 问题

使用中遇到的任何问题，都可以：

+ 访问 [使用指南](http://qinwenfeng.com/jiebaR/) ：http://qinwenfeng.com/jiebaR/ ，并可在文档内评论
+ 发送邮件至用户邮件列表　[jiebaR@googlegroups.com](mailto:jiebaR@googlegroups.com)
+ 访问　https://groups.google.com/d/forum/jiebaR
+ 在 [GitHub](https://github.com/qinwf/jiebaR) 提交 issues。　

# jiebaR

This is a package for Chinese text segmentation, keyword extraction
and speech tagging. `jiebaR` supports four
types of segmentation modes: Maximum Probability, Hidden Markov Model, Query Segment and Mix Segment.

## Features

+ Support Windows, Linux,and Mac.
+ Using Rcpp to load different segmentation worker at the same time.
+ Support Chinese text segmentation, keyword extraction, speech tagging and simhash computation.
+ Custom dictionary path.
+ Support simplified Chinese and traditional Chinese.
+ New words identification.
+ Auto encoding detection.
+ Fast text segmentation.
+ Easy installation.
+ MIT license.

## Installation

Install the latest development version from GitHub:

```r
devtools::install_github("qinwf/jiebaR")
```

Install from [CRAN](http://cran.r-project.org/web/packages/jiebaR/index.html):

```r
install.packages("jiebaR")
```

["结巴"中文分词]:https://github.com/fxsjy/jieba
[Rcpp]:https://github.com/RcppCore/Rcpp
[Cppjieba]:https://github.com/yanyiwu/cppjieba
[Rtools]:http://mirrors.xmu.edu.cn/CRAN/bin/windows/Rtools
[深蓝词库转换]:https://github.com/studyzy/imewlconverter
[开发版]:https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master/artifacts
[Rpy2]:http://rpy.sourceforge.net/
[jvmr]:http://dahl.byu.edu/software/jvmr/
[imewlconverter]:https://github.com/studyzy/imewlconverter
