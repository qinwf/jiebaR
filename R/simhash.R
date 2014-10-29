#' @export
simhash <- function(code, jiebar, topn =5, encoding ="UTF-8",detect=T,symbol = F) {
  
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  if (file.exists(code)) {
    if(detect==T)  encoding<-filecoding(code)
    simhashl(code = code, jiebar = jiebar, symbol = symbol, 
         encoding = encoding, topn = topn )
  } else {
    simhashw(code = code, jiebar = jiebar, topn = topn , symbol = symbol
    )
  }
}

simhashl <- function(code, jiebar, symbol, topn, encoding) {
  
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
      out.lines <- simhashw(code = tmp.lines, jiebar = jiebar, 
                        symbol = symbol,topn=topn)
    }
    return(out.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)
  })
}


simhashw <- function(code, jiebar, topn,symbol,weight) {
  
  if (symbol == F) {
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))

    result <- jiebar$simhash(code,topn)

  if (.Platform$OS.type == "windows") {
    result$keyword<-iconv(result$keyword, "UTF-8", "GBK")
    return(result)
  }
  return(result)
} 
