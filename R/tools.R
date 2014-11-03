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
#' @details 
#' There are three column in the dictionary
#' . The first column is the word, the second column is the frequency
#' of words. The third column is speech tag. 
#' 
#' \tabular{lc}{
#' Tag\tab  TYPE \cr
#' 1 \tab  名词 \cr
#' n \tab  名词 \cr
#' nr \tab  人名 \cr
#' nr1 \tab  汉语姓氏 \cr
#' nr2 \tab  汉语名字 \cr
#' nrj \tab  日语人名 \cr
#' nrf \tab  音译人名 \cr
#' ns \tab  地名 \cr
#' nsf \tab  音译地名 \cr
#' nt \tab  机构团体名 \cr
#' nz \tab  其它专名 \cr
#' nl \tab  名词性惯用语 \cr
#' ng \tab  名词性语素 \cr
#' 2 \tab  时间词 \cr
#' t \tab  时间词 \cr
#' tg \tab  时间词性语素 \cr
#' 3 \tab 处所词 \cr
#' s \tab  处所词 \cr
#' 4 \tab  方位词 \cr
#' f \tab  方位词 \cr
#' 5 \tab 动词 \cr
#' v \tab  动词 \cr
#' vd \tab  副动词 \cr
#' vn \tab  名动词 \cr
#' vshi \tab  动词“是” \cr
#' vyou \tab  动词“有” \cr
#' vf \tab  趋向动词 \cr
#' vx \tab  形式动词 \cr
#' vi \tab  不及物动词（内动词） \cr
#' vl \tab  动词性惯用语 \cr
#' vg \tab  动词性语素 \cr
#' 6 \tab 形容词 \cr
#' a \tab  形容词 \cr
#' ad \tab  副形词 \cr
#' an \tab  名形词 \cr
#' ag \tab  形容词性语素 \cr
#' al \tab  形容词性惯用语 \cr
#' 7 \tab 区别词 \cr
#' b \tab  区别词 \cr
#' bl \tab  区别词性惯用语 \cr
#' 8 \tab 状态词 \cr
#' z \tab  状态词 \cr
#' 9 \tab 代词 \cr 
#' r \tab  代词 \cr \cr
#' rr \tab  人称代词 \cr
#' rz \tab  指示代词 \cr
#' rzt \tab  时间指示代词 \cr
#' rzs \tab  处所指示代词 \cr
#' rzv \tab  谓词性指示代词 \cr
#' ry \tab  疑问代词 \cr
#' ryt \tab  时间疑问代词 \cr
#' rys \tab  处所疑问代词 \cr
#' ryv \tab  谓词性疑问代词 \cr
#' rg \tab  代词性语素 \cr
#' 10 \tab 数词 \cr
#' m \tab  数词 \cr
#' mq \tab  数量词 \cr
#' 11 \tab 量词 \cr
#' q \tab  量词 \cr
#' qv \tab  动量词 \cr
#' qt \tab  时量词 \cr
#' 12 \tab 副词 \cr
#' d \tab  副词 \cr
#' 13 \tab 介词 \cr
#' p \tab  介词 \cr
#' pba \tab  介词“把” \cr
#' pbei \tab  介词“被” \cr
#' 14 \tab 连词 \cr
#' c \tab  连词 \cr
#' cc \tab  并列连词 \cr
#' 15 \tab 助词 \cr
#' u \tab  助词 \cr
#' 16 \tab  叹词 \cr
#' e \tab  叹词 \cr
#' 17 \tab 语气词 \cr
#' y \tab  语气词 \cr
#' 18 \tab 拟声词 \cr
#' o \tab  拟声词 \cr
#' 19 \tab 前缀 \cr
#' h \tab  前缀 \cr
#' 20 \tab 后缀 \cr
#' k \tab  后缀 \cr
#' 21 \tab 字符串 \cr
#' x \tab  字符串 \cr
#' xx \tab  非语素字 \cr
#' xu \tab  网址URL \cr
#' 22 \tab  标点符号 \cr
#' w \tab  标点符号 \cr
#' wkz \tab ，：（〔［｛《【〖〈( [  < \cr
#' wky \tab ）〕］｝》】 〗〉) ]> \cr
#' wyz \tab “‘『 \cr
#' wyy \tab ” \cr
#' wj \tab  `。`\cr
#' ww \tab  ？ \cr
#' wt \tab  ！!\cr
#' wd \tab  ，,\cr
#' wf \tab  ；;\cr
#' wn \tab `、` \cr
#' wm \tab  `： :`\cr
#' ws  \tab ……… \cr
#' wp \tab  ——---- \cr
#' wb \tab ％‰     \cr
#' wh \tab ￥＄￡°℃$ \cr
#' }
#' 
#' @author Qin Wenfeng 
#' @export
EditDict<-function(){
  file.show(file.path(path.package("jiebaR"),"dict","user.dict.utf8"))
}

