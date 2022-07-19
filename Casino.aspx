<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
%>
<!doctype html>
<html class="innerHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja3</title>
    <link href="Scripts/vendor/swiper/css/swiper-bundle.min.css" rel="stylesheet" />
    <link href="css/basic.min.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <link href="css/lobby.css" rel="stylesheet" />
    <!--===========JS========-->
    <script type="text/javascript" src="/Scripts/Common.js?<%:Version%>"></script>
    <%--<script type="text/javascript" src="/Scripts/UIControl.js"></script>--%>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/lozad.min.js"></script>
    <script src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
    <script src="Scripts/vendor/swiper/js/swiper-bundle.min.js"></script>
    <style>
        .title-showAll:hover {
            cursor: pointer;
        }
    </style>
</head>
<%--<script type="text/javascript" src="/Scripts/Common.js?<%:Version%>"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script src="Scripts/OutSrc/lib/jquery/jquery.min.js"></script>
<script src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
<script src="Scripts/OutSrc/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/OutSrc/lib/swiper/js/swiper-bundle.min.js"></script>
<script src="Scripts/theme.js"></script>--%>
<%--<script src="Scripts/OutSrc/js/games.js"></script>--%>


<script type="text/javascript">      
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    //var ui = new uiControl();
    var c = new common();
    var mlp;
    var sumask;
    var Webinfo;
    var p;
    var LobbyGameList;
    var lang;
    var nowGameBrand = "All";
    var gameBrandList = [];
    var v = "";
    var GCB;
    var iframeWidth;
    var selectedCategoryCode;
    var categoryDatas = [];
    var tmpCategory_GameList_All = "";
    var tmpCategory_GameList_Live = "";
    var tmpCategory_GameList_Electron = "";
    var tmpCategory_GameList_Other = "";
    var tmpCategory_GameList_Slot = "";
    var selectedCategorys = [];
    function showSearchGameModel() {
        window.parent.API_ShowSearchGameModel();
    }

    function loginRecover() {
        window.location.href = "LoginRecover.aspx";
    }

    function selGameCategory(categoryCode, doc) {
        selectedCategoryCode = categoryCode;
        selectedCategory = $('#idGameItemTitle .tab-item.active>span>span').attr('langkey');
        $('#idGameItemTitle .tab-item').removeClass('active');
        $(doc).addClass('active');
        if (!selectedCategorys.includes(categoryCode)) {
            createCategory(categoryCode, function () {
                //$('#categoryPage_' + selectedCategory).css('content-visibility', 'hidden');
                //$('#categoryPage_' + categoryCode).css('content-visibility', 'auto');

                $('#categoryPage_' + selectedCategory).css('height', '0');
                
                $('#categoryPage_' + categoryCode).css('height', 'auto');
                setSwiper(categoryCode);
            });
        } else {
            $('#categoryPage_' + selectedCategory).css('height', '0');
            $('#categoryPage_' + categoryCode).css('height', 'auto');
        }

        window.document.body.scrollTop = 0;
        window.document.documentElement.scrollTop = 0;
    }

    function setSwiper(categoryName) {
        new Swiper(".GameItemGroup_" + categoryName, {
            slidesPerView: "auto",
            // loop:true,
            // slidesPerGroup: 2,
            // loopedSlides: 8,
            lazy: true,
            freeMode: true,
            navigation: {
                nextEl: ".GameItemGroup_" + categoryName + " .swiper-button-next",
                prevEl: ".GameItemGroup_" + categoryName + " .swiper-button-prev",
            },
            breakpoints: {

                936: {
                    freeMode: false,
                    slidesPerGroup: 6, //index:992px
                },
                1144: {
                    slidesPerGroup: 7, //index:1200px
                    allowTouchMove: false, //拖曳
                },
                1384: {
                    slidesPerGroup: 7, //index:1440px
                    allowTouchMove: false,
                },
                1544: {
                    slidesPerGroup: 7, //index:1600px
                    allowTouchMove: false,
                },
                1864: {
                    slidesPerGroup: 8, //index:1920px
                    allowTouchMove: false,
                },
                1920: {
                    slidesPerGroup: 8, //index:1920px up
                    allowTouchMove: false,
                }
            }
        });
    }
    //人氣,搜長,slot,live,其他,品牌
    async function createCategory(categoryName, cb) {

        if (LobbyGameList) {

            var lobbyGame = LobbyGameList.find(function (o) {
                return o.Location == categoryName;
            });

            if (lobbyGame) {
                selectedCategorys.push(categoryName);
                var Location = lobbyGame.Location;
                var categAreas = "";

                for (var i = 0; i < lobbyGame.Categories.length; i++) {
                    category = lobbyGame.Categories[i];
                    if (category) {

                        if (category.Datas.length > 0) {
                            var categArea;
                            var textlink;
                            var gameItems = "";
                    
                            for (var ii = 0; ii < category.Datas.length; ii++) {
                                var o = category.Datas[ii];

                                var GI;
                                var btnlike;
                                var GItitle;
                                var gameitemlink;
                                var btnplay;
                                var imgsrc;
                                var gameName;
                                var appendGameProp;
                                var gameItem = await new Promise((resolve, reject) => {
                                    GCB.GetByGameCode(o.GameCode, (gameItem) => {
                                        resolve(gameItem);
                                    })
                                });
                             
                                if (gameItem) {
                                    gameName = gameItem.Language.find(x => x.LanguageCode == lang) ? gameItem.Language.find(x => x.LanguageCode == lang).DisplayText : "";
                                    var gameitemmobilepopup = '<span class="game-item-mobile-popup" data-toggle="modal"></span>';
                                    if (gameItem.FavoTimeStamp) {
                                        btnlike = `<button type="button" class="btn-like gameCode_${gameItem.GameCode} btn btn-round added" onclick="favBtnClcik('${gameItem.GameCode}')">`;
                                    } else {
                                        btnlike = `<button type="button" class="btn-like gameCode_${gameItem.GameCode} btn btn-round" onclick="favBtnClcik('${gameItem.GameCode}')">`;
                                    }

                                    var RTP = "";
                                    if (gameItem.RTPInfo) {
                                        var RtpInfoObj = JSON.parse(gameItem.RTPInfo);

                                        if (RtpInfoObj.RTP && RtpInfoObj.RTP != 0) {
                                            RTP = RtpInfoObj.RTP.toString();
                                        } else {
                                            RTP = '--';
                                        }
                                    } else {
                                        RTP = '--';
                                    }

                                    if (iframeWidth < 936) {
                                        GItitle = `<div class="swiper-slide ${'gameid_' + gameItem.GameID}">`;
                                        btnplay = '<button type="button" class="btn btn-play">';
                                        gameitemlink = `<span class="game-item-link"></span>`;
                                        gameitemmobilepopup = `<span class="game-item-mobile-popup" data-toggle="modal" onclick="window.parent.API_MobileDeviceGameInfo('${gameItem.GameBrand}','${RTP}','${gameItem.GameName}',${gameItem.GameID})"></span>`;
                                        //gameitemlink = `<span class="game-item-link" onclick="window.parent.API_MobileDeviceGameInfo('${gameItem.GameBrand}','${RTP}','${gameItem.GameName}',${gameItem.GameID})"></span>`;
                                    } else {
                                        gameitemmobilepopup = '<span class="game-item-mobile-popup" data-toggle="modal"></span>';
                                        GItitle = `<div class="swiper-slide ${'gameid_' + gameItem.GameID}">`;
                                        gameitemlink = '<span class="game-item-link" onmouseover="' + "appendGameProp('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameName + "','" + RTP + "','" + gameItem.GameID + "','" + gameItem.FavoTimeStamp + "','" + gameItem.GameCode +"')" + '" onclick="' + "window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameName + "')" + '"></span>';
                                        btnplay = '<button type="button" class="btn btn-play" onclick="' + "window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameName + "')" + '">';
                                    }

                                    imgsrc = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + WebInfo.Lang + "/" + gameItem.GameName + ".png";


                                    GI = `${GItitle}
                        <div class="game-item">
<div class="game-item-inner">
${gameitemmobilepopup}
<div class="game-item-focus">
    <div class="game-item-img">
        ${gameitemlink}
        <div class="img-wrap">
            <img class="gameimg lozad" src="${imgsrc}">
        </div>
    </div>
 
</div>
<div class="game-item-info">
    <div class="game-item-info-inner">
        <h3 class="game-item-name"></h3>
    </div>
</div>
</div>
                        </div>
                    </div>`;

                                    gameItems += GI;
                                }
                            }
                       
                            categName = category.CategoryName.replace('@', '').replace('#', '');
                            gameBrand = category.Datas[0].GameBrand;
                            if (iframeWidth < 936) {
                                textlink = '';
                            } else {
                                textlink = `<a class="text-link">
                    <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('${gameBrand}')">${mlp.getLanguageKey('全部顯示')}</span><i class="icon arrow arrow-right"></i>
                    </a>`;
                            }

                            if (category.SortIndex >= 90) {
                                categArea = ` <section class="section-wrap section-levelUp">
                    <div class="game_wrapper">
                    <div class="sec-title-container">
                    <div class="sec-title-wrapper">
                    <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('${gameBrand}')">${mlp.getLanguageKey(categName)}</span></h3>
                    </div>
                    ${textlink}
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup_${Location}">
                    <div class="swiper-wrapper GameItemGroupContent">
                    ${gameItems}
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    </div>
                    </div>
                    </section>`;
                            } else {
                                categArea = ` <section class="section-wrap section-levelUp">
                    <div class="game_wrapper">
                    <div class="sec-title-container">
                    <div class="sec-title-wrapper">
                    <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="language_replace title CategName langkey">${mlp.getLanguageKey(categName)}</span></h3>
                    </div>
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup_${Location}">
                    <div class="swiper-wrapper GameItemGroupContent">
                    ${gameItems}
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                    </div>
                    </div>
                    </section>`;

                            }
                            for (var iii = 0; iii < 10; iii++) {
                                categAreas += categArea;
                            }
                       
                        }
                    }
                }

                //var categoryDiv = $('<div id="categoryPage_' + Location + '" class="categoryPage" style="content-visibility:hidden"></div>');
                var categoryDiv = $('<div id="categoryPage_' + Location + '" class="categoryPage" style="height:0;overflow-y:hidden;overflow-x:hidden;"></div>');
            
                categoryDiv.append(categAreas);
                $('#gameAreas').append(categoryDiv);
                cb();

            }
        }
    }

    function appendGameProp(gameBrand, gameName, gameLangName, RTP, gameID, favoTimeStamp, gameCode) {
      
        var doc = event.currentTarget;
        var jquerydoc = $(doc).parent().parent().eq(0);
        var btnlike;
        var btnplay;

        if (!jquerydoc.hasClass('addedGameProp')) {
            if (favoTimeStamp) {
                btnlike = `<button type="button" class="btn-like gameCode_${gameCode} btn btn-round added" onclick="favBtnClcik('${gameCode}')">`;
            } else {
                btnlike = `<button type="button" class="btn-like gameCode_${gameCode} btn btn-round" onclick="favBtnClcik('${gameCode}')">`;
            }

            btnplay = '<button type="button" class="btn btn-play" onclick="' + "window.parent.openGame('" + gameBrand + "', '" + gameName + "','" + gameLangName + "')" + '">';

            var gameProp = `<div class="game-item-info-detail open">
        <div class="game-item-info-detail-wrapper">
            <div class="game-item-info-detail-moreInfo">
                <ul class="moreInfo-item-wrapper">
                    <li class="moreInfo-item brand">
                        <span class="title language_replace">品牌</span>
                        <span class="value GameBrand">${gameBrand}</span>
                    </li>
                    <li class="moreInfo-item RTP">
                        <span class="title">RTP</span>
                        <span class="value number valueRTP">${RTP}</span>
                    </li>
                    <li class="moreInfo-item gamecode">
                        <span class="title">NO.</span>
                        <span class="value number GameID">${gameID}</span>
                    </li>
                </ul>
            </div>
            <div class="game-item-info-detail-indicator">
                <div class="game-item-info-detail-indicator-inner">
                    <div class="info">
                        <h3 class="game-item-name">${gameName}</h3>
                    </div>
                    <div class="action"
                        <div class="btn-s-wrapper">
<button type="button" class="btn-thumbUp btn btn-round">
<i class="icon icon-m-thumup"></i>
</button>
                            ${btnlike}
<i class="icon icon-m-favorite"></i>
</button>
<button type="button" class="btn-more btn btn-round" onclick="$(this).closest('.game-item-info-detail').toggleClass('open');">
<i class="arrow arrow-down"></i>
</button>
                        </div>
                        ${btnplay}
<span class="language_replace">遊玩</span><i class="triangle"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>`;
            jquerydoc.append(gameProp);
            jquerydoc.addClass('addedGameProp');
        }

      

    };

    function favBtnClcik(gameCode) {
        var btn = event.currentTarget;
        event.stopPropagation();

        if ($(btn).hasClass("added")) {
            $(btn).removeClass("added");
            GCB.RemoveFavo(gameCode, function () {
                window.parent.API_RefreshPersonalFavo(gameCode, false);
                window.parent.API_ShowMessageOK(mlp.getLanguageKey("我的最愛"), mlp.getLanguageKey("已移除我的最愛"));
            });
        } else {
            $(btn).addClass("added");
            GCB.AddFavo(gameCode, function () {
                window.parent.API_RefreshPersonalFavo(gameCode, true);
                window.parent.API_ShowMessageOK(mlp.getLanguageKey("我的最愛"), mlp.getLanguageKey("已加入我的最愛"));
            });
        }
    }

    function updateGameCode() {
        iframeWidth = window.innerWidth;
        var idGameItemTitle = document.getElementById("idGameItemTitle");
        idGameItemTitle.innerHTML = "";
        // 尋找新增+
        var RecordDom;
        var record;

        if (LobbyGameList) {
            for (var i = 0; i < LobbyGameList.length; i++) {
                LobbyGameList[i].Categories.sort(function (a, b) {
                    return a.SortIndex - b.SortIndex;
                });
            }

            for (var i = 0; i < LobbyGameList.length; i++) {
                var lobbyGame = LobbyGameList[i];
                if (lobbyGame.Location.includes("GameList")) {
                    RecordDom = c.getTemplate("temCategItem");
                    c.setClassText(RecordDom, "CategName", null, mlp.getLanguageKey(lobbyGame.Location));
                    $(RecordDom).find('.CategName').attr('langkey', lobbyGame.Location);
                    switch (lobbyGame.Location) {
                        case 'GameList_Hot':
                            $(RecordDom).find('.CategIcon').addClass('icon-hot-tt');
                            break;
                        case 'GameList_Favo':
                            $(RecordDom).find('.CategIcon').addClass('icon-favo-tt');
                            break;
                        case 'GameList_Live':
                            $(RecordDom).find('.CategIcon').addClass('icon-live-tt');
                            break;
                        case 'GameList_Slot':
                            $(RecordDom).find('.CategIcon').addClass('icon-slot-tt');
                            break;
                        case 'GameList_Other':
                            $(RecordDom).find('.CategIcon').addClass('icon-etc-tt');
                            break;
                        case 'GameList_Brand':
                            $(RecordDom).find('.CategIcon').addClass('icon-brand-tt');
                            break;
                        default:
                    }
                    RecordDom.onclick = new Function("selGameCategory('" + lobbyGame.Location + "',this)");
                    idGameItemTitle.appendChild(RecordDom);
                }
            }

            $('#idGameItemTitle').append('<div class="tab-slide"></div>');
        }

        selectedCategoryCode = "GameList_Slot";
        iframeWidth = window.innerWidth;
        var idGameItemGroup = document.getElementById("gameAreas");
        idGameItemGroup.innerHTML = "";

        createCategory(selectedCategoryCode, function () {
            //$('#categoryPage_' + selectedCategoryCode).css('content-visibility', 'auto');
            $('#idGameItemTitle .tab-item').eq(0).addClass('active');
    
            $('#categoryPage_' + selectedCategoryCode).css('height', 'auto');
            $('#categoryPage_' + selectedCategoryCode).css('overflow-y', 'hidden');

            setSwiper(selectedCategoryCode);
        });

    }

    function resetCategory(categoryCode) {

        selectedCategorys = [];
        var idGameItemGroup = document.getElementById("gameAreas");
        idGameItemGroup.innerHTML = "";
        iframeWidth = window.innerWidth;
        createCategory(categoryCode, function () {
            //$('.categoryPage').css('content-visibility', 'hidden');
            //$('#categoryPage_' + categoryCode).css('content-visibility', 'auto');

            $('.categoryPage').css('height', '0');
            $('.categoryPage').css('overflow-y', 'hidden');

            $('#categoryPage_' + categoryCode).css('height', 'auto');
            $('#categoryPage_' + categoryCode).css('overflow-y', 'hidden');
            setSwiper(categoryCode);
        });

    }

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        GCB = window.parent.API_GetGCB();
        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();

        lang = window.parent.API_GetLang();

        var heroLobby = new Swiper("#hero-slider-lobby", {
            loop: true,
            // slidesPerView: 1,
            slidesPerView: "auto",
            centeredSlides: true,
            // freeMode: true,
            // spaceBetween: 20,  
            speed: 1000, //Duration of transition between slides (in ms)
            // autoplay: {
            //     delay: 3500,
            //     disableOnInteraction: false,
            // },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },

        });

        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            if (p != null) {
                if (GCB.IsFirstLoaded) {
                    getCompanyGameCode();
                    window.parent.API_LoadingEnd();
                }
            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }


        });
    }

    function getCompanyGameCode() {
        p.GetCompanyGameCodeThree(Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.LobbyGameList.length > 0) {
                        LobbyGameList = o.LobbyGameList;
                        updateGameCode();
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                            window.parent.location.href = "index.aspx";
                        });
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                        window.parent.location.href = "index.aspx";
                    });
                }
            }
            else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }

        });
    }

    function setDefaultIcon(brand, name) {
        var img = event.currentTarget;
        img.onerror = null;
        img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + brand + "/PC/" + WebInfo.Lang + "/" + name + ".png";
    }

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":
                //updateBaseInfo();

                break;
            case "BalanceChange":
                break;
            case "resize":

                if ((iframeWidth > param && param < 936) || (iframeWidth < param && param > 936)) {
                    resetCategory(selectedCategoryCode);
                }

                break;
            case "RefreshPersonalFavo":
                //window.parent.API_LoadingEnd();
                var selector = "." + ("gameCode_" + param.GameCode + ".btn-like").replace(".", "\\.");
             
                if (param.IsAdded) {
                    $(selector).addClass("added");
                } else {
                    $(selector).removeClass("added");
                }
                break;
            case "SetLanguage":
                lang = param;

                mlp.loadLanguage(lang, function () {
                    window.parent.API_LoadingEnd(1);
                    resetCategory(selectedCategoryCode);
                });
                break;

        }
    }

    window.onload = init;

   
