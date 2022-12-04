gmae_Data_file = open("game_data.txt", "r")

game_data = gmae_Data_file.readline()

game_data_list = game_data.split("},{")

file = open("game_list.sql", "a")

for i in game_data_list:
    game_data = i.replace('"', "")
    game_datas = game_data.split(',')
    game_datas[0] = game_datas[0].replace("appid:", "")
    game_datas[1] = game_datas[1].replace("name:", "")
    game_datas[1] = '"' + game_datas[1] + '"'
    file.write(
        f"insert into game_data values({game_datas[0]},{game_datas[1]})")

file.close()
