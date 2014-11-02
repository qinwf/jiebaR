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
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))

    result <- jiebar$worker$tag(code)
  
  if (.Platform$OS.type == "windows") {
    
    return(iconv(result, "UTF-8", "GBK"))
  }
  return(result)
} 
