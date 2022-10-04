# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 00:36:13 2020

@author: mina
"""

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import pyautogui
import pandas as pd
pyautogui.position()
driver = webdriver.Chrome("C:/Users/mina/Downloads/chromedriver_win32/chromedriver.exe")
driver.get("https://www.rsquare.co.kr/")

time.sleep(3)
driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[1]/div[2]/div[1]/ul/li[1]/a").click()
driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[4]/div[2]/form/div[1]/div/p[1]/input").send_keys("tight729@naver.com") #알스퀘어 아이디
driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[4]/div[2]/form/div[1]/div/p[2]/input").send_keys("wind1021") #알스퀘어 비
driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[4]/div[2]/form/div[2]/button").click()
time.sleep(3)
driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[2]/div[1]/div[1]/div[1]/div[1]/div/form/div/div[1]/input").send_keys("서울특별시 중구\n")
time.sleep(3)
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
time.sleep(2)
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
time.sleep(2)
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
time.sleep(2)
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  
time.sleep(2)
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")  

direction_cs = []
rent_cs = []
width_cs = []
bojeung_cs = []

for i in range(1,201):
    direction=driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[2]/div[3]/div[2]/div/div/div/ul/div/li["+str(i)+"]/a/div[1]")
    rent_cost=driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[2]/div[3]/div[2]/div/div/div/ul/div/li["+str(i)+"]/a/dl/dd[4]")
    width=driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[2]/div[3]/div[2]/div/div/div/ul/div/li["+str(i)+"]/a/dl/dd[1]/em")
    bojeung=driver.find_element_by_xpath("/html/body/div[1]/div[1]/div/div/div[2]/div[3]/div[2]/div/div/div/ul/div/li["+str(i)+"]/a/dl/dd[3]")
    print(direction.text)
    print(rent_cost.text)
    print(width.text)
    print(bojeung.text)
    print("++++++++++++++++++++++"+str(i)+"+++++++++++++")
    direction_cs.append(direction.text)
    rent_cs.append(rent_cost.text)
    width_cs.append(width.text)
    bojeung_cs.append(bojeung.text)

direction_cs
rent_cs
width_cs
bojeung_cs

df = {'위치':direction_cs,'임대료':rent_cs,'임대면적': width_cs,'보증금': bojeung_cs}

gongmo = pd.DataFrame(df)
print(gongmo)    
gongmo.to_csv("C:/Users/Larry Baek/Desktop/python/gongmo_Data_대구중구.csv",encoding=('ANSI') )