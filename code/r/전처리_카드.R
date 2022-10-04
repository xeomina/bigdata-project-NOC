rm=list(ls())

library(readxl)
card_resident<-read.table("G:\\내 드라이브\\2020 빅데이터 콘테스트\\4. data analysis\\0. data cleaning\\02_card_sales\\CARD_SPENDING_RESIDENT.txt",header = T)

#####데이터 가져오고###
card_resident2<-card_resident
card_resident
View(card_resident2)
card_resident2$STD_DD2<-as.Date(as.character(card_resident2$STD_DD),'%Y%m%d')
install.packages("lubridate")
library(lubridate)
card_resident2$corona<-ifelse(card_resident2$STD_DD2<as.Date('2020-02-01'),"bf","af")
card_resident2$month<-month(card_resident2$STD_DD2)

head(card_resident2)
tail(card_resident2)
View(card_resident2)
write.csv(card_resident2,'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\card_resident2.csv')

##코로나 이전 이후 데이터에서 평균 소비금액###
library(dplyr)

mean_bf_corona<-card_resident2 %>% filter(corona=="bf") %>% group_by(month(STD_DD2))%>% summarise(mean_cat=mean(USE_AMT))
mean_bf_corona
View(mean_bf_corona)


mean_af_corona<-card_resident2 %>% filter(corona=="af") %>% group_by(month(STD_DD2))%>% summarise(mean_cat=mean(USE_AMT))
mean_af_corona
View(mean_af_corona)


#소비금액 증감율 추가해주기##
merge_bf_af<-merge(mean_bf_corona,mean_af_corona,by="month(STD_DD2)")
merge_bf_af

##증감률 계산식 코로나 이후-코로나이전/코로나 이전 *100###

merge_bf_af$incre<-(merge_bf_af$mean_cat.y-merge_bf_af$mean_cat.x)/merge_bf_af$mean_cat.x*100
merge_bf_af

##소비건수###
mean_bf_cnt_corona<-card_resident2 %>% filter(corona=="bf") %>% group_by(month(STD_DD2))%>% summarise(mean_cat=mean(USE_CNT))
mean_bf_cnt_corona
View(mean_bf_cnt_corona)

### 지역별 평균소비금액###

card_resident2$region<-ifelse(card_resident2$GU_CD==140 | card_resident2$GU_CD==110, "center","residential")
tail(card_resident2)

library(dplyr)
mean_region<-card_resident2 %>% filter(corona=="bf") %>% group_by(region,month) %>% summarise(mean_cat=mean(USE_AMT))
View(mean_region)
mean_region_af<-card_resident2 %>% filter(corona=="af") %>% group_by(region,month) %>% summarise(mean_cat=mean(USE_AMT))
View(mean_region_af)


View(card_resident2)
View(mean__region)
####지역별 평균소비건수 

library(dplyr)


mean_region_gun<-card_resident2 %>% filter(corona=="bf") %>% group_by(region,weekdays,month) %>% summarise(mean_cat=mean(USE_CNT))
mean_region_run_af<-card_resident2 %>% filter(corona=="af") %>% group_by(region,weekdays,month) %>% summarise(mean_cat=mean(USE_CNT))

View(mean_region_gun)
View(mean_region_run_af)
weekdays(card_resident2$STD_DD2)
card_resident2$STD_DD2





##주중과 주말 평균 소비금액, 소비건수#####
card_resident2$weekdays<-ifelse(weekdays(card_resident2$STD_DD2)=="토요일"|weekdays(card_resident2$STD_DD2)=="일요일","주말","평일")
View(card_resident2)
##주말주중 평균소비건수##
mean_weekday_bf<-card_resident2 %>% filter(corona=="bf") %>% group_by(weekdays,month) %>% summarise(mean_cat=mean(USE_CNT))
View(mean_weekday_bf)
mean_weekday_af<-card_resident2 %>% filter(corona=="af") %>% group_by(weekdays,month) %>% summarise(mean_cat=mean(USE_CNT))
View(mean_weekday_af)


###주말과 주중 평균 소비금액####
mean_weekday_bf_AMT<-card_resident2 %>% filter(corona=="bf") %>% group_by(region,weekdays,month) %>% summarise(mean_cat=mean(USE_AMT))
View(mean_weekday_bf_AMT)
mean_weekday_af_amt<-card_resident2 %>% filter(corona=="af") %>% group_by(region,weekdays,month) %>% summarise(mean_cat=mean(USE_AMT))
View(mean_weekday_af_amt)

