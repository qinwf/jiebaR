.onLoad <- function(libname, pkgname) {
  if(.Platform$OS.type=="windows"){
    Sys.setlocale(locale="English")}
}

#' @export
mixcut<-function(code,dict=NULL,hmm=NULL,user=NULL,symbol=F,
                 lines=1000,output=paste0("rjieba", as.numeric(Sys.time()),".dat"),encoding="UTF-8"){
  if (!is.character(code) || length(code) != 1 )
    stop("Argument 'code' must be an string.")
  if (file.exists(code)){
  FILESMODE<-T 
  mixcutline(code=code,dict=dict,hmm=hmm,user=user,symbol=symbol,
              lines=lines,output=output,encoding=encoding,FILESMODE=FILESMODE)
   
  } 
  else{
    FILESMODE<-F
    mixcutword(code=code,dict=dict,hmm=hmm,user=user,symbol=symbol,FILESMODE=FILESMODE)
}
}

mixcutline<-function(code,dict=NULL,hmm=NULL,user=NULL,symbol=F,
                     lines=1000,output=paste0("rjieba", as.numeric(Sys.time()),".dat"),encoding="UTF-8",FILESMODE){
    nlines <- lines
    input.r <- file(code, open = "r")
    if(.Platform$OS.type=="windows"){
    output.w <- file(output, open = "ab", encoding = "UTF-8")
    } else{
      output.w <- file(output, open = "a", encoding = "UTF-8")
    }
    OUT <- FALSE
    tryCatch({
      while(nlines == lines) {
        tmp.lines <- paste0(readLines(input.r, n = lines, encoding = encoding),collapse = "")
        nlines <- length(tmp.lines)
        if (nlines > 0) {
          if(encoding!="UTF-8"){
            tmp.lines <- iconv(tmp.lines, tmp.enc, "UTF-8")}
          out.lines <- mixcutword(tmp.lines,dict=dict,hmm=hmm,user=user,symbol=symbol,FILESMODE=FILESMODE)
          if(.Platform$OS.type=="windows"){
          writeBin(charToRaw(paste(out.lines,collapse = " ")), output.w)
          } else{
            writeLines(paste(out.lines,collapse = " "),output.w)
          }
        }
      }
      OUT <- TRUE
      cat(paste("Output file: ", output, "\n"))
    },
    finally = {
      try(close(input.r), silent = TRUE)
      try(close(output.w), silent = TRUE)
    }
    )
  } 


mixcutword<-function(code,dict=NULL,hmm=NULL,user=NULL,symbol=F,FILESMODE){
  
  if(symbol==F){
    code<-gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  }
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
  result<-mixcutc(code)
  if(symbol==F){
    result<-grep("[^[:space:]]", result,value = T)
  }
  print(FILESMODE)
  if(.Platform$OS.type=="windows" && FILESMODE==F){
    
    return (iconv(result,"UTF-8","GBK"))
  }
  return(result)
}