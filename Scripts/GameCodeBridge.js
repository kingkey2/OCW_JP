var GameCodeBridge = function (version, url, langUrl, second, loadedEvent) {
    var myWorker
    var CtList = null;
    var SearchCore = null;

    this.FirstLoaded = false;
    this.SearchGameCodeByLang = function (lang, searchText, gameBrand, gameCategoryCode) {
        let Ret = [];
        let findCharList;
        let langTemp;
        //find GameID

        if (brand) {
            let targetBrand = SearchCore.SearchDic.Brands.find(x => x.GameBrand == gameBrand);

            if (targetBrand) {
                langTemp = targetBrand.Langs[lang];

            } else {
                langTemp = SearchCore.SearchDic.Langs[lang];
            }

            if (langTemp) {
                findCharList = temp[searchText[0]];

                if (findCharIndexObj) {
                    for (var i = 0; i < findCharList.length; i++) {
                        // gameID + 
                        let charObj = findCharList[i];
                        if (charObj.TargetValue.indexOf(searchText) != -1) {
                            let IndexOne = Math.trunc(charObj.GameID / 100);
                            let IndexTwo = charObj.GameID % 100;
                            let gameCodeObj = SearchCore.GameList.Slices[IndexOne][IndexTwo];

                            if (gameCategoryCode) {
                                if (gameCodeObj.GameCategoryCode == gameCategoryCode) {
                                    Ret.push(gameCodeObj);
                                }
                            } else {
                                Ret.push(gameCodeObj);
                            }                            
                        }
                    }
                }
            }
        }

        return Ret;
    }
    this.SearchGameCodeByBrand = function (gameBrand, gameCategoryCode) {
        let Ret = [];
        //find GameID

        let targetBrand = SearchCore.SearchDic.Brands.find(x => x.GameBrand == gameBrand);
    

        for (var i = 0; i < targetBrand.AllGame.length; i++) {
            // gameID + 
            let gameID = targetBrand.AllGame[i];
            let IndexOne = Math.trunc(gameID / 100);
            let IndexTwo = gameID % 100;
            let gameCodeObj = SearchCore.GameList.Slices[IndexOne][IndexTwo];

            if (gameCategoryCode) {
                if (gameCodeObj.GameCategoryCode == gameCategoryCode) {
                    Ret.push(gameCodeObj);
                }
            } else {
                Ret.push(gameCodeObj);
            }
        }

        return Ret;
    }
    this.GetGameCode = function (gameID) {
        let IndexOne = Math.trunc(gameID / 100);
        let IndexTwo = gameID % 100;
        return SearchCore.GameList.Slices[IndexOne][IndexTwo];
    }
    this.GetCategories = function (loactions) {
        let Ret;

        if (loactions) {
            Ret = [];

            for (var i = 0; i < CtList.length; i++) {
                if (loactions.includes(CtList[i].Loacation)) {
                    Ret.push(CtList[i]);
                }
            }
        } else {
            Ret = CtList;
        }
        

        return Ret;
    }
    this.GetCategory = function (loaction) {

        let Ret;

        for (var i = 0; i < CtList.length; i++) {
            if (loaction == CtList[i].Loacation) {
                Ret = CtList[i];
                break;
            }
        }

        return Ret;
    }
    this.onCtListChange;
    this.onLoaded = loadedEvent;
    this.init = function () {
        myWorker = new Worker("/Scripts/worker.js");
        myWorker.postMessage({
            Cmd : "Init",
            Params: [version, url, langUrl, 5000]
        });
        myWorker.onmessage = (function (e) {
            if (e.data) {
                switch (e.data.Cmd) {
                    case "RefreshCtList":
                        this.CtList = e.data.Data;

                        if (FirstLoaded == false) {
                            if (CtList != null && SearchCore != null) {                               
                                if (this.onLoaded) {
                                    this.onLoaded();
                                }
                                FirstLoaded = true;
                            }
                        }

                        if (this.onCtListChange) {
                            this.onCtListChange(CtList);
                        }

                        break;

                    case "RefreshDic":
                        this.SearchCore = e.data.Data;

                        if (FirstLoaded == false) {
                            if (CtList != null && SearchCore != null) {                               
                                if (this.onLoaded) {
                                    this.onLoaded();
                                }
                                FirstLoaded = true;
                            }
                        }


                        break;
                    default:
                        break;
                }
            }
        }).bind(this);
    }

    this.init();
}