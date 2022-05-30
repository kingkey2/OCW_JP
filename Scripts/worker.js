var workerControl;

//定期更新與整理資料吐回(背景執行)
//整理成兩塊
//1.全部遊戲，做索引，做單遊戲搜尋與優化
//2.按照分類、廠牌整理

self.addEventListener('message', function (e) {
    //data格式
    //Cmd => 執行動作
    //Params => data參數
    if (e.data) {
        if (e.data.Cmd == "INIT") {
            wokerControl = new Worker(Params[0]);
        } else if (e.data.Cmd == "INIT") {

        }
    }
    self.postMessage(res);
    self.close();
}, false);


workerControl

function UpdateGameCodeDic() {

}

function SetGameCategory() {
    var GameList = [
        {
            Loacation: "",
            Category: [
                {

                }
            ]
        }
    ];

    workerControl
}




//#region  Class
var Worker = function (version, url, langUrl, second, finishNotifyEvent) {
    var defineLocations = ["Home", "GameList_All", "GameList_Slot", "GameList_Live", "GameList_Electron", "GameList_Other"];
    var defineLangs = ["JPN", "CHT"];

    var RecordTimeStamp = 0;
    var url = url
    var langUrl = langUrl;
    var IntervalSecond = second;
    var version = version;
    var onFinish = finishNotifyEvent;

    //#region List
    var GameList = {
        Slice: [
            {
                Index: 0 // GameID /100
                Datas: [

                ]
            }
        ],

    };

    var BrandList = [];

    var GameCtList = [{
        Loacation: "",
        Categories: [
            {
                CategoryID: 0,
                State: 0,
                SortIndex: 0,
                Location: 0,
                ShowType: 0,
                Datas: [
                    {
                        CategoryID: 0,
                        GameID: 0,
                        GameCode: "",
                        GameName: "",
                        GameCategoryCode: "",
                        GameCategorySubCode: "",
                        AllowDemoPlay: 0,
                        RTPInfo: 0,
                        Info: 0,
                        IsHot: 0,
                        IsNew: 0,
                        SortIndex: 0
                    }
                ]
            }
        ]
    }];

    //#endregion List

    var languages = [
        {
            lang: "",
            type: "Brand",
            mlp: null
        }
    ];

    var multiLanguage = function (v) {
        var _LanguageContextJSON = [];

        function loadLanguageFromFile(langFile, cb) {
            readTextFile(langFile, function (success, text) {
                if (success) {
                    var langObj = JSON.parse(text);

                    _LanguageContextJSON[_LanguageContextJSON.length] = langObj;
                }

                if (cb != null)
                    cb();
            });
        }

        function readTextFile(file, callback) {
            var rawFile = new XMLHttpRequest();
            //rawFile.overrideMimeType("application/json");
            rawFile.open("GET", file, true);
            //rawFile.setRequestHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            rawFile.onreadystatechange = function () {
                if (rawFile.readyState === 4) {
                    if (rawFile.status == "200") {
                        callback(true, rawFile.responseText);
                    } else {
                        callback(false, rawFile.responseText);
                    }

                }
            }
            rawFile.send(null);
        }

        this.getLanguageKey = function (key) {
            var retValue = key;

            if (key) {
                if (key != "") {
                    if (_LanguageContextJSON != null) {
                        for (var _i = 0; _i < _LanguageContextJSON.length; _i++) {
                            var _o = _LanguageContextJSON[_i];

                            if (typeof _o[key] != 'undefined') {
                                retValue = _o[key];
                            }
                        }
                    }
                }
            }

            return retValue;
        }

        this.loadLanguageByOtherFile = function (filePath, lang, cb) {
            if (lang) {
                if (lang != "") {
                    _LanguageContextJSON = [];

                    if (v) {
                        loadLanguageFromFile(filePath + lang + ".json?" + v, function () {
                            if (cb)
                                cb();
                        });
                    } else {
                        loadLanguageFromFile(filePath + lang + ".json", function () {
                            if (cb)
                                cb();
                        });
                    }
                } else {
                    if (cb)
                        cb();
                }
            } else {
                if (cb)
                    cb();
            }
        }

    };


    this.UpdateGameCodeDic = function () { };

    this.LoadLang = function (cb) {
        var PromiseList = [];

        for (var i = 0; i < defineLangs.length; i++) {
            var lang = defineLangs[i];
            promiseList.push(new Promise(function (resolve, reject) {
                var mlp = new multiLanguage(version);
                mlp.loadLanguageByOtherFile(langUrl + "/GameCode.", lang, function () {
                    languages.push({
                        lang: lang,
                        type: "GameCode",
                        mlp: mlp
                    });
                    resolve();
                })
            }));
            promiseList.push(new Promise(function (resolve, reject) {
                var mlp = new multiLanguage(version);
                mlp.loadLanguageByOtherFile(langUrl + "/GameBrand.", lang, function () {
                    languages.push({
                        lang: lang,
                        type: "GameBrand",
                        mlp: mlp
                    });
                    resolve();
                })
            }));
        }

        Promise.all(promiseList).then(function (values) {
            cb();
        });
    }

    this.RefreshData = function () {
        this.lobbyAPI.GetCompanyGameCodeTwo(getUUID(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    for (var i = 0; i < CompanyCategoryDatas.length; i++) {
                        var ctData = CompanyCategoryDatas[i];
                        var targetLoacation = GameCtList.find(x => x.Location == ctData.Location);                      
                        var pushCtData = {
                            CategoryID : ctData.CompanyCategoryID,
                            State : ctData.State,
                            SortIndex : ctData.SortIndex,
                            CategoryName : ctData.CategoryName,
                            Location : ctData.Location,
                            ShowType : ctData.ShowType,
                            Datas : [],
                        };

                        for (var ii = 0; ii < ctData.Datas.length; ii++) {
                            var gameData = ctData.Datas[ii];
                            var pushGameData = {
                                CategoryID: ctData.CompanyCategoryID,
                                GameID: gameData.GameID,
                                GameCode: gameData.GameCode,
                                GameBrand: gameData.GameBrand,
                                GameName: gameData.GameName,
                                GameCategoryCode: gameData.GameCategoryCode,
                                GameCategorySubCode: gameData.GameCategorySubCode,
                                AllowDemoPlay: gameData.AllowDemoPlay,
                                RTPInfo: gameData.RTPInfo,
                                Info: gameData.Info,
                                RTPInfo: gameData.RTPInfo,
                                IsHot: gameData.IsHot,
                                IsNew: gameData.IsNew,
                                SortIndex: gameData.SortIndex,
                                Tag: gameData.Tag,
                                GameText: {},
                                BrandText: {}
                            };

                            for (var iii = 0; iii < languages.length; iii++) {
                                var language = languages[i];

                                if (language.type == "GameCode") {
                                    pushGameData.GameText[language.lang] = mlp.getLanguageKey(GameCode);
                                } else if (language.type == "GameBrand") {
                                    pushGameData.BrandText[language.lang] = mlp.getLanguageKey(GameBrand);
                                }                                                                                           
                            }
                                                        
                            pushCtData.Datas.push(pushGameData);
                        }

                        targetLoacation.Categories.push(pushCtData);
                    }
                }
            }
        });

        this.lobbyAPI.GetCompanyGameCodeTwo(getUUID(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    for (var i = 0; i < CompanyCategoryDatas.length; i++) {
                        var ctData = CompanyCategoryDatas[i];
                        var targetLoacation = GameCtList.find(x => x.Location == ctData.Location);
                        var pushCtData = {
                            CategoryID: ctData.CompanyCategoryID,
                            State: ctData.State,
                            SortIndex: ctData.SortIndex,
                            CategoryName: ctData.CategoryName,
                            Location: ctData.Location,
                            ShowType: ctData.ShowType,
                            Datas: [],
                        };



                        targetLoacation.Categories.push(pushCtData);
                    }


                    for (var ii = 0; ii < ctData.Datas.length; ii++) {
                        var gameData = ctData.Datas[ii];
                        var pushGameData = {
                            CategoryID: ctData.CompanyCategoryID,
                            GameID: gameData.GameID,
                            GameCode: gameData.GameCode,
                            GameBrand: gameData.GameBrand,
                            GameName: gameData.GameName,
                            GameCategoryCode: gameData.GameCategoryCode,
                            GameCategorySubCode: gameData.GameCategorySubCode,
                            AllowDemoPlay: gameData.AllowDemoPlay,
                            RTPInfo: gameData.RTPInfo,
                            Info: gameData.Info,
                            RTPInfo: gameData.RTPInfo,
                            IsHot: gameData.IsHot,
                            IsNew: gameData.IsNew,
                            SortIndex: gameData.SortIndex,
                            Tag: gameData.Tag,
                            GameText: {},
                            BrandText: {}
                        };

                        for (var iii = 0; iii < languages.length; iii++) {
                            var language = languages[i];

                            if (language.type == "GameCode") {
                                pushGameData.GameText[language.lang] = mlp.getLanguageKey(GameCode);
                            } else if (language.type == "GameBrand") {
                                pushGameData.BrandText[language.lang] = mlp.getLanguageKey(GameBrand);
                            }
                        }

                        pushCtData.Datas.push(pushGameData);
                    }
                }
            }
        });
    };

    function getUUID(len, radix) {
        if (len) {
            // Compact form
            for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random() * radix];
        } else {
            // rfc4122, version 4 form
            var r;

            // rfc4122 requires these characters
            uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
            uuid[14] = '4';

            // Fill in random data.  At i==19 set the high bits of clock sequence as
            // per rfc4122, sec. 4.1.5
            for (i = 0; i < 36; i++) {
                if (!uuid[i]) {
                    r = 0 | Math.random() * 16;
                    uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
                }
            }
        }

        return uuid.join('');
    }

    function init() {
        //執行 init

        for (var i = 0; i < defineLocations.length; i++) {
            GameCtList.push({
                Loacation: defineLocations[i],
                Categories: null
            });
        }

        this.lobbyAPI = new (function (APIUrl) {
            this.GeAlltCompanyGameCode = function (GUID, cb) {
                var url = APIUrl + "/GeAlltCompanyGameCode";
                var postData;

                postData = {
                    GUID: GUID
                };

                callService(url, postData, 10000, function (success, text) {
                    if (success == true) {
                        var obj = getJSON(text);

                        if (cb)
                            cb(true, obj);
                    } else {
                        if (cb)
                            cb(false, text);
                    }
                });
            };

            this.GetCompanyGameCodeTwo = function (GUID, cb) {
                var url = APIUrl + "/GetCompanyGameCodeTwo";
                var postData;

                postData = {
                    GUID: GUID
                };

                callService(url, postData, 10000, function (success, text) {
                    if (success == true) {
                        var obj = getJSON(text);

                        if (cb)
                            cb(true, obj);
                    } else {
                        if (cb)
                            cb(false, text);
                    }
                });
            };

            function callService(URL, postObject, timeoutMS, cb) {
                var xmlHttp = new XMLHttpRequest;
                var postData;

                if (postObject)
                    postData = JSON.stringify(postObject);

                xmlHttp.open("POST", URL, true);
                xmlHttp.onreadystatechange = function () {
                    if (this.readyState == 4) {
                        var contentText = this.responseText;

                        if (this.status == "200") {
                            if (cb) {
                                cb(true, contentText);
                            }
                        } else {
                            cb(false, contentText);
                        }
                    }
                };

                xmlHttp.timeout = timeoutMS;
                xmlHttp.ontimeout = function () {
                    /*
                    timeoutTryCount += 1;
        
                    if (timeoutTryCount < 2)
                        xmlHttp.send(postData);
                    else*/
                    if (cb)
                        cb(false, "Timeout");
                };

                xmlHttp.setRequestHeader("Content-Type", "application/json; charset=utf-8");
                xmlHttp.send(postData);
            }

            function getJSON(text) {
                var obj = JSON.parse(text);

                if (obj) {
                    if (obj.hasOwnProperty('d')) {
                        return obj.d;
                    } else {
                        return obj;
                    }
                }
            }
        })(url);


        this.LoadLang(function () {
            setInterval.call(this, this.RefreshData, IntervalSecond);
        });
    }

    init.call(this);
};
//#endregion