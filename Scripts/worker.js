self.importScripts("/Scripts/Math.uuid.js");

//定期更新與整理資料吐回(背景執行)
//整理成兩塊
//1.全部遊戲，做索引，做單遊戲搜尋與優化
//2.按照分類、廠牌整理

var wokerControl;
self.addEventListener('message', function (e) {
    //data格式
    //Cmd => 執行動作
    //Params => data參數
    if (e.data) {
        if (e.data.Cmd == "Init") {            
            wokerControl = new worker(e.data.Params[0], e.data.Params[1], e.data.Params[2]);

            //dataExist,true => indexedDB已經有資料，可不等同步直接使用
            wokerControl.OnInitSyncStart = function (dataExist) {
                self.postMessage({
                    Cmd: "InitSyncStart",
                    Data: dataExist,
                });
            };

            wokerControl.OnInitSyncEnd = function () {
                self.postMessage({
                    Cmd: "InitSyncEnd",
                    Data: null,
                });
            };

            wokerControl.Start();
        }
    }
}, false);



//#region  Class
var worker = function (WebUrl, Second, eWinGameItem) {
    var workerSelf = this;        
    var APIUrl = WebUrl;
    

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

    
    //#region public屬性

    //property
    this.SyncEventData = {
        Database: null,
        LastTimeStamp: 0,
        LastGameID : 0,
        NowTimeStamp: 0,
        NowGameID: 0 ,
        IntervalSecond: Second,
        FailureSecond : 3,
    };

    this.EWinGameItem = eWinGameItem;

    //delegate
    //刷新全部    
    this.OnInitSyncStart;

    this.OnInitSyncEnd;

    this.IsFirstLoaded = false;

    this.Sync = function () {
        //初始化，不指定version
        let DBRequestLink = self.indexedDB.open('GameCodeDB');

        //check indexDB init

        //版本號高於當前版本，觸發
        DBRequestLink.onupgradeneeded = function (event) {
            var db = event.target.result;
            var store;
            var categoryStore;
            // 第一次建立indexedDB
            if (event.oldVersion == 0) {
                store = db.createObjectStore("GameCodes", { keyPath: "GameCode", autoIncrement: false });
                store.createIndex('GameID', "GameID", { unique: true, multiEntry: false });
                store.createIndex('GameBrand', ['GameBrand', 'SortIndex'], { unique: false, multiEntry: false });
                store.createIndex('GameCategoryCode', ['GameCategoryCode', 'SortIndex'], { unique: false, multiEntry: false });                
                store.createIndex('GameCategorySubCode', ['GameCategoryCode', 'GameCategorySubCode', 'SortIndex'], { unique: false, multiEntry: false });
                store.createIndex('SearchKeyWord', "Tags", { unique: false, multiEntry: true }); //搜尋關鍵字使用
                store.createIndex('PersonalFavo', 'FavoTimeStamp', { unique: false, multiEntry: false });
                store.createIndex('PersonalPlayed', 'PlayedTimeStamp', { unique: false, multiEntry: false });
                //store.createIndex('ShowTags', 'ShowTags', { unique: false, multiEntry: true }); //顯性標籤

                categoryStore = db.createObjectStore("GameCategory", { keyPath: ['GameBrand', 'GameCategoryCode'] ,autoIncrement: false });
                categoryStore.createIndex('GameBrand', 'GameBrand', { unique: false, multiEntry: false });
                categoryStore.createIndex('GameCategoryCode', 'GameCategoryCode', { unique: false, multiEntry: false });
                if (workerSelf.EWinGameItem) {
                    store.put(workerSelf.EWinGameItem);
                    categoryStore.put({
                        GameBrand: workerSelf.EWinGameItem.GameBrand,
                        GameCategoryCode: workerSelf.EWinGameItem.GameCategoryCode,
                    });
                }
            } 
        };

        DBRequestLink.onsuccess = function (event) {
            workerSelf.SyncEventData.Database = event.target.result;
            if (workerSelf.SyncEventData.Database.version == 1) {
                //有初始化，但沒同步過資料 version =>1
                workerSelf.SyncEventData.NowGameID = 0;
                workerSelf.SyncEventData.NowTimeStamp = 0;

                if (workerSelf.IsFirstLoaded == false) {
                    if (workerSelf.OnInitSyncStart) {
                        workerSelf.OnInitSyncStart(false);
                    }
                }               
            } else {
                //有初始化，有同步過資料 version => 15位數，10位數unix + 5 位GamdID
                workerSelf.SyncEventData.NowTimeStamp = Math.floor(workerSelf.SyncEventData.Database.version / 100000);
                workerSelf.SyncEventData.NowGameID = workerSelf.SyncEventData.Database.version % 100000;

                if (workerSelf.IsFirstLoaded == false) {
                    if (workerSelf.OnInitSyncStart) {
                        workerSelf.OnInitSyncStart(true);
                    }
                }              
            }

           
            workerSelf.RecursiveSyncGameCode();
        };
    }

    this.NextSync = function (Second) {
        workerSelf.SyncEventData.LastTimeStamp = 0;
        workerSelf.SyncEventData.LastGameID = 0;


        setTimeout(workerSelf.Sync, Second * 1000)
    };

    this.SyncSuccess = function (needResetVersion) {
        //db drop

        if (workerSelf.SyncEventData.Database) {
            workerSelf.SyncEventData.Database.close();
            workerSelf.SyncEventData.Database = null;
        }
 
        //更新目前同步時間與IndexedDB版本
        if (needResetVersion) {
            if (workerSelf.SyncEventData.NowTimeStamp * 100000 + workerSelf.SyncEventData.NowGameID == 0) {
                self.indexedDB.open('GameCodeDB', 1);
            } else {
                self.indexedDB.open('GameCodeDB', workerSelf.SyncEventData.NowTimeStamp * 100000 + workerSelf.SyncEventData.NowGameID);
            }           
        }

        if (workerSelf.IsFirstLoaded == false) {
            if (workerSelf.OnInitSyncEnd) {
                workerSelf.OnInitSyncEnd();
            }

            workerSelf.IsFirstLoaded = true;
        }

        workerSelf.NextSync(workerSelf.SyncEventData.IntervalSecond);
    };

    this.SyncFaliure = function () {
        //db drop
        if (workerSelf.SyncEventData.Database) {
            workerSelf.SyncEventData.Database.close();
            workerSelf.SyncEventData.Database = null;
        }

        //更新目前同步時間與IndexedDB版本
        if (workerSelf.SyncEventData.NowTimeStamp * 100000 + workerSelf.SyncEventData.NowGameID == 0) {
            self.indexedDB.open('GameCodeDB', 1);
        } else {
            self.indexedDB.open('GameCodeDB', workerSelf.SyncEventData.NowTimeStamp * 100000 + workerSelf.SyncEventData.NowGameID);
        }
        workerSelf.NextSync(workerSelf.SyncEventData.FailureSecond);
    };

    this.GetCompanyGameCodeByUpdateTimestamp = function (GUID, UpdateTimestamp, GameID, cb) {
        var url = APIUrl + "/GetCompanyGameCodeByUpdateTimestamp";
        var postData;

        postData = {
            GUID: GUID,
            UpdateTimestamp: UpdateTimestamp,
            GameID: GameID
        };

        callService(url, postData, 100000, function (success, text) {
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
                                                      
    this.RecursiveSyncGameCode = function () {
        workerSelf.GetCompanyGameCodeByUpdateTimestamp(Math.uuid(), workerSelf.SyncEventData.NowTimeStamp, workerSelf.SyncEventData.NowGameID, function (success, o) {
            if (workerSelf.SyncEventData.Database) {
                if (success) {
                    if (o.Result == 0) {
                        workerSelf.SyncEventData.LastTimeStamp = o.LastTimestamp;
                        workerSelf.SyncEventData.LastGameID = o.LastGameID;

                        if (workerSelf.SyncEventData.LastTimeStamp == workerSelf.SyncEventData.NowTimeStamp && workerSelf.SyncEventData.NowGameID == workerSelf.SyncEventData.LastGameID) {
                            //已是最新數據，不用同步
                            workerSelf.SyncSuccess(false);
                        } else {

                            let transaction = workerSelf.SyncEventData.Database.transaction(['GameCodes', 'GameCategory'], 'readwrite');
                            let objectStore = transaction.objectStore('GameCodes');
                            let objectCategoryStore = transaction.objectStore('GameCategory');

                            for (var i = 0; i < o.GameCodeList.length; i++) {
                                let gameCodeItem = o.GameCodeList[i];
                                let tags = [];
                                let temps = gameCodeItem.CompanyCategoryTag.split(",");

                                for (var ii = 0; ii < temps.length; ii++) {
                                    let index = temps[ii].indexOf("@")
                                    if (index != -1) {                                        
                                        tags.push(temps[ii].substring(index + 1).trim());
                                    }
                                }

                                let InsertData = {
                                    GameCode: gameCodeItem.GameCode,
                                    GameBrand: gameCodeItem.BrandCode,
                                    GameID: gameCodeItem.GameID,
                                    GameName: gameCodeItem.GameName,
                                    GameCategoryCode: gameCodeItem.GameCategoryCode,
                                    GameCategorySubCode: gameCodeItem.GameCategorySubCode,
                                    GameAccountingCode: gameCodeItem.GameAccountingCode,
                                    AllowDemoPlay: gameCodeItem.AllowDemoPlay,
                                    RTPInfo: gameCodeItem.RTPInfo,
                                    IsHot: gameCodeItem.IsHot,
                                    IsNew: gameCodeItem.IsNew,
                                    SortIndex: gameCodeItem.SortIndex,                                    
                                    Tags: tags,
                                    Language: gameCodeItem.Language,
                                    RTP: gameCodeItem.RTP,
                                    FavoTimeStamp: null,
                                    PlayedTimeStamp: null
                                };


                                try {
                                    objectStore.put(InsertData);
                                    objectCategoryStore.put({
                                        GameBrand: InsertData.GameBrand,
                                        GameCategoryCode: InsertData.GameCategoryCode
                                    });
                                    workerSelf.SyncEventData.NowGameID = gameCodeItem.GameID;
                                    workerSelf.SyncEventData.NowTimeStamp = gameCodeItem.UpdateTimestamp;
                                } catch (e) {
                                    workerSelf.SyncEventData.NowGameID = gameCodeItem.GameID;
                                    workerSelf.SyncEventData.NowTimeStamp = gameCodeItem.UpdateTimestamp;
                                    workerSelf.SyncFaliure();
                                    break;
                                }

                                
                            }
                
                            transaction.oncomplete = function (event) {
                                if (workerSelf.SyncEventData.LastTimeStamp == workerSelf.SyncEventData.NowTimeStamp && workerSelf.SyncEventData.NowGameID == workerSelf.SyncEventData.LastGameID) {
                                    workerSelf.SyncSuccess(true);
                                } else {
                                    workerSelf.RecursiveSyncGameCode();
                                }
                            };
                        }
                    } else {
                        workerSelf.SyncFaliure();
                    }
                } else {
                    workerSelf.SyncFaliure();
                }
            }
        });
    };

    this.Start = function () {
        //分為兩部分進行
        //1.indexDB 處理GameCode事務
        //2.處理分類事務
               
        //indexDB init
        self.indexedDB = self.indexedDB || self.mozIndexedDB || self.webkitIndexedDB || self.msIndexedDB;
        self.IDBTransaction = self.IDBTransaction || self.webkitIDBTransaction || self.msIDBTransaction;
        self.IDBKeyRange = self.IDBKeyRange || self.webkitIDBKeyRange || self.msIDBKeyRange;

        workerSelf.Sync();
    }
    //#endregion
};
//#endregion
