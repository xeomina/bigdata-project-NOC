install.packages('readxl')
library(readxl)
install.packages('dplyr')
library(dplyr)

rm(list=ls())

sk_1902_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_201902.csv')
sk_1903_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_201903.csv')
sk_1904_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_201904.csv')
sk_1905_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_201905.csv')

sk_1902 <- sk_1902_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique
sk_1903 <- sk_1903_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique
sk_1904 <- sk_1904_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique
sk_1905 <- sk_1905_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique

sk_2002_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_202002.csv')
sk_2003_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_202003.csv')
sk_2004_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_202004.csv')
sk_2005_raw <- read_excel('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/FLOW_TIME_202005.xlsx')

sk_2002 <- sk_2002_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique
sk_2003 <- sk_2003_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique
sk_2004 <- sk_2004_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique
sk_2005 <- sk_2005_raw %>% select(STD_YM,HDONG_NM,TMST_08,TMST_18) %>% group_by(HDONG_NM) %>% 
  summarise(TMST_08 = mean(TMST_08),TMST_18 = mean(TMST_18)) %>% unique

sk_cha <- data.frame(HDONG_NM = sk_1902$HDONG_NM,
                     work_02 = (sk_2002$TMST_08 - sk_1902$TMST_08)/sk_1902$TMST_08,
                     home_02 = (sk_2002$TMST_18 - sk_1902$TMST_18)/sk_1902$TMST_18,
                     work_03 = (sk_2003$TMST_08 - sk_1903$TMST_08)/sk_1903$TMST_08,
                     home_03 = (sk_2003$TMST_18 - sk_1903$TMST_18)/sk_1903$TMST_18,
                     work_04 = (sk_2004$TMST_08 - sk_1904$TMST_08)/sk_1904$TMST_08,
                     home_04 = (sk_2004$TMST_18 - sk_1904$TMST_18)/sk_1904$TMST_18,
                     work_05 = (sk_2005$TMST_08 - sk_1905$TMST_08)/sk_1905$TMST_08,
                     home_05 = (sk_2005$TMST_18 - sk_1905$TMST_18)/sk_1905$TMST_18)

write.csv(sk_cha,'C:/Users/mina/OneDrive/바탕 화면/공모전/SK/지역별 출퇴근 유동인구 증감.csv')










