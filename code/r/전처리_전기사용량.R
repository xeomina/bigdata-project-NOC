rm(list=ls())

#201902
ele_1902_raw <- read.table('C:/Users/mina/Desktop/전기/2019/지번별_전기_201902.txt', header = F, sep = '|')

ele_1902 <- ele_1902_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_1902 <- ele_1902 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
         '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)

View(ele_1902)

#201903
ele_1903_raw <- read.table('C:/Users/mina/Desktop/전기/2019/지번별_전기_201903.txt', header = F, sep = '|')

ele_1903 <- ele_1903_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_1903 <- ele_1903 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_1903)


#201904
ele_1904_raw <- read.table('C:/Users/mina/Desktop/전기/2019/지번별_전기_201904.txt', header = F, sep = '|')

ele_1904 <- ele_1904_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_1904 <- ele_1904 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_1904)


#201905
ele_1905_raw <- read.table('C:/Users/mina/Desktop/전기/2019/지번별_전기_201905.txt', header = F, sep = '|')

ele_1905 <- ele_1905_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_1905 <- ele_1905 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_1905)

############################################################################

#202002
ele_2002_raw <- read.table('C:/Users/mina/Desktop/전기/2020/지번별_전기_202002.txt', header = F, sep = '|')

ele_2002 <- ele_2002_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_2002 <- ele_2002 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_2002)

#202003
ele_2003_raw <- read.table('C:/Users/mina/Desktop/전기/2020/지번별_전기_202003.txt', header = F, sep = '|')

ele_2003 <- ele_2003_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_2003 <- ele_2003 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_2003)

#202004
ele_2004_raw <- read.table('C:/Users/mina/Desktop/전기/2020/지번별_전기_202004.txt', header = F, sep = '|')

ele_2004 <- ele_2004_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_2004 <- ele_2004 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_2004)

#202005
ele_2005_raw <- read.table('C:/Users/mina/Desktop/전기/2020/지번별_전기_202005.txt', header = F, sep = '|')

ele_2005 <- ele_2005_raw %>% filter(V5 == '서울특별시') %>% select(V1,V5,V6,V7,V9,V10,V11,V12,V17) 
ele_2005 <- ele_2005 %>%  rename('사용년월'= V1,'시도명'=V5,'시군구명'=V6,'법정동명'=V7,'본번'=V9,
                                 '부번'=V10,'새주소코드'=V11,'새주소명'=V12,'사용량'=V17)
View(ele_2005)


############################################################################

ele_02_out <- merge (x = ele_1902,  +  y = ele_2002,  +  by = '본번','부번',  +  all = TRUE)








































