import json

cleanedJson = []

def saveJson(fileName, jsonFile):
    f = open(fileName, "w")
    f.write(json.dumps(jsonFile))
    f.close()


if __name__ == "__main__":
    jsonFile = json.loads(open("test/games_list_get/games.json", "r").read())
    jsonFile.sort(key=lambda item: item.get("title"))

    # saveJson("games_titles_sorted.json", [jf.get("title") for jf in jsonFile])

    progressString = "progress: {} of " + str(len(jsonFile))

    for i in range(len(jsonFile)):
        print(progressString.format(i))

        game = jsonFile[i]
        game["platform"] = [game["platform"]]
        for j in range(i + 1, len(jsonFile)):
            otherGame = jsonFile[j]
            if game["title"] != otherGame["title"]:
                break
            if (
                game["pic"] == otherGame["pic"]
                and game["type"] == otherGame["type"]
                and game["date"] == otherGame["date"]
                and game["platform"] != otherGame["platform"]
            ):
                game["platform"].append(otherGame["platform"])
            cleanedJson.append(game)
        saveJson("cleanGames.json", cleanedJson)
