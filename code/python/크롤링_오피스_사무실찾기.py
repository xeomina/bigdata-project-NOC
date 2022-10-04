# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 00:40:35 2020

@author: mina
"""


from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import pyautogui
import pandas as pd
from bs4 import BeautifulSoup
import requests
import scipy as sp

building_name = input("빌딩이름을 입력하세요:")
driver = webdriver.Chrome("C:/Users/mina/Downloads/chromedriver_win32/chromedriver.exe")
driver.get("https://www.officefind.co.kr/")
time.sleep(2)
driver.find_element_by_xpath("/html/body/div[2]/div[2]/form/div/div[1]/div[2]/div[1]/div/div/input").send_keys(building_name+"\n")
time.sleep(2)
try:
    driver.find_element_by_xpath("/html/body/div[2]/div[2]/form/div/div[1]/div[5]/div[2]/div[1]/div[2]/h3/a").click()
except:
    print("존재하지 않는 빌딩이거나 해당 건물에 공실이 존재하지 않습니다.")
else:
    last_tab = driver.window_handles[-1]
    driver.switch_to.window(last_tab)
    time.sleep(2)
    office_direction=driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[1]/div[1]/h2/small")
    office_wid=driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[1]/table[2]/tbody/tr[3]/td/strong[2]")
    building_direction_dabang=office_direction.text
    available_studio=float(office_wid.text.replace("㎡","").replace(",",""))
    driver.get("https://www.dabangapp.com/")
    time.sleep(3)
    driver.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/form/div/input").send_keys(building_direction_dabang+"\n")
    time.sleep(3)
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[2]/ul[1]/li[1]/label/span[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[2]/ul[1]/li[2]/label/span[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[1]").click()
    time.sleep(3)
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/ul/li[2]/label/span[1]").click()
    driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/ul/li[3]/label/span[1]").click()
    time.sleep(3)
    aa=driver.find_elements_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li")
    number_of_dabang_list=len(aa)
    if number_of_dabang_list > 22 :
        number_of_dabang_list = 21
    officetel_cs = []
    width_ot = []
    for i in range (1,number_of_dabang_list):
        rent_cs=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(i)+"]/div/a/p[2]")
        width=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(i)+"]/div/a/p[3]")
        officetel_cs.append(rent_cs.text.split("/"))
        width_ot.append(width.text.split(','))
    average_cost = 0
    average_deposit = 0
    for j in range(0,len(officetel_cs)):
        cost_per_squaremeter=float(officetel_cs[j][1])/float(width_ot[j][1].replace("m²",""))
        deposit_per_squaremeter=float(officetel_cs[j][0].replace("월세 ","").replace("억","0000"))/float(width_ot[j][1].replace("m²",""))
        if deposit_per_squaremeter > 10000 :
            deposit_per_squaremeter = average_deposit
        average_cost+=cost_per_squaremeter
        average_deposit+=deposit_per_squaremeter

    print("총"+str(number_of_dabang_list-1)+"건의 데이터를 분석한 결과")
    print("오피스텔로 리모델링시 예상되는 비용은 한 개의 층에 대략"+str(available_studio*130)+"만원 입니다.")
    print("해당 빌딩 근처의 m²당 평균 월세는:"+str(average_cost/len(officetel_cs))+"만원 입니다")
    print("해당 빌딩 근처의 m²당 평균 보증금은:"+str(average_deposit/len(officetel_cs))+"만원 입니다")
    print("임대 가능한 오피스텔 호수 는 전용 면적 84m² 기준 1 층에"+str(available_studio/84)+"개 입니다.")
    print("오피스텔 전환시 최대 월세 수익은 한 개의 층 당"+str((average_cost/len(officetel_cs))*available_studio)+"만원 입니다.")



    cashflows = [-130,average_deposit/len(officetel_cs)]
    investment_period = 40
    
    for monthly_cash_flow in range(1,investment_period+1):
        cashflows.append(average_cost/len(officetel_cs))
    
    
    inflation_rate = 0.006   
    
    print("오피스텔 전환 시 내부 수익률 : "+str(sp.irr(cashflows)))
    if sp.irr(cashflows) > inflation_rate:
        print("적합한 투자")
        print("기대할 수 있는 NPV 값 : "+str(sp.npv(inflation_rate, cashflows)))
        r = sp.irr(cashflows)
        print(sp.npv(r,cashflows))
    else : 
        print("적합하지 않은 투자 입니다.")
    
    df = {'주변월세시세':average_cost/len(officetel_cs),
          '주변 보증금 평균':average_deposit/len(officetel_cs),
          'IRR': sp.irr(cashflows),
          'NPV': sp.npv(inflation_rate, cashflows),
          '검증':sp.npv(r,cashflows)}

gongmo = pd.DataFrame(df)
gongmo.to_csv("C:/Users/Larry Baek/Desktop/python/gongmo_Data.csv",encoding=('ANSI') )