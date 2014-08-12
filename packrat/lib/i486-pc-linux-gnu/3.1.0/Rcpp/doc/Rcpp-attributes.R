### R code from vignette source 'Rcpp-attributes.Rnw'

###################################################
### code chunk number 1: Rcpp-attributes.Rnw:39-41
###################################################
prettyVersion <- packageDescription("Rcpp")$Version
prettyDate <- format(Sys.Date(), "%B %e, %Y")


###################################################
### code chunk number 3: Rcpp-attributes.Rnw:147-149 (eval = FALSE)
###################################################
## sourceCpp("convolve.cpp")
## convolveCpp(x, y)


###################################################
### code chunk number 5: Rcpp-attributes.Rnw:176-177 (eval = FALSE)
###################################################
## function(file, colNames=character(), commentChar="#", header=TRUE)


###################################################
### code chunk number 12: Rcpp-attributes.Rnw:368-378 (eval = FALSE)
###################################################
## cppFunction('
##     int fibonacci(const int x) {
##         if (x < 2)
##             return x;
##         else
##             return (fibonacci(x - 1)) + fibonacci(x - 2);
##     }
## ')
## 
## evalCpp('std::numeric_limits<double>::max()')


###################################################
### code chunk number 13: Rcpp-attributes.Rnw:383-384 (eval = FALSE)
###################################################
## cppFunction(depends = 'RcppArmadillo', code = '...')


###################################################
### code chunk number 14: Rcpp-attributes.Rnw:415-416 (eval = FALSE)
###################################################
## Rcpp.package.skeleton("NewPackage", attributes = TRUE)


###################################################
### code chunk number 15: Rcpp-attributes.Rnw:422-424 (eval = FALSE)
###################################################
## Rcpp.package.skeleton("NewPackage", example_code = FALSE,
##                       cpp_files = c("convolve.cpp"))


###################################################
### code chunk number 17: Rcpp-attributes.Rnw:459-460 (eval = FALSE)
###################################################
## compileAttributes()


###################################################
### code chunk number 19: Rcpp-attributes.Rnw:506-511 (eval = FALSE)
###################################################
## #' The length of a string (in characters).
## #'
## #' @param str input character vector
## #' @return characters in each element of the vector
## strLength <- function(str)


