from bs4 import BeautifulSoup
from requests import get

game_url = "https://store.steampowered.com/app/381210/Dead_by_Daylight/?l=koreana"
#입력 안함
ko_name = '"' + "데드 바이 데이라이트" + '"'

response = get(f"{game_url}")

#데이터 변수들
game_info = ""
game_name = ""
game_tag = ""
game_min_spec = ""
game_nomal_spec = ""
pbulish_date = ""

if response.status_code != 200:  #사이트 미 응답시
    print("cannot request website")
else:  #홈페이지 html 데이터 추출
    soup = BeautifulSoup(response.text, "html.parser")

    #사용 할 데이터 추출(태그 정보)
    game_tag_list = soup.find("div", class_="glance_tags popular_tags")
    game_tag_list = game_tag_list.find_all("a")
    for i in game_tag_list:
        a = i.text.replace('\n', "")
        a = a.replace('\r', "")
        a = a.replace('\t', "")
        game_tag = game_tag + " " + a
    game_tag = '"' + game_tag + '"'

    #사용 할 데이터 추출(출시일 정보)
    pbulish_date = soup.find("div", class_="date").text
    pbulish_date = pbulish_date.replace(" ", "")
    pbulish_date = pbulish_date.replace("년", "-")
    pbulish_date = pbulish_date.replace("월", "-")
    pbulish_date = pbulish_date.replace("일", "")
    pbulish_date = '"' + pbulish_date + '"'

    #최소 권장 존재 여부 확인용.
    game_spec = soup.find("div", class_="game_area_sys_req_rightCol")
    #요구 사양이 하나일 경우.
    if (game_spec is None):
        game_spec = soup.find("div", class_="game_area_sys_req_full")
        game_spec = game_spec.find_all("li")
        for i in game_spec:
            a = i.text.replace('\n', "")
            a = a.replace('\r', "")
            a = a.replace('\t', "")
            game_nomal_spec = game_nomal_spec + " " + a
        game_nomal_spec = '"' + game_nomal_spec + '"'
        game_min_spec = '"' + "없음." + '"'
    else:  #요구 사양이 최소 권장으로 나뉠 경우.
        #사용 할 데이터 추출(최소사양 정보)
        game_spec = soup.find("div", class_="game_area_sys_req_rightCol")
        game_spec = game_spec.find_all("li")
        for i in game_spec:
            a = i.text.replace('\n', "")
            a = a.replace('\r', "")
            a = a.replace('\t', "")
            game_nomal_spec = game_nomal_spec + " " + a
        game_nomal_spec = '"' + game_nomal_spec + '"'

        #사용 할 데이터 추출(권장사양 정보)
        game_spec = soup.find("div", class_="game_area_sys_req_leftCol")
        game_spec = game_spec.find_all("li")
        for i in game_spec:
            a = i.text.replace('\n', "")
            a = a.replace('\r', "")
            a = a.replace('\t', "")
            game_min_spec = game_min_spec + " " + a
        game_min_spec = '"' + game_min_spec + '"'

    #사용 할 데이터 추출(게임에 대한 상세 정보)
    game_info = soup.find("div", id="aboutThisGame")
    game_info = game_info.text.replace('\t', "")
    game_info = '"' + game_info + '"'

    #사용 할 데이터 추출(게임 이름 정보)
    game_name = soup.find("div", class_="apphub_AppName").text.replace('®', "")
    game_name = game_name.replace('™', "")
    game_name = '"' + game_name + '"'

file = open("GameData.sql", "a")

file.write(
    f"insert into game(GMAE_INFO,CODE_TYPE,PUBLSH_DATE,KOR_NAME,ENG_NAME,MIN_SPEC,SEPC,DEFAULT_PRICE,DEVELOPER,PUBLISHER) values({game_info},\n{game_tag},\n{pbulish_date},{ko_name},{game_name},\n{game_min_spec},\n{game_nomal_spec},21000,66,67);\n\n\n"
)

#원가 개발사 유통사 순서임

file.close()