#' @export
para<-function(){
  rr<-new(applymix,DICTPATH,HMMPATH,USERPATH,RcppParallel::defaultNumThreads())
  rr
}