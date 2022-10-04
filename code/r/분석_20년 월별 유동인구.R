rm(list=ls())

pop_2002_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/2020_2월_서울중구.csv')
pop_2003_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/2020_3월_서울중구.csv')
pop_2004_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/2020_4월_서울중구.csv')
pop_2005_raw <- read.csv('C:/Users/mina/OneDrive/바탕 화면/공모전/SK/2020_5월_서울중구.csv')

pop_2002 <- pop_2002_raw %>% select(X.1,X.2,X.3) %>% rename(DATE = X.1, DONG = X.2, MEAN = X.3) %>%
  group_by(DONG) %>% summarise(MEAN = mean(MEAN)) %>% unique %>% na.omit
pop_2003 <- pop_2003_raw %>% select(X.1,X.2,X.3) %>% rename(DATE = X.1, DONG = X.2, MEAN = X.3) %>%
  group_by(DONG) %>% summarise(MEAN = mean(MEAN)) %>% unique %>% na.omit
pop_2004 <- pop_2004_raw %>% select(X.1,X.2,X.3) %>% rename(DATE = X.1, DONG = X.2, MEAN = X.3) %>%
  group_by(DONG) %>% summarise(MEAN = mean(MEAN)) %>% unique %>% na.omit
pop_2005 <- pop_2005_raw %>% select(날짜, HDONG_NM, 요일별평균) %>% rename(DATE = 날짜, DONG = HDONG_NM, MEAN = 요일별평균) %>%
  group_by(DONG) %>% summarise(MEAN = mean(MEAN)) %>% unique %>% na.omit

pop_2020 <- data.frame(DONG =pop_2002$DONG, POP_02 = pop_2002$MEAN,
                       POP_03 = pop_2003$MEAN,POP_04 = pop_2004$MEAN,
                       POP_05 = pop_2005$MEAN)

write.csv(pop_2020,'C:/Users/mina/OneDrive/바탕 화면/공모전/SK/20년 월별 유동인구.csv')
