var GameCodeBridge = function (url, second, eWinGameItem, notifyGameLoadEnd) {
    var GCBSelf = this;
    var myWorker;


    function init() {
        // In the following line, you should include the prefixes of implementations you want to test.
        window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
        // DON'T use "var indexedDB = ..." if you're not in a function.
        // Moreover, you may need references to some window.IDB* objects:
        window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
        window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;

        myWorker = new Worker("/Scripts/worker.js");

        myWorker.postMessage({
            Cmd: "Init",
            Params: [url, second, eWinGameItem]
        });

        GCBSelf.InitPromise = new Promise((resolve, reject) => {
            myWorker.onmessage = (function (e) {
                if (e.data) {
                    switch (e.data.Cmd) {
                        case "InitSyncStart":
                            if (e.data.Data == true) {
                                setTimeout(function () {
                                    GCBSelf.InitDB(resolve);
                                }, 10000);                                                       
                            }

                            break;

                        case "InitSyncEnd":
                            if (GCBSelf.IsFirstLoaded == false) {
                                setTimeout(function () {
                                    GCBSelf.InitDB(resolve);
                                }, 10000);
                            }
                            break;
                        default:
                            break;
                    }
                }
            });
        });

        GCBSelf.InitPromise.then(GCBSelf.NotifyGameLoadEnd);
    }

    this.InitDB = function (resolve) {
        var DBOpenRequest = window.indexedDB.open('GameCodeDB');

        GCBSelf.IsFirstLoaded = true;

        DBOpenRequest.onsuccess = function (event) {
            GCBSelf.IndexedDB = event.target.result;
            GCBSelf.IsFirstLoaded = true;
            resolve();
        };
    }


    //搜尋方法 cb回傳統一為一個或多個GameCodeItem

    /**
     * 
     * @param {string} GameCode    遊戲代碼
     * @param {Function} cb 找到資料時的cb, param => data, null時為無資料
     */
    this.GetByGameCode = function (GameCode, cb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');

            objectStore.get(GameCode).onsuccess = function (event) {
                cb(event.target.result);
            };
        };

        GCBSelf.InitPromise.then(queue);
        //if (GCBSelf.IsFirstLoaded) {
        //    event();
        //} else {

        //}
    };

    /**
     * Return  遊戲代碼
     * @param {string} GameCode 遊戲代碼
     * @param {Function} cb 找到資料時的cb, param => data, null時為無資料
     */
    this.GetByGameCodeSync = async function (GameCode) {
        var GameCodeItem = await new Promise((resolve, reject) => {
            var queue = () => {
                var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
                var objectStore = transaction.objectStore('GameCodes');

                objectStore.get(GameCode).onsuccess = function (event) {
                    resolve(event.target.result);
                };
            };

            GCBSelf.InitPromise.then(queue);
        });

        return GameCodeItem;
    };

    /**
     * 
     * @param {any} GameBrand   遊戲廠牌
     * @param {any} cb  資料迭代cb, param => data
     * @param {any} endCb 結束cb, param => true=結束,有找到資料 false=結束,無找到資料
     */
    this.CursorGetByGameBrand = function (GameBrand, cb, endCb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("GameBrand");
            var isDataExist = false;
            var range = IDBKeyRange.bound([GameBrand, 0], [GameBrand, 99])
            //var count = index.count();

            index.openCursor(range, "prev").onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }
            };
        };

        GCBSelf.InitPromise.then(queue);
    };

    /**
     *
     * @param {any} GameCategoryCode   遊戲分類代碼
     * @param {any} cb  資料迭代cb, param => data
     * @param {any} endCb 結束cb, param => true=結束,有找到資料 false=結束,無找到資料
     */
    this.CursorGetByCategoryCode = function (GameCategoryCode, cb, endCb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("GameCategoryCode");
            var isDataExist = false;
            var range = IDBKeyRange.bound([GameCategoryCode, 0], [GameCategoryCode, 99])
            //var count = index.count();
            index.openCursor(range, "prev").onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }
            };
        };

        GCBSelf.InitPromise.then(queue);
    };

    /**
     *
     * @param {any} GameCategoryCode   遊戲分類代碼
     * @param {any} GameCategorySubCode   遊戲次分類代碼
     * @param {any} cb  資料迭代cb, param => data
     * @param {any} endCb 結束cb, param => true=結束,有找到資料 false=結束,無找到資料
     */
    this.CursorGetByCategorySubCode = function (GameCategoryCode, GameCategorySubCode, cb, endCb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("GameCategorySubCode");
            var isDataExist = false;
            var range = IDBKeyRange.bound([GameCategoryCode, GameCategorySubCode, 0], [GameCategoryCode, GameCategorySubCode, 99])
            index.openCursor(range, "prev").onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }
            };
        };

        GCBSelf.InitPromise.then(queue);
    };

    /**
     * 
     * @param {any} GameCode    遊戲代碼
     * @param {any} type   cb, param => 0=Favo,1=History of Play
     * @param {any} cb   cb, param => true=成功, false=失敗FavoTag
     */
    this.AddPersonal = function (GameCode, type, cb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readwrite');
            var objectStore = transaction.objectStore('GameCodes');
            var FavoIndexStr;

            if (type == 0) {
                FavoIndexStr = "Favo";
            } else if (type == 1) {
                FavoIndexStr = "History";
            } else {
                cb(false);
                return;
            }


            objectStore.get(GameCode).onsuccess = function (event) {
                if (event.target.result) {
                    var data = event.target.result;
                    data.FavoTag.push(FavoIndexStr);
                    objectStore.put(data);
                    cb(true);
                } else {
                    cb(false);
                }
            };
        };

        GCBSelf.InitPromise.then(queue);
    }

    /**
     * 
     * @param {any} GameCode    遊戲代碼
     * @param {any} type   cb, param => 0=Favo,1=History of Play
     * @param {any} cb   cb, param => true=成功, false=失敗FavoTag
     */
    this.RemovePersonal = function (GameCode, type, cb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readwrite');
            var objectStore = transaction.objectStore('GameCodes');
            var FavoIndexStr;

            if (type == 0) {
                FavoIndexStr = "Favo";
            } else if (type == 1) {
                FavoIndexStr = "History";
            } else {
                cb(false);
                return;
            }


            objectStore.get(GameCode).onsuccess = function (event) {
                if (event.target.result) {
                    var data = event.target.result;
                    var index = data.FavoTag.indexOf(FavoIndexStr);

                    if (index != -1) {
                        data.FavoTag.splice(index, 1);
                        objectStore.put(data);
                        cb(true);
                    } else {
                        cb(false);
                    }                    
                } else {
                    cb(false);
                }
            };
        };

        GCBSelf.InitPromise.then(queue);
    }

    this.GetPersonal = function (type, cb, endCb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var index = objectStore.index("Personal");
            var isDataExist = false;
            var FavoIndexStr;

            if (type == 0) {
                FavoIndexStr = "Favo";
            } else if (type == 1) {
                FavoIndexStr = "History";
            } else {
                endCb(isDataExist);
                return;
            }
            //var count = index.count();
            index.openCursor(FavoIndexStr).onsuccess = function (event) {
                var cursor = event.target.result;
                if (cursor) {
                    isDataExist = true;
                    cb(cursor.value);
                    cursor.continue();
                } else {
                    endCb(isDataExist);
                }
            };
        };

        GCBSelf.InitPromise.then(queue);
    }

    /**
     *  搜尋，取交集
     * @param {any} GameBrand 遊戲廠牌
     * @param {any} GameCategoryCode 遊戲分類
     * @param {any} GameCategorySubCode 遊戲次分類(使用時請連遊戲分類一起給)
     * @param {any} SearchKeyWord   搜尋關鍵字(如果為5位數內的數字，視為GameID做搜尋，並回傳單一GameItem)
     * @param {any} cb  迭代fun
     * @param {any} endCb   結束fun(isDataExist) => isDataExist=true 有資料, isDataExist=false 無資料
     */
    this.CursorGetByMultiSearch = function (GameBrand, GameCategoryCode, GameCategorySubCode, SearchKeyWord, cb, endCb) {
        var queue = () => {
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
                var range = IDBKeyRange.bound([GameBrand, 0], [GameBrand, 99])
                request = objectStore.index("GameBrand").openCursor(range, "prev");
            } else if (GameCategoryCode && GameCategorySubCode) {
                var range = IDBKeyRange.bound([GameBrand, GameCategorySubCode, 0], [GameCategoryCode, GameCategorySubCode, 99])
                request = objectStore.index("GameCategorySubCode").openCursor(range, "prev");
            } else if (GameCategoryCode) {
                var range = IDBKeyRange.bound([GameCategoryCode, 0], [GameCategoryCode, 99])
                request = objectStore.index("GameCategoryCode").openCursor(range, "prev");
            } else if (SearchKeyWord) {
                request = objectStore.index("SearchKeyWord").openCursor(SearchKeyWord.toLowerCase());
                isSearchKeyRequest = true;
            } else {
                endCb(isDataExist);
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
                                if (gameCodeItem.Language[i].DisplayText.toLowerCase().includes(SearchKeyWord.toLowerCase())) {
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
                    if (isDataExist == false && isSearchKeyRequest) {
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
                                    if (gameCodeItem.Language[i].DisplayText.toLowerCase().includes(SearchKeyWord.toLowerCase())) {
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
                                    GCBSelf.updateByKeywordSearch(updateDatas, SearchKeyWord.toLowerCase());
                                    endCb(isDataExist);
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
        };

        GCBSelf.InitPromise.then(queue);
    }

    /**
 *  搜尋，取交集
 * @param {any} GameBrands 遊戲廠牌
 * @param {any} GameCategoryCode 遊戲分類
 * @param {any} GameCategorySubCode 遊戲次分類(使用時請連遊戲分類一起給)
 * @param {any} SearchKeyWord   搜尋關鍵字(如果為5位數內的數字，視為GameID做搜尋，並回傳單一GameItem)
 * @param {any} cb  迭代fun
 * @param {any} endCb   結束fun(isDataExist) => isDataExist=true 有資料, isDataExist=false 無資料
 */
    this.CursorGetByMultiSearch2 = function (GameBrands, GameCategoryCode, GameCategorySubCode, SearchKeyWord, cb, endCb) {
        var queue = () => {
            var transaction = GCBSelf.IndexedDB.transaction(['GameCodes'], 'readonly');
            var objectStore = transaction.objectStore('GameCodes');
            var mainPromise = Promise.resolve(false);
            var getPromiseForGameBrand = (GameBrand, GameCategoryCode, GameCategorySubCode, SearchKeyWord, cb) => {
                return (PreviousDataExist) => {
                    return new Promise((resolve, reject) => {
                        //var index = null;
                        var request;
                        var searchGameID;
                        var isSearchKeyRequest;
                        var isDataExist = PreviousDataExist;

                        if (SearchKeyWord && SearchKeyWord.length < 6) {
                            //如果關鍵字為GameID，特別拉出來做處理，由於結果一定為單一值，不做複合搜尋
                            var searchGameID = Number(SearchKeyWord);

                            if (searchGameID) {
                                if (isDataExist) {
                                    resolve(isDataExist);                                    
                                } else {
                                    objectStore.index("GameID").openCursor(searchGameID).onsuccess = function (event) {
                                        var cursor = event.target.result;
                                        if (cursor) {
                                            isDataExist = true;
                                            cb(cursor.value);
                                            resolve(isDataExist);
                                        } else {
                                            resolve(isDataExist);
                                        }
                                    };
                                }

                                return;                                                           
                            }
                        }


                        if (GameBrand) {
                            var range = IDBKeyRange.bound([GameBrand, 0], [GameBrand, 99])
                            request = objectStore.index("GameBrand").openCursor(range, "prev");
                        } else if (GameCategoryCode && GameCategorySubCode) {
                            var range = IDBKeyRange.bound([GameBrand, GameCategorySubCode, 0], [GameCategoryCode, GameCategorySubCode, 99])
                            request = objectStore.index("GameCategorySubCode").openCursor(range, "prev");
                        } else if (GameCategoryCode) {
                            var range = IDBKeyRange.bound([GameCategoryCode, 0], [GameCategoryCode, 99])
                            request = objectStore.index("GameCategoryCode").openCursor(range, "prev");
                        } else if (SearchKeyWord) {
                            request = objectStore.index("SearchKeyWord").openCursor(SearchKeyWord.toLowerCase());
                            isSearchKeyRequest = true;
                        } else {
                            resolve(isDataExist);
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
                                            if (gameCodeItem.Language[i].DisplayText.toLowerCase().includes(SearchKeyWord.toLowerCase())) {
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
                                if (isDataExist == false && isSearchKeyRequest) {
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
                                                if (gameCodeItem.Language[i].DisplayText.toLowerCase().includes(SearchKeyWord.toLowerCase())) {
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
                                                GCBSelf.updateByKeywordSearch(updateDatas, SearchKeyWord.toLowerCase());
                                                resolve(isDataExist);
                                            } else {
                                                resolve(isDataExist);
                                            }
                                        }
                                    }
                                } else {
                                    resolve(isDataExist);
                                }
                            }
                        };;
                    })
                };
            };

            if (GameBrands && GameBrands.length > 0) {
                for (var i = 0; i < GameBrands.length; i++) {
                    var funReturnPromise = getPromiseForGameBrand(GameBrands[i], GameCategoryCode, GameCategorySubCode, SearchKeyWord, cb);
                    mainPromise = mainPromise.then(funReturnPromise);
                }
            } else {
                mainPromise = mainPromise.then(getPromiseForGameBrand("", GameCategoryCode, GameCategorySubCode, SearchKeyWord, cb))
            }

            mainPromise.then(endCb);
        }
 
        GCBSelf.InitPromise.then(queue);
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

    this.InitPromise;

    this.NotifyGameLoadEnd = notifyGameLoadEnd;

    init();
}