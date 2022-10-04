# -*- coding: utf-8 -*-
"""
Created on Thu Sep 10 13:23:58 2020

@author: mina
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Aug 27 09:30:00 2020

@author: student
"""

import numpy as np
import pandas as pd

seoul = pd.read_csv('C:/Users/mina/OneDrive/바탕 화면/공모전/gongmo_Data_gee_burn_modified.csv', 
                                thousands=',', #, 없애기
                                encoding = 'euc-kr')
seoul.head()
seoul.index
seoul.columns
seoul.values
seoul.info()
seoul.describe()

#pip install googlemaps

import googlemaps

gmaps_key = "" #자신의 key를 사용합니다
gmaps = googlemaps.Client(key = gmaps_key)


####------------------------------------

seoul_raw = pd.read_csv('C:/Users/mina/OneDrive/바탕 화면/공모전/gongmo_Data_gee_burn_modified.csv', 
                             encoding ='euc-kr',index_col=0) #unnamed 컬럼 빼기
seoul_raw.head()
seoul_raw.index
seoul_raw.columns
seoul_anal = pd.pivot_table(seoul_raw,index="구",aggfunc = np.mean)
seoul_anal.head()




######################################[2-7] 시각화 도구 Seaborn
#pip install seaborn
import matplotlib.pyplot as plt
import seaborn as sns
import platform

path = "c:/Windows/Fonts/malgun.ttf"
from matplotlib import font_manager, rc
if platform.system() == 'Darwin':
    rc('font', family='AppleGothic')
elif platform.system() == 'Windows':
    font_name = font_manager.FontProperties(fname=path).get_name()
    rc('font', family=font_name)
else:
    print('Unknown system... sorry~~~~')
############################################################################상관관계
'''
sns.pairplot(crime_anal_norm, vars = ['강도','살인','폭력'],kind = 'reg', size = 3)
plt.show()

sns.pairplot(crime_anal_norm, x_vars = ['인구수','CCTV'], y_vars = ['살인','강도'], kind = 'reg', size = 3)
plt.show()

sns.pairplot(crime_anal_norm, x_vars = ['인구수','CCTV'], y_vars = ['살인검거율','폭력검거율'], kind = 'reg', size = 3)
plt.show() #양의 상관관계 X

tmp_max = crime_anal_norm['검거'].max()
crime_anal_norm['검거'] = crime_anal_norm['검거'] / tmp_max * 100 #검거 항목 최고값 100으로 한정
crime_anal_norm_sort = crime_anal_norm.sort_values(by='검거',ascending=False)
crime_anal_norm_sort.head()
'''
#[79]
target_col = ['주변 월세 시세', '주변 보증금 평균', 'IRR', 'NPV']
seoul_anal_sort = seoul_anal.sort_values(by='구',ascending=False)

plt.figure(figsize = (10,10))
sns.heatmap(seoul_anal_sort[target_col], annot=True, fmt='f', linewidths=.5, fill_color = 'YlGnBu')
plt.title('구로 정렬')
plt.show()

######################################[2-9] 지도 시각화 도구 Folium
#pip install folium
import folium
import pandas as pd
import json
geo_path = 'C:/Users/mina/temp/Python/data/02. skorea_municipalities_geo_simple.json'
geo_str = json.load(open(geo_path,encoding='utf-8'))

#제곱미터당 주변 월세 시세 지도 시각화
map = folium.Map(location=[37.5502, 126.982], zoom_start=11, tiles='Stamen Toner')
map.choropleth(geo_data = geo_str, data = seoul_anal['주변 월세 시세'],
               columns = [seoul_anal.index, seoul_anal['주변 월세 시세']],
               fill_color = 'YlGnBu', 
               key_on = 'feature.id') 
map.save("C:/Users/mina/OneDrive/바탕 화면/공모전/주변 월세 시세.html")

#제곱미터당 주변 보증금 평균 지도 시각화
map = folium.Map(location=[37.5502, 126.982], zoom_start=11, tiles='Stamen Toner')
map.choropleth(geo_data = geo_str, data = seoul_anal['주변 보증금 평균'],
               columns = [seoul_anal.index, seoul_anal['주변 보증금 평균']],
               fill_color = 'YlGnBu', 
               key_on = 'feature.id') 
map.save("C:/Users/mina/OneDrive/바탕 화면/공모전/주변 보증금 평균.html")

#NPV 지도 시각화
map = folium.Map(location=[37.5502, 126.982], zoom_start=11, tiles='Stamen Toner')
map.choropleth(geo_data = geo_str, data = seoul_anal['NPV'],
               columns = [seoul_anal.index, seoul_anal['NPV']],
               fill_color = 'YlGnBu', 
               key_on = 'feature.id') 