mean_weekday_bf_AMT<-card_resident2 %>% filter(corona=="bf") %>% group_by(region,weekdays,month) %>% summarise(mean_cat=mean(USE_CNT))
View(mean_weekday_bf_CNT)
mean_weekday_af_amt<-card_resident2 %>% filter(corona=="af") %>% group_by(region,weekdays,month) %>% summarise(mean_cat=mean(USE_CNT))
View(mean_weekday_af_CNT)

mean_af_cnt<-card_resident2 %>% filter(corona=="af") %>% group_by(month(STD_DD2))%>% summarise(mean_cat=mean(USE_CNT))
mean_af_cnt
View(mean_af_cnt)


merge_bf_af_cnt<-merge(mean_bf_cnt_corona,mean_af_cnt,by="month(STD_DD2)")
merge_bf_af_cnt
merge_bf_af_cnt$incre<-(merge_bf_af_cnt$mean_cat.y-merge_bf_af_cnt$mean_cat.x)/merge_bf_af_cnt$mean_cat.x*100

##업종별 월별 평균소비건수##

mean_industry_bf_cnt<-card_resident2 %>% filter(corona=="bf") %>% group_by(MCT_CAT_CD,month) %>% summarise(mean_cat=mean(USE_CNT))

View(mean_industry_bf_cnt)
write.csv(mean_industry_bf_cnt,'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\mean_industry_bf_cnt.csv')
mean_industry_af_cnt<-card_resident2 %>% filter(corona=="af") %>% group_by(MCT_CAT_CD,month) %>% summarise(mean_cat=mean(USE_CNT))
View(mean_industry_af_cnt)
write.csv(mean_industry_af_cnt,'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\mean_industry_af_cnt.csv')

###성별별 평균 소비건수###

sex_corona_bf_cnt<-card_resident2 %>% filter(corona=="bf") %>% group_by(SEX_CD,month) %>% summarise(mean_cat=mean(USE_CNT))
View(sex_corona_bf_cnt)
sex_corona_af_cnt<-card_resident2 %>% filter(corona=="af") %>% group_by(SEX_CD,month) %>% summarise(mean_cat=mean(USE_CNT))
View(sex_corona_af_cnt)


###나이대별 평균소비건수####
library(dplyr)
card_resident2
age_corona_bf<-card_resident2 %>% filter(corona=="bf") %>% group_by(age_range,month) %>% summarise(mean_cat=mean(USE_CNT))
View(age_corona_bf)
write.csv(age_corona_bf, 'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\age_corona_bf.csv')

write.csv(age_corona_af, 'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\age_corona_af.csv')

age_corona_af<-card_resident2 %>% filter(corona=="af") %>% group_by(age_range,month) %>% summarise(mean_cat=mean(USE_CNT))
View(age_corona_af)




##코로나 이전이후 데이터에서 업종코드 별 월별 평균 소비금액####
mean_industry_bf_corona<-card_resident2 %>% filter(corona=="bf") %>% group_by(MCT_CAT_CD,month) %>% summarise(mean_cat=mean(USE_AMT))

View(mean_industry_bf_corona)

mean_industry_af_corona<-card_resident2 %>% filter(corona=="af") %>% group_by(MCT_CAT_CD,month) %>% summarise(mean_cat=mean(USE_AMT))
View(mean_industry_af_corona)
write.csv()
##코로나 이전 이후 데이터 합쳐서 소비금액증가률보기##
merge_industry_bf_af<-merge(mean_industry_bf_corona,mean_industry_af_corona,by="MCT_CAT_CD","month")
write.csv(mean_industry_af_corona, 'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\corona_industry_af.csv')

merge_bf_af$incre<-(merge_bf_af$mean_cat.y-merge_bf_af$mean_cat.x)/merge_bf_af$mean_cat.x*100
merge_bf_af

#####코로나 이전이후 성별별 소비금액####
sex_corona_bf<-card_resident2 %>% filter(corona=="bf") %>% group_by(SEX_CD,month) %>% summarise(mean_cat=mean(USE_AMT))
View(sex_corona)
sex_corona_af<-card_resident2 %>% filter(corona=="af") %>% group_by(SEX_CD,month) %>% summarise(mean_cat=mean(USE_AMT))
View(sex_corona_af)


