## worker()

`worker()` 用于新建分词引擎，可以同时新建多个分词引擎。引擎的类型有： mix（混合模型）, mp（最大概率模型）, hmm（HMM模型）, query（索引模型）, tag（标记模型）, simhash（Simhash 模型）和 keywords（关键词模型），共7种。

## 默认参数

```r
worker(type = "mix", dict = DICTPATH, hmm = HMMPATH, user = USERPATH,
  idf = IDFPATH, stop_word = STOPPATH, write = T, qmax = 20, topn = 5,
  encoding = "UTF-8", detect = T, symbol = F, lines = 1e+05,
  output = NULL, bylines = F)
```

## 参数说明

#### type 引擎类型

引擎的类型有： mix（混合模型）, mp（最大概率模型）, hmm（HMM模型）, query（索引模型）, tag（标记模型）, simhash（Simhash 模型）和 keywords（关键词模型），共7种。

#### dict 系统词典

优先载入的词典，包括词、词频、词性标记三列。可以输入自定义路径。

#### hmm HMM模型路径

HMM模型路径

#### user 用户词典

用户词典，包括词、词性标记两列。用户词典中的所有词的词频均为系统词典中的最大词频。可以输入自定义路径。

#### idf IDF词典

IDF 词典，关键词提取使用。

#### stop_word 关键词用停止词库

关键词提取使用的停止词库。

#### write 写入文件

是否将文件分词结果写入文件，默认为否。

#### qmax 最大索引长度

索引模型中，最大可能成词的字符数。

#### topn 关键词数

提取的关键词数。

#### encoding 输入文件编码

输入文件的编码，默认为UTF-8。

#### detect 检测编码

是否检查输入文件的编码，默认检查。

#### symbol 保留符号

是否保留符号，默认不保留符号。

#### lines 读取行数

每次读取文件的最大行数，用于控制读取文件的长度。对于大文件，实现分次读取。

#### output 输出路径

指定输出路径，一个字符串路径。

#### bylines 按行输出

文件结果是否按行输出，如果是，则将读入的文件或字符串向量按行逐个进行分词操作。
