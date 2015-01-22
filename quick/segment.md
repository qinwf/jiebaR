## 分词

jiebaR提供了四种分词模式，可以通过`worker()`来初始化分词引擎，使用`segment()`进行分词。

```r
##  接受默认参数，建立分词引擎 
mixseg = worker()

##  相当于：
##       worker( type = "mix", dict = "inst/dict/jieba.dict.utf8",
##               hmm  = "inst/dict/hmm_model.utf8",  ### HMM模型数据
##               user = "inst/dict/user.dict.utf8") ### 用户自定义词库

mixseg <= "江州市长江大桥参加了长江大桥的通车仪式"  ### <= 分词运算符

## 相当于 segment( "江州市长江大桥参加了长江大桥的通车仪式" , mixseg ) 
## 或者 mixseg["江州市长江大桥参加了长江大桥的通车仪式"]
```

```r
[1] "江州"     "市长"     "江大桥"   "参加"     "了"       "长江大桥"
[7] "的"       "通车"     "仪式" 
```

支持对文件进行分词：

```r
mixseg <= "./temp.dat"  ### 自动判断输入文件编码模式，默认文件输出在同目录下。

## segment( "./temp.dat" , mixseg )   
```

## 分词引擎介绍

在加载分词引擎时，可以自定义词库路径，同时可以启动不同的引擎：

最大概率法（MPSegment），负责根据Trie树构建有向无环图和进行动态规划算法，是分词算法的核心。

隐式马尔科夫模型（HMMSegment）是根据基于人民日报等语料库构建的HMM模型来进行分词，主要算法思路是根据(B,E,M,S)四个状态来代表每个字的隐藏状态。 HMM模型由dict/hmm_model.utf8提供。分词算法即viterbi算法。

混合模型（MixSegment）是四个分词引擎里面分词效果较好的类，结它合使用最大概率法和隐式马尔科夫模型。

索引模型（QuerySegment）先使用混合模型进行切词，再对于切出来的较长的词，枚举句子中所有可能成词的情况，找出词库里存在。


```r
mixseg2 = worker(type  = "mix", dict = "dict/jieba.dict.utf8",
                 hmm   = "dict/hmm_model.utf8",  
                 user  = "dict/test.dict.utf8",
                 detect=T,      symbol = F,
                 lines = 1e+05, output = NULL
                 ) 
mixseg2   ### 输出worker的设置
```

```r
Worker Type:  Mix Segment

Detect Encoding :  TRUE
Default Encoding:  UTF-8
Keep Symbols    :  FALSE
Output Path     :  
Write File      :  TRUE
Max Read Lines  :  1e+05

Fixed Model Components:  

$dict
[1] "dict/jieba.dict.utf8"

$hmm
[1] "dict/hmm_model.utf8"

$user
[1] "dict/test.dict.utf8"

$detect $encoding $symbol $output $write $lines can be reset.
```

可以通过R语言常用的 `$`符号重设一些`worker`的参数设置，如 ` WorkerName$symbol = T `，在输出中保留标点符号。一些参数在初始化的时候已经确定，无法修改， 可以通过`WorkerName$PrivateVarible`来获得这些信息。

```r
mixseg$encoding

mixseg$detect = F
```

## 词典介绍

可以自定义用户词库，推荐使用[深蓝词库转换]构建分词词库，它可以快速地将搜狗细胞词库等输入法词库转换为jiebaR的词库格式。

```r
show_dictpath()     ### 显示词典路径
edit_dict("user")   ### 编辑用户词典
?edit_dict()        ### 打开帮助系统
```

系统词典共有三列，第一列为词项，第二列为词频，第三列为词性标记。

用户词典有两列，第一列为词项，第二列为词性标记。用户词库默认词频为系统词库中的最大词频，如需自定义词频率，可将新词添加入系统词库中。

词典中的词性标记采用ictclas的标记方法。
