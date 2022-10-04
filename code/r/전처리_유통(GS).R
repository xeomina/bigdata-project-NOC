install.packages('readxl')
library(readxl)
install.packages('dplyr')
library(dplyr)

rm(list=ls())

#데이터 가져오기
gs_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/GS/종합.csv')

gs <- gs_raw %>% mutate(YEAR = format(as.Date(OPER_DT), "%Y"),
                        MONTH = format(as.Date(OPER_DT), "%m")) #%>% select(OPER_DT,PVN, BOR, ADMD, AMT_IND, YEAR, MONTH)

#19년, 20년의 송장 건수의 월별 평균
gs_19 <- gs %>% filter(YEAR == '2019') %>% group_by(MONTH, ADMD) %>% 
  mutate(MEAN_AMT = mean(AMT_IND)) %>% select(MONTH, PVN, BOR, ADMD, MEAN_AMT) %>% unique

gs_20 <- gs %>% filter(YEAR == '2020') %>% group_by(MONTH, ADMD) %>% 
  mutate(MEAN_AMT = mean(AMT_IND)) %>% select(MONTH, PVN, BOR, ADMD, MEAN_AMT) %>% unique

View(gs_19)
View(gs_20)

#월별로 데이터 나누기
gs_1902 <- gs_19 %>% filter(MONTH == '02')
gs_2002 <- gs_20 %>% filter(MONTH == '02')
gs_1903 <- gs_19 %>% filter(MONTH == '03')
gs_2003 <- gs_20 %>% filter(MONTH == '03')
gs_1904 <- gs_19 %>% filter(MONTH == '04')
gs_2004 <- gs_20 %>% filter(MONTH == '04')
gs_1905 <- gs_19 %>% filter(MONTH == '05')
gs_2005 <- gs_20 %>% filter(MONTH == '05')

#동별 매출지수 증감
gs_cha <- data.frame(PVN = gs_1902$PVN, BOR = gs_1902$BOR, ADMD = gs_1902$ADMD, 
                     RATE_02 = (gs_2002$MEAN_AMT - gs_1902$MEAN_AMT)/gs_1902$MEAN_AMT,
                     RATE_03 = (gs_2003$MEAN_AMT - gs_1903$MEAN_AMT)/gs_1903$MEAN_AMT,
                     RATE_04 = (gs_2004$MEAN_AMT - gs_1904$MEAN_AMT)/gs_1904$MEAN_AMT,
                     RATE_05 = (gs_2005$MEAN_AMT - gs_1905$MEAN_AMT)/gs_1905$MEAN_AMT)
write.csv(gs_cha,'C:/Users/mina/OneDrive/바탕 화면/공모전/GS/동별 매출지수 증감.csv')


### 지역별 평균 매출지수###
gs_19$REGION <- ifelse (gs_19$BOR == '중구', "중심지역","거주지역")
gs_20$REGION <- ifelse (gs_20$BOR == '중구', "중심지역","거주지역")

gs_region_19 <- gs_19 %>% group_by(REGION,MONTH) %>% summarise(MEAN_AMT=mean(MEAN_AMT))
gs_region_20 <- gs_20 %>% group_by(REGION,MONTH) %>% summarise(MEAN_AMT=mean(MEAN_AMT))

gs_region <- data.frame(REGION = gs_region_19$REGION, MONTH = gs_region_19$MONTH, 
                        MEAN_AMT = (gs_region_20$MEAN_AMT - gs_region_19$MEAN_AMT)/gs_region_19$MEAN_AMT)

write.csv(gs_region,'C:/Users/mina/OneDrive/바탕 화면/엑셀 (2)/지역별 매출지수 증감.csv')



