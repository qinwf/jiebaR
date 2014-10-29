
#' @export
jiebar <- function(type = "mix", dict=DICTPATH, hmm=HMMPATH, 
    user=USERPATH, idf=IDFPATH, stop_word=STOPPATH, 
    qmax = 20, topn = 5) {
    switch(type, 
           mp = new(mpseg, dict, user), 
           mix = new(mixseg, dict, hmm, user), 
           query = new(queryseg, dict, hmm, qmax), 
           hmm = new(hmmseg, hmm), 
           tag = new(tagger, dict, hmm, user), 
           keyword = new(keyword, topn, dict, hmm, idf, stop_word), 
           simhash = new(sim, dict, hmm, idf, stop_word))
}


#' @export
segment <- function(code, jiebar, encoding = "UTF-8", detect=F,symbol = F, lines = 1e+05,
                output = paste0("rjieba", as.numeric(Sys.time()), ".dat")) {
   
   if (!is.character(code) || length(code) != 1) 
        stop("Argument 'code' must be an string.")
    if (file.exists(code)) {
        if(detect==T)  encoding<-filecoding(code)
        FILESMODE <- T
        cutl(code = code, jiebar = jiebar, symbol = symbol, lines = lines, 
            output = output, encoding = encoding, FILESMODE = FILESMODE)
    } else {
        FILESMODE <- F
        cutw(code = code, jiebar = jiebar,symbol = symbol, 
            FILESMODE = FILESMODE)
    }
}

cutl <- function(code, jiebar, symbol, lines, output, encoding, FILESMODE) {
    nlines <- lines
    input.r <- file(code, open = "r")
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
        OUT <- TRUE
        cat(paste("Output file: ", output, "\n"))
    }, finally = {
        try(close(input.r), silent = TRUE)
        try(close(output.w), silent = TRUE)
    })
}


cutw <- function(code, jiebar,  symbol, FILESMODE) {
    
    if (symbol == F) {
        code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
    } 
    code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
    result <- jiebar$cut(code)
    if (symbol == F) {
        result <- grep("[^[:space:]]", result, value = T)
    }
    if (.Platform$OS.type == "windows" && FILESMODE == F) {
        
        return(iconv(result, "UTF-8", "GBK"))
    }
    return(result)
} 
