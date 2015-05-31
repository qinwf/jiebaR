# 分词词典工具 [cidian](https://github.com/qinwf/cidian) 包

## 安装

```r
install.packages("devtools")
install.packages("stringi")
install.packages("pbapply")
install.packages("Rcpp")
install.packages("RcppProgress")
library(devtools)
install_github("qinwf/cidian")
```

## 使用

```r
decode_scel(scel = "细胞词库路径",output = "输出文件路径",cpp = TRUE)

decode_scel(scel = "细胞词库路径",output = "输出文件路径",cpp = FALSE,progress =TRUE)
```
