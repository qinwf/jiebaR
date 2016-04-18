#' Initialize jiebaR worker
#' 
#' This function can initialize jiebaR workers. You can initialize different 
#' kinds of workers including \code{mix}, \code{mp}, \code{hmm}, 
#' \code{query}, \code{tag}, \code{simhash}, and \code{keywords}.
#' see Detail for more information.
#' 
#' @param type The type of jiebaR workers including \code{mix}, \code{mp}, \code{hmm}, 
#'   \code{query}, \code{tag}, \code{simhash}, and \code{keywords}.
#'   
#' @param dict A path to main dictionary, default value is \code{DICTPATH},
#'  and the value is used for \code{mix}, \code{mp}, \code{query},
#'  \code{tag}, \code{simhash} and \code{keywords} workers.
#'  
#' @param hmm A path to Hidden Markov Model, default value is \code{HMMPATH}, 
#' and the value is used for \code{mix}, \code{hmm}, \code{query}, 
#'  \code{tag}, \code{simhash} and \code{keywords} workers.
#'   
#' @param user A path to user dictionary, default value is \code{USERPATH},
#'  and the value is used for \code{mix}, \code{tag} and \code{mp} workers.
#'
#' @param idf A path to inverse document frequency, default value is \code{IDFPATH},
#'  and the value is used for \code{simhash} and \code{keywords} workers.
#'   
#' @param stop_word A path to stop word dictionary, default value is \code{STOPPATH},
#'  and the value is used for \code{simhash}, \code{keywords}, \code{tagger} and \code{segment} workers. Encoding of this file is checked by \code{filecoding}, and it should be UTF-8 encoding. For \code{segment} workers, the default \code{STOPPATH} will not be used, so you should provide another file path.
#'   
#' @param write Whether to write the output to a file, or return 
#'   a the result in a object. This value will only be used when 
#'   the input is a file path. The default value is TRUE. The value 
#'   is used for segment and speech tagging workers.
#' 
#' @param qmax Max query length of words, and the value 
#'   is used for \code{query} workers.
#'   
#' @param topn The number of keywords, and the value is used for 
#'   \code{simhash} and \code{keywords} workers.
#'
#' @param encoding The encoding of the input file. If encoding 
#'   detection is enable, the value of \code{encoding} will be 
#'   ignore.
#'   
#' @param user_weight the weight of the user dict words. "min" "max" or "median".
#'   
#' @param detect Whether to detect the encoding of input file 
#'  using \code{filecoding} function. If encoding 
#'  detection is enable, the value of \code{encoding} will be 
#'  ignore.
#'  
#' @param symbol Whether to keep symbols in the sentence.
#' 
#' @param lines The maximal number of lines to read at one 
#'   time when input is a file. The value 
#'   is used for segmentation and speech tagging  workers.
#'   
#' @param output A path to the output file, and default worker will
#'   generate file name by system time stamp, the value 
#'   is used for segmentation and speech tagging  workers. 
#'   
#' @param bylines return the result by the lines of input files
#' 
#' @return  This function returns an environment containing segmentation 
#' settings and worker. Public settings can be modified and got 
#' using \code{$}.
#' 
#' @details 
#' The package uses initialized engines for word segmentation, and you 
#' can initialize multiple engines simultaneously. You can also reset the model
#' public settings using \code{$} such as
#' \code{ WorkerName$symbol = T }. Some private settings are fixed 
#' when a engine is initialized, and you can get then by 
#' \code{WorkerName$PrivateVarible}.
#' 
#' Maximum probability segmentation model uses Trie tree to construct
#' a directed acyclic graph and uses dynamic programming algorithm. It
#' is the core segmentation algorithm. \code{dict} and \code{user}
#' should be provided when initializing jiebaR worker.
#'  
#' Hidden Markov Model uses HMM model to determine status set and 
#' observed set of words. The default HMM model is based on People's Daily 
#' language library. \code{hmm} should be provided when initializing 
#' jiebaR worker.
#' 
#' MixSegment model uses both Maximum probability segmentation model 
#' and Hidden Markov Model to construct segmentation.  \code{dict} 
#' \code{hmm} and \code{user} should be provided when initializing 
#' jiebaR worker.
#' 
#' QuerySegment model uses MixSegment to construct segmentation and then 
#' enumerates all the possible long words in the dictionary.  \code{dict}, 
#' \code{hmm} and \code{qmax} should be provided when initializing 
#' jiebaR worker.
#' 
#' Speech Tagging worker uses MixSegment model to cut word and 
#' tag each word after segmentation using labels compatible with 
#' ictclas.  \code{dict}, 
#' \code{hmm} and \code{user} should be provided when initializing 
#' jiebaR worker.
#' 
#' Keyword Extraction worker uses MixSegment model to cut word and use 
#' TF-IDF algorithm to find the keywords.  \code{dict} ,\code{hmm}, 
#' \code{idf}, \code{stop_word} and \code{topn} should be provided when initializing 
#' jiebaR worker.
#' 
#' Simhash worker uses the keyword extraction worker to find the keywords
#' and uses simhash algorithm to compute simhash.  \code{dict} 
#' \code{hmm}, \code{idf} and \code{stop_word} should be provided when initializing 
#' jiebaR worker.
#' 
#' @examples 
#' ### Note: Can not display Chinese character on Windows here.
#' \dontrun{
#' words = "hello world"
#' test1 = worker()
#' test1
#' test1 <= words}
#' 
#' \dontrun{
#' test <= "./temp.txt"
#'  
#' engine2 = worker("mix",symbol = T)
#' engine2 <= "./temp.txt"
#' engine2
#' engine2$symbol = T
#' engine2
#' engine2 <= words
#' 
#' engine3 = worker(type = "mix", dict = "dict_path",symbol = T)
#' engine3 <= "./temp.txt"
#'  }
#'  \dontrun{
#' keys = worker("keywords", topn = 1)
#' keys <= words
#' tagger = worker("tag")
#' tagger <= words}
#' 
#' @author Qin Wenfeng 
#' @export
worker <- function(type = "mix", dict = DICTPATH, hmm = HMMPATH, 
                   user = USERPATH, idf = IDFPATH, stop_word = STOPPATH, write = T,
                   qmax = 20, topn = 5, encoding = "UTF-8", detect = T, symbol = F,
                   lines = 1e+05, output = NULL, bylines = F, user_weight = "max") 
{ 
  if(!any(type == c("mix","mp","hmm","query","simhash","keywords","tag","full","level","level_pair"))){
    stop("unknown worker type")
  }
  stopifnot(user_weight %in% c("median","min","max"))
  jiebapath <- find.package("jiebaRD")
  
  # unzip files
  # 
  if(!file.exists(file.path(jiebapath,"dict","jieba.dict.utf8"))){
    try(unzip(file.path(jiebapath,"dict","jieba.dict.zip"),exdir =file.path( jiebapath,"dict") ) )
  }
  if(!file.exists(file.path(jiebapath,"dict","hmm_model.utf8"))){
    try(unzip(file.path(jiebapath,"dict","hmm_model.zip"),exdir =file.path( jiebapath,"dict") ) )
  }
  if(!file.exists(file.path(jiebapath,"dict","idf.utf8"))){
    try(unzip(file.path(jiebapath,"dict","idf.zip"),exdir =file.path( jiebapath,"dict") ) )
  }
  
  # set up result
  # 
  result = new.env(parent = emptyenv())
  stop2 = if(stop_word==STOPPATH) NULL else stop_word
  
  if(!is.null(stop2)){
    if(!file.exists(stop2)){
      stop("There is no such file for stop words.")
    }
    encodings = suppressWarnings(filecoding(stop2))
    if(encodings != "UTF-8" && encodings != "binary"){
      cat("Encoding of stop words file: ",encodings,"\n")
      warning("stop words file should be UTF-8 encoding.")
    }
  }
  if(user_weight == "min")    uw=1L
  if(user_weight == "median") uw=2L
  if(user_weight == "max")    uw=3L
  if(type %in% c("mix","query","hmm","mp","tag","full","level","level_pair")){
    worker  = jiebaclass_ptr_v2(dict, hmm, user,stop2,uw)
    private = list(dict = dict,user = user, hmm = hmm, stop_word= stop2,user_weight = user_weight, timestamp = TIMESTAMP)
    assignjieba(worker,detect,encoding,symbol,lines,output,write,private,bylines,result)
    result$max_word_length = qmax
    result$default = type
    class(result) <- c("jiebar","segment","jieba")
    return(result)
  }
  
  if(type == "simhash"){
    worker  = sim_ptr(dict,hmm,idf,stop_word,user)
    private = list(dict=dict,hmm=hmm, user = user, idf=idf,stop_word=stop_word, timestamp = TIMESTAMP)
    assignjieba(worker,detect,encoding,symbol,lines,output,write,private,bylines,result)
    class(result) <- c("jiebar","nonsegment","simhash")
    result$topn = topn
    return(result)
  }
  
  if(type == "keywords"){
    worker  =  key_ptr(topn, dict,hmm,idf,stop_word,user)
    private = list(top_n_word=topn,dict=dict,hmm=hmm,user=user,idf=idf,stop_word=stop_word, timestamp = TIMESTAMP)
    assignjieba(worker,detect,encoding,symbol,lines,output,write,private,bylines,result)
    class(result) <- c("jiebar","nonsegment","keywords")
    return(result)
  }

}

assignjieba<-function(worker,detect,encoding,symbol,lines,output,write,private,bylines,result){
  assign(x = "worker",value = worker,envir = result)
  assign(x = "detect",value = detect,envir = result)
  assign(x = "symbol",value = symbol,envir = result)
  assign(x = "lines",value = lines,envir = result)
  assign(x = "output",value = output,envir = result)
  assign(x = "write",value = write,envir = result)
  assign(x = "PrivateVarible",value = private,envir = result)
  assign(x = "encoding",value = encoding, envir=result)
  assign(x = "bylines",value = bylines, envir=result)
}

read_stop_words<- function(filepath){
  if(!file.exists(filepath)){
    stop("There is no such file for stopwords.")
  }
  res = readLines(filepath,encoding = filecoding(filepath))
  class(res) <- "stopword_list"
  res
}