</script>

<body class="innerBody">
    <main class="innerMain">
        <section class="section-slider_lobby hero">
            <div class="hero_slider_lobby swiper_container round-arrow" id="hero-slider-lobby">
                <div class="swiper-wrapper">
                    <!-- <div class="swiper-slide">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('','ActivityCenter.aspx?type=6')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/bng/bng2207/img/gameroom-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/bng/bng2207/img/gameroom-l.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('','ActivityCenter.aspx?type=4')"></a>
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/pp-slot-s.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/pp-slot.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('','ActivityCenter.aspx?type=5')"></a>
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/pp-live-s.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/pp-live.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <!-- <a class="hero-item-link" href="#"></a> -->
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/newopen-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/newopen-2.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <!-- <a class="hero-item-link" href="#"></a> -->
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/evo-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/evo-2.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <!-- <a class="hero-item-link" href="#"></a> -->
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/PNG-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/PNG-2.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="swiper-pagination"></div>
            </div>
        </section>
        <div class="tab-game">
            <div class="tab-inner">
                <div class="tab-search" onclick="showSearchGameModel()">
                    <img src="images/icon/ico-search-dog-tt.svg" alt=""><span class="title language_replace">找遊戲</span>
                </div>
                <div class="tab-scroller tab-5">
                    <div class="tab-scroller__area">
                        <ul class="tab-scroller__content" id="idGameItemTitle">
                            <div class="tab-slide"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- 各分類-單一遊戲推薦區 -->
        <section class="section-category-dailypush" style="display: ;">
            <div class="container">
                <!-- SLOT -->
                <div class="category-dailypush-wrapper slot">
                    <div class="category-dailypush-inner">
                        <div class="category-dailypush-img" style="background-color: #121a16;">
                            <div class="img-box mobile">
                                <div class="img-wrap">
                                    <img src="images/lobby/dailypush-slot-M-001.jpg" alt="">
                                </div>
                            </div>
                            <div class="img-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/dailypush-slot-001.jpg" alt="">
                                </div>
                            </div>
                        </div>
                        <div class="category-dailypush-cotentBox">
                            <div class="category-dailypush-cotent">
                                <h2 class="title language_replace">本日優選推薦</h2>
                                <div class="info">
                                    <h3 class="gamename language_replace">月亮守護者</h3>
                                    <div class="detail">
                                        <span class="gamebrand">PNG</span>
                                        <span class="gamecategory">SLOT</span>
                                    </div>
                                </div>
                                <div class="intro language_replace">
                                    遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                                </div>
                                <div class="action">
                                    <button class="btn btn-play"><span class="language_replace">進入遊戲</span></button>
                                    <!-- 加入最愛 class=>added-->
                                    <button type="button" class="btn-like btn btn-round">
                                        <i class="icon icon-m-favorite"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- REAL -->                
            </div>
        </section>
        <section class="game-area overflow-hidden">
            <div class="container" id="gameAreas">
            </div>
        </section>
         <!-- 遊戲-排名區-->
         <section class="game-area overflow-hidden">
            <div class="container">
                <section class="section-wrap section-levelUp"> 
                    <div class="game_wrapper gameRanking">
                        <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="">排名</span></h3>
                        </div>
                        </div>
                        <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow" id="idGameRanking">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PNG/PC/JPN/moonprincess.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
    
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
    
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/hip-hop-panda.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
    
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
    
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
    
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
    
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <li class="moreInfo-item brand">
                                                                    <span class="title">メーカー</span>
                                                                    <span class="value">PG</span>
                                                                </li>
                                                                <li class="moreInfo-item RTP">
                                                                    <span class="title">RTP</span>
                                                                    <span class="value number">96.66</span>
                                                                </li>
                                                                <li class="moreInfo-item gamecode">
                                                                    <span class="title">NO.</span>
                                                                    <span class="value number">00976</span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="game-item-info-detail-indicator">
                                                            <div class="game-item-info-detail-indicator-inner">
                                                                <div class="info">
                                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                                </div>
                                                                <div class="action">
                                                                    <div class="btn-s-wrapper">
                                                                        <button type="button" class="btn-thumbUp btn btn-round">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="game-item-info">
                                                <div class="game-item-info-inner">
                                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                    </div>
            </section>
            </div> 
         </section>
       


    </main>

    <div id="temCategItem" class="is-hide">
        <li class="tab-item">
            <span class="tab-item-link"><i class="icon icon-mask CategIcon"></i>
                <span class="title language_replace CategName"></span></span>
        </li>
    </div>
</body>
<script>
     // 遊戲排名 TEST
     var GameRanking = new Swiper("#idGameRanking", {    
        slidesPerView: "auto",
        lazy: true,
        freeMode: true,
        navigation: {
            nextEl: "#idGameRanking .swiper-button-next",
            prevEl: "#idGameRanking .swiper-button-prev",
        },
        breakpoints: {
            936: {
                    freeMode: false,
                    slidesPerGroup: 6, //index:992px
                },
                1144: {
                    slidesPerGroup: 7, //index:1200px
                    allowTouchMove: false, //拖曳
                },
                1384: {
                    slidesPerGroup: 7, //index:1440px
                    allowTouchMove: false,
                },
                1544: {
                    slidesPerGroup: 7, //index:1600px
                    allowTouchMove: false,
                },
                1864: {
                    slidesPerGroup: 8, //index:1920px
                    allowTouchMove: false,
                },
                1920: {
                    slidesPerGroup: 8, //index:1920px up
                    allowTouchMove: false,
                },
        }

    });
    
</script>
</html>

