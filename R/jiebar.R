assignjieba<-function(worker,detect,encoding,symbol,lines,output,write_file,private,result){
  assign(x = "Worker",value = worker,envir = result)
  assign(x = "DetectEncoding",value = detect,envir = result)
  assign(x = "Symbol",value = symbol,envir = result)
  assign(x = "ReadLines",value = lines,envir = result)
  assign(x = "OutputPath",value = output,envir = result)
  assign(x = "WriteFile",value = write_file,envir = result)
  assign(x = "PrivateVarible",value = private,envir = result)
  assign(x = "Encoding",value = encoding, envir=result)
  
}


#' @export
jiebar <- function(type = "mix", dict=DICTPATH, hmm=HMMPATH, 
                   user=USERPATH, idf=IDFPATH, stop_word=STOPPATH, write_file=T,
                   qmax = 20, topn = 5, encoding = "UTF-8", detect=T,symbol = F,
                   lines = 1e+05,output = paste0("rjieba", as.numeric(Sys.time()), ".dat")) 
{ 
  if(!any(type==c("mix","mp","hmm","query","simhash","keywords","tag"))){
    stop("Unkowned worker type")
  }
  result<-new.env()
  
  switch(type, 
         mp = {
           worker  = new(mpseg, dict, user)
           private = list(dict=dict,user=user)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","segment","mpseg")
         }, 
         
         mix = {
           worker  =  new(mixseg, dict, hmm, user)
           private = list(dict=dict,hmm=hmm,user=user)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","segment","mixseg")
         },
         hmm = {
           worker  =  new(hmmseg, hmm)
           private = list(hmm=hmm)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","segment","hmmseg")
         },
         query = {
           worker  =  new(queryseg, dict,hmm,qmax)
           private = list(dict=dict,hmm=hmm,max_word_lenght=qmax)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","segment","queryseg")
         },
         simhash = {
           worker  =  new(sim, dict,hmm,idf,stop_word)
           private = list(dict=dict,hmm=hmm,idf=idf,stop_word=stop_word)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","simhash")
         },
         keywords = {
           worker  =  new(keyword,topn, dict,hmm,idf,stop_word)
           private = list(top_n_word=topn,dict=dict,hmm=hmm,idf=idf,stop_word=stop_word)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","keywords")
         },
         tag = {
           worker  =  new(tagger, dict,hmm,user)
           private = list(dict=dict,hmm=hmm,user=user)
           assignjieba(worker,detect,encoding,symbol,lines,output,write_file,private,result)
           class(result)<-c("jiebar","tagger")         
         })
  result
}


# print.jiebar<-function(jiebar) { 
#   cat("jiebaR worker type:  ")
#   switch(class(jiebar)[2], mpseg = {
#     "Maximum Probability Segment",
#                       mixseg = "Mix Segment",
#                       hmmseg = "Hidden Markov Model Segment",
#                       queryseg = "Query Segment",
#                       simhash = "Simhash",
#                       tagger = "Speech Tagging",
#                       keywords = "Keyword Extraction")
# 
# }



