import json

path = "test/games_list_get/jsons/"
cleanedJson = []

def saveJson(fileName, jsonFile):
    f = open(fileName, "w")
    f.write(json.dumps(jsonFile))
    f.close()

def orderBy(jsonFile, order):
    jsonFile.sort(key=lambda item: item.get("title"))

if __name__ == "__main__":
    jsonFile = json.loads(open(path + "games.json", "r").read())
    orderBy(jsonFile, "title")

    for i in range(len(jsonFile)):
        print("progress: {} of {}".format(i, str(len(jsonFile))))
        game = jsonFile[i]

        game["platform"] = [game["platform"]]

        # il titolo non viene ricontrollato dopo il primo controllo
        if len(cleanedJson) != 0 and game["title"] == cleanedJson[-1:][0]["title"]:
            continue

        for otherGame in jsonFile[i + 1 :]:
            if game["title"] != otherGame["title"]:
                break
            if (
                game["pic"] == otherGame["pic"]
                and game["type"] == otherGame["type"]
                and game["date"] == otherGame["date"]
                and game["platform"][0] != otherGame["platform"]
            ):
                game["platform"].append(otherGame["platform"])

        cleanedJson.append(game)

    saveJson(path + "cleanGames.json", cleanedJson)
