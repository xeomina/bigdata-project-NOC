install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz%22",
                 repos = NULL, type = "source", INSTALL_opts = c('--no-lock'))
.libPaths()

install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'))
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", 
                        INSTALL_opts=c("--no-multiarch"))
library(KoNLP) 

Sys.getenv("JAVA_HOME")
useSejongDic()

#????Ŭ??????
library(wordcloud)
library(wordcloud2)

#2019??
data_2019_raw <- read.table(file = 'C:/Users/mina/OneDrive/???? ȭ??/???? (2)/??ó??_????????_2019.txt',sep = ",")
data_2019 <- gsub("\t", ",", data_2019_raw$V1)
data_2019

data2_2019 <- strsplit(data_2019, split= ",")
data2_2019

undata_2019 <- unlist(data2_2019)
undata_2019

#???? Ȯ???ϱ?
word_table_2019 <- table(undata_2019)
word_table_2019
word_table_2019 <- head(sort(word_table_2019,decreasing = T),70)

wordcloud2(word_table_2019, size=0.5, fontFamily = '?????ٸ?????')

#2020??
data_2020_raw <- read.table(file = 'C:/Users/mina/OneDrive/???? ȭ??/???? (2)/??ó??_????????_2020.txt',sep = ",")
data_2020 <- gsub("\t", ",", data_2020_raw$V1)
data_2020

data2_2020 <- strsplit(data_2020, split= ",")
data2_2020

undata_2020 <- unlist(data2_2020)
undata_2020

#???? Ȯ???ϱ?
word_table_2020 <- table(undata_2020)
word_table_2020
word_table_2020 <- head(sort(word_table_2020,decreasing = T),200)

wordcloud2(word_table_2020, size=0.5, fontFamily = '?????ٸ?????')

