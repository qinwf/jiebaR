# jiebaR

Linux : [![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=master)](https://travis-ci.org/qinwf/jiebaR)　Mac : [![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=osx)](https://travis-ci.org/qinwf/jiebaR)　Windows : [![Build status](https://ci.appveyor.com/api/projects/status/k8swxpkue1caiiwi/branch/master?svg=true)](https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master)

["结巴"中文分词]的R语言版本，支持最大概率法（Maximum Probability），隐式马尔科夫模型（Hidden Markov Model），索引模型（QuerySegment），混合模型（MixSegment），共四种分词模式，同时有词性标注，关键词提取，文本Simhash相似度比较等功能。项目使用了[Rcpp]和[CppJieba]进行开发。

## 特性

+ 支持 Windows，Linux，Mac 操作系统。
+ 通过Rcpp Modules实现同时加载多个分词系统,可以分别使用不同的分词模式和词库。
+ 支持多种分词模式、中文姓名识别、关键词提取、词性标注以及文本Simhash相似度比较等功能。
+ 支持加载自定义用户词库，设置词频、词性。
+ 同时支持简体中文、繁体中文分词。
+ 支持自动判断编码模式。
+ 比原["结巴"中文分词]速度快，是其他R分词包的5-20倍。
+ 安装简单，无需复杂设置。
+ 可以通过[Rpy2]，[jvmr]等被其他语言调用。
+ 基于MIT协议。

## CRAN 版更新 v0.3

+ 2X 分词速度
+ 新的`[`分词运算符
+ 快速模式
+ 修正特定环境下的编码转换问题

## 安装

通过CRAN安装:

```r
install.packages("jiebaR")
library("jiebaR")
```

同时还可以通过Github安装[开发版],建议使用 gcc >= 4.6 编译包：

```r
library(devtools)
install_github("qinwf/jiebaR")
library("jiebaR")
```

## 使用示例

### 分词

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

可以自定义用户词库，推荐使用[深蓝词库转换]构建分词词库，它可以快速地将搜狗细胞词库等输入法词库转换为jiebaR的词库格式。

```r
show_dictpath()  ### 显示词典路径
edit_dict()      ### 编辑用户词典
?edit_dict()     ### 打开帮助系统
```

### 快速模式

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

### 词性标注
可以使用 `<=.tagger` 或者 `tag` 来进行分词和词性标注，词性标注使用混合模型模型分词，标注采用和 ictclas 兼容的标记法。

```r
words = "我爱北京天安门"
tagger = worker("tag")
tagger <= words
```

```r
     r        v       ns       ns 
    "我"     "爱"   "北京" "天安门" 
```
### 关键词提取
关键词提取所使用逆向文件频率（IDF）文本语料库可以切换成自定义语料库的路径，使用方法与分词类似。`topn`参数为关键词的个数。

```r
keys = worker("keywords", topn = 1)
keys <= "我爱北京天安门"
keys <= "一个文件路径.txt"
```
```r
  8.9954 
"天安门" 
```
### Simhash 与海明距离
对中文文档计算出对应的simhash值。simhash是谷歌用来进行文本去重的算法，现在广泛应用在文本处理中。Simhash引擎先进行分词和关键词提取，后计算Simhash值和海明距离。

```r
 words = "hello world!"
 simhasher = worker("simhash",topn=2)
 simhasher <= "江州市长江大桥参加了长江大桥的通车仪式"
```
 
 ```r
$simhash
[1] "12882166450308878002"

$keyword
   22.3853    8.69667 
"长江大桥"     "江州" 
```

```r
distance("江州市长江大桥参加了长江大桥的通车仪式" , "hello world!", simhasher)

```

```r
$distance
[1] "23"

$lhs
   22.3853    8.69667 
"长江大桥"     "江州" 

$rhs
11.7392 11.7392 
"hello" "world" 
```

## 计划支持

+ 支持 Windows , Linux , Mac 操作系统并行分词。
+ 简单的自然语言统计分析功能。

# jiebaR

This is a package for Chinese text segmentation, keyword extraction
and speech tagging. `jiebaR` supports four
types of segmentation modes: Maximum Probability, Hidden Markov Model, Query Segment and Mix Segment.

## Features

+ Support Windows, Linux,and Mac.
+ Using Rcpp Modules to load different segmentation worker at the same time.
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

## Example

### Text Segmentation

There are four segmentation models. You can use `worker()` to initialize a worker, and then use `<=` or `segment()` to do the segmentation.

```r
library(jiebaR)

##  Using default argument to initialize worker.
cutter = worker()

##       jiebar( type = "mix", dict = "dictpath/jieba.dict.utf8",
##               hmm  = "dictpath/hmm_model.utf8",  ### HMM model data
##               user = "dictpath/user.dict.utf8") ### user dictionary

###  Note: Can not display Chinese character here.

cutter <= "This is a good day!"  

## OR segment( "This is a good day!" , cutter )

```

```r
[1] "This" "is"   "a"    "good" "day" 
```

You can pipe a file path to cut file.

```r
cutter <= "./temp.dat"  ### Auto encoding detection.

## OR segment( "./temp.dat" , cutter )   
```

The package uses initialized engines for word segmentation. You
can initialize multiple engines simultaneously.

```r
cutter2 = worker(type  = "mix", dict = "dict/jieba.dict.utf8",
                 hmm   = "dict/hmm_model.utf8",  
                 user  = "dict/test.dict.utf8",
                 detect=T,      symbol = F,
                 lines = 1e+05, output = NULL
                 ) 
cutter2   ### Print information of worker
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

The model public settings can be modified and got using `$` , such as ` WorkerName$symbol = T `. Some private settings are fixed when the engine is initialized, and you can get them by `WorkerName$PrivateVarible`.

```r
cutter$encoding

cutter$detect = F
```

Users can specify their own custom dictionary to be included in the jiebaR default dictionary. jiebaR is able to identify new words, but adding your own new words can ensure a higher accuracy. [imewlconverter] is a good tools for dictionary construction.

```r
ShowDictPath()  ### Show path
EditDict()      ### Edit user dictionary
?EditDict()     ### For more information
```

### Speech Tagging
Speech Tagging function `<=.tagger` or `tag` uses speech tagging worker to cut word and tags each word after segmentation, using labels compatible with ictclas.  `dict` `hmm` and `user` should be provided when initializing `jiebaR` worker.

```r
words = "hello world"
tagger = worker("tag")
tagger <= words
```
```r
      x       x 
"hello" "world" 
```
### Keyword Extraction
Keyword Extraction worker use MixSegment model to cut word and use 
 TF-IDF algorithm to find the keywords.  `dict`, `hmm`, 
 `idf`, `stop_word` and `topn` should be provided when initializing  `jiebaR` worker.

```r
keys = worker("keywords", topn = 1)
keys <= "words of fun"
```
```r
11.7392 
  "fun" 
```
### Simhash Distance
Simhash worker can do keyword extraction and find 
the keywords from two inputs, and then computes Hamming distance between them.

```r
 words = "hello world"
 simhasher = worker("simhash",topn=1)
 simhasher <= words
 ```
 
 ```r
 $simhash
[1] "3804341492420753273"

$keyword
11.7392 
"hello" 
```

```r
distance("hello world" , "hello world!" , simhasher)
```

```r
$distance
[1] "0"

$lhs
11.7392 
"hello" 

$rhs
11.7392 
"hello" 
```

## Future Development

+ Support parallel programming on Windows , Linux , Mac.
+ Simple Natural Language Processing features.

## More Information and Issues
[https://github.com/qinwf/jiebaR](https://github.com/qinwf/jiebaR)

[https://github.com/aszxqw/cppjieba](https://github.com/aszxqw/cppjieba)

["结巴"中文分词]:https://github.com/fxsjy/jieba
[Rcpp]:https://github.com/RcppCore/Rcpp
[Cppjieba]:https://github.com/aszxqw/cppjieba
[Rtools]:http://mirrors.xmu.edu.cn/CRAN/bin/windows/Rtools
[深蓝词库转换]:https://github.com/studyzy/imewlconverter
[开发版]:https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master/artifacts
[Rpy2]:http://rpy.sourceforge.net/
[jvmr]:http://dahl.byu.edu/software/jvmr/
[imewlconverter]:https://github.com/studyzy/imewlconverter