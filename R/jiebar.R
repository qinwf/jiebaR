#' Initialize jiebaR worker
#' 
#' This function initializes jiebaR workers. You can initialize different 
#' kinds of workers including \code{mix}, \code{mp}, \code{hmm}, 
#' \code{query}, \code{tag}, \code{simhash}, and \code{keywords}.
#' see Detail for more information.
#' 
#' @param type The type of jiebaR workers including \code{mix}, \code{mp}, \code{hmm}, 
#'   \code{query}, \code{tag}, \code{simhash}, and \code{keywords}.
#'   
#' @param dict A path to main dictionary, default value is \code{
#'   DICTPATH}, and the value is used for \code{mix}, \code{mp}, \code{query},
#'  \code{tag}, \code{simhash} and \code{keywords} workers.
#'  
#' @param hmm A path to Hidden Markov Model, default value is \code{
#'   HMMPATH}, and the value is used for \code{mix}, \code{hmm}, \code{query}, 
#'   \code{tag}, \code{simhash} and \code{keywords} workers.
#'   
#' @param user A path to user dictionary, default value is \code{
#'   USERPATH}, and the value is used for \code{mix}, 
#'   \code{tag} and \code{mp} workers.
#'
#' @param idf A path to inverse document frequency, default value is \code{
#'   IDFPATH}, and the value is used for 
#'   \code{simhash} and \code{keywords} workers.
#'   
#' @param stop_word A path to stop word dictionary, default value is \code{
#'   STOPPATH}, and the value is used for 
#'   \code{simhash} and \code{keywords} workers.
#'   
#' @param write Whether to write the output to a file, or return 
#'   a the obeject in a object, and default value is TRUE, and the value 
#'   is used for segment and speech tagging workers.
#' 
#' @param qmax Max query lenght of words, and the value 
#'   is used for \code{query} workers.
#'   
#' @param topn The number of keywords, the value is used for 
#'   \code{simhash} and \code{keywords} workers.
#'
#' @param encoding The encoding of Input file, if encoding 
#'   detection is enable, the value of \code{encoding} will be 
#'   ignore.
#'   
#' @param detect Whether to detect the encoding of input file 
#'  using \code{filecoding} function.
#'  
#' @param symbol Whether to keep symbols in the sentence.
#' 
#' @param lines The maximal number of lines to read at one 
#'   time when input is a file. the value 
#'   is used for segment and speech tagging  workers.
#'   
#' @param output A path to the output file, and default worker will
#'   generate filename by system time stamp, the value 
#'   is used for segment and speech tagging  workers. 
#'   
#' @return  The function return an enviroment which is containing segmentation 
#' settings and worker. Public settings can be modified and get 
#' using \code{$}.
#' 
#' @details 
#' The package uses initialized engines for word segmentation, you 
#' can initialize multiple engines simultaneously, and reset the model
#' public settings can be modified and get using \code{$} like 
#' \code{ WorkerName$symbol = T }. Some private setting are fixed 
#' when engine is initialized, and you can get then by 
#' \code{WorkerName$PrivateVarible}.
#' 
#' Maximum probability segmentation model uses Trie tree to construct
#' a directed acyclic graph and dynamic programming algorithm, and it
#' is the core segmentation algorithm. \code{dict} and \code{user}
#' should be provided when initializing jiebaR worker.
#'  
#' Hidden Markov Model uses HMM model to determin status set and 
#' observed set of words. The default hmm model is base on People's Daily 
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
#' Speech Tagging worker use MixSegment model to cut word and 
#' tag each word after segmentation, using labels compatible with 
#' ictclas.  \code{dict} 
#' \code{hmm} and \code{user} should be provided when initializing 
#' jiebaR worker.
#' 
#' Keyword Extraction worker use MixSegment model to cut word and use 
#' TF-IDF algorithm to find the keywords.  \code{dict} ,\code{hmm}, 
#' \code{idf}, \code{stop_word} and \code{topn} should be provided when initializing 
#' jiebaR worker.
#' 
#' Simhash worker use the keyword extraction worker to find the keywords
#' and using simhash algorithm to compute simhash.  \code{dict} 
#' \code{hmm}, \code{idf} and \code{stop_word} should be provided when initializing 
#' jiebaR worker.
#' 
#' @examples 
#' ### Note: Can not display Chinese character on Windows here.
#' \donttest{
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
#'  \donttest{
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
                   lines = 1e+05, output = NULL) 
{ 
  if(!any(type == c("mix","mp","hmm","query","simhash","keywords","tag"))){
    stop("Unkown worker type")
  }
  result = new.env(parent = emptyenv())
  
  switch(type, 
           mp      = {
           worker  = new(mpseg, dict, user)
           private = list(dict = dict,user = user)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           class(result) <- c("jiebar","segment","mpseg")
         }, 
         
           mix     = {
           worker  = new(mixseg, dict, hmm, user)
           private = list(dict = dict,hmm = hmm,user = user)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           class(result) <- c("jiebar","segment","mixseg")
         },
           hmm     = {
           worker  = new(hmmseg, hmm)
           private = list(hmm = hmm)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           class(result) <- c("jiebar","segment","hmmseg")
         },
           query   = {
           worker  = new(queryseg, dict,hmm,qmax)
           private = list(dict = dict,hmm = hmm,max_word_lenght = qmax)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           
           class(result) <- c("jiebar","segment","queryseg")
         },
          simhash  = {
           worker  = new(sim, dict,hmm,idf,stop_word)
           private = list(dict=dict,hmm=hmm,idf=idf,stop_word=stop_word)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           class(result) <- c("jiebar","simhash")
           result$topn = topn
         },
         keywords  = {
           worker  =  new(keyword,topn, dict,hmm,idf,stop_word)
           private = list(top_n_word=topn,dict=dict,hmm=hmm,idf=idf,stop_word=stop_word)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           class(result) <- c("jiebar","keywords")
         },
           tag     = {
           worker  =  new(tagger, dict,hmm,user)
           private = list(dict=dict,hmm=hmm,user=user)
           assignjieba(worker,detect,encoding,symbol,lines,output,write,private,result)
           class(result) <- c("jiebar","tagger")         
         })
  result
}



assignjieba<-function(worker,detect,encoding,symbol,lines,output,write,private,result){
  assign(x = "worker",value = worker,envir = result)
  assign(x = "detect",value = detect,envir = result)
  assign(x = "symbol",value = symbol,envir = result)
  assign(x = "lines",value = lines,envir = result)
  assign(x = "output",value = output,envir = result)
  assign(x = "write",value = write,envir = result)
  assign(x = "PrivateVarible",value = private,envir = result)
  assign(x = "encoding",value = encoding, envir=result)
  
}
