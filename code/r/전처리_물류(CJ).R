rm(list=ls())

library(readxl)
library(dplyr)

#데이터 가져오기
cj_raw <- read_excel("C:/Users/mina/OneDrive/바탕 화면/엑셀 (2)/05_물류데이터(CJ올리브네트웍스)/2020 빅콘테스트_CJ올리브네트웍스_제공DB.xlsx")

cj_raw_2 <- cj_raw %>% mutate(DL_YMD =  paste0('20', as.character(DL_YMD))) %>% mutate(DATE = as.Date(DL_YMD, "%Y%m%d"))

cj <- cj_raw_2 %>% mutate(YEAR = format(as.Date(DATE), "%Y"), MONTH = format(as.Date(DATE), "%m")) %>% 
  select(YEAR, MONTH, CTPV_NM, CTGG_NM, HDNG_NM, INVC_CONT)

#19년, 20년의 송장 건수의 월별 평균
cj_19 <- cj %>% filter(YEAR == '2019') %>% group_by(MONTH, HDNG_NM) %>% 
  mutate(MEAN_INVC = mean(INVC_CONT)) %>% select(MONTH, CTPV_NM, CTGG_NM, HDNG_NM, MEAN_INVC) %>% unique
cj_20 <- cj %>% filter(YEAR == '2020') %>% group_by(MONTH, HDNG_NM) %>% 
  mutate(MEAN_INVC = mean(INVC_CONT)) %>% select(MONTH, CTPV_NM, CTGG_NM, HDNG_NM, MEAN_INVC) %>% unique

#월별로 데이터 나누기
cj_1902 <- cj_19 %>% filter(MONTH == '02')
cj_2002 <- cj_20 %>% filter(MONTH == '02')
cj_1903 <- cj_19 %>% filter(MONTH == '03')
cj_2003 <- cj_20 %>% filter(MONTH == '03')
cj_1904 <- cj_19 %>% filter(MONTH == '04')
cj_2004 <- cj_20 %>% filter(MONTH == '04')
cj_1905 <- cj_19 %>% filter(MONTH == '05')
cj_2005 <- cj_20 %>% filter(MONTH == '05')

#동별 송장건수 증감
cj_cha <- data.frame(CTPV_NM = cj_1902$CTPV_NM, CTGG_NM = cj_1902$CTGG_NM, HDNG_NM = cj_1902$HDNG_NM, 
                     RATE_02 = (cj_2002$MEAN_INVC - cj_1902$MEAN_INVC)/cj_1902$MEAN_INVC,
                     RATE_03 = (cj_2003$MEAN_INVC - cj_1903$MEAN_INVC)/cj_1903$MEAN_INVC,
                     RATE_04 = (cj_2004$MEAN_INVC - cj_1904$MEAN_INVC)/cj_1904$MEAN_INVC,
                     RATE_05 = (cj_2005$MEAN_INVC - cj_1905$MEAN_INVC)/cj_1905$MEAN_INVC)

write.csv(cj_cha,'C:/Users/mina/OneDrive/바탕 화면/엑셀 (2)/동별 송장건수 증감.csv')


### 지역별 평균 송장건수###
cj_19$REGION <- ifelse (cj_19$CTGG_NM == '중구', "중심지역","거주지역")
cj_20$REGION <- ifelse (cj_20$CTGG_NM == '중구', "중심지역","거주지역")

cj_region_19 <- cj_19 %>% group_by(REGION,MONTH) %>% summarise(MEAN_INVC=mean(MEAN_INVC))
cj_region_20 <- cj_20 %>% group_by(REGION,MONTH) %>% summarise(MEAN_INVC=mean(MEAN_INVC))

cj_region <- data.frame(REGION = cj_region_19$REGION, MONTH = cj_region_19$MONTH, 
                     RATE_INVC = (cj_region_20$MEAN_INVC - cj_region_19$MEAN_INVC)/cj_region_19$MEAN_INVC)

write.csv(cj_region,'C:/Users/mina/OneDrive/바탕 화면/엑셀 (2)/지역별 송장건수 증감.csv')
