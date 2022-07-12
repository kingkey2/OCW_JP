var GameCodeBridge = function (url, second, notifyDataCanUse) {
    var GCBSelf = this;
    var myWorker;

    function init() {
        // In the following line, you should include the prefixes of implementations you want to test.
        window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
        // DON'T use "var indexedDB = ..." if you're not in a function.
        // Moreover, you may need references to some window.IDB* objects:
        window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
        window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;

        myWorker = new Worker("/Scripts/worker_2.js");

        myWorker.postMessage({
            Cmd: "Init",
            Params: [url, second]
        });

        myWorker.onmessage = (function (e) {
            if (e.data) {
                switch (e.data.Cmd) {
                    case "InitSyncStart":
                        if (e.data.Data == true) {
                            GCBSelf.InitDB();
                        }

                        break;

                    case "InitSyncEnd":
                        if (GCBSelf.IsFirstLoaded == false) {
                            GCBSelf.InitDB();
                        }
                        break;
                    default:
                        break;
                }
            }
        });
    }

    this.InitDB = function () {
        var DBOpenRequest = window.indexedDB.open('GameCodeDB');

        if (GCBSelf.IsFirstLoaded) {
            if (this.NotifyDataCanUse) {
                this.NotifyDataCanUse();
            }
        }

        GCBSelf.IsFirstLoaded = true;

        DBOpenRequest.onsuccess = function (event) {
            GCBSelf.IndexedDB = event.target.result;
            GCBSelf.IsFirstLoaded = true;

            if (this.NotifyDataCanUse) {
                this.NotifyDataCanUse();
            }
        };
    }


    //搜尋方法 cb回傳統一為一個或多個GameCodeItem

    /**
     * 
     * @param {string} GameCode    遊戲代碼
     * @param {Function} cb 找到資料時的cb, param => data, null時為無資料
     */
    this.GetByGameCode = function (GameCode, cb) {
        if (GCBSelf.IsFirstLoaded) {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');

            objectStore.get(GameCode).onsuccess = function (event) {
                cb(event.target.result);
            };
        }
    };

    /**
     * 
     * @param {any} GameBrand   遊戲廠牌
     * @param {any} cb  資料迭代cb, param => data
     * @param {any} endCb 結束cb, param => true=結束,有找到資料 false=結束,無找到資料
     */
    this.CursorGetByGameBrand = function (GameBrand, cb, endCb) {
        if (GCBSelf.IsFirstLoaded) {

            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("GameBrand");
            var isDataExist = false;
            //var count = index.count();
            index.openCursor(GameBrand).onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }
            };
        }
    };


    /**
     *
     * @param {any} GameCategoryCode   遊戲分類代碼
     * @param {any} cb  資料迭代cb, param => data
     * @param {any} endCb 結束cb, param => true=結束,有找到資料 false=結束,無找到資料
     */
    this.CursorGetByCategoryCode = function (GameCategoryCode, cb, endCb) {
        if (GCBSelf.IsFirstLoaded) {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("GameCategoryCode");
            var isDataExist = false;
            //var count = index.count();
            index.openCursor(GameCategoryCode).onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }
            };
        }
    };


    /**
     *
     * @param {any} GameCategoryCode   遊戲分類代碼
     * @param {any} GameCategorySubCode   遊戲次分類代碼
     * @param {any} cb  資料迭代cb, param => data
     * @param {any} endCb 結束cb, param => true=結束,有找到資料 false=結束,無找到資料
     */
    this.CursorGetByCategorySubCode = function (GameCategoryCode, GameCategorySubCode, cb, endCb) {
        if (GCBSelf.IsFirstLoaded) {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("GameCategorySubCode");
            var isDataExist = false;
            index.openCursor([GameCategoryCode, GameCategorySubCode]).onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }               
            };
        }
    };

    this.CursorGetByMultiSearch = function (GameBrand, GameCategoryCode, GameCategorySubCode, SearchKeyWord, cb, endCb) {
        if (GCBSelf.IsFirstLoaded) {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            //var index = null;
            var request;
            var searchGameID;
            var isSearchKeyRequest;
            var isDataExist = false;

            if (SearchKeyWord && SearchKeyWord.length < 6) {
                 //如果關鍵字為GameID，特別拉出來做處理，由於結果一定為單一值，不做複合搜尋
                var searchGameID = Number(SearchKeyWord);

                if (searchGameID) {
                    objectStore.index("GameID").openCursor(searchGameID).onsuccess = function (event) {
                        var cursor = event.target.result;
                        if (cursor) {
                            isDataExist = true;
                            cb(cursor.value);
                            endCb(isDataExist);
                        } else {
                            endCb(isDataExist);
                        }
                    };

                    return;
                }
            }


            if (GameBrand) {
                request = objectStore.index("GameBrand").openCursor(GameBrand);
            } else if (GameCategoryCode && GameCategorySubCode) {
                request = objectStore.index("GameCategorySubCode").openCursor([GameCategoryCode, GameCategorySubCode]);
            } else if (GameCategoryCode) {
                request = objectStore.index("GameCategoryCode").openCursor(GameCategoryCode);
            } else if (SearchKeyWord) {
                request = objectStore.index("SearchKeyWord").openCursor(SearchKeyWord);
                isSearchKeyRequest = true;
            } else {
                return;
            }

            request.onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    var gameCodeItem = cursor.value;
                    var checkFlag = true;

                    if (GameBrand && gameCodeItem.GameBrand != GameBrand) {
                        checkFlag = false;
                    } else if ((GameCategoryCode && GameCategorySubCode) && (gameCodeItem.GameCategoryCode != GameCategoryCode || gameCodeItem.GameCategorySubCode != GameCategorySubCode)) {
                        checkFlag = false;
                    } else if (GameCategoryCode && gameCodeItem.GameCategoryCode != GameCategoryCode) {
                        checkFlag = false;
                    } else if (SearchKeyWord) {
                        var searchFlag = false;

                        //先搜尋既有關鍵字
                        for (var i = 0; i < gameCodeItem.Tags.length; i++) {
                            if (SearchKeyWord.toLowerCase().includes(gameCodeItem.Tags[i].toLowerCase())) {
                                searchFlag = true;
                                break;
                            }
                        }

                        //不存在關鍵字內，搜尋翻譯後的遊戲名稱
                        if (searchFlag == false) {
                            for (var i = 0; i < gameCodeItem.Language.length; i++) {
                                if (gameCodeItem.Language[i].DisplayText.includes(SearchKeyWord)) {
                                    searchFlag = true;
                                    break;
                                }
                            }
                        }

                        if (searchFlag == false) {
                            checkFlag = false;
                        }
                    }

                    if (checkFlag) {
                        isDataExist = true;
                        cb(gameCodeItem);
                    }

                    cursor.continue();
                } else {
                    //沒有資料，且為關鍵字搜尋，做全部資料的mapping
                    if (isDataExist == false &&　isSearchKeyRequest) {
                        var updateDatas = [];

                        objectStore.openCursor().onsuccess = function (event) {
                            var cursor = event.target.result;
                            if (cursor) {
                                var gameCodeItem = cursor.value;
                                var searchFlag = false;

                                //先搜尋既有關鍵字
                                for (var i = 0; i < gameCodeItem.Tags.length; i++) {
                                    if (SearchKeyWord.toLowerCase().includes(gameCodeItem.Tags[i].toLowerCase())) {
                                        searchFlag = true;
                                        break;
                                    }
                                }

                                for (var i = 0; i < gameCodeItem.Language.length; i++) {
                                    if (gameCodeItem.Language[i].DisplayText.includes(SearchKeyWord)) {
                                        searchFlag = true;                                      
                                        updateDatas.push(gameCodeItem)                                      
                                        break;
                                    }
                                }


                                if (searchFlag) {
                                    isDataExist = true;
                                    cb(gameCodeItem);
                                }

                                cursor.continue();
                            } else {
                                //資料遍歷完
                                if (updateDatas.length >= 20) {
                                    GCBSelf.updateByKeywordSearch(updateDatas, SearchKeyWord);
                                } else {
                                    endCb(isDataExist);
                                }
                            }
                        }
                    } else {
                        endCb(isDataExist);
                    }
                }
            };;
        }
    }

    this.updateByKeywordSearch = function (datas, searchKeyword) {
        if (GCBSelf.IsFirstLoaded) {
            if (datas.length >= 20) {
                var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readwrite');
                var objectStore = transaction.objectStore('GameCodes');

                for (var i = 0; i < datas.length; i++) {
                    var data = datas[i];
                    data.Tags.push(searchKeyword);
                    objectStore.put(data);
                }
            }
        }
    }


    this.IndexedDB = null;

    this.IsFirstLoaded = false;

    this.NotifyDataCanUse = notifyDataCanUse;

    init();
}