####코로나 이전 이후 나이대별 평균소비금액###
card_resident2$age_range<-ifelse(card_resident2$AGE_CD<30,20,ifelse(card_resident2$AGE_CD<40,30,ifelse(card_resident2$AGE_CD<50,40,ifelse(card_resident2$AGE_CD<60,50,60))))
card_resident2$age_range
age_corona_bf<-card_resident2 %>% filter(corona=="bf") %>% group_by(age_range,month) %>% summarise(mean_cat=mean(USE_AMT))
View(age_corona_bf)
write.csv(age_corona_bf, 'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\age_corona_bf.csv')

write.csv(age_corona_af, 'C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\age_corona_af.csv')

age_corona_af<-card_resident2 %>% filter(corona=="af") %>% group_by(age_range,month) %>% summarise(mean_cat=mean(USE_AMT))
View(sex_corona_af)

###코로나 이전의 데이터와 코로나 이후 데이터의 이용금액 차이##
##연구가설: 코로나 전후 집단에 따라 이용금액의 차이가 있다. ##
##귀무가설: 코로나 전후 집단에 따라 이용금액의 차이가 없다.##
corona_bf<-subset(card_resident2,card_resident2$corona=="bf")
View(corona_bf)
corona_af<-subset(card_resident2,card_resident2$corona=="af")
bf_amtuse<-corona_bf$USE_AMT
af_amtuse<-corona_af$USE_AMT
View(bf_amtuse)

var.test(bf_amtuse,af_amtuse)
t.test(bf_amtuse,af_amtuse,alter="two.sided",conf.int=TRUE,conf.level=0.95)
t.test(bf_amtuse,af_amtuse,var.equal=T,alter="greater",conf.int=TRUE,conf.level=0.95)
######

##코로나 이전 데이터에서 나이대별 평균 소비금액###
library(dplyr)
card_resident2$age_range<-ifelse(card_resident2$AGE_CD<30,20,ifelse(card_resident2$AGE_CD<40,30,ifelse(card_resident2$AGE_CD<50,40,ifelse(card_resident2$AGE_CD<60,50,60))))
card_resident2$age_range
head(card_resident2$age_range)
mean_bf_corona_age_range<-card_resident2 %>% filter(corona=="bf") %>% group_by(age_range)%>% summarise(mean_age_cat=mean(USE_AMT))
mean_bf_corona_age_range
View(mean_bf_corona_age_range)

##코로나 이후 데이터에서 나이대별 별 평균 소비금액####

mean_af_corona_age_range<-card_resident2 %>% filter(corona=="af") %>% group_by(age_range)%>% summarise(mean_age_cat=mean(USE_AMT))
mean_af_corona_age_range
View(mean_af_corona_age_range)


##코로나 이전 이후 데이터 합쳐서 나이대별 소비금액증가률보기##
merge_age_bf_af_range<-merge(mean_bf_corona_age_range,mean_af_corona_age_range,by="age_range")
merge_age_bf_af_range
merge_age_bf_af_range$incre<-(merge_age_bf_af_range$mean_age_cat.y-merge_age_bf_af_range$mean_age_cat.x)/merge_age_bf_af_range$mean_age_cat.x*100
merge_age_bf_af_range


##코로나 이전데이터에서 연령대별 이용금액 차이###
install.packages("stats")
library(stats)

x<-table(card_resident2$age_range)
x
y<-tapply(card_resident2$USE_AMT,card_resident2$age_range,mean)
y
corona_bf
bartlett.test(USE_AMT~age_range,data=corona_bf)
kruskal.test(data=corona_bf,USE_AMT~age_range)

age_20<-corona_bf %>% filter(age_range==20) %>% select(USE_AMT)
plot(age_20)

##성별별 코로나 이전 이후 평균소비금액##
mean_sex_bf<-card_resident2 %>% filter(corona=="bf") %>% group_by(SEX_CD) %>% summarise(mean_sex=mean(USE_AMT))
mean_sex_bf
View(mean_sex_bf)
mean_sex_af<-card_resident2 %>% filter(corona=="af") %>% group_by(SEX_CD) %>% summarise(mean_sex=mean(USE_AMT))
mean_sex_af
View(mean_sex_af)
merge_sex_bf_af<-merge(mean_sex_bf,mean_sex_af,by="SEX_CD")
merge_sex_bf_af
merge_sex_bf_af$incre<-(merge_sex_bf$mean_sex_cat.y-merge_age_bf_af_range$mean_age_cat.x)/merge_age_bf_af_range$mean_age_cat.x*100
merge_age_bf_af