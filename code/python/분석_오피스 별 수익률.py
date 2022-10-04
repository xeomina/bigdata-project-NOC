# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 00:40:28 2020

@author: mina
"""

# -*- coding: utf-8 -*-
"""
Created on Wed Sep  9 08:40:34 2020

@author: HP
"""

from selenium import webdriver
import time
import scipy as sp
import matplotlib.pyplot as plt
import pandas as pd
from tqdm import tqdm

near_average_rent_cost = []
near_average_depoist = []
officetel_IRR = []
NPV_expectation = []
probation = []

len(probation)

driver = webdriver.Chrome("C:/Users/mina/Downloads/chromedriver_win32/chromedriver.exe")
driver.get("https://www.dabangapp.com/")
gongmo_gee_burn=pd.read_csv("C:/Users/mina/Documents/카카오톡 받은 파일/gongmo_Data_gee_burn.csv", encoding="ANSI")
gongmo_gee_burn['위치']
time.sleep(3)

for i in tqdm(range(790,len(gongmo_gee_burn['위치']))):
    driver.get("https://www.dabangapp.com/")
    driver.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/form/div/input").send_keys(gongmo_gee_burn['위치'][i]+"\n")
    time.sleep(3)
    #월세랑 오피스텔만 찾는 걸로 클릭
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[2]/ul[1]/li[1]/label/span[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[2]/ul[1]/li[2]/label/span[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[1]").click()
    time.sleep(3)
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/ul/li[2]/label/span[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/ul/li[3]/label/span[1]").click()
    time.sleep(3)
    #첫 페이지에 매물이 몇 개나 있는지 확인
    aa=driver.find_elements_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li")
    number_of_dabang_list=len(aa)
    if number_of_dabang_list > 22 :
            number_of_dabang_list = 21
            
    officetel_cs = []
    width_ot = []
    for a in range (1,number_of_dabang_list-1):
        #임대료 가져오기
        try:
            rent_cs=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(a)+"]/div/a/p[2]")
        except:    
            rent_cs=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul[2]/li["+str(a)+"]/div/a/p[2]/span")
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        #면적 가져오기
        width=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(a)+"]/div/a/p[3]")
        officetel_cs.append(rent_cs.text.split("/"))
        width_ot.append(width.text.split(','))
    average_cost = 0
    average_deposit = 0
    
    #m²당 평균 임대료랑 평균 보증금 계산
    for j in range(0,len(officetel_cs)):
        cost_per_squaremeter=float(officetel_cs[j][1])/float(width_ot[j][1].replace("m²",""))
        deposit_per_squaremeter=float(officetel_cs[j][0].replace("월세 ","").replace("억","0000"))/float(width_ot[j][1].replace("m²",""))
        #1억5000만원이 넘으면 평균 값으로 계산해버림
        if deposit_per_squaremeter > 10000 :
            deposit_per_squaremeter = average_deposit
        average_cost+=cost_per_squaremeter
        average_deposit+=deposit_per_squaremeter
    print("해당 빌딩 근처의 m²당 평균 월세는:"+str(average_cost/(len(officetel_cs)+1))+"만원 입니다")
    near_average_rent_cost.append(average_cost/(len(officetel_cs)+1))
    print("해당 빌딩 근처의 m²당 평균 보증금은:"+str(average_deposit/(len(officetel_cs)+1))+"만원 입니다")
    near_average_depoist.append(average_deposit/(len(officetel_cs)+1))
    cashflows = [-130,average_deposit/(len(officetel_cs)+1)]
    investment_period = 40
        
    for monthly_cash_flow in range(1,investment_period+1):
        cashflows.append(average_cost/(len(officetel_cs)+1))
        
    inflation_rate = 0.006
    
    print("오피스텔 전환 시 내부 수익률 : "+str(sp.irr(cashflows)))
    officetel_IRR.append(sp.irr(cashflows))
    #if sp.irr(cashflows) > inflation_rate:
        #print("적합한 투자")
    print("기대할 수 있는 NPV 값 : "+str(sp.npv(inflation_rate, cashflows)))
    NPV_expectation.append(sp.npv(inflation_rate, cashflows))
    r = sp.irr(cashflows)
    print(sp.npv(r,cashflows))
    probation.append(sp.npv(r,cashflows))

officetel_cs    
    
df = {'주변 월세 시세':near_average_rent_cost,
      "주변 보증금 평균":near_average_depoist,
      "IRR":officetel_IRR,
      "NPV":NPV_expectation,"검증":probation}

gongmo_IRR = pd.DataFrame(df)
print(gongmo_IRR)    
gongmo_IRR.to_csv("C:/python.py/gongmo_IRR_8.csv",encoding=('ANSI') )
    

    
    
    