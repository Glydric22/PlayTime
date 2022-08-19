import requests
import json
from bs4 import BeautifulSoup

multiplayerUrl = "https://multiplayer.it{}"
bigGamesList = []


def getMultiplayerURL(URL):
    response = requests.get(URL)
    if response.status_code != 200:
        raise Exception("Invalid URL: response %s" % response.status_code)

    soup = BeautifulSoup(response.content, "html.parser")

    gameList = soup.find_all(
        "div",
        class_="media media--game align-items-sm-center position-relative pb-3 mb-3 border-bottom",
    )

    title = soup.find("title").text.split("-")[0:-1]
    print(
        len(gameList),
        (title[0].strip() + title[1] if len(title) > 1 else title[0].strip()),
    )
    for game in gameList:
        bigGamesList.append(parseGame(game))
    pages = soup.find_all("a", "page-link")
    if len(pages) != 0:
        nextUrl = pages[-1].get("href")
        if nextUrl != "#":
            getMultiplayerURL(multiplayerUrl.format(nextUrl))


def parseGame(rawGame) -> dict:
    game = dict()

    rawGame.find("a")
    game["pic"] = rawGame.find("a", "mr-3").find("img").get("src")
    game["title"] = rawGame.find(
        "a", "h4 font-weight-bold lh-1 text-decoration-none"
    ).text
    mb1 = rawGame.find("p", "mb-1").find_all("a")
    game["type"] = [m.text for m in mb1[0:-1]]
    game["platform"] = mb1[-1].text
    game["date"] = rawGame.find("p", "m-0 lh-1").find("small").find("strong").text
    bigGamesList.append(game)

    return game

def saveJson(fileName, jsonFile):
    f = open(fileName, "w")
    f.write(json.dumps(jsonFile))
    f.close()

if __name__ == "__main__":
    # getMultiplayerURL(multiplayerUrl.format("/giochi/?month=2019_08"))
    for year in range(2001, 2023):
        for month in range(1, 13):
            try:
                getMultiplayerURL(
                    multiplayerUrl.format(
                        "/giochi/?month={}_{:02d}".format(year, month)
                    )
                )
            except requests.exceptions.TooManyRedirects:
                print("la pagina non esiste")
    saveJson("game.json",bigGamesList)
