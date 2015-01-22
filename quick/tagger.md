## 词性标注

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