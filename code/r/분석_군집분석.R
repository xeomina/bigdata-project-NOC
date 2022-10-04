rm(list=ls())
library(dplyr)

library(party)


df<-read.csv(file='C:\\Users\\최지수\\Documents\\카카오톡 받은 파일\\gongmo_Data_gee_burn_modified (2).csv',header=TRUE)
tail(df)
df<-na.omit(df)
head(df)

is.na(df)
tail(df)

formula<-df$NPV~df$rent+df$deposit

npv_ctree<-ctree(formula,data=df)
npv_ctree


plot(npv_ctree)

####rpart#####
install.packages("rpart")
library(rpart)
npv_rpt<-rpart(formula,data=df)
plot(npv_rpt)
text(npv_rpt)
printcp(npv_rpt)
plotcp(npv_rpt)

npv_rpt_tree<-prune(npv_rpt, cp= npv_rpt$cptable[which.min(npv_rpt$cptable[,"xerror"]),"CP"])
plot(npv_rpt_tree)
text(npv_rpt_tree)
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(npv_rpt_tree)
