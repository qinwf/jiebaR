#' Keyword extraction
#' 
#' Keyword Extraction worker uses MixSegment model to cut word and uses 
#' TF-IDF algorithm to find the keywords.  \code{dict} , \code{hmm}, 
#' \code{idf}, \code{stop_word} and \code{topn} should be provided when initializing 
#' jiebaR worker.
#' 
#' There is a symbol \code{<=} for this function.
#' @seealso \code{\link{<=.keywords}} \code{\link{worker}} 
#' @param code A Chinese sentence or the path of a text file. 
#' @param jiebar jiebaR Worker.
#' @return a vector of keywords with weight.
#' @references \url{http://en.wikipedia.org/wiki/Tf-idf}
#' @author Qin Wenfeng
#' @examples 
#' \dontrun{
#' ### Keyword Extraction
#' keys = worker("keywords", topn = 1)
#' keys <= "words of fun"}
#' @export
keywords <- function(code, jiebar) {
  stopifnot("keywords" %in% class(jiebar))
  if(jiebar$PrivateVarible$timestamp != TIMESTAMP){
    stop("Please create a new worker after jiebaR is reloaded.")
  }
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  
  if (file.exists(code) && jiebar$write != "NOFILE") {
    encoding <- jiebar$encoding
    
    if(jiebar$detect == T)  encoding <- filecoding(code)
    keyl(code = code, jiebar = jiebar, encoding = encoding)
    
  } else {
    if (.Platform$OS.type == "windows") {
      code<-enc2utf8(code)
    }
    keyw(code = code, jiebar = jiebar)
    
  }
}

keyl <- function(code, jiebar, encoding) {

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
      out.lines <- keyw(code = tmp.lines, jiebar = jiebar)
                      
    }
    return(out.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)

  })
}


keyw <- function(code, jiebar) {
  
  if (jiebar$symbol == F) {
    code <- gsub("[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]", " ", code)
  } 
  # code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))

    result <- key_tag(code,jiebar$worker)
  
  if (.Platform$OS.type == "windows") {
    Encoding(result)<-"UTF-8"
  }
  result
} 

#' @rdname keywords
#' @export
vector_keywords <- function(code,jiebar){
  stopifnot("keywords" %in% class(jiebar))
  if(jiebar$PrivateVarible$timestamp != TIMESTAMP){
    stop("Please create a new worker after jiebaR is reloaded.")
  }
  if (!is.character(code)) 
    stop("Argument 'code' must be an string.")
  if (.Platform$OS.type == "windows") {
    code = enc2utf8(code)
  }
  result = key_keys(code,jiebar$worker)
  if (.Platform$OS.type == "windows") {
    Encoding(result)<-"UTF-8"
  }
  result
}
