## 最简单的方法

打开 `library/jiebaR/dict/` 目录下的 `user.dict.utf8` 文件（这个是默认载入的用户词典文件），直接往里面添加词就可以了。

打开后格式是这样子的

```r
云计算
韩玉鉴赏
蓝翔 nz
CEO
江大桥 x
```

### 更多说明

用户词典有两列，第一列为词项，第二列为词性标记。用户词库默认词频为系统词库中的最大词频，如需自定义词频率，可将新词添加入系统词库中。

词典中的词性标记采用ictclas的标记方法。如果不知道怎么标记词性，可以不填写，直接导入词条就可以了。

比如你的词库只需要新建成如下：

```r
摩尔定律
三角函数
内容存取存储器
操作系统
```

jieba.dict.utf8 是系统词典，共有三列，第一列为词项，第二列为词频，第三列为词性标记。


### 温馨提示

如果不使用另外的词典，新建worker的时候，可以不用指定词典路径，会自动查找，比如

```r
> cutter = worker(type  = "mix", dict = "D:/Program Files/R/R-3.1.2/library/jiebaR/dict/jieba.dict.utf8",
+        hmm   = "D:/Program Files/R/R-3.1.2/library/jiebaR/dict/hmm_model.utf8",  
+        user  = "D:/Program Files/R/R-3.1.2/library/jiebaR/dict/user.dict.utf8",
+        detect=T,      symbol = F,
+        lines = 1e+05, output = NULL
+ ) 
```

可以省略为

```r
> cutter = worker(type  = "mix") 
```

如果指定用户词典目录，只需要写user这个参数就可以了，多写容易错，用默认就好。

```r
> cutter = worker(type  = "mix"，user  = "D:/somefile.xxx") 
```

### 制作词库


制作词库可以用 深蓝词库转换 或者 [cidian](https://github.com/qinwf/cidian/) 包。注意：如果使用  深蓝词库转换 导出有拼音项，将无法正常读取词库。
