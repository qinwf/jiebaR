### R code from vignette source 'Rcpp-sugar.Rnw'

###################################################
### code chunk number 1: Rcpp-sugar.Rnw:41-43
###################################################
prettyVersion <- packageDescription("Rcpp")$Version
prettyDate <- format(Sys.Date(), "%B %e, %Y")


###################################################
### code chunk number 3: Rcpp-sugar.Rnw:104-107 (eval = FALSE)
###################################################
## foo <- function(x, y){
## 	ifelse( x < y, x*x, -(y*y) )
## }


