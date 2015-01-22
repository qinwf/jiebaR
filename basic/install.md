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

["结巴"中文分词]:https://github.com/fxsjy/jieba
[Rcpp]:https://github.com/RcppCore/Rcpp
[Cppjieba]:https://github.com/aszxqw/cppjieba
[Rtools]:http://mirrors.xmu.edu.cn/CRAN/bin/windows/Rtools
[深蓝词库转换]:https://github.com/studyzy/imewlconverter
[开发版]:https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master/artifacts
[Rpy2]:http://rpy.sourceforge.net/
[jvmr]:http://dahl.byu.edu/software/jvmr/
[imewlconverter]:https://github.com/studyzy/imewlconverter
