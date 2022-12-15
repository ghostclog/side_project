from bs4 import BeautifulSoup
from requests import get

#데이터 변수들

game_url = [
    "https://www.inven.co.kr/webzine/news/?news=279278",
    "https://www.inven.co.kr/webzine/news/?news=279291",
    "https://www.inven.co.kr/webzine/news/?news=279276",
    "https://www.inven.co.kr/webzine/news/?news=279270",
    "https://www.inven.co.kr/webzine/news/?news=279269",
    "https://www.inven.co.kr/webzine/news/?news=279262",
    "https://www.inven.co.kr/webzine/news/?news=279245",
    "https://www.inven.co.kr/webzine/news/?news=279257",
    "https://www.inven.co.kr/webzine/news/?news=279252",
    "https://www.inven.co.kr/webzine/news/?news=279250",
    "https://www.inven.co.kr/webzine/news/?news=279246",
    "https://www.inven.co.kr/webzine/news/?news=279197",
    "https://www.inven.co.kr/webzine/news/?news=279183",
    "https://www.inven.co.kr/webzine/news/?news=279145",
    "https://www.inven.co.kr/webzine/news/?news=279143",
    "https://www.inven.co.kr/webzine/news/?news=279137",
    "https://www.inven.co.kr/webzine/news/?news=279115",
    "https://www.inven.co.kr/webzine/news/?news=279118",
    "https://www.inven.co.kr/webzine/news/?news=279116",
    "https://www.inven.co.kr/webzine/news/?news=279114",
    "https://www.inven.co.kr/webzine/news/?news=279112",
    "https://www.inven.co.kr/webzine/news/?news=279111",
    "https://www.inven.co.kr/webzine/news/?news=279089",
    "https://www.inven.co.kr/webzine/news/?news=279086",
    "https://www.inven.co.kr/webzine/news/?news=279081",
    "https://www.inven.co.kr/webzine/news/?news=279082",
    "https://www.inven.co.kr/webzine/news/?news=279014"
]

print(len(game_url))

for i in game_url:
    response = get(f"{i}")
    if response.status_code != 200:  #사이트 미 응답시
        print("cannot request website")
    else:  #홈페이지 html 데이터 추출
        soup = BeautifulSoup(response.text, "html.parser")
        news_title = soup.find("div", class_="title").text
        news_title = news_title.replace("\n","")
        news_time = soup.find("dl", class_="date")
        news_time = news_time.find("dd").text

        #따옴표 붙이기
        news_title = news_title.replace('"', "'")
        news_title = '"' + news_title + '"'
        news_time = '"' + news_time + '"'
        url = '"' + i + '"'

    file = open("GameNews.sql", "a")

    file.write(
        f"insert into News(headline,news_url,news_time) values({news_title},{url},{news_time});\n"
    )

    file.close()
