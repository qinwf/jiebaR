#' Keyword extraction
#' 
#' Keyword Extraction worker use MixSegment model to cut word and use 
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
#' \donttest{
#' ### Keyword Extraction
#' keys = worker("keywords", topn = 1)
#' keys <= "words of fun"}
#' @export
keywords <- function(code, jiebar) {
  
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  if (file.exists(code)) {
    encoding<-jiebar$encoding
    if(jiebar$detect ==T)  encoding<-filecoding(code)
    keyl(code = code, jiebar = jiebar,
         encoding = encoding)
  } else {
    keyw(code = code, jiebar = jiebar)
    
  }
}

keyl <- function(code, jiebar, encoding) {
  if (.Platform$OS.type == "windows"){
    old.locale <- Sys.getlocale("LC_CTYPE")
    Sys.setlocale(category = "LC_CTYPE", locale = "chs")
  }
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
    if (.Platform$OS.type == "windows"){
      Sys.setlocale(category = "LC_CTYPE", locale = old.locale)
    }
  })
}


keyw <- function(code, jiebar) {
  
  if (jiebar$symbol == F) {
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))

    result <- jiebar$worker$tag(code)
  
  if (.Platform$OS.type == "windows") {
    Encoding(result)<-"UTF-8"}
  return(result)
} 