map.save("C:/Users/mina/OneDrive/바탕 화면/공모전/NPV.html")


#IRR 지도 시각화
map = folium.Map(location=[37.5502, 126.982], zoom_start=11, tiles='Stamen Toner')
map.choropleth(geo_data = geo_str, data = seoul_anal['IRR'],
               columns = [seoul_anal.index, seoul_anal['IRR']],
               fill_color = 'YlGnBu', 
               key_on = 'feature.id') 
map.save("C:/Users/mina/OneDrive/바탕 화면/공모전/IRR.html")

################################################################
import folium
import pandas as pd
from tqdm import tqdm

map_osm=folium.Map(location=[37.566345, 126.977893])
map_osm.save('C:/Users/mina/OneDrive/바탕 화면/공모전/map_a.html')

seoul_raw.columns
seoul_raw.head()

building_name = []

for name in  tqdm(seoul_raw['이름']):
    building_name.append(name)

len(building_name)

building_lat = []
building_lng = []

for name in  tqdm(seoul_raw['빌딩 위도']):
   building_lat.append(name)
   
for name in  tqdm(seoul_raw['빌딩 경도']):
   building_lng.append(name)

for i in tqdm(range(0,len(building_name))):    
    folium.Marker([building_lat[i],building_lng[i]]).add_to(map_osm)
   
map_osm.save('C:/Users/mina/OneDrive/바탕 화면/공모전/map_b.html')

#######################################################################
#seoul_anal['빌딩 위도'] = building_lat
#seoul_anal['빌딩 경도'] = building_lng
'''
col = ['주변 월세 시세', '주변 보증금 평균', 'IRR', 'NPV']
tmp = crime_anal_raw[col] / crime_anal_raw[col].max()  
crime_anal_raw['검거'] = np.sum(tmp, axis=1)
crime_anal_raw.head()

#경찰서 위도와 경도로 위치 확인
map = folium.Map(location=[37.5502, 126.982], zoom_start=11)
for n in seoul_raw.index:
    folium.Marker([building_lat[n], 
                   building_lng[n]]).add_to(map) 
    
map.save("c:/temp/Python/data/경찰서 위치.html")'''

#오피스 위도와 경도로 위치 확인
for i in tqdm(range(0,len(building_name))):    
    folium.Marker([building_lat[i],building_lng[i]]).add_to(map_osm)
   
map_osm.save('C:/Users/mina/OneDrive/바탕 화면/공모전/오피스 위치.html')

#[79]
target_col = ['주변 월세 시세', '주변 보증금 평균', 'IRR', 'NPV']
seoul_anal_sort = seoul_anal.sort_values(by='구',ascending=False)

plt.figure(figsize = (10,10))
sns.heatmap(seoul_anal_sort[target_col], annot=True, fmt='f', linewidths=.5, fill_color = 'YlGnBu')
plt.title('구로 정렬')
plt.show()

#오피스 매물 원의 넓이로 표현하기
for i in tqdm(range(0,len(building_name))):    
    folium.CircleMarker([building_lat[i],building_lng[i]],
                         color='#3186cc', fill_color='#3186cc', fill=True).add_to(map_osm)
map_osm.save('C:/Users/mina/OneDrive/바탕 화면/공모전/오피스 위치2.html')
    
map = folium.Map(location=[37.5502, 126.982], zoom_start=11)
for n in seoul_raw.index:
    folium.CircleMarker([building_lat[n], building_lng[n]], 
                        radius = crime_anal_raw['검거'][n]*10, 
                        color='#3186cc', fill_color='#3186cc', fill=True).add_to(map)
    
map.save('c:/temp/Python/data/경찰서별 검거율.html')

#범죄 발생 건수 추가
map = folium.Map(location=[37.5502, 126.982], zoom_start=11)
map.choropleth(geo_data = geo_str, data = crime_anal_norm['범죄'],
               columns = [crime_anal_norm.index, crime_anal_norm['범죄']],
               fill_color = 'PuRd', #PuRd, YlGnBu
               key_on = 'feature.id')

for n in crime_anal_raw.index:
    folium.CircleMarker([crime_anal_raw['lat'][n], crime_anal_raw['lng'][n]], 
                        radius = crime_anal_raw['검거'][n]*10, 
                        color='#3186cc', fill_color='#3186cc', fill=True).add_to(map)
    
map.save("c:/temp/Python/data/경찰서별 검거율과 범죄 발생 건수.html")








