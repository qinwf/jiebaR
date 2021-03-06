% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/worker_func.R
\name{new_user_word}
\alias{new_user_word}
\title{Add user word}
\usage{
new_user_word(worker, words, tags = rep("n", length(words)))
}
\arguments{
\item{worker}{a jieba worker}

\item{words}{the new words}

\item{tags}{the new words tags, default "n"}
}
\description{
Add user word
}
\examples{
cc = worker()
new_user_word(cc, "test")
new_user_word(cc, "do", "v")
}
