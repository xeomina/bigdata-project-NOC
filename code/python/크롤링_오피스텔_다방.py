# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 00:25:12 2020

@author: mina
"""

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import pyautogui
import pandas as pd

pyautogui.position()
driver = webdriver.Chrome("C:/Users/mina/Downloads/chromedriver_win32/chromedriver.exe")
driver.get("https://www.dabangapp.com/")
#서울 중구 오피스텔 매물 찾기
driver.find_element_by_xpath("/html/body/div[1]/div/div/div[1]/form/div/input").send_keys("서울 중구\n")
time.sleep(3)
driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[1]").click()
driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[2]/ul[1]/li[1]/label/span[1]").click()
driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[1]/div[2]/ul[1]/li[2]/label/span[1]").click()
driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[1]").click()
time.sleep(3)
driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/ul/li[2]/label/span[1]").click()
driver.find_element_by_xpath("/html/body/div[1]/div/div[1]/div/div[2]/div[2]/div[2]/ul/li[3]/label/span[1]").click()
time.sleep(3)


name_ot = []
rent_cs_ot = []
width_ot = []
notification_ot = []


for j in range(1,4):
    driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/div/div/div/ul/li["+str(j)+"]/a").click()
    time.sleep(3)

    for i in range(1,25):
        name=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(i)+"]/div/a/p[1]")
        rent_cs=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(i)+"]/div/a/p[2]")
        width=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(i)+"]/div/a/p[3]")
        notification=driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/ul/li["+str(i)+"]/div/a/p[4]")
        print(name.text)
        print(rent_cs.text)
        print(width.text)
        print(notification.text)
        print("++++++++++++++++++++++++++++++++++++")
        name_ot .append(name.text)
        rent_cs_ot.append(rent_cs.text)
        width_ot.append(width.text)
        notification_ot.append(notification.text)

    
driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[1]/div/div[2]/div/div/div/ul/li[2]/a").click()
time.sleep(3)

name_ot 
rent_cs_ot
width_ot
notification_ot


df = {'이름':name_ot,'임대료':rent_cs_ot,'임대면적': width_ot,'보증금': notification_ot}

gongmo_ot_seoul = pd.DataFrame(df)
print(gongmo_ot_seoul)    
gongmo_ot_seoul.to_csv("C:/temp/python/gongmo_Data_seoulofficetel.csv",encoding=('ANSI') )