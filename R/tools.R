#' Show default dictionaries' path
#' 
#' Show the default dictionaries' path. \code{HMMPATH}, \code{DICTPATH}
#' , \code{IDFPATH}, \code{STOPPATH} and \code{USERPATH} can be changed 
#' in global enviroment.
#' @author Qin Wenfeng 
#' 
#' @export
ShowDictPath<-function(){
  print(file.path(path.package("jiebaR"),"dict"))
}

#' Edit default user dictionary
#' 
#' Edit the default user dictionary. 
#' @references  The ictclas speech tag : \url{http://t.cn/8FdDD3I}
#' @details 
#' There are three column in the dictionary
#' . The first column is the word, the second column is the frequency
#' of words. The third column is speech tag using labels compatible
#'  with ictclas.
#' 
#' \tabular{ll}{
#' Tag\tab  TYPE \cr
#' 1 Group\tab  nouns \cr
#' n \tab  nouns \cr
#' nr \tab  name \cr
#' nr1 \tab  Chinese surname \cr
#' nr2 \tab  Chinese first name \cr
#' nrj \tab  Japanese names \cr
#' nrf \tab  transliteration name \cr
#' ns \tab  geographical name \cr
#' nsf \tab  transliteration geographical name\cr
#' nt \tab  organization \cr
#' nz \tab  others \cr
#' nl \tab  noun phrases \cr
#' ng \tab  noun morpheme \cr
#' 2 Group\tab  time \cr
#' t \tab  time \cr
#' tg \tab time morpheme  \cr
#' 3 Group\tab words that denotes a location \cr
#' s \tab  words that denotes a location \cr
#' 4 Group\tab  noun of a oflocality \cr
#' f \tab  noun of a oflocality \cr
#' 5 Group\tab verb \cr
#' v \tab  verb \cr
#' vd \tab  sub verb \cr
#' vn \tab  denominative \cr
#' vshi \tab  is \cr
#' vyou \tab  have \cr
#' vf \tab  denominative verb\cr
#' vx \tab  dummy verb \cr
#' vi \tab  intransitive verbs  \cr
#' vl \tab  verb Phrases \cr
#' vg \tab  verb morpheme\cr
#' 6 Group\tab adjective \cr
#' a \tab  adjective \cr
#' ad \tab  Adverb adjectives \cr
#' an \tab  Noun adjectives \cr
#' ag \tab  adjective morpheme \cr
#' al \tab  Adjectival phrases \cr
#' 7 Group\tab determiner \cr
#' b \tab  determiner \cr
#' bl \tab  determiner  phrases \cr
#' 8 Group\tab State words \cr
#' z \tab  State words \cr
#' 9 Group\tab pronoun \cr 
#' r \tab  pronoun \cr \cr
#' rr \tab  personal pronoun \cr
#' rz \tab  demonstrative pronoun \cr
#' rzt \tab   time pronoun \cr
#' rzs \tab  place pronoun \cr
#' ry \tab  interrogative pronoun \cr
#' rg \tab   interrogative morpheme \cr
#' 10 Group\tab numeral \cr
#' m \tab  numeral \cr
#' mq \tab  quantifier \cr
#' 11 Group\tab measure word \cr
#' q \tab  measure word \cr
#' qv \tab  Verbal \cr
#' qt \tab  time measure word \cr
#' 12 Group\tab adverb \cr
#' d \tab  adverb \cr
#' 13 Group\tab preposition \cr
#' p \tab  preposition \cr
#' pba \tab  "ba" \cr
#' pbei \tab  "bei" \cr
#' 14 Group\tab conjunction \cr
#' c \tab  conjunction \cr
#' cc \tab  coordinating conjunction \cr
#' 15 Group\tab auxiliary word \cr
#' u \tab  auxiliary word \cr
#' 16 Group\tab  interjection \cr
#' e \tab  interjection \cr
#' 17 Group\tab modal particle \cr
#' y \tab  modal particle \cr
#' 18 Group\tab onomatopoeia \cr
#' o \tab  onomatopoeia \cr
#' 19 Group\tab prefix \cr
#' h \tab  prefix \cr
#' 20 Group\tab suffix \cr
#' k \tab  suffix \cr
#' 21 Group\tab character string \cr
#' x \tab  character string \cr
#' xx \tab  non-morpheme character \cr
#' xu \tab  URL \cr
#' 22 Group\tab  symbol \cr
#' w \tab  symbol \cr
#' }
#' 
#' @author Qin Wenfeng 
#' @export
EditDict<-function(){
  file.show(file.path(path.package("jiebaR"),"dict","user.dict.utf8"))
}

