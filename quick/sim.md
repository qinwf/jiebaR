## Simhash 与海明距离

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

