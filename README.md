# jiebaR 中文分词  [![](https://zenodo.org/badge/8525/qinwf/jiebaR.svg)](http://dx.doi.org/10.5281/zenodo.13729)

Linux : [![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=master)](https://travis-ci.org/qinwf/jiebaR)　Mac : [![Build Status](https://travis-ci.org/qinwf/jiebaR.svg?branch=osx)](https://travis-ci.org/qinwf/jiebaR)　Win : [![Build status](https://ci.appveyor.com/api/projects/status/k8swxpkue1caiiwi/branch/master?svg=true)](https://ci.appveyor.com/project/qinwf53234/jiebar/branch/master)


["结巴"中文分词]的R语言版本，支持最大概率法（Maximum Probability），隐式马尔科夫模型（Hidden Markov Model），索引模型（QuerySegment），混合模型（MixSegment），共四种分词模式，同时有词性标注，关键词提取，文本Simhash相似度比较等功能。项目使用了[Rcpp]和[CppJieba]进行开发。

["结巴"中文分词]:https://github.com/fxsjy/jieba
[Rcpp]:https://github.com/RcppCore/Rcpp
[Cppjieba]:https://github.com/aszxqw/cppjieba
