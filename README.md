# 中文分词 

[![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=master)](https://travis-ci.org/qinwf/jiebaR) [![Build status](https://ci.appveyor.com/api/projects/status/k8swxpkue1caiiwi/branch/master?svg=true)](https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master) [![codecov](https://codecov.io/gh/qinwf/jiebaR/branch/master/graph/badge.svg)](https://codecov.io/gh/qinwf/jiebaR) [![DOI](https://zenodo.org/badge/8525/qinwf/jiebaR.svg)](http://dx.doi.org/10.5281/zenodo.13729)

细胞词库转换可以使用 [cidian](https://github.com/qinwf/cidian) 包 ：https://github.com/qinwf/cidian/


## 安装

通过CRAN安装:

```r
install.packages("jiebaR")
```

同时还可以通过Github安装[开发版]，建议使用 gcc >= 4.9 编译，Windows需要安装 [Rtools](https://cran.r-project.org/bin/windows/Rtools/) ：

```r
library(devtools)
install_github("qinwf/jiebaRD")
install_github("qinwf/jiebaR")
```

## 使用指南 与 演示

[使用指南](http://qinwenfeng.com/jiebaR/) ：http://qinwenfeng.com/jiebaR/

[v2 文档](https://jiebaR.qinwf.com/) : https://jiebaR.qinwf.com/

[Shiny 演示](https://qinwf.shinyapps.io/jiebaR-shiny/) ：https://qinwf.shinyapps.io/jiebaR-shiny/

[细胞词库转换](https://github.com/qinwf/cidian) ：https://github.com/qinwf/cidian/

## 问题

使用中遇到问题，可以：

+ 发送邮件至用户邮件列表  [jiebaR@googlegroups.com](mailto:jiebaR@googlegroups.com)
+ 访问 https://groups.google.com/d/forum/jiebaR
+ 在 [GitHub](https://github.com/qinwf/jiebaR) 提交 issues。

# jiebaR

This is a package for Chinese text segmentation, keyword extraction
and speech tagging. 

## Installation

Install the latest development version from GitHub:

```r
devtools::install_github("qinwf/jiebaR")
```

Install from [CRAN](https://cran.r-project.org/package=jiebaR):

```r
install.packages("jiebaR")
```
