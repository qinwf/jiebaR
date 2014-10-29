##loadModule
loadModule("mod_mpseg", TRUE)
loadModule("mod_mixseg", TRUE)
loadModule("mod_query", TRUE)
loadModule("mod_hmmseg", TRUE)
loadModule("mod_tag", TRUE)
loadModule("mod_key", TRUE)
loadModule("mod_sim", TRUE)

##Path
DICTPATH<-file.path(find.package("jiebaR"),"dict","jieba.dict.utf8")
HMMPATH <-file.path(find.package("jiebaR"),"dict","hmm_model.utf8")
USERPATH<-file.path(find.package("jiebaR"),"dict","user.dict.utf8")
STOPPATH<-file.path(find.package("jiebaR"),"dict","stop_words.utf8")
IDFPATH <-file.path(find.package("jiebaR"),"dict","idf.utf8")
