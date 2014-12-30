#' Chinese text segmentation function
#' 
#' The function uses initialized engines for words segmentation. You 
#' can initialize multiple engines simultaneously using \code{worker()}.
#' Public settings of workers can be got and modified using \code{$}, 
#' such as \code{ WorkerName$symbol = T }. Some private settings are fixed 
#' when engine is initialized, and you can get then by 
#' \code{WorkerName$PrivateVarible}.
#' 
#' There are four kinds of models:
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
#' and Hidden Markov Model to construct segmentation.  \code{dict}, 
#' \code{hmm} and \code{user} should be provided when initializing 
#' jiebaR worker.
#' 
#' QuerySegment model uses MixSegment to construct segmentation and then 
#' enumerates all the possible long words in the dictionary.  \code{dict}, 
#' \code{hmm} and \code{qmax} should be provided when initializing 
#' jiebaR worker.
#' 
#' There is a symbol \code{<=} for this function.
#' @author Qin Wenfeng
#' @param code A Chinese sentence or the path of a text file. 
#' @param jiebar jiebaR Worker.
#' @seealso  \code{\link{<=.segment}} \code{\link{worker}} 
#' 
#' @export
segment <- function(code, jiebar) {
  stopifnot("segment" %in% class(jiebar))
  if(jiebar$PrivateVarible$timestamp != TIMESTAMP){
    stop("Please create a new worker after jiebaR is reloaded.")
  }
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  
  if (file.exists(code)) {
    if(is.null(jiebar$output)){
      basenames <- gsub("\\.[^\\.]*$", "", code)
      extnames  <- gsub(basenames, "", code, fixed = TRUE)
      output    <- paste(basenames, ".segment", as.numeric(Sys.time()), extnames, sep = "")
    } else {
      output<-jiebar$output
    }
    encoding<-jiebar$encoding
    if(jiebar$detect==T)  encoding<-filecoding(code)
    FILESMODE <- T
    cutl(code = code, jiebar=jiebar,symbol = jiebar$symbol, lines = jiebar$lines, 
         output = output, encoding = encoding, write_file= jiebar$write,FILESMODE = FILESMODE)
  } else {
    if (.Platform$OS.type == "windows") {
      code<-enc2utf8(code)
    }
    FILESMODE <- F
    cutw(code = code, jiebar=jiebar,symbol=jiebar$symbol, 
         FILESMODE = FILESMODE)
  }
  
}

cutl <- function(code, jiebar, symbol, lines, output, encoding, write_file,FILESMODE) {
  
  nlines <- lines
  input.r <- file(code, open = "r")
  if(write_file==T){
    
    if (.Platform$OS.type == "windows") {
      output.w <- file(output, open = "ab", encoding = "UTF-8")
    } else {
      output.w <- file(output, open = "a", encoding = "UTF-8")
    }
    OUT <- FALSE
    
    tryCatch({
      while (nlines == lines) {
        tmp.lines <- readLines(input.r, n = lines, encoding = encoding)
        nlines <- length(tmp.lines)
        tmp.lines <- paste(tmp.lines, collapse = " ")
        if (nlines > 0) {
          if (encoding != "UTF-8") {
            tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
          }
          out.lines <- cutw(code = tmp.lines, jiebar = jiebar, 
                            symbol = symbol, FILESMODE = FILESMODE)
          
          if (.Platform$OS.type == "windows") {
            writeBin(charToRaw(paste(out.lines, collapse = " ")), output.w)
          } else {
            writeLines(paste(out.lines, collapse = " "), output.w)
          }
          
        } 
      } 
    }
    , finally = {
      try(close(input.r), silent = TRUE)
      try(close(output.w), silent = TRUE)
      
    })
    OUT <- TRUE
    cat(paste("Output file: ", output, "\n"))
    return(output) 
    
  } else{
    result<-c()
    FILESMODE=F
    tryCatch({
      while (nlines == lines) {
        tmp.lines <- readLines(input.r, n = lines, encoding = encoding)
        nlines <- length(tmp.lines)
        tmp.lines <- paste(tmp.lines, collapse = " ")
        if (nlines > 0) {
          if (encoding != "UTF-8") {
            tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
          }
          out.lines <- cutw(code = tmp.lines, jiebar = jiebar, 
                            symbol = symbol, FILESMODE = FILESMODE)
          
          result<-c(result,out.lines)

        } 
      } 
    }
    , finally = {
      try(close(input.r), silent = TRUE)
      
    })
    return(result)
  }
  
}


cutw <- function(code, jiebar,  symbol, FILESMODE) {
  
  if (symbol == F) {
    code <- gsub("[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]", " ", code)
  } 
#  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
  result <- switch(class(jiebar)[3],
                   mixseg = mix_cut(code, jiebar$worker),
                   mpseg = mp_cut(code, jiebar$worker),
                   hmmseg = hmm_cut(code, jiebar$worker),
                   queryseg = query_cut(code, jiebar$worker)
                   )
  if (symbol == F) {
    result = result[ result != " "]
  }
  if (.Platform$OS.type == "windows") {
    Encoding(result)<-"UTF-8"}
  return(result)
} 

