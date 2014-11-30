#' Simhash computation
#' 
#' Simhash worker uses the keyword extraction worker to find the keywords
#' and uses simhash algorithm to compute simhash.  \code{dict} 
#' \code{hmm}, \code{idf} and \code{stop_word} should be provided when initializing 
#' jiebaR worker.
#' 
#' There is a symbol \code{<=} for this function.
#' @seealso \code{\link{<=.simhash}} \code{\link{worker}} 
#' @param code A Chinese sentence or the path of a text file. 
#' @param jiebar jiebaR Worker.
#' @references MS Charikar - Similarity Estimation Techniques from Rounding Algorithms
#' @author Qin Wenfeng
#' @examples 
#' \donttest{
#' ### Simhash
#' words = "hello world"
#' simhasher = worker("simhash",topn=1)
#' simhasher <= words
#' distance("hello world" , "hello world!" , simhasher)
#' }
#' @export
simhash <- function(code, jiebar) {
  stopifnot("simhash" %in% class(jiebar))
  if(jiebar$PrivateVarible$timestamp != TIMESTAMP){
    stop("Please create a new worker after jiebaR is reloaded.")
  }
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  
  if (file.exists(code)) {
    encoding <- jiebar$encoding
    if(jiebar$detect == T)  encoding<-filecoding(code)
    simhashl(code = code, jiebar = jiebar, encoding = encoding)
  } else {
    if (.Platform$OS.type == "windows") {
      code<-enc2utf8(code)
    }
    simhashw(code = code, jiebar = jiebar)
  }
}

simhashl <- function(code, jiebar, encoding) {
  
  input.r <- file(code, open = "r")
  OUT <- FALSE
  tryCatch({
    
    tmp.lines <- readLines(input.r,  encoding = encoding)
    nlines    <- length(tmp.lines)
    tmp.lines <- paste(tmp.lines, collapse = " ")
    if (nlines > 0) {
      if (encoding != "UTF-8") {
        tmp.lines  <- iconv(tmp.lines,encoding , "UTF-8")
      } 
      out.lines <- simhashw(code = tmp.lines, jiebar = jiebar)
    }
    return(out.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)
    
  })
}


simhashw <- function(code, jiebar) {
  
  if (jiebar$symbol == F) {
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
  
  result <- jiebar$worker$simhash(code,jiebar$topn)
  
  if (.Platform$OS.type == "windows") {
    Encoding(result$keyword) <- "UTF-8"
  }
  result
} 
#' Hamming distance of words
#' 
#' The function uses Simhash worker to do keyword extraction and find 
#' the keywords from two inputs, and then computes Hamming distance 
#' between them.
#' 
#' @param codel a Chinese sentence or the path of a text file
#' @param coder a Chinese sentence or the path of a text file
#' @param jiebar jiebaR Worker
#' @author Qin Wenfeng
#' @seealso \code{\link{worker}} 
#' @references \url{http://en.wikipedia.org/wiki/Hamming_distance}
#' @examples 
#' \donttest{
#' ### Simhash
#' words = "hello world"
#' simhasher = worker("simhash", topn = 1)
#' simhasher <= words
#' distance("hello world" , "hello world!" , simhasher)
#' }
#' @export
distance <- function(codel,coder,jiebar){
  stopifnot("simhash" %in% class(jiebar))
  if(jiebar$PrivateVarible$timestamp != TIMESTAMP){
    stop("Please create a new worker after jiebaR is reloaded.")
  }
  if (!is.character(codel)   || length(codel) != 1 ||
      !is.character(coder)   || length(coder) != 1) 
    stop("Argument 'code' must be an string.")
  
  encoding <- jiebar$encoding
  
  if (file.exists(codel)) {
    if(jiebar$detect == T)  encoding <- filecoding(codel)
    codel <- distancel(codel,jiebar,encoding)
  } else{
    if (.Platform$OS.type == "windows") {
      codel<-enc2utf8(codel)
    }
  }
  if (file.exists(coder)) {
    if(jiebar$detect == T)  encoding <- filecoding(coder)
    coder <- distancel(coder,jiebar,encoding)
  } else{
    if (.Platform$OS.type == "windows") {
      coder<-enc2utf8(coder)
    }
  }
  result <- jiebar$worker$distance(codel,coder,jiebar$topn)
  if (.Platform$OS.type == "windows") {
    Encoding(result$rhs) <- "UTF-8"
    Encoding(result$lhs) <- "UTF-8"
  }
  result  
}


distancel <- function(code, jiebar, encoding) {
  
  input.r <- file(code, open = "r")
  OUT <- FALSE
  tryCatch({
    tmp.lines <- readLines(input.r,  encoding = encoding)
    nlines <- length(tmp.lines)
    tmp.lines <- paste(tmp.lines, collapse = " ")
    if (nlines > 0) {
      if (encoding != "UTF-8") {
        tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
      } 
      if (jiebar$symbol == F) {
        tmp.lines <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", tmp.lines)
      } 
      tmp.lines <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", tmp.lines))
      
    }
    return(tmp.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)
  })
}
