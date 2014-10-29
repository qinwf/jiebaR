#' @export
keywords <- function(code, jiebar, encoding ="UTF-8", weight = F,detect=T,symbol = F) {
  
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  if (file.exists(code)) {
    if(detect==T)  encoding<-filecoding(code)
    keyl(code = code, jiebar = jiebar, symbol = symbol, 
         encoding = encoding,weight=weight)
  } else {
    keyw(code = code, jiebar = jiebar,symbol = symbol
    )
  }
}

keyl <- function(code, jiebar, symbol, encoding,weight) {
  
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
      out.lines <- keyw(code = tmp.lines, jiebar = jiebar, 
                        symbol = symbol,weight=weight)
    }
    return(out.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)
  })
}


keyw <- function(code, jiebar, symbol,weight) {
  
  if (symbol == F) {
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
  if(weight==T) {
    result <- jiebar$tag(code)
  } else{
    result <- jiebar$cut(code)
  }
  if (.Platform$OS.type == "windows") {
    
    return(iconv(result, "UTF-8", "GBK"))
  }
  return(result)
} 
