## 快速模式

无需使用`worker()`，使用默认参数启动引擎，并立即进行分词：

```r
library(jiebaR)

qseg <= "江州市长江大桥参加了长江大桥的通车仪式" 
```

```r
[1] "江州"     "市长"     "江大桥"   "参加"     "了"       "长江大桥" "的"      
[8] "通车"     "仪式"   
```
`qseg` ~ quick segmentation，使用默认分词模式，自动建立分词引擎，类似于`ggplot2`包里面的`qplot`函数。

```r
### 第一次运行时，启动默认引擎 quick_worker，第二次运行，不再启动引擎。
qseg <= "这是测试文本。" 

```

```r
[1] "这是" "测试" "文本"
```

```r
### 效果相同
quick_worker <=  "这是测试文本。" 

qseg
```

```r
Worker Type:  Mix Segment

Detect Encoding :  TRUE
Default Encoding:  UTF-8
Keep Symbols    :  FALSE
Output Path     :  NULL
.......
```

可以通过`qseg$`重设模型参数，重设模型参数将会修改以后每次默认启动的默认参数，如果只是希望单次修改模型参数，可以使用非快速模式的修改方式`quick_worker$`。

```r
qseg$type = "mp" ### 重设模型参数的同时，重新启动引擎。

qseg$type        ### 下次重新启动包是将使用现在的参数，构建模型。

quick_worker$detect = T ### 临时修改，对下次重新启动包时，没有影响。

get_qsegmodel()         ### 获得当前快速模式的默认参数

```
