rm(list=ls())
###유동인구 추가#####
df4<-read.csv(file='C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\gongmo_IRR_chunggu.csv',header=TRUE)
df4<-df4[1:129,]
tail(df4)
df4<-rename(df4,rent=주변.월세.시세,deposit=주변.보증금.평균,movperson=유동인구)
tail(df4)
formula4<-NPV~rent+deposit+movperson
npv_rpt_4<-rpart(formula4,data=df4)
plot(npv_rpt_4)
text(npv_rpt_4)
printcp(npv_rpt_4)
plotcp(npv_rpt_4)

npv_rpt_tree_4<-prune(npv_rpt_4, cp= npv_rpt_4$cptable[which.min(npv_rpt_4$cptable[,"xerror"]),"CP"])
plot(npv_rpt_tree_4)
text(npv_rpt_tree_4)
prp(npv_rpt_tree,type=1)
