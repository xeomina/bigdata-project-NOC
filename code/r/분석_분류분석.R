df <- read.csv("C:/Users/mina/desktop/office_return.csv",header=TRUE)
tail(df)
df <- na.omit(df)
head (df)
is.na (df)
tail (df)
formula <- df$NPV~df$rent+df$deposit

####rpart#####
npv_rpt <- rpart(formula,data=df)
plot(npv_rpt)
text(npv_rpt)
printcp(npv_rpt)
plotcp(npv_rpt)











