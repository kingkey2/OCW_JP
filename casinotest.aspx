<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;

    string selectedCategory = "GameList_Hot";

    if (string.IsNullOrEmpty(Request["selectedCategory"]) == false) {
        selectedCategory = Request["selectedCategory"];
    }
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
    <!-- 菲律賓站 -->
    <link href="css/ph.css" rel="stylesheet">
    <link href="css/lobby.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />
    <!--===========JS========-->
    <script type="text/javascript" src="/Scripts/Common.js?<%:Version%>"></script>
    <%--<script type="text/javascript" src="/Scripts/UIControl.js"></script>--%>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lozad.js/1.16.0/lozad.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.1/swiper-bundle.min.js"></script>
    <script src="https://genieedmp.com/dmp.js?c=6780&ver=2" async></script>

    <style>
        .title-showAll:hover {
            cursor: pointer;
        }

        .game-item-info-detail {
            cursor: pointer;
        }
    </style>
</head>

<script>
    var mlp;
    var lang;
    var ESID = "";
    var Webinfo;
    var p;
    var GCB;
    var v = "";

    function init() {
        ESID = window.top.SID_E;
        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        GCB = window.parent.API_GetGCB();
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

        var heroLobby1 = new Swiper("#div1", {
            slidesPerView: "auto",
            lazy: true,
            freeMode: true,
            allowTouchMove: false,
            navigation: {
                nextEl: "#div1 .swiper-button-next",
                prevEl: "#div1 .swiper-button-prev",
            },
            breakpoints: {

                936: {
                    freeMode: false,
                    slidesPerGroup: 6, //index:992px
                },
                1144: {
                    slidesPerGroup: 7, //index:1200px
                    //allowTouchMove: false, //拖曳
                },
                1384: {
                    slidesPerGroup: 7, //index:1440px
                    //allowTouchMove: false,
                },
                1544: {
                    slidesPerGroup: 7, //index:1600px
                    //allowTouchMove: false,
                },
                1864: {
                    slidesPerGroup: 8, //index:1920px
                    //allowTouchMove: false,
                },
                1920: {
                    slidesPerGroup: 8, //index:1920px up
                    //allowTouchMove: false,
                }
            }
        });

        window.parent.API_LoadingEnd();

        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {

        });
    }

    function appendGameProp(gameBrand, gameLangName, RTP, gameID, gameCode, showType, gameCategoryCode, gameName) {

        var doc = event.currentTarget;
        var jquerydoc = $(doc).parent().parent().eq(0);
        var btnlike;
        var gameProp;
        var _gameCategoryCode;

        const promise = new Promise((resolve, reject) => {
            GCB.GetByGameCode(gameCode, (gameItem) => {
                resolve(gameItem.FavoTimeStamp);
            })
        });
        promise.then((favoTimeStamp) => {

            switch (gameCategoryCode) {
                case "Electron":
                    _gameCategoryCode = "elec";
                    break;
                case "Live":
                    _gameCategoryCode = "live";
                    break;
                case "Slot":
                    _gameCategoryCode = "slot";
                    break;
                default:
                    _gameCategoryCode = "etc";
                    break;
            }

            if (!jquerydoc.hasClass('addedGameProp')) {
                if (favoTimeStamp != null) {
                    if (WebInfo.DeviceType == 1) {
                        btnlike = `<button type="button" class="btn-like gameCode_${gameCode} btn btn-round added" onclick="favBtnClcik('${gameCode}')">`;
                    } else {
                        btnlike = `<button type="button" class="btn-like desktop gameCode_${gameCode} btn btn-round added" onclick="favBtnClcik('${gameCode}')">`;
                    }

                } else {
                    if (WebInfo.DeviceType == 1) {
                        btnlike = `<button type="button" class="btn-like gameCode_${gameCode} btn btn-round" onclick="favBtnClcik('${gameCode}')">`;
                    } else {
                        btnlike = `<button type="button" class="btn-like desktop gameCode_${gameCode} btn btn-round" onclick="favBtnClcik('${gameCode}')">`;
                    }

                }
                // onclick="' + "window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameName + "')" 
                //<!-- 判斷分類 加入class=> slot/live/etc/elec-->
                if (showType != 2) {
                    gameProp = `<div class="game-item-info-detail open" onclick="window.parent.openGame('${gameBrand}','${gameName}','${gameLangName}')">
                                <div class="game-item-info-detail-wrapper">
                                    <div class="game-item-info-detail-moreInfo">
                                        <ul class="moreInfo-item-wrapper">
                                            <li class="moreInfo-item category ${_gameCategoryCode}">
                                                <span class="value"><i class="icon icon-mask"></i></span>
                                            </li>
                                            <li class="moreInfo-item brand">
                                                <span class="title language_replace">${"廠牌"}</span>
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
                                                <h3 class="game-item-name" style="font-size: 0.8rem;">${ESID}</h3>
                                            </div>
                                            <div class="action">
                                                <div class="btn-s-wrapper">
                                                    <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                        <i class="icon icon-m-thumup"></i>
                                                    </button>
                                                     ${btnlike}
                                                        <i class="icon icon-m-favorite"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="game-item-info-detail-indicator-inner">
                                            <div class="info">
                                                <h3 class="game-item-name">${gameLangName}</h3>
                                            </div>
                                            <div class="action">
                                                <div class="btn-s-wrapper">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>`;

                    jquerydoc.append(gameProp);
                }
                jquerydoc.addClass('addedGameProp');
            }

        });
    };

    function tabclick(k) {
        $(".divGameAreas").hide();
        $("#idGameItemTitle .tab-item").removeClass("active");
        $("#idGameItemTitle .tab-item").eq(k).addClass("active");

        switch (k) {
            case 0:
                $("#gameAreas0").show();
                break;
            case 1:
                $("#gameAreas1").show();
                break;
            case 2:
                $("#gameAreas2").show();
                break;
            case 3:
                $("#gameAreas3").show();
                break;
            case 4:
                $("#gameAreas4").show();
                break;
        }
    }

    window.onload = init;
</script>

<body class="innerBody">
    <main class="innerMain">
        <!-- <section class="section-slider_lobby hero">
            <div class="hero_slider_lobby swiper_container round-arrow swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" id="hero-slider-lobby">
                <div class="swiper-wrapper" id="swiper-wrapper-acdfe95a3c47ec107" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-4939.6px, 0px, 0px);">
                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=30')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/mahaEvent/src/202303-m.png" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/mahaEvent/src/202303.png" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=29')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/pp202302-2/img/pp-liveJp-s.png">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/pp202302-2/img/pp-liveJp.png" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="3 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=28')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/pp202302-1/img/pp-slotJp-s.jpg">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/pp202302-1/img/pp-slotJp.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="3" role="group" aria-label="4 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','/Article/guide-TripleCrown_JPN.html?Page=CasinoPage')"></a>
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/crown-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/crown.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="5 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=30')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/mahaEvent/src/202303-m.png" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/mahaEvent/src/202303.png" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-next" data-swiper-slide-index="1" role="group" aria-label="6 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=29')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/pp202302-2/img/pp-liveJp-s.png">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/pp202302-2/img/pp-liveJp.png" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide" data-swiper-slide-index="2" role="group" aria-label="7 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=28')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/pp202302-1/img/pp-slotJp-s.jpg">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/pp202302-1/img/pp-slotJp.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="swiper-slide swiper-slide-duplicate-prev" data-swiper-slide-index="3" role="group" aria-label="8 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','/Article/guide-TripleCrown_JPN.html?Page=CasinoPage')"></a>
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/crown-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/crown.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="9 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=30')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/mahaEvent/src/202303-m.png" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/mahaEvent/src/202303.png" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="10 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=29')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/pp202302-2/img/pp-liveJp-s.png">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/pp202302-2/img/pp-liveJp.png" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="11 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=28')"></a>
                            <div class="hero-item-box mobile">
                                <img src="Activity/event/pp202302-1/img/pp-slotJp-s.jpg">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="Activity/event/pp202302-1/img/pp-slotJp.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="12 / 12">
                        <div class="hero-item">
                            <a class="hero-item-link" onclick="window.parent.API_LoadPage('ActivityCenter','/Article/guide-TripleCrown_JPN.html?Page=CasinoPage')"></a>
                            <div class="hero-item-box mobile">
                                <img src="images/lobby/crown-m.jpg" alt="">
                            </div>
                            <div class="hero-item-box desktop">
                                <div class="img-wrap">
                                    <img src="images/lobby/crown.jpg" class="bg">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active" tabindex="0" role="button" aria-label="Go to slide 1"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 2"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 3"></span><span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 4"></span></div>
                <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
            </div>
        </section> -->
        <div class="tab-game">
            <div class="tab-inner">
                 <%--<div class="tab-search" onclick="showSearchGameModel()">
                    <img src="images/icon/ico-search-dog-tt.svg" alt=""><span class="title language_replace" langkey="找遊戲">找遊戲</span>
                </div> --%>
                <div class="tab-scroller tab-6">
                    <div class="tab-scroller__area">
                        <ul class="tab-scroller__content" id="idGameItemTitle">
                            <li class="tab-item active" onclick="tabclick(0)">
                                <span class="tab-item-link"><i class="icon icon-mask CategIcon icon-hot-tt"></i>
                                    <span class="title language_replace CategName" langkey="GameList_Hot">熱門</span></span>
                            </li>
                            <li class="tab-item" onclick="tabclick(1)">
                                <span class="tab-item-link"><i class="icon icon-mask CategIcon icon-slot-tt"></i>
                                    <span class="title language_replace CategName" langkey="GameList_Slot">老虎機</span></span>
                            </li>
                            <li class="tab-item" onclick="tabclick(2)">
                                <span class="tab-item-link"><i class="icon icon-mask CategIcon icon-live-tt"></i>
                                    <span class="title language_replace CategName" langkey="GameList_Live">真人</span></span>
                            </li>
                            <li class="tab-item" onclick="tabclick(3)">
                                <span class="tab-item-link"><i class="icon icon-mask CategIcon icon-etc-tt"></i>
                                    <span class="title language_replace CategName" langkey="GameList_Other">其他</span></span>
                            </li>
                            <li class="tab-item" onclick="tabclick(4)">
                                <span class="tab-item-link"><i class="icon icon-mask CategIcon icon-brand-tt"></i>
                                    <span class="title language_replace CategName" langkey="GameList_Brand">品牌</span></span>
                            </li>
                            <div class="tab-slide"></div>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- 各分類-單一遊戲推薦區 -->

        <section class="game-area overflow-hidden">
            <div id="gameAreas0" class="divGameAreas">
                <div id="categoryPage_GameList_Hot" class="categoryPage" style="display: block;">
                    <!-- <div class="container category-dailypush">
                        <section class="section-category-dailypush" onclick="window.parent.openGame('CQ9', '179','跳高高2')">
                            <div class="category-dailypush-wrapper hot  ">
                                <div class="category-dailypush-inner">
                                    <div class="category-dailypush-img" style="background-color: #000000;">
                                        <div class="img-box mobile">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-hot-M-001.jpg" alt="">
                                            </div>
                                        </div>
                                        <div class="img-box pad">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-hot-MD-001.jpg" alt="">
                                            </div>
                                        </div>
                                        <div class="img-box desktop">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-hot-001.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="category-dailypush-cotentBox">
                                        <div class="category-dailypush-cotent">
                                            <h2 class="title language_replace">本日優選推薦測試頁</h2>
                                            <div class="info">
                                                <h3 class="gamename language_replace">跳高高2</h3>
                                                <div class="detail">
                                                    <span class="gamebrand">CQ9</span>
                                                    <span class="gamecategory">老虎機</span>
                                                </div>
                                            </div>
                                            <div class="intro language_replace is-hide">
                                                遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                               
                                            </div>
                                            <div class="action">
                                                <button class="btn btn-play" onclick="window.parent.openGame('CQ9', '179','跳高高2')"><span class="language_replace">進入遊戲</span></button>
                                                加入最愛 class=>added
                                                <button type="button" class="btn-like desktop gameCode_CQ9.179 btn btn-round" onclick="favBtnClcik('CQ9.179')">
                                                    <i class="icon icon-m-favorite"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div> -->
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title">
                                            <!-- <i class="icon icon-mask icon-star"></i> -->
                                            <span class="language_replace title CategName langkey">熱門品牌</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode" id="div1">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-1916eb47d419c817" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_10335 swiper-slide-active" role="group" aria-label="1 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-001.png" onerror="showDefauktGameIcon('PG', 'SLOT-001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PG','SLOT-001','夜戲貂蟬')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10335</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PG.SLOT-001 btn btn-round" onclick="favBtnClcik('PG.SLOT-001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">夜戲貂蟬</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">夜戲貂蟬</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10336 swiper-slide-next" role="group" aria-label="2 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-002.png" onerror="showDefauktGameIcon('PG', 'SLOT-002')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PG','SLOT-002','寶石俠')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10336</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PG.SLOT-002 btn btn-round added" onclick="favBtnClcik('PG.SLOT-002')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">寶石俠</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">寶石俠</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10337" role="group" aria-label="3 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-003.png" onerror="showDefauktGameIcon('PG', 'SLOT-003')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PG','SLOT-003','橫財來啦')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10337</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PG.SLOT-003 btn btn-round" onclick="favBtnClcik('PG.SLOT-003')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">橫財來啦</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">橫財來啦</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10338" role="group" aria-label="4 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-005.png" onerror="showDefauktGameIcon('PG', 'SLOT-005')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PG','SLOT-005','美杜莎 II')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10338</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PG.SLOT-005 btn btn-round" onclick="favBtnClcik('PG.SLOT-005')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">美杜莎 II</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">美杜莎 II</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10339" role="group" aria-label="5 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-006.png" onerror="showDefauktGameIcon('PG', 'SLOT-006')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PG','SLOT-006','美杜莎')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10339</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PG.SLOT-006 btn btn-round" onclick="favBtnClcik('PG.SLOT-006')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">美杜莎</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">美杜莎</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10340" role="group" aria-label="6 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-008.png" onerror="showDefauktGameIcon('PG', 'SLOT-008')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PG','SLOT-008','巫師之書')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10340</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PG.SLOT-008 btn btn-round" onclick="favBtnClcik('PG.SLOT-008')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">巫師之書</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">巫師之書</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10341" role="group" aria-label="7 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="showSearchGameModel()"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-009.png" onerror="showDefauktGameIcon('PG', 'SLOT-009')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">逆襲的小紅帽</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10342" role="group" aria-label="8 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-011','旺旺旺')" onmouseover="appendGameProp('PG','旺旺旺','--','10342','PG.SLOT-011',0,'Slot','SLOT-011')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-011.png" onerror="showDefauktGameIcon('PG', 'SLOT-011')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">旺旺旺</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10343" role="group" aria-label="9 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-012','抓抓樂')" onmouseover="appendGameProp('PG','抓抓樂','--','10343','PG.SLOT-012',0,'Slot','SLOT-012')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-012.png" onerror="showDefauktGameIcon('PG', 'SLOT-012')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">抓抓樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10344" role="group" aria-label="10 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-013','搖錢樹')" onmouseover="appendGameProp('PG','搖錢樹','--','10344','PG.SLOT-013',0,'Slot','SLOT-013')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-013.png" onerror="showDefauktGameIcon('PG', 'SLOT-013')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">搖錢樹</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10345" role="group" aria-label="11 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-015','麻辣火鍋')" onmouseover="appendGameProp('PG','麻辣火鍋','--','10345','PG.SLOT-015',0,'Slot','SLOT-015')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-015.png" onerror="showDefauktGameIcon('PG', 'SLOT-015')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">麻辣火鍋</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10346" role="group" aria-label="12 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-016','魚躍龍門')" onmouseover="appendGameProp('PG','魚躍龍門','--','10346','PG.SLOT-016',0,'Slot','SLOT-016')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-016.png" onerror="showDefauktGameIcon('PG', 'SLOT-016')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">魚躍龍門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10347" role="group" aria-label="13 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-017','嘻哈熊貓')" onmouseover="appendGameProp('PG','嘻哈熊貓','--','10347','PG.SLOT-017',0,'Slot','SLOT-017')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-017.png" onerror="showDefauktGameIcon('PG', 'SLOT-017')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">嘻哈熊貓</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10348" role="group" aria-label="14 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-018','后羿射日')" onmouseover="appendGameProp('PG','后羿射日','--','10348','PG.SLOT-018',0,'Slot','SLOT-018')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-018.png" onerror="showDefauktGameIcon('PG', 'SLOT-018')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">后羿射日</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10349" role="group" aria-label="15 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-019','萬勝狂歡夜')" onmouseover="appendGameProp('PG','萬勝狂歡夜','--','10349','PG.SLOT-019',0,'Slot','SLOT-019')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-019.png" onerror="showDefauktGameIcon('PG', 'SLOT-019')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">萬勝狂歡夜</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10350" role="group" aria-label="16 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-020','舞獅進寶')" onmouseover="appendGameProp('PG','舞獅進寶','--','10350','PG.SLOT-020',0,'Slot','SLOT-020')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-020.png" onerror="showDefauktGameIcon('PG', 'SLOT-020')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">舞獅進寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10351" role="group" aria-label="17 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-021','聖誕歡樂送')" onmouseover="appendGameProp('PG','聖誕歡樂送','--','10351','PG.SLOT-021',0,'Slot','SLOT-021')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-021.png" onerror="showDefauktGameIcon('PG', 'SLOT-021')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">聖誕歡樂送</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10352" role="group" aria-label="18 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-022','寶石俠-大寶劍')" onmouseover="appendGameProp('PG','寶石俠-大寶劍','--','10352','PG.SLOT-022',0,'Slot','SLOT-022')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-022.png" onerror="showDefauktGameIcon('PG', 'SLOT-022')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">寶石俠-大寶劍</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10353" role="group" aria-label="19 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-023','金豬報財')" onmouseover="appendGameProp('PG','金豬報財','--','10353','PG.SLOT-023',0,'Slot','SLOT-023')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-023.png" onerror="showDefauktGameIcon('PG', 'SLOT-023')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">金豬報財</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10354" role="group" aria-label="20 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-024','水果叢林')" onmouseover="appendGameProp('PG','水果叢林','--','10354','PG.SLOT-024',0,'Slot','SLOT-024')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-024.png" onerror="showDefauktGameIcon('PG', 'SLOT-024')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">水果叢林</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10355" role="group" aria-label="21 / 21">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PG', 'SLOT-025','埃及尋寶')" onmouseover="appendGameProp('PG','埃及尋寶','--','10355','PG.SLOT-025',0,'Slot','SLOT-025')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PG/CHT/SLOT-025.png" onerror="showDefauktGameIcon('PG', 'SLOT-025')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">埃及尋寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-1916eb47d419c817" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-1916eb47d419c817" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <!-- <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">Maharaja，人氣遊戲推薦</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-583f2c3f2477c631" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_3957 swiper-slide-active" role="group" aria-label="1 / 2">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '200','跑跑愛麗絲')" onmouseover="appendGameProp('CQ9','跑跑愛麗絲','96.05','3957','CQ9.200',0,'Electron','200')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/200.png" onerror="showDefauktGameIcon('CQ9', '200')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('CQ9','200','跑跑愛麗絲')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category elec">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">CQ9</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.05</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">3957</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_CQ9.200 btn btn-round" onclick="favBtnClcik('CQ9.200')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">跑跑愛麗絲</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">跑跑愛麗絲</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_673 swiper-slide-next" role="group" aria-label="2 / 2">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs1600drago','群龍保珠-寶石致富')" onmouseover="appendGameProp('PP','群龍保珠-寶石致富','96.5','673','PP.vs1600drago',0,'Slot','vs1600drago')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs1600drago.png" onerror="showDefauktGameIcon('PP', 'vs1600drago')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs1600drago','群龍保珠-寶石致富')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">673</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs1600drago btn btn-round" onclick="favBtnClcik('PP.vs1600drago')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">群龍保珠-寶石致富</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">群龍保珠-寶石致富</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-583f2c3f2477c631" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-583f2c3f2477c631" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp gameRanking">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">New Game！火熱登場</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=1 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-4f8100b464b1ea819" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_10143 swiper-slide-active" role="group" aria-label="1 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningBac0001','閃電百家樂')" onmouseover="appendGameProp('EVO','閃電百家樂','--','10143','EVO.LightningBac0001',1,'Live','LightningBac0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningBac0001.png" onerror="showDefauktGameIcon('EVO', 'LightningBac0001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','LightningBac0001','閃電百家樂')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10143</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.LightningBac0001 btn btn-round" onclick="favBtnClcik('EVO.LightningBac0001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">閃電百家樂</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10325 swiper-slide-next" role="group" aria-label="2 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'TopCard000000001','足球廳')" onmouseover="appendGameProp('EVO','足球廳','--','10325','EVO.TopCard000000001',1,'Live','TopCard000000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/TopCard000000001.png" onerror="showDefauktGameIcon('EVO', 'TopCard000000001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','TopCard000000001','足球廳')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">10325</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.TopCard000000001 btn btn-round" onclick="favBtnClcik('EVO.TopCard000000001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">足球廳</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6168" role="group" aria-label="3 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KX', '620','德州撲克')" onmouseover="appendGameProp('KX','德州撲克','97','6168','KX.620',1,'Electron','620')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KX/CHT/620.png" onerror="showDefauktGameIcon('KX', '620')">
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6642" role="group" aria-label="4 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'pyramidsofdead','Cat Wilde 之金字塔亡者')" onmouseover="appendGameProp('PNG','Cat Wilde 之金字塔亡者','96.5','6642','PNG.pyramidsofdead',1,'Slot','pyramidsofdead')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/pyramidsofdead.png" onerror="showDefauktGameIcon('PNG', 'pyramidsofdead')">
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6620" role="group" aria-label="5 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'wildtrigger','狂野百搭')" onmouseover="appendGameProp('PNG','狂野百搭','96.2','6620','PNG.wildtrigger',1,'Slot','wildtrigger')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/wildtrigger.png" onerror="showDefauktGameIcon('PNG', 'wildtrigger')">
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-4f8100b464b1ea819" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-4f8100b464b1ea819" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp gameRanking">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">戰勝疫情，在家安心玩遊戲</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=1 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-3df5c173d7cc4bed" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_727 swiper-slide-active" role="group" aria-label="1 / 1">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20starlight','星光公主')" onmouseover="appendGameProp('PP','星光公主','94.5','727','PP.vs20starlight',1,'Slot','vs20starlight')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20starlight.png" onerror="showDefauktGameIcon('PP', 'vs20starlight')">
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-3df5c173d7cc4bed" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-3df5c173d7cc4bed" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section> -->
                    </div>
                    <!-- <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Hot swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-3574887689fce1049" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-930px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_3800 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('CQ9', '188','板球狂熱')" onmouseover="appendGameProp('CQ9','板球狂熱','95.97','3800','CQ9.188',2,'Slot','188')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/188.png" onerror="showDefauktGameIcon('CQ9', '188')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">板球狂熱</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 5; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10245 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'GonzoTH000000001','岡佐的尋寶之旅')" onmouseover="appendGameProp('EVO','岡佐的尋寶之旅','--','10245','EVO.GonzoTH000000001',2,'Live','GonzoTH000000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/GonzoTH000000001.png" onerror="showDefauktGameIcon('EVO', 'GonzoTH000000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">岡佐的尋寶之旅</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 4; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3144 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="3 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'aztecidols','阿茲特克人像')" onmouseover="appendGameProp('PNG','阿茲特克人像','96.65','3144','PNG.aztecidols',2,'Slot','aztecidols')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/aztecidols.png" onerror="showDefauktGameIcon('PNG', 'aztecidols')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">阿茲特克人像</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 3; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3314 swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="4 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'reactoonz','外星實驗室')" onmouseover="appendGameProp('PNG','外星實驗室','96.51','3314','PNG.reactoonz',2,'Slot','reactoonz')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/reactoonz.png" onerror="showDefauktGameIcon('PNG', 'reactoonz')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">外星實驗室</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_727 swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="4" role="group" aria-label="5 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20starlight','星光公主')" onmouseover="appendGameProp('PP','星光公主','94.5','727','PP.vs20starlight',2,'Slot','vs20starlight')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20starlight.png" onerror="showDefauktGameIcon('PP', 'vs20starlight')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">星光公主</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3800 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="6 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('CQ9', '188','板球狂熱')" onmouseover="appendGameProp('CQ9','板球狂熱','95.97','3800','CQ9.188',2,'Slot','188')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/188.png" onerror="showDefauktGameIcon('CQ9', '188')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">板球狂熱</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10245 swiper-slide-next" data-swiper-slide-index="1" role="group" aria-label="7 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'GonzoTH000000001','岡佐的尋寶之旅')" onmouseover="appendGameProp('EVO','岡佐的尋寶之旅','--','10245','EVO.GonzoTH000000001',2,'Live','GonzoTH000000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/GonzoTH000000001.png" onerror="showDefauktGameIcon('EVO', 'GonzoTH000000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">岡佐的尋寶之旅</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3144" data-swiper-slide-index="2" role="group" aria-label="8 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'aztecidols','阿茲特克人像')" onmouseover="appendGameProp('PNG','阿茲特克人像','96.65','3144','PNG.aztecidols',2,'Slot','aztecidols')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/aztecidols.png" onerror="showDefauktGameIcon('PNG', 'aztecidols')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">阿茲特克人像</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3314" data-swiper-slide-index="3" role="group" aria-label="9 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'reactoonz','外星實驗室')" onmouseover="appendGameProp('PNG','外星實驗室','96.51','3314','PNG.reactoonz',2,'Slot','reactoonz')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/reactoonz.png" onerror="showDefauktGameIcon('PNG', 'reactoonz')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">外星實驗室</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_727 swiper-slide-duplicate-prev" data-swiper-slide-index="4" role="group" aria-label="10 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(-80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20starlight','星光公主')" onmouseover="appendGameProp('PP','星光公主','94.5','727','PP.vs20starlight',2,'Slot','vs20starlight')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20starlight.png" onerror="showDefauktGameIcon('PP', 'vs20starlight')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">星光公主</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 4; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3800 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="11 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(-100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('CQ9', '188','板球狂熱')" onmouseover="appendGameProp('CQ9','板球狂熱','95.97','3800','CQ9.188',2,'Slot','188')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/188.png" onerror="showDefauktGameIcon('CQ9', '188')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">板球狂熱</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 5; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10245 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="12 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1800px) rotateX(0deg) rotateY(-120deg) scale(1); z-index: -5;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'GonzoTH000000001','岡佐的尋寶之旅')" onmouseover="appendGameProp('EVO','岡佐的尋寶之旅','--','10245','EVO.GonzoTH000000001',2,'Live','GonzoTH000000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/GonzoTH000000001.png" onerror="showDefauktGameIcon('EVO', 'GonzoTH000000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">岡佐的尋寶之旅</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 6; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3144 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="13 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2100px) rotateX(0deg) rotateY(-140deg) scale(1); z-index: -6;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'aztecidols','阿茲特克人像')" onmouseover="appendGameProp('PNG','阿茲特克人像','96.65','3144','PNG.aztecidols',2,'Slot','aztecidols')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/aztecidols.png" onerror="showDefauktGameIcon('PNG', 'aztecidols')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">阿茲特克人像</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 7; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3314 swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="14 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2400px) rotateX(0deg) rotateY(-160deg) scale(1); z-index: -7;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'reactoonz','外星實驗室')" onmouseover="appendGameProp('PNG','外星實驗室','96.51','3314','PNG.reactoonz',2,'Slot','reactoonz')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/reactoonz.png" onerror="showDefauktGameIcon('PNG', 'reactoonz')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">外星實驗室</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 8; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_727 swiper-slide-duplicate" data-swiper-slide-index="4" role="group" aria-label="15 / 15" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2700px) rotateX(0deg) rotateY(-180deg) scale(1); z-index: -8;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20starlight','星光公主')" onmouseover="appendGameProp('PP','星光公主','94.5','727','PP.vs20starlight',2,'Slot','vs20starlight')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20starlight.png" onerror="showDefauktGameIcon('PP', 'vs20starlight')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">星光公主</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 9; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">Maharja Top 10</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-96bf1c156e3cf5c5" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_547 swiper-slide-active" role="group" aria-label="1 / 2">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', '401','真人百家樂')" onmouseover="appendGameProp('PP','真人百家樂','--','547','PP.401',0,'Live','401')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/401.png" onerror="showDefauktGameIcon('PP', '401')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">真人百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_727 swiper-slide-next" role="group" aria-label="2 / 2">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20starlight','星光公主')" onmouseover="appendGameProp('PP','星光公主','94.5','727','PP.vs20starlight',0,'Slot','vs20starlight')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20starlight.png" onerror="showDefauktGameIcon('PP', 'vs20starlight')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">星光公主</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-96bf1c156e3cf5c5" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-96bf1c156e3cf5c5" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">歐洲大人氣！</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-2e19c109109312d8e" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_10291 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', '01rb77cq1gtenhmo','VIP 自動輪盤')" onmouseover="appendGameProp('EVO','VIP 自動輪盤','--','10291','EVO.01rb77cq1gtenhmo',0,'Live','01rb77cq1gtenhmo')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/01rb77cq1gtenhmo.png" onerror="showDefauktGameIcon('EVO', '01rb77cq1gtenhmo')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">VIP 自動輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10124 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'BacBo00000000001','百家寶')" onmouseover="appendGameProp('EVO','百家寶','--','10124','EVO.BacBo00000000001',0,'Live','BacBo00000000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/BacBo00000000001.png" onerror="showDefauktGameIcon('EVO', 'BacBo00000000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">百家寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10238" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'DragonTiger00001','龍虎')" onmouseover="appendGameProp('EVO','龍虎','--','10238','EVO.DragonTiger00001',0,'Live','DragonTiger00001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/DragonTiger00001.png" onerror="showDefauktGameIcon('EVO', 'DragonTiger00001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">龍虎</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10143" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningBac0001','閃電百家樂')" onmouseover="appendGameProp('EVO','閃電百家樂','--','10143','EVO.LightningBac0001',0,'Live','LightningBac0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningBac0001.png" onerror="showDefauktGameIcon('EVO', 'LightningBac0001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">閃電百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10190" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'sni5cza6d1vvl50i','派對式二十一點')" onmouseover="appendGameProp('EVO','派對式二十一點','--','10190','EVO.sni5cza6d1vvl50i',0,'Live','sni5cza6d1vvl50i')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/sni5cza6d1vvl50i.png" onerror="showDefauktGameIcon('EVO', 'sni5cza6d1vvl50i')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">派對式二十一點</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3255" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'jacksorbetter','傑克高手')" onmouseover="appendGameProp('PNG','傑克高手','95','3255','PNG.jacksorbetter',0,'Electron','jacksorbetter')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/jacksorbetter.png" onerror="showDefauktGameIcon('PNG', 'jacksorbetter')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">傑克高手</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3282" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'moonprincess','月亮守護者')" onmouseover="appendGameProp('PNG','月亮守護者','96.5','3282','PNG.moonprincess',0,'Slot','moonprincess')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/moonprincess.png" onerror="showDefauktGameIcon('PNG', 'moonprincess')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">月亮守護者</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3327" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'riseofolympus','奧林匹斯之巔')" onmouseover="appendGameProp('PNG','奧林匹斯之巔','96.5','3327','PNG.riseofolympus',0,'Slot','riseofolympus')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/riseofolympus.png" onerror="showDefauktGameIcon('PNG', 'riseofolympus')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之巔</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3348" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'superwheel','超級旋轉')" onmouseover="appendGameProp('PNG','超級旋轉','92.31','3348','PNG.superwheel',0,'Electron','superwheel')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/superwheel.png" onerror="showDefauktGameIcon('PNG', 'superwheel')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級旋轉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3350" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'sweetalchemy','魔力 小甜心')" onmouseover="appendGameProp('PNG','魔力 小甜心','96.52','3350','PNG.sweetalchemy',0,'Slot','sweetalchemy')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/sweetalchemy.png" onerror="showDefauktGameIcon('PNG', 'sweetalchemy')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">魔力 小甜心</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-2e19c109109312d8e" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-2e19c109109312d8e" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">撲克系列大集結</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-1103e5312e63857da" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_10164 swiper-slide-active" role="group" aria-label="1 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'ejx1a04w4ben0mou','富貴二十一點')" onmouseover="appendGameProp('EVO','富貴二十一點','--','10164','EVO.ejx1a04w4ben0mou',0,'Live','ejx1a04w4ben0mou')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/ejx1a04w4ben0mou.png" onerror="showDefauktGameIcon('EVO', 'ejx1a04w4ben0mou')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">富貴二十一點</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10135 swiper-slide-next" role="group" aria-label="2 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'NoCommBac0000001','免佣百家樂')" onmouseover="appendGameProp('EVO','免佣百家樂','--','10135','EVO.NoCommBac0000001',0,'Live','NoCommBac0000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/NoCommBac0000001.png" onerror="showDefauktGameIcon('EVO', 'NoCommBac0000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">免佣百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5845" role="group" aria-label="3 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '866','四倍紅利撲克5手')" onmouseover="appendGameProp('HB','四倍紅利撲克5手','98.98','5845','HB.866',0,'Electron','866')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/866.png" onerror="showDefauktGameIcon('HB', '866')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">四倍紅利撲克5手</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6196" role="group" aria-label="4 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KX', '8250','十點半')" onmouseover="appendGameProp('KX','十點半','97','6196','KX.8250',0,'Electron','8250')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KX/CHT/8250.png" onerror="showDefauktGameIcon('KX', '8250')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">十點半</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_520" role="group" aria-label="5 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', '1024','安達巴哈爾')" onmouseover="appendGameProp('PP','安達巴哈爾','--','520','PP.1024',0,'Live','1024')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/1024.png" onerror="showDefauktGameIcon('PP', '1024')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">安達巴哈爾</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_600" role="group" aria-label="6 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'bjma','21點之富貴臨門')" onmouseover="appendGameProp('PP','21點之富貴臨門','99.62','600','PP.bjma',0,'Electron','bjma')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/bjma.png" onerror="showDefauktGameIcon('PP', 'bjma')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">21點之富貴臨門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-1103e5312e63857da" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-1103e5312e63857da" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Hot swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-b7459142ee5d15b5" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-1190px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_3327 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1800px) rotateX(0deg) rotateY(120deg) scale(1); z-index: -5;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'riseofolympus','奧林匹斯之巔')" onmouseover="appendGameProp('PNG','奧林匹斯之巔','96.5','3327','PNG.riseofolympus',2,'Slot','riseofolympus')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/riseofolympus.png" onerror="showDefauktGameIcon('PNG', 'riseofolympus')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">奧林匹斯之巔</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 6; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3338 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'sistersofthesun','太陽神姐妹')" onmouseover="appendGameProp('PNG','太陽神姐妹','96.2','3338','PNG.sistersofthesun',2,'Slot','sistersofthesun')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/sistersofthesun.png" onerror="showDefauktGameIcon('PNG', 'sistersofthesun')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">太陽神姐妹</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 5; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3367 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="3 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'trollhunters','巨魔獵人')" onmouseover="appendGameProp('PNG','巨魔獵人','96.69','3367','PNG.trollhunters',2,'Slot','trollhunters')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/trollhunters.png" onerror="showDefauktGameIcon('PNG', 'trollhunters')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">巨魔獵人</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 4; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_839 swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="4 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysaztecking','阿茲特克國王Megaways')" onmouseover="appendGameProp('PP','阿茲特克國王Megaways','95.59','839','PP.vswaysaztecking',2,'Slot','vswaysaztecking')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysaztecking.png" onerror="showDefauktGameIcon('PP', 'vswaysaztecking')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">阿茲特克國王Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 3; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_843 swiper-slide-duplicate" data-swiper-slide-index="4" role="group" aria-label="5 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysdogs','汪汪之家Megaways')" onmouseover="appendGameProp('PP','汪汪之家Megaways','96.55','843','PP.vswaysdogs',2,'Slot','vswaysdogs')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysdogs.png" onerror="showDefauktGameIcon('PP', 'vswaysdogs')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">汪汪之家Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_849 swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="5" role="group" aria-label="6 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysrhino','巨大犀牛 Megaways')" onmouseover="appendGameProp('PP','巨大犀牛 Megaways','96.58','849','PP.vswaysrhino',2,'Slot','vswaysrhino')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysrhino.png" onerror="showDefauktGameIcon('PP', 'vswaysrhino')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">巨大犀牛 Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3327 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="7 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'riseofolympus','奧林匹斯之巔')" onmouseover="appendGameProp('PNG','奧林匹斯之巔','96.5','3327','PNG.riseofolympus',2,'Slot','riseofolympus')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/riseofolympus.png" onerror="showDefauktGameIcon('PNG', 'riseofolympus')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">奧林匹斯之巔</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3338 swiper-slide-next" data-swiper-slide-index="1" role="group" aria-label="8 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'sistersofthesun','太陽神姐妹')" onmouseover="appendGameProp('PNG','太陽神姐妹','96.2','3338','PNG.sistersofthesun',2,'Slot','sistersofthesun')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/sistersofthesun.png" onerror="showDefauktGameIcon('PNG', 'sistersofthesun')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">太陽神姐妹</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3367" data-swiper-slide-index="2" role="group" aria-label="9 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'trollhunters','巨魔獵人')" onmouseover="appendGameProp('PNG','巨魔獵人','96.69','3367','PNG.trollhunters',2,'Slot','trollhunters')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/trollhunters.png" onerror="showDefauktGameIcon('PNG', 'trollhunters')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">巨魔獵人</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_839" data-swiper-slide-index="3" role="group" aria-label="10 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysaztecking','阿茲特克國王Megaways')" onmouseover="appendGameProp('PP','阿茲特克國王Megaways','95.59','839','PP.vswaysaztecking',2,'Slot','vswaysaztecking')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysaztecking.png" onerror="showDefauktGameIcon('PP', 'vswaysaztecking')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">阿茲特克國王Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_843" data-swiper-slide-index="4" role="group" aria-label="11 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(-80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysdogs','汪汪之家Megaways')" onmouseover="appendGameProp('PP','汪汪之家Megaways','96.55','843','PP.vswaysdogs',2,'Slot','vswaysdogs')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysdogs.png" onerror="showDefauktGameIcon('PP', 'vswaysdogs')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">汪汪之家Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 4; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_849 swiper-slide-duplicate-prev" data-swiper-slide-index="5" role="group" aria-label="12 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(-100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysrhino','巨大犀牛 Megaways')" onmouseover="appendGameProp('PP','巨大犀牛 Megaways','96.58','849','PP.vswaysrhino',2,'Slot','vswaysrhino')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysrhino.png" onerror="showDefauktGameIcon('PP', 'vswaysrhino')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">巨大犀牛 Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 5; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3327 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="13 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1800px) rotateX(0deg) rotateY(-120deg) scale(1); z-index: -5;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'riseofolympus','奧林匹斯之巔')" onmouseover="appendGameProp('PNG','奧林匹斯之巔','96.5','3327','PNG.riseofolympus',2,'Slot','riseofolympus')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/riseofolympus.png" onerror="showDefauktGameIcon('PNG', 'riseofolympus')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">奧林匹斯之巔</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 6; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3338 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="14 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2100px) rotateX(0deg) rotateY(-140deg) scale(1); z-index: -6;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'sistersofthesun','太陽神姐妹')" onmouseover="appendGameProp('PNG','太陽神姐妹','96.2','3338','PNG.sistersofthesun',2,'Slot','sistersofthesun')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/sistersofthesun.png" onerror="showDefauktGameIcon('PNG', 'sistersofthesun')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">太陽神姐妹</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 7; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3367 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="15 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2400px) rotateX(0deg) rotateY(-160deg) scale(1); z-index: -7;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PNG', 'trollhunters','巨魔獵人')" onmouseover="appendGameProp('PNG','巨魔獵人','96.69','3367','PNG.trollhunters',2,'Slot','trollhunters')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/trollhunters.png" onerror="showDefauktGameIcon('PNG', 'trollhunters')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">巨魔獵人</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 8; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_839 swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="16 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2700px) rotateX(0deg) rotateY(-180deg) scale(1); z-index: -8;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysaztecking','阿茲特克國王Megaways')" onmouseover="appendGameProp('PP','阿茲特克國王Megaways','95.59','839','PP.vswaysaztecking',2,'Slot','vswaysaztecking')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysaztecking.png" onerror="showDefauktGameIcon('PP', 'vswaysaztecking')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">阿茲特克國王Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 9; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_843 swiper-slide-duplicate" data-swiper-slide-index="4" role="group" aria-label="17 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -3000px) rotateX(0deg) rotateY(-200deg) scale(1); z-index: -9;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysdogs','汪汪之家Megaways')" onmouseover="appendGameProp('PP','汪汪之家Megaways','96.55','843','PP.vswaysdogs',2,'Slot','vswaysdogs')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysdogs.png" onerror="showDefauktGameIcon('PP', 'vswaysdogs')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">汪汪之家Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 10; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_849 swiper-slide-duplicate" data-swiper-slide-index="5" role="group" aria-label="18 / 18" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -3300px) rotateX(0deg) rotateY(-220deg) scale(1); z-index: -10;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysrhino','巨大犀牛 Megaways')" onmouseover="appendGameProp('PP','巨大犀牛 Megaways','96.58','849','PP.vswaysrhino',2,'Slot','vswaysrhino')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysrhino.png" onerror="showDefauktGameIcon('PP', 'vswaysrhino')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">巨大犀牛 Megaways</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 11; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">侏羅紀公園！怪獸風格SLOT</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-c5e9337c68b48702" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_3891 swiper-slide-active" role="group" aria-label="1 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '197','盤龍秘寶')" onmouseover="appendGameProp('CQ9','盤龍秘寶','96.14','3891','CQ9.197',0,'Slot','197')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/197.png" onerror="showDefauktGameIcon('CQ9', '197')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">盤龍秘寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3904 swiper-slide-next" role="group" aria-label="2 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '70','萬飽龍')" onmouseover="appendGameProp('CQ9','萬飽龍','96.07','3904','CQ9.70',0,'Slot','70')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/70.png" onerror="showDefauktGameIcon('CQ9', '70')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">萬飽龍</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3185" role="group" aria-label="3 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'demon','惡魔')" onmouseover="appendGameProp('PNG','惡魔','96.51','3185','PNG.demon',0,'Slot','demon')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/demon.png" onerror="showDefauktGameIcon('PNG', 'demon')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">惡魔</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_3352" role="group" aria-label="4 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PNG', 'taleofkyubiko','九尾狐自傳')" onmouseover="appendGameProp('PNG','九尾狐自傳','96.29','3352','PNG.taleofkyubiko',0,'Slot','taleofkyubiko')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PNG/CHT/taleofkyubiko.png" onerror="showDefauktGameIcon('PNG', 'taleofkyubiko')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">九尾狐自傳</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-c5e9337c68b48702" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-c5e9337c68b48702" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">Hot!EVO，全球高人氣Live遊戲</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Hot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-37b6c194d2ff3194" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_10124 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'BacBo00000000001','百家寶')" onmouseover="appendGameProp('EVO','百家寶','--','10124','EVO.BacBo00000000001',0,'Live','BacBo00000000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/BacBo00000000001.png" onerror="showDefauktGameIcon('EVO', 'BacBo00000000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">百家寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10227 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'Craps00000000001','花旗骰')" onmouseover="appendGameProp('EVO','花旗骰','--','10227','EVO.Craps00000000001',0,'Live','Craps00000000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/Craps00000000001.png" onerror="showDefauktGameIcon('EVO', 'Craps00000000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">花旗骰</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10245" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'GonzoTH000000001','岡佐的尋寶之旅')" onmouseover="appendGameProp('EVO','岡佐的尋寶之旅','--','10245','EVO.GonzoTH000000001',0,'Live','GonzoTH000000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/GonzoTH000000001.png" onerror="showDefauktGameIcon('EVO', 'GonzoTH000000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">岡佐的尋寶之旅</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10143" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningBac0001','閃電百家樂')" onmouseover="appendGameProp('EVO','閃電百家樂','--','10143','EVO.LightningBac0001',0,'Live','LightningBac0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningBac0001.png" onerror="showDefauktGameIcon('EVO', 'LightningBac0001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">閃電百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10254" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MegaBall00000001','')" onmouseover="appendGameProp('EVO','','--','10254','EVO.MegaBall00000001',0,'Live','MegaBall00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MegaBall00000001.png" onerror="showDefauktGameIcon('EVO', 'MegaBall00000001')">
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
                                        </div>
                                        <div class="swiper-slide desktop gameid_10256" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MOWDream00000001','追夢轉盤')" onmouseover="appendGameProp('EVO','追夢轉盤','--','10256','EVO.MOWDream00000001',0,'Live','MOWDream00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MOWDream00000001.png" onerror="showDefauktGameIcon('EVO', 'MOWDream00000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">追夢轉盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10153" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'oytmvb9m1zysmc44','百家樂A桌')" onmouseover="appendGameProp('EVO','百家樂A桌','--','10153','EVO.oytmvb9m1zysmc44',0,'Live','oytmvb9m1zysmc44')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/oytmvb9m1zysmc44.png" onerror="showDefauktGameIcon('EVO', 'oytmvb9m1zysmc44')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">百家樂A桌</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10190" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'sni5cza6d1vvl50i','派對式二十一點')" onmouseover="appendGameProp('EVO','派對式二十一點','--','10190','EVO.sni5cza6d1vvl50i',0,'Live','sni5cza6d1vvl50i')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/sni5cza6d1vvl50i.png" onerror="showDefauktGameIcon('EVO', 'sni5cza6d1vvl50i')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">派對式二十一點</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10325" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'TopCard000000001','足球廳')" onmouseover="appendGameProp('EVO','足球廳','--','10325','EVO.TopCard000000001',0,'Live','TopCard000000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/TopCard000000001.png" onerror="showDefauktGameIcon('EVO', 'TopCard000000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">足球廳</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_10309" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'wzg6kdkad1oe7m5k','尊貴輪盤')" onmouseover="appendGameProp('EVO','尊貴輪盤','--','10309','EVO.wzg6kdkad1oe7m5k',0,'Live','wzg6kdkad1oe7m5k')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/wzg6kdkad1oe7m5k.png" onerror="showDefauktGameIcon('EVO', 'wzg6kdkad1oe7m5k')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">尊貴輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-37b6c194d2ff3194" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-37b6c194d2ff3194" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div> -->
                </div>
            </div>

            <div id="gameAreas1" class="divGameAreas" style="display: none">
                <div id="categoryPage_GameList_Slot" class="categoryPage" style="display: block;">
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">PP ，一番人気SLOT</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-1872c64d7210366b1" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6397 swiper-slide-active" role="group" aria-label="1 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20fruitsw','甜入心扉')" onmouseover="appendGameProp('PP','甜入心扉','96.5','6397','PP.vs20fruitsw',0,'Slot','vs20fruitsw')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20fruitsw.png" onerror="showDefauktGameIcon('PP', 'vs20fruitsw')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs20fruitsw','甜入心扉')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6397</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs20fruitsw btn btn-round" onclick="favBtnClcik('PP.vs20fruitsw')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6366 swiper-slide-next" role="group" aria-label="2 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysdogs','汪汪之家Megaways')" onmouseover="appendGameProp('PP','汪汪之家Megaways','96.55','6366','PP.vswaysdogs',0,'Slot','vswaysdogs')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysdogs.png" onerror="showDefauktGameIcon('PP', 'vswaysdogs')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vswaysdogs','汪汪之家Megaways')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.55</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6366</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vswaysdogs btn btn-round" onclick="favBtnClcik('PP.vswaysdogs')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">汪汪之家Megaways</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">汪汪之家Megaways</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6378" role="group" aria-label="3 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswaysmadame','命運女巫Megaways')" onmouseover="appendGameProp('PP','命運女巫Megaways','96.56','6378','PP.vswaysmadame',0,'Slot','vswaysmadame')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswaysmadame.png" onerror="showDefauktGameIcon('PP', 'vswaysmadame')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vswaysmadame','命運女巫Megaways')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.56</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6378</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vswaysmadame btn btn-round" onclick="favBtnClcik('PP.vswaysmadame')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">命運女巫Megaways</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">命運女巫Megaways</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6331" role="group" aria-label="4 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs40wildwest','西部牛仔黃金地段')" onmouseover="appendGameProp('PP','西部牛仔黃金地段','96.51','6331','PP.vs40wildwest',0,'Slot','vs40wildwest')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs40wildwest.png" onerror="showDefauktGameIcon('PP', 'vs40wildwest')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs40wildwest','西部牛仔黃金地段')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.51</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6331</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs40wildwest btn btn-round" onclick="favBtnClcik('PP.vs40wildwest')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">西部牛仔黃金地段</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">西部牛仔黃金地段</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6206" role="group" aria-label="5 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20doghouse','汪汪之家')" onmouseover="appendGameProp('PP','汪汪之家','96.51','6206','PP.vs20doghouse',0,'Slot','vs20doghouse')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20doghouse.png" onerror="showDefauktGameIcon('PP', 'vs20doghouse')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs20doghouse','汪汪之家')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.51</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6206</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs20doghouse btn btn-round" onclick="favBtnClcik('PP.vs20doghouse')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">汪汪之家</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">汪汪之家</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-1872c64d7210366b1" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-1872c64d7210366b1" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">BNG週年慶典</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-7e1ae52b27268b37" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4329 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '151','15龍珠 - 集鴻運')" onmouseover="appendGameProp('BNG','15龍珠 - 集鴻運','94.94','4329','BNG.151',0,'Slot','151')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/151.png" onerror="showDefauktGameIcon('BNG', '151')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','151','15龍珠 - 集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">94.94</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4329</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.151 btn btn-round" onclick="favBtnClcik('BNG.151')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">15龍珠 - 集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">15龍珠 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4330 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '152','維京寶藏: 集鴻運')" onmouseover="appendGameProp('BNG','維京寶藏: 集鴻運','95.2','4330','BNG.152',0,'Slot','152')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/152.png" onerror="showDefauktGameIcon('BNG', '152')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','152','維京寶藏: 集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.2</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4330</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.152 btn btn-round" onclick="favBtnClcik('BNG.152')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">維京寶藏: 集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">維京寶藏: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4356" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '191','蠻牛向錢衝: 集鴻運')" onmouseover="appendGameProp('BNG','蠻牛向錢衝: 集鴻運','95.04','4356','BNG.191',0,'Slot','191')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/191.png" onerror="showDefauktGameIcon('BNG', '191')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','191','蠻牛向錢衝: 集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.04</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4356</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.191 btn btn-round" onclick="favBtnClcik('BNG.191')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">蠻牛向錢衝: 集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">蠻牛向錢衝: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4373" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '218','狼魂: 集鴻運')" onmouseover="appendGameProp('BNG','狼魂: 集鴻運','95.04','4373','BNG.218',0,'Slot','218')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/218.png" onerror="showDefauktGameIcon('BNG', '218')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">狼魂: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4383" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '231','聖甲降臨-集鴻運')" onmouseover="appendGameProp('BNG','聖甲降臨-集鴻運','95.77','4383','BNG.231',0,'Slot','231')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/231.png" onerror="showDefauktGameIcon('BNG', '231')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">聖甲降臨-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4385" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '240','招財金像神-集鴻運')" onmouseover="appendGameProp('BNG','招財金像神-集鴻運','95.77','4385','BNG.240',0,'Slot','240')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/240.png" onerror="showDefauktGameIcon('BNG', '240')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">招財金像神-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4388" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '245','皇朝盛世2-集鴻運')" onmouseover="appendGameProp('BNG','皇朝盛世2-集鴻運','95.49','4388','BNG.245',0,'Slot','245')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/245.png" onerror="showDefauktGameIcon('BNG', '245')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">皇朝盛世2-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4395" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '256','烈日女神-集鴻運')" onmouseover="appendGameProp('BNG','烈日女神-集鴻運','95.77','4395','BNG.256',0,'Slot','256')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/256.png" onerror="showDefauktGameIcon('BNG', '256')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">烈日女神-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4396" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '259','採珠潛水員2: 藏寶箱')" onmouseover="appendGameProp('BNG','採珠潛水員2: 藏寶箱','95.67','4396','BNG.259',0,'Slot','259')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/259.png" onerror="showDefauktGameIcon('BNG', '259')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">採珠潛水員2: 藏寶箱</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4409" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '274','驚天大盜')" onmouseover="appendGameProp('BNG','驚天大盜','95.71','4409','BNG.274',0,'Slot','274')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/274.png" onerror="showDefauktGameIcon('BNG', '274')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">驚天大盜</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-7e1ae52b27268b37" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-7e1ae52b27268b37" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">老虎機最多轉</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-e4625d6ffbd4b210b" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4393 swiper-slide-active" role="group" aria-label="1 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '254','黑狼-集鴻運')" onmouseover="appendGameProp('BNG','黑狼-集鴻運','95.63','4393','BNG.254',0,'Slot','254')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/254.png" onerror="showDefauktGameIcon('BNG', '254')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','254','黑狼-集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.63</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4393</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.254 btn btn-round" onclick="favBtnClcik('BNG.254')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">黑狼-集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黑狼-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6285 swiper-slide-next" role="group" aria-label="2 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs25goldparty','黃金派對')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.48</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6285</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs25goldparty btn btn-round" onclick="favBtnClcik('PP.vs25goldparty')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">黃金派對</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6400" role="group" aria-label="3 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20olympgate','奧林匹斯之門')" onmouseover="appendGameProp('PP','奧林匹斯之門','96.5','6400','PP.vs20olympgate',0,'Slot','vs20olympgate')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20olympgate.png" onerror="showDefauktGameIcon('PP', 'vs20olympgate')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs20olympgate','奧林匹斯之門')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6400</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs20olympgate btn btn-round" onclick="favBtnClcik('PP.vs20olympgate')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6245" role="group" aria-label="4 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20sugarrush','極速糖果')" onmouseover="appendGameProp('PP','極速糖果','96.5','6245','PP.vs20sugarrush',0,'Slot','vs20sugarrush')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20sugarrush.png" onerror="showDefauktGameIcon('PP', 'vs20sugarrush')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs20sugarrush','極速糖果')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6245</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs20sugarrush btn btn-round" onclick="favBtnClcik('PP.vs20sugarrush')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">極速糖果</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">極速糖果</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6347" role="group" aria-label="5 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs5joker','小丑珠寶')" onmouseover="appendGameProp('PP','小丑珠寶','96.5','6347','PP.vs5joker',0,'Slot','vs5joker')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs5joker.png" onerror="showDefauktGameIcon('PP', 'vs5joker')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs5joker','小丑珠寶')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6347</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs5joker btn btn-round" onclick="favBtnClcik('PP.vs5joker')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">小丑珠寶</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">小丑珠寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6397" role="group" aria-label="6 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20fruitsw','甜入心扉')" onmouseover="appendGameProp('PP','甜入心扉','96.5','6397','PP.vs20fruitsw',0,'Slot','vs20fruitsw')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20fruitsw.png" onerror="showDefauktGameIcon('PP', 'vs20fruitsw')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs20fruitsw','甜入心扉')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6397</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs20fruitsw btn btn-round" onclick="favBtnClcik('PP.vs20fruitsw')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6292" role="group" aria-label="7 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25kingdoms','三國')" onmouseover="appendGameProp('PP','三國','96.5','6292','PP.vs25kingdoms',0,'Slot','vs25kingdoms')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25kingdoms.png" onerror="showDefauktGameIcon('PP', 'vs25kingdoms')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','vs25kingdoms','三國')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.5</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6292</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.vs25kingdoms btn btn-round" onclick="favBtnClcik('PP.vs25kingdoms')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">三國</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">三國</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6398" role="group" aria-label="8 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20goldfever','富礦寶石')" onmouseover="appendGameProp('PP','富礦寶石','96.51','6398','PP.vs20goldfever',0,'Slot','vs20goldfever')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20goldfever.png" onerror="showDefauktGameIcon('PP', 'vs20goldfever')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">富礦寶石</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5261" role="group" aria-label="9 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '13','幸運水果盤')" onmouseover="appendGameProp('KGS','幸運水果盤','96.99','5261','KGS.13',0,'Slot','13')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/13.png" onerror="showDefauktGameIcon('KGS', '13')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">幸運水果盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-e4625d6ffbd4b210b" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-e4625d6ffbd4b210b" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Slot swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-01145964ee10e97bd" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-410px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_4397 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BNG', '261','快樂魚')" onmouseover="appendGameProp('BNG','快樂魚','95.61','4397','BNG.261',2,'Slot','261')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/261.png" onerror="showDefauktGameIcon('BNG', '261')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">快樂魚</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 3; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4939 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('GMW', '893','深淵公主')" onmouseover="appendGameProp('GMW','深淵公主','96','4939','GMW.893',2,'Slot','893')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/893.png" onerror="showDefauktGameIcon('GMW', '893')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">深淵公主</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5062 swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="2" role="group" aria-label="3 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('HB', '751','鯉魚門')" onmouseover="appendGameProp('HB','鯉魚門','96','5062','HB.751',2,'Slot','751')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/751.png" onerror="showDefauktGameIcon('HB', '751')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">鯉魚門</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4397 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="4 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BNG', '261','快樂魚')" onmouseover="appendGameProp('BNG','快樂魚','95.61','4397','BNG.261',2,'Slot','261')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/261.png" onerror="showDefauktGameIcon('BNG', '261')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">快樂魚</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4939 swiper-slide-next" data-swiper-slide-index="1" role="group" aria-label="5 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('GMW', '893','深淵公主')" onmouseover="appendGameProp('GMW','深淵公主','96','4939','GMW.893',2,'Slot','893')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/893.png" onerror="showDefauktGameIcon('GMW', '893')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">深淵公主</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5062 swiper-slide-duplicate-prev" data-swiper-slide-index="2" role="group" aria-label="6 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('HB', '751','鯉魚門')" onmouseover="appendGameProp('HB','鯉魚門','96','5062','HB.751',2,'Slot','751')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/751.png" onerror="showDefauktGameIcon('HB', '751')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">鯉魚門</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4397 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="7 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BNG', '261','快樂魚')" onmouseover="appendGameProp('BNG','快樂魚','95.61','4397','BNG.261',2,'Slot','261')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/261.png" onerror="showDefauktGameIcon('BNG', '261')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">快樂魚</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4939 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="8 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(-80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('GMW', '893','深淵公主')" onmouseover="appendGameProp('GMW','深淵公主','96','4939','GMW.893',2,'Slot','893')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/893.png" onerror="showDefauktGameIcon('GMW', '893')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">深淵公主</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 4; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5062 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="9 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(-100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('HB', '751','鯉魚門')" onmouseover="appendGameProp('HB','鯉魚門','96','5062','HB.751',2,'Slot','751')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/751.png" onerror="showDefauktGameIcon('HB', '751')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">鯉魚門</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 5; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">maharaja最多轉</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-1b3bc84b4975f110c" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6245 swiper-slide-active" role="group" aria-label="1 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20sugarrush','極速糖果')" onmouseover="appendGameProp('PP','極速糖果','96.5','6245','PP.vs20sugarrush',0,'Slot','vs20sugarrush')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20sugarrush.png" onerror="showDefauktGameIcon('PP', 'vs20sugarrush')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">極速糖果</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6397 swiper-slide-next" role="group" aria-label="2 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20fruitsw','甜入心扉')" onmouseover="appendGameProp('PP','甜入心扉','96.5','6397','PP.vs20fruitsw',0,'Slot','vs20fruitsw')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20fruitsw.png" onerror="showDefauktGameIcon('PP', 'vs20fruitsw')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6400" role="group" aria-label="3 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20olympgate','奧林匹斯之門')" onmouseover="appendGameProp('PP','奧林匹斯之門','96.5','6400','PP.vs20olympgate',0,'Slot','vs20olympgate')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20olympgate.png" onerror="showDefauktGameIcon('PP', 'vs20olympgate')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6292" role="group" aria-label="4 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25kingdoms','三國')" onmouseover="appendGameProp('PP','三國','96.5','6292','PP.vs25kingdoms',0,'Slot','vs25kingdoms')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25kingdoms.png" onerror="showDefauktGameIcon('PP', 'vs25kingdoms')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">三國</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4387" role="group" aria-label="5 / 8">
                                            <div class="game-item crownLevel-2 crown-P-S">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '242','叢林之王-集鴻運')" onmouseover="appendGameProp('BNG','叢林之王-集鴻運','95.86','4387','BNG.242',0,'Slot','242')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/242.png" onerror="showDefauktGameIcon('BNG', '242')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">叢林之王-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6216" role="group" aria-label="6 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20gatotgates','印尼傳奇迦多鐸卡')" onmouseover="appendGameProp('PP','印尼傳奇迦多鐸卡','96.5','6216','PP.vs20gatotgates',0,'Slot','vs20gatotgates')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20gatotgates.png" onerror="showDefauktGameIcon('PP', 'vs20gatotgates')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">印尼傳奇迦多鐸卡</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6285" role="group" aria-label="7 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6398" role="group" aria-label="8 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20goldfever','富礦寶石')" onmouseover="appendGameProp('PP','富礦寶石','96.51','6398','PP.vs20goldfever',0,'Slot','vs20goldfever')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20goldfever.png" onerror="showDefauktGameIcon('PP', 'vs20goldfever')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">富礦寶石</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-1b3bc84b4975f110c" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-1b3bc84b4975f110c" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">7天內最大開獎</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-684c2105b8c8be4f1" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6400 swiper-slide-active" role="group" aria-label="1 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20olympgate','奧林匹斯之門')" onmouseover="appendGameProp('PP','奧林匹斯之門','96.5','6400','PP.vs20olympgate',0,'Slot','vs20olympgate')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20olympgate.png" onerror="showDefauktGameIcon('PP', 'vs20olympgate')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6285 swiper-slide-next" role="group" aria-label="2 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6405" role="group" aria-label="3 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20starlight','星光公主')" onmouseover="appendGameProp('PP','星光公主','94.5','6405','PP.vs20starlight',0,'Slot','vs20starlight')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20starlight.png" onerror="showDefauktGameIcon('PP', 'vs20starlight')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">星光公主</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6397" role="group" aria-label="4 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20fruitsw','甜入心扉')" onmouseover="appendGameProp('PP','甜入心扉','96.5','6397','PP.vs20fruitsw',0,'Slot','vs20fruitsw')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20fruitsw.png" onerror="showDefauktGameIcon('PP', 'vs20fruitsw')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6245" role="group" aria-label="5 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20sugarrush','極速糖果')" onmouseover="appendGameProp('PP','極速糖果','96.5','6245','PP.vs20sugarrush',0,'Slot','vs20sugarrush')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20sugarrush.png" onerror="showDefauktGameIcon('PP', 'vs20sugarrush')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">極速糖果</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6396" role="group" aria-label="6 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20fruitparty','水果派對')" onmouseover="appendGameProp('PP','水果派對','96.5','6396','PP.vs20fruitparty',0,'Slot','vs20fruitparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20fruitparty.png" onerror="showDefauktGameIcon('PP', 'vs20fruitparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">水果派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-684c2105b8c8be4f1" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-684c2105b8c8be4f1" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">7天內最大倍率</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-c16afb0d48bc9186" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6285 swiper-slide-active" role="group" aria-label="1 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6245 swiper-slide-next" role="group" aria-label="2 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20sugarrush','極速糖果')" onmouseover="appendGameProp('PP','極速糖果','96.5','6245','PP.vs20sugarrush',0,'Slot','vs20sugarrush')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20sugarrush.png" onerror="showDefauktGameIcon('PP', 'vs20sugarrush')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">極速糖果</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6400" role="group" aria-label="3 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20olympgate','奧林匹斯之門')" onmouseover="appendGameProp('PP','奧林匹斯之門','96.5','6400','PP.vs20olympgate',0,'Slot','vs20olympgate')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20olympgate.png" onerror="showDefauktGameIcon('PP', 'vs20olympgate')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6288" role="group" aria-label="4 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25hotfiesta','狂熱嘉年華')" onmouseover="appendGameProp('PP','狂熱嘉年華','96.5','6288','PP.vs25hotfiesta',0,'Slot','vs25hotfiesta')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25hotfiesta.png" onerror="showDefauktGameIcon('PP', 'vs25hotfiesta')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">狂熱嘉年華</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6347" role="group" aria-label="5 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs5joker','小丑珠寶')" onmouseover="appendGameProp('PP','小丑珠寶','96.5','6347','PP.vs5joker',0,'Slot','vs5joker')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs5joker.png" onerror="showDefauktGameIcon('PP', 'vs5joker')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">小丑珠寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6397" role="group" aria-label="6 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20fruitsw','甜入心扉')" onmouseover="appendGameProp('PP','甜入心扉','96.5','6397','PP.vs20fruitsw',0,'Slot','vs20fruitsw')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20fruitsw.png" onerror="showDefauktGameIcon('PP', 'vs20fruitsw')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">甜入心扉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6240" role="group" aria-label="7 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20schristmas','星光聖誕系列')" onmouseover="appendGameProp('PP','星光聖誕系列','96.5','6240','PP.vs20schristmas',0,'Slot','vs20schristmas')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20schristmas.png" onerror="showDefauktGameIcon('PP', 'vs20schristmas')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">星光聖誕系列</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6398" role="group" aria-label="8 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20goldfever','富礦寶石')" onmouseover="appendGameProp('PP','富礦寶石','96.51','6398','PP.vs20goldfever',0,'Slot','vs20goldfever')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20goldfever.png" onerror="showDefauktGameIcon('PP', 'vs20goldfever')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">富礦寶石</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6206" role="group" aria-label="9 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20doghouse','汪汪之家')" onmouseover="appendGameProp('PP','汪汪之家','96.51','6206','PP.vs20doghouse',0,'Slot','vs20doghouse')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20doghouse.png" onerror="showDefauktGameIcon('PP', 'vs20doghouse')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">汪汪之家</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-c16afb0d48bc9186" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-c16afb0d48bc9186" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Slot swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-933ffec445f54c33" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-410px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_4368 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BNG', '209','金鑽霸虎 - 集鴻運')" onmouseover="appendGameProp('BNG','金鑽霸虎 - 集鴻運','95.67','4368','BNG.209',2,'Slot','209')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/209.png" onerror="showDefauktGameIcon('BNG', '209')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">金鑽霸虎 - 集鴻運</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 3; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5263 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('KGS', '33','夜店')" onmouseover="appendGameProp('KGS','夜店','96.89','5263','KGS.33',2,'Slot','33')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/33.png" onerror="showDefauktGameIcon('KGS', '33')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">夜店</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5291 swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="2" role="group" aria-label="3 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('KGS', '6','招財進寶')" onmouseover="appendGameProp('KGS','招財進寶','96.98','5291','KGS.6',2,'Slot','6')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/6.png" onerror="showDefauktGameIcon('KGS', '6')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">招財進寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4368 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="4 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BNG', '209','金鑽霸虎 - 集鴻運')" onmouseover="appendGameProp('BNG','金鑽霸虎 - 集鴻運','95.67','4368','BNG.209',2,'Slot','209')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/209.png" onerror="showDefauktGameIcon('BNG', '209')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">金鑽霸虎 - 集鴻運</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5263 swiper-slide-next" data-swiper-slide-index="1" role="group" aria-label="5 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('KGS', '33','夜店')" onmouseover="appendGameProp('KGS','夜店','96.89','5263','KGS.33',2,'Slot','33')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/33.png" onerror="showDefauktGameIcon('KGS', '33')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">夜店</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5291 swiper-slide-duplicate-prev" data-swiper-slide-index="2" role="group" aria-label="6 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('KGS', '6','招財進寶')" onmouseover="appendGameProp('KGS','招財進寶','96.98','5291','KGS.6',2,'Slot','6')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/6.png" onerror="showDefauktGameIcon('KGS', '6')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">招財進寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4368 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="7 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BNG', '209','金鑽霸虎 - 集鴻運')" onmouseover="appendGameProp('BNG','金鑽霸虎 - 集鴻運','95.67','4368','BNG.209',2,'Slot','209')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/209.png" onerror="showDefauktGameIcon('BNG', '209')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">金鑽霸虎 - 集鴻運</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5263 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="8 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(-80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('KGS', '33','夜店')" onmouseover="appendGameProp('KGS','夜店','96.89','5263','KGS.33',2,'Slot','33')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/33.png" onerror="showDefauktGameIcon('KGS', '33')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">夜店</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 4; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5291 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="9 / 9" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(-100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('KGS', '6','招財進寶')" onmouseover="appendGameProp('KGS','招財進寶','96.98','5291','KGS.6',2,'Slot','6')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/6.png" onerror="showDefauktGameIcon('KGS', '6')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">招財進寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 5; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">前天最大開獎</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-f93b740083ecac3f" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6285 swiper-slide-active" role="group" aria-label="1 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6400 swiper-slide-next" role="group" aria-label="2 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20olympgate','奧林匹斯之門')" onmouseover="appendGameProp('PP','奧林匹斯之門','96.5','6400','PP.vs20olympgate',0,'Slot','vs20olympgate')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20olympgate.png" onerror="showDefauktGameIcon('PP', 'vs20olympgate')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6347" role="group" aria-label="3 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs5joker','小丑珠寶')" onmouseover="appendGameProp('PP','小丑珠寶','96.5','6347','PP.vs5joker',0,'Slot','vs5joker')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs5joker.png" onerror="showDefauktGameIcon('PP', 'vs5joker')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">小丑珠寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6393" role="group" aria-label="4 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20chickdrop','金雞下蛋')" onmouseover="appendGameProp('PP','金雞下蛋','96.5','6393','PP.vs20chickdrop',0,'Slot','vs20chickdrop')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20chickdrop.png" onerror="showDefauktGameIcon('PP', 'vs20chickdrop')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">金雞下蛋</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4393" role="group" aria-label="5 / 5">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '254','黑狼-集鴻運')" onmouseover="appendGameProp('BNG','黑狼-集鴻運','95.63','4393','BNG.254',0,'Slot','254')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/254.png" onerror="showDefauktGameIcon('BNG', '254')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黑狼-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-f93b740083ecac3f" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-f93b740083ecac3f" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">前天最大倍率</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-0518284ba9346a210" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6285 swiper-slide-active" role="group" aria-label="1 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6400 swiper-slide-next" role="group" aria-label="2 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20olympgate','奧林匹斯之門')" onmouseover="appendGameProp('PP','奧林匹斯之門','96.5','6400','PP.vs20olympgate',0,'Slot','vs20olympgate')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20olympgate.png" onerror="showDefauktGameIcon('PP', 'vs20olympgate')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">奧林匹斯之門</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6347" role="group" aria-label="3 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs5joker','小丑珠寶')" onmouseover="appendGameProp('PP','小丑珠寶','96.5','6347','PP.vs5joker',0,'Slot','vs5joker')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs5joker.png" onerror="showDefauktGameIcon('PP', 'vs5joker')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">小丑珠寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6292" role="group" aria-label="4 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25kingdoms','三國')" onmouseover="appendGameProp('PP','三國','96.5','6292','PP.vs25kingdoms',0,'Slot','vs25kingdoms')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25kingdoms.png" onerror="showDefauktGameIcon('PP', 'vs25kingdoms')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">三國</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6245" role="group" aria-label="5 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs20sugarrush','極速糖果')" onmouseover="appendGameProp('PP','極速糖果','96.5','6245','PP.vs20sugarrush',0,'Slot','vs20sugarrush')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs20sugarrush.png" onerror="showDefauktGameIcon('PP', 'vs20sugarrush')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">極速糖果</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6367" role="group" aria-label="6 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vswayselements','五行寶石 Megaways')" onmouseover="appendGameProp('PP','五行寶石 Megaways','95.45','6367','PP.vswayselements',0,'Slot','vswayselements')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vswayselements.png" onerror="showDefauktGameIcon('PP', 'vswayselements')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">五行寶石 Megaways</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4393" role="group" aria-label="7 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '254','黑狼-集鴻運')" onmouseover="appendGameProp('BNG','黑狼-集鴻運','95.63','4393','BNG.254',0,'Slot','254')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/254.png" onerror="showDefauktGameIcon('BNG', '254')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黑狼-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4405" role="group" aria-label="8 / 8">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '270','蓮花奇緣-超百搭集鴻運')" onmouseover="appendGameProp('BNG','蓮花奇緣-超百搭集鴻運','95.78','4405','BNG.270',0,'Slot','270')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/270.png" onerror="showDefauktGameIcon('BNG', '270')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">蓮花奇緣-超百搭集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-0518284ba9346a210" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-0518284ba9346a210" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">前天最高RTP</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Slot data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-e5889250e2ab994d" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4398 swiper-slide-active" role="group" aria-label="1 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '262','太陽神殿3 - 集鴻運')" onmouseover="appendGameProp('BNG','太陽神殿3 - 集鴻運','95.58','4398','BNG.262',0,'Slot','262')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/262.png" onerror="showDefauktGameIcon('BNG', '262')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">太陽神殿3 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4373 swiper-slide-next" role="group" aria-label="2 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '218','狼魂: 集鴻運')" onmouseover="appendGameProp('BNG','狼魂: 集鴻運','95.04','4373','BNG.218',0,'Slot','218')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/218.png" onerror="showDefauktGameIcon('BNG', '218')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">狼魂: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4330" role="group" aria-label="3 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '152','維京寶藏: 集鴻運')" onmouseover="appendGameProp('BNG','維京寶藏: 集鴻運','95.2','4330','BNG.152',0,'Slot','152')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/152.png" onerror="showDefauktGameIcon('BNG', '152')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">維京寶藏: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6285" role="group" aria-label="4 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25goldparty','黃金派對')" onmouseover="appendGameProp('PP','黃金派對','95.48','6285','PP.vs25goldparty',0,'Slot','vs25goldparty')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25goldparty.png" onerror="showDefauktGameIcon('PP', 'vs25goldparty')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-e5889250e2ab994d" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-e5889250e2ab994d" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>

            <div id="gameAreas2" class="divGameAreas" style="display: none">
                <div id="categoryPage_GameList_Live" class="categoryPage" style="display: block;">
                    <div class="container category-dailypush">
                        <section class="section-category-dailypush" onclick="window.parent.openGame('EVO', 'GonzoTH000000001','岡佐的尋寶之旅')">
                            <div class="category-dailypush-wrapper live  ">
                                <div class="category-dailypush-inner">
                                    <div class="category-dailypush-img" style="background-color: #352c1c;">
                                        <div class="img-box mobile">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-live-M-001.jpg" alt="">
                                            </div>
                                        </div>
                                        <div class="img-box pad">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-live-MD-001.jpg" alt="">
                                            </div>
                                        </div>
                                        <div class="img-box desktop">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-live-001.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="category-dailypush-cotentBox">
                                        <div class="category-dailypush-cotent">
                                            <h2 class="title language_replace">本日優選推薦</h2>
                                            <div class="info">
                                                <h3 class="gamename language_replace">岡佐的尋寶之旅</h3>
                                                <div class="detail">
                                                    <span class="gamebrand">EVO</span>
                                                    <span class="gamecategory">真人</span>
                                                </div>
                                            </div>
                                            <div class="intro language_replace is-hide">
                                                遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                               
                                            </div>
                                            <div class="action">
                                                <button class="btn btn-play" onclick="window.parent.openGame('EVO', 'GonzoTH000000001','岡佐的尋寶之旅')"><span class="language_replace">進入遊戲</span></button>
                                                <!-- 加入最愛 class=>added-->
                                                <button type="button" class="btn-like desktop gameCode_EVO.GonzoTH000000001 btn btn-round" onclick="favBtnClcik('EVO.GonzoTH000000001')">
                                                    <i class="icon icon-m-favorite"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">EVO，全球高人氣Live遊戲</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Live data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-f6b2aaa35a88f88b" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4875 swiper-slide-active" role="group" aria-label="1 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'XxxtremeLigh0001','XXXtreme閃電輪盤')" onmouseover="appendGameProp('EVO','XXXtreme閃電輪盤','--','4875','EVO.XxxtremeLigh0001',0,'Live','XxxtremeLigh0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/XxxtremeLigh0001.png" onerror="showDefauktGameIcon('EVO', 'XxxtremeLigh0001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','XxxtremeLigh0001','XXXtreme閃電輪盤')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4875</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.XxxtremeLigh0001 btn btn-round" onclick="favBtnClcik('EVO.XxxtremeLigh0001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4713 swiper-slide-next" role="group" aria-label="2 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'peekbaccarat0001','看牌百家樂')" onmouseover="appendGameProp('EVO','看牌百家樂','--','4713','EVO.peekbaccarat0001',0,'Live','peekbaccarat0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/peekbaccarat0001.png" onerror="showDefauktGameIcon('EVO', 'peekbaccarat0001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','peekbaccarat0001','看牌百家樂')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4713</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.peekbaccarat0001 btn btn-round" onclick="favBtnClcik('EVO.peekbaccarat0001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">看牌百家樂</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">看牌百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4791" role="group" aria-label="3 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'p36n5jvdx7bugh2g','沙龍私人二十一點G')" onmouseover="appendGameProp('EVO','沙龍私人二十一點G','--','4791','EVO.p36n5jvdx7bugh2g',0,'Live','p36n5jvdx7bugh2g')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/p36n5jvdx7bugh2g.png" onerror="showDefauktGameIcon('EVO', 'p36n5jvdx7bugh2g')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','p36n5jvdx7bugh2g','沙龍私人二十一點G')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4791</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.p36n5jvdx7bugh2g btn btn-round" onclick="favBtnClcik('EVO.p36n5jvdx7bugh2g')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4847" role="group" aria-label="4 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'dealnodeal000001','一擲千金')" onmouseover="appendGameProp('EVO','一擲千金','--','4847','EVO.dealnodeal000001',0,'Live','dealnodeal000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/dealnodeal000001.png" onerror="showDefauktGameIcon('EVO', 'dealnodeal000001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','dealnodeal000001','一擲千金')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4847</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.dealnodeal000001 btn btn-round" onclick="favBtnClcik('EVO.dealnodeal000001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">一擲千金</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">一擲千金</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4850" role="group" aria-label="5 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MegaBall00000001','超級球')" onmouseover="appendGameProp('EVO','超級球','--','4850','EVO.MegaBall00000001',0,'Live','MegaBall00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MegaBall00000001.png" onerror="showDefauktGameIcon('EVO', 'MegaBall00000001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','MegaBall00000001','超級球')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4850</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.MegaBall00000001 btn btn-round" onclick="favBtnClcik('EVO.MegaBall00000001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">超級球</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級球</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4843" role="group" aria-label="6 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'TRPTable00000001','三重卡撲克')" onmouseover="appendGameProp('EVO','三重卡撲克','--','4843','EVO.TRPTable00000001',0,'Live','TRPTable00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/TRPTable00000001.png" onerror="showDefauktGameIcon('EVO', 'TRPTable00000001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','TRPTable00000001','三重卡撲克')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4843</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.TRPTable00000001 btn btn-round" onclick="favBtnClcik('EVO.TRPTable00000001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">三重卡撲克</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">三重卡撲克</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-f6b2aaa35a88f88b" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-f6b2aaa35a88f88b" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">與眾不同的真人遊戲</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Live data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-a661756653e6d931" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4791 swiper-slide-active" role="group" aria-label="1 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'p36n5jvdx7bugh2g','沙龍私人二十一點G')" onmouseover="appendGameProp('EVO','沙龍私人二十一點G','--','4791','EVO.p36n5jvdx7bugh2g',0,'Live','p36n5jvdx7bugh2g')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/p36n5jvdx7bugh2g.png" onerror="showDefauktGameIcon('EVO', 'p36n5jvdx7bugh2g')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4845 swiper-slide-next" role="group" aria-label="2 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CrazyCoinFlip001','瘋狂擲硬幣')" onmouseover="appendGameProp('EVO','瘋狂擲硬幣','--','4845','EVO.CrazyCoinFlip001',0,'Live','CrazyCoinFlip001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CrazyCoinFlip001.png" onerror="showDefauktGameIcon('EVO', 'CrazyCoinFlip001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">瘋狂擲硬幣</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4847" role="group" aria-label="3 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'dealnodeal000001','一擲千金')" onmouseover="appendGameProp('EVO','一擲千金','--','4847','EVO.dealnodeal000001',0,'Live','dealnodeal000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/dealnodeal000001.png" onerror="showDefauktGameIcon('EVO', 'dealnodeal000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">一擲千金</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4850" role="group" aria-label="4 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MegaBall00000001','超級球')" onmouseover="appendGameProp('EVO','超級球','--','4850','EVO.MegaBall00000001',0,'Live','MegaBall00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MegaBall00000001.png" onerror="showDefauktGameIcon('EVO', 'MegaBall00000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級球</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-a661756653e6d931" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-a661756653e6d931" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">各品牌LiveGame人氣Top3</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Live data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-6e713e43ff29363d" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4791 swiper-slide-active" role="group" aria-label="1 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'p36n5jvdx7bugh2g','沙龍私人二十一點G')" onmouseover="appendGameProp('EVO','沙龍私人二十一點G','--','4791','EVO.p36n5jvdx7bugh2g',0,'Live','p36n5jvdx7bugh2g')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/p36n5jvdx7bugh2g.png" onerror="showDefauktGameIcon('EVO', 'p36n5jvdx7bugh2g')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4847 swiper-slide-next" role="group" aria-label="2 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'dealnodeal000001','一擲千金')" onmouseover="appendGameProp('EVO','一擲千金','--','4847','EVO.dealnodeal000001',0,'Live','dealnodeal000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/dealnodeal000001.png" onerror="showDefauktGameIcon('EVO', 'dealnodeal000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">一擲千金</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4850" role="group" aria-label="3 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MegaBall00000001','超級球')" onmouseover="appendGameProp('EVO','超級球','--','4850','EVO.MegaBall00000001',0,'Live','MegaBall00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MegaBall00000001.png" onerror="showDefauktGameIcon('EVO', 'MegaBall00000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級球</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-6e713e43ff29363d" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-6e713e43ff29363d" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Live swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-c52aaa652f5607e1" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-150px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_4875 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'XxxtremeLigh0001','XXXtreme閃電輪盤')" onmouseover="appendGameProp('EVO','XXXtreme閃電輪盤','--','4875','EVO.XxxtremeLigh0001',2,'Live','XxxtremeLigh0001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/XxxtremeLigh0001.png" onerror="showDefauktGameIcon('EVO', 'XxxtremeLigh0001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4864 swiper-slide-duplicate swiper-slide-prev swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningTable01','閃電輪盤')" onmouseover="appendGameProp('EVO','閃電輪盤','--','4864','EVO.LightningTable01',2,'Live','LightningTable01')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningTable01.png" onerror="showDefauktGameIcon('EVO', 'LightningTable01')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">閃電輪盤</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4875 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="3 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'XxxtremeLigh0001','XXXtreme閃電輪盤')" onmouseover="appendGameProp('EVO','XXXtreme閃電輪盤','--','4875','EVO.XxxtremeLigh0001',2,'Live','XxxtremeLigh0001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/XxxtremeLigh0001.png" onerror="showDefauktGameIcon('EVO', 'XxxtremeLigh0001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4864 swiper-slide-next swiper-slide-duplicate-prev" data-swiper-slide-index="1" role="group" aria-label="4 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningTable01','閃電輪盤')" onmouseover="appendGameProp('EVO','閃電輪盤','--','4864','EVO.LightningTable01',2,'Live','LightningTable01')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningTable01.png" onerror="showDefauktGameIcon('EVO', 'LightningTable01')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">閃電輪盤</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4875 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="5 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item addedGameProp">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'XxxtremeLigh0001','XXXtreme閃電輪盤')" onmouseover="appendGameProp('EVO','XXXtreme閃電輪盤','--','4875','EVO.XxxtremeLigh0001',2,'Live','XxxtremeLigh0001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/XxxtremeLigh0001.png" onerror="showDefauktGameIcon('EVO', 'XxxtremeLigh0001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4864 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="6 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningTable01','閃電輪盤')" onmouseover="appendGameProp('EVO','閃電輪盤','--','4864','EVO.LightningTable01',2,'Live','LightningTable01')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningTable01.png" onerror="showDefauktGameIcon('EVO', 'LightningTable01')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">閃電輪盤</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">即時互動，百家樂集結</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Live data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-9b51293e7f825eac" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4680 swiper-slide-active" role="group" aria-label="1 / 2">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'gwbaccarat000001','黃金財富百家樂')" onmouseover="appendGameProp('EVO','黃金財富百家樂','--','4680','EVO.gwbaccarat000001',0,'Live','gwbaccarat000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/gwbaccarat000001.png" onerror="showDefauktGameIcon('EVO', 'gwbaccarat000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金財富百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4713 swiper-slide-next" role="group" aria-label="2 / 2">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'peekbaccarat0001','看牌百家樂')" onmouseover="appendGameProp('EVO','看牌百家樂','--','4713','EVO.peekbaccarat0001',0,'Live','peekbaccarat0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/peekbaccarat0001.png" onerror="showDefauktGameIcon('EVO', 'peekbaccarat0001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">看牌百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-9b51293e7f825eac" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-9b51293e7f825eac" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">一球入魂，各類Live輪盤</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Live data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-6ebfc5439ec9bd97" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4867 swiper-slide-active" role="group" aria-label="1 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'mdkqijp3dctrhnuv','沙龍私人輪盤')" onmouseover="appendGameProp('EVO','沙龍私人輪盤','--','4867','EVO.mdkqijp3dctrhnuv',0,'Live','mdkqijp3dctrhnuv')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/mdkqijp3dctrhnuv.png" onerror="showDefauktGameIcon('EVO', 'mdkqijp3dctrhnuv')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">沙龍私人輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4868 swiper-slide-next" role="group" aria-label="2 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'mvrcophqscoqosd6','馬耳他賭場輪盤')" onmouseover="appendGameProp('EVO','馬耳他賭場輪盤','--','4868','EVO.mvrcophqscoqosd6',0,'Live','mvrcophqscoqosd6')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/mvrcophqscoqosd6.png" onerror="showDefauktGameIcon('EVO', 'mvrcophqscoqosd6')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">馬耳他賭場輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4871" role="group" aria-label="3 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'pv5q45yjhasyt46y','巨富輪盤')" onmouseover="appendGameProp('EVO','巨富輪盤','--','4871','EVO.pv5q45yjhasyt46y',0,'Live','pv5q45yjhasyt46y')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/pv5q45yjhasyt46y.png" onerror="showDefauktGameIcon('EVO', 'pv5q45yjhasyt46y')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">巨富輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-6ebfc5439ec9bd97" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-6ebfc5439ec9bd97" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Live swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-910c109a17b4d4c159" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-670px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_4835 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'AndarBahar000001','超級內外注')" onmouseover="appendGameProp('EVO','超級內外注','--','4835','EVO.AndarBahar000001',2,'Live','AndarBahar000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/AndarBahar000001.png" onerror="showDefauktGameIcon('EVO', 'AndarBahar000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">超級內外注</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 4; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4836 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CSPTable00000001','加勒⽐海撲克')" onmouseover="appendGameProp('EVO','加勒⽐海撲克','--','4836','EVO.CSPTable00000001',2,'Live','CSPTable00000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CSPTable00000001.png" onerror="showDefauktGameIcon('EVO', 'CSPTable00000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">加勒⽐海撲克</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 3; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4845 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="3 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CrazyCoinFlip001','瘋狂擲硬幣')" onmouseover="appendGameProp('EVO','瘋狂擲硬幣','--','4845','EVO.CrazyCoinFlip001',2,'Live','CrazyCoinFlip001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CrazyCoinFlip001.png" onerror="showDefauktGameIcon('EVO', 'CrazyCoinFlip001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">瘋狂擲硬幣</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4878 swiper-slide-duplicate swiper-slide-prev" data-swiper-slide-index="3" role="group" aria-label="4 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningDice001','閃電骰寶')" onmouseover="appendGameProp('EVO','閃電骰寶','--','4878','EVO.LightningDice001',2,'Live','LightningDice001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningDice001.png" onerror="showDefauktGameIcon('EVO', 'LightningDice001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">閃電骰寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4835 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="5 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'AndarBahar000001','超級內外注')" onmouseover="appendGameProp('EVO','超級內外注','--','4835','EVO.AndarBahar000001',2,'Live','AndarBahar000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/AndarBahar000001.png" onerror="showDefauktGameIcon('EVO', 'AndarBahar000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">超級內外注</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4836 swiper-slide-next" data-swiper-slide-index="1" role="group" aria-label="6 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CSPTable00000001','加勒⽐海撲克')" onmouseover="appendGameProp('EVO','加勒⽐海撲克','--','4836','EVO.CSPTable00000001',2,'Live','CSPTable00000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CSPTable00000001.png" onerror="showDefauktGameIcon('EVO', 'CSPTable00000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">加勒⽐海撲克</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4845" data-swiper-slide-index="2" role="group" aria-label="7 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CrazyCoinFlip001','瘋狂擲硬幣')" onmouseover="appendGameProp('EVO','瘋狂擲硬幣','--','4845','EVO.CrazyCoinFlip001',2,'Live','CrazyCoinFlip001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CrazyCoinFlip001.png" onerror="showDefauktGameIcon('EVO', 'CrazyCoinFlip001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">瘋狂擲硬幣</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4878 swiper-slide-duplicate-prev" data-swiper-slide-index="3" role="group" aria-label="8 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningDice001','閃電骰寶')" onmouseover="appendGameProp('EVO','閃電骰寶','--','4878','EVO.LightningDice001',2,'Live','LightningDice001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningDice001.png" onerror="showDefauktGameIcon('EVO', 'LightningDice001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">閃電骰寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4835 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="9 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1200px) rotateX(0deg) rotateY(-80deg) scale(1); z-index: -3;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'AndarBahar000001','超級內外注')" onmouseover="appendGameProp('EVO','超級內外注','--','4835','EVO.AndarBahar000001',2,'Live','AndarBahar000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/AndarBahar000001.png" onerror="showDefauktGameIcon('EVO', 'AndarBahar000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">超級內外注</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 4; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4836 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="10 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1500px) rotateX(0deg) rotateY(-100deg) scale(1); z-index: -4;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CSPTable00000001','加勒⽐海撲克')" onmouseover="appendGameProp('EVO','加勒⽐海撲克','--','4836','EVO.CSPTable00000001',2,'Live','CSPTable00000001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CSPTable00000001.png" onerror="showDefauktGameIcon('EVO', 'CSPTable00000001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">加勒⽐海撲克</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 5; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4845 swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="11 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -1800px) rotateX(0deg) rotateY(-120deg) scale(1); z-index: -5;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'CrazyCoinFlip001','瘋狂擲硬幣')" onmouseover="appendGameProp('EVO','瘋狂擲硬幣','--','4845','EVO.CrazyCoinFlip001',2,'Live','CrazyCoinFlip001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/CrazyCoinFlip001.png" onerror="showDefauktGameIcon('EVO', 'CrazyCoinFlip001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">瘋狂擲硬幣</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 6; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4878 swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="12 / 12" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -2100px) rotateX(0deg) rotateY(-140deg) scale(1); z-index: -6;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('EVO', 'LightningDice001','閃電骰寶')" onmouseover="appendGameProp('EVO','閃電骰寶','--','4878','EVO.LightningDice001',2,'Live','LightningDice001')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/LightningDice001.png" onerror="showDefauktGameIcon('EVO', 'LightningDice001')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">閃電骰寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 7; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">Maharaja!真人遊戲激推</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Live data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-a5bbe4262987bee9" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4875 swiper-slide-active" role="group" aria-label="1 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'XxxtremeLigh0001','XXXtreme閃電輪盤')" onmouseover="appendGameProp('EVO','XXXtreme閃電輪盤','--','4875','EVO.XxxtremeLigh0001',0,'Live','XxxtremeLigh0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/XxxtremeLigh0001.png" onerror="showDefauktGameIcon('EVO', 'XxxtremeLigh0001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4791 swiper-slide-next" role="group" aria-label="2 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'p36n5jvdx7bugh2g','沙龍私人二十一點G')" onmouseover="appendGameProp('EVO','沙龍私人二十一點G','--','4791','EVO.p36n5jvdx7bugh2g',0,'Live','p36n5jvdx7bugh2g')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/p36n5jvdx7bugh2g.png" onerror="showDefauktGameIcon('EVO', 'p36n5jvdx7bugh2g')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4847" role="group" aria-label="3 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'dealnodeal000001','一擲千金')" onmouseover="appendGameProp('EVO','一擲千金','--','4847','EVO.dealnodeal000001',0,'Live','dealnodeal000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/dealnodeal000001.png" onerror="showDefauktGameIcon('EVO', 'dealnodeal000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">一擲千金</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4850" role="group" aria-label="4 / 4">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MegaBall00000001','超級球')" onmouseover="appendGameProp('EVO','超級球','--','4850','EVO.MegaBall00000001',0,'Live','MegaBall00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MegaBall00000001.png" onerror="showDefauktGameIcon('EVO', 'MegaBall00000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級球</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-a5bbe4262987bee9" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-a5bbe4262987bee9" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>

            <div id="gameAreas3" class="divGameAreas" style="display: none">
                <div id="categoryPage_GameList_Other" class="categoryPage" style="display: block;">
                    <div class="container category-dailypush">
                        <section class="section-category-dailypush" onclick="window.parent.openGame('BTI', 'Sport','BTI體育')">
                            <div class="category-dailypush-wrapper other  ">
                                <div class="category-dailypush-inner">
                                    <div class="category-dailypush-img" style="background-color: #f66f13;">
                                        <div class="img-box mobile">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-bti-M-001.jpg" alt="">
                                            </div>
                                        </div>
                                        <div class="img-box pad">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-bti-MD-001.jpg" alt="">
                                            </div>
                                        </div>
                                        <div class="img-box desktop">
                                            <div class="img-wrap">
                                                <img src="/images/lobby/dailypush-bti-001.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="category-dailypush-cotentBox">
                                        <div class="category-dailypush-cotent">
                                            <h2 class="title language_replace">本日優選推薦</h2>
                                            <div class="info">
                                                <h3 class="gamename language_replace">BTI體育</h3>
                                                <div class="detail">
                                                    <span class="gamebrand">BTI</span>
                                                    <span class="gamecategory">體育</span>
                                                </div>
                                            </div>
                                            <div class="intro language_replace is-hide">
                                                遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                               
                                            </div>
                                            <div class="action">
                                                <button class="btn btn-play" onclick="window.parent.openGame('BTI', 'Sport','BTI體育')"><span class="language_replace">進入遊戲</span></button>
                                                <!-- 加入最愛 class=>added-->
                                                <button type="button" class="btn-like desktop gameCode_BTI.Sport btn btn-round" onclick="favBtnClcik('BTI.Sport')">
                                                    <i class="icon icon-m-favorite"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">Maharaja，人氣精選</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Other data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-d37ee0b9136bcd3d" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_224 swiper-slide-active" role="group" aria-label="1 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BTI', 'Sport','BTI體育')" onmouseover="appendGameProp('BTI','BTI體育','--','224','BTI.Sport',0,'Sports','Sport')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BTI/CHT/Sport.png" onerror="showDefauktGameIcon('BTI', 'Sport')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BTI','Sport','BTI體育')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category etc">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BTI</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">224</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BTI.Sport btn btn-round" onclick="favBtnClcik('BTI.Sport')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">BTI體育</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">BTI體育</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4363 swiper-slide-next" role="group" aria-label="2 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '202','太陽神殿2 - 集鴻運')" onmouseover="appendGameProp('BNG','太陽神殿2 - 集鴻運','95.64','4363','BNG.202',0,'Slot','202')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/202.png" onerror="showDefauktGameIcon('BNG', '202')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','202','太陽神殿2 - 集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.64</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4363</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.202 btn btn-round" onclick="favBtnClcik('BNG.202')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">太陽神殿2 - 集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">太陽神殿2 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4371" role="group" aria-label="3 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '216','狼佐賀 - 集鴻運')" onmouseover="appendGameProp('BNG','狼佐賀 - 集鴻運','96.06','4371','BNG.216',0,'Slot','216')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/216.png" onerror="showDefauktGameIcon('BNG', '216')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','216','狼佐賀 - 集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.06</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4371</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.216 btn btn-round" onclick="favBtnClcik('BNG.216')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">狼佐賀 - 集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">狼佐賀 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4381" role="group" aria-label="4 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '228','淘金樂-集鴻運')" onmouseover="appendGameProp('BNG','淘金樂-集鴻運','95.66','4381','BNG.228',0,'Slot','228')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/228.png" onerror="showDefauktGameIcon('BNG', '228')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','228','淘金樂-集鴻運')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.66</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4381</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.228 btn btn-round" onclick="favBtnClcik('BNG.228')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">淘金樂-集鴻運</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">淘金樂-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4409" role="group" aria-label="5 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '274','驚天大盜')" onmouseover="appendGameProp('BNG','驚天大盜','95.71','4409','BNG.274',0,'Slot','274')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/274.png" onerror="showDefauktGameIcon('BNG', '274')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('BNG','274','驚天大盜')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">BNG</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">95.71</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4409</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_BNG.274 btn btn-round" onclick="favBtnClcik('BNG.274')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">驚天大盜</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">驚天大盜</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5258" role="group" aria-label="6 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '43','7PK')" onmouseover="appendGameProp('KGS','7PK','96.52','5258','KGS.43',0,'Electron','43')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/43.png" onerror="showDefauktGameIcon('KGS', '43')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">7PK</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4311" role="group" aria-label="7 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '212','大三元-集鴻運')" onmouseover="appendGameProp('BNG','大三元-集鴻運','95.84','4311','BNG.212',0,'Slot','212')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/212.png" onerror="showDefauktGameIcon('BNG', '212')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">大三元-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-d37ee0b9136bcd3d" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-d37ee0b9136bcd3d" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">經典機台，PK系列</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Other data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-27b1085cb9a9ee09b" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_5257 swiper-slide-active" role="group" aria-label="1 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '44','5PK')" onmouseover="appendGameProp('KGS','5PK','96.78','5257','KGS.44',0,'Electron','44')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/44.png" onerror="showDefauktGameIcon('KGS', '44')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('KGS','44','5PK')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category elec">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">KGS</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.78</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">5257</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_KGS.44 btn btn-round" onclick="favBtnClcik('KGS.44')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">5PK</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">5PK</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5258 swiper-slide-next" role="group" aria-label="2 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '43','7PK')" onmouseover="appendGameProp('KGS','7PK','96.52','5258','KGS.43',0,'Electron','43')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/43.png" onerror="showDefauktGameIcon('KGS', '43')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('KGS','43','7PK')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category elec">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">KGS</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.52</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">5258</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_KGS.43 btn btn-round" onclick="favBtnClcik('KGS.43')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">7PK</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">7PK</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5259" role="group" aria-label="3 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '45','懷舊7PK')" onmouseover="appendGameProp('KGS','懷舊7PK','96.06','5259','KGS.45',0,'Electron','45')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/45.png" onerror="showDefauktGameIcon('KGS', '45')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('KGS','45','懷舊7PK')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category elec">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">KGS</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.06</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">5259</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_KGS.45 btn btn-round" onclick="favBtnClcik('KGS.45')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">懷舊7PK</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">懷舊7PK</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-27b1085cb9a9ee09b" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-27b1085cb9a9ee09b" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">棒球 足球 籃球，體育大集結</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Other data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-176101f8f2dacd7be" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_224 swiper-slide-active" role="group" aria-label="1 / 1">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BTI', 'Sport','BTI體育')" onmouseover="appendGameProp('BTI','BTI體育','--','224','BTI.Sport',0,'Sports','Sport')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BTI/CHT/Sport.png" onerror="showDefauktGameIcon('BTI', 'Sport')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">BTI體育</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-176101f8f2dacd7be" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-176101f8f2dacd7be" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">經典!電子撲克系列</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Other data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-a9640c15b8889e11" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4533 swiper-slide-active" role="group" aria-label="1 / 1">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'BT03','搶莊眯牌牛牛')" onmouseover="appendGameProp('CQ9','搶莊眯牌牛牛','96','4533','CQ9.BT03',0,'Electron','BT03')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/BT03.png" onerror="showDefauktGameIcon('CQ9', 'BT03')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">搶莊眯牌牛牛</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-a9640c15b8889e11" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-a9640c15b8889e11" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey">Maharaja，小編私心推薦</span>
                                        </h3>
                                    </div>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Other data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-381cc103133807c2a" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4094 swiper-slide-active" role="group" aria-label="1 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BBIN', '120','色碟')" onmouseover="appendGameProp('BBIN','色碟','97.5','4094','BBIN.120',0,'Electron','120')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/120.png" onerror="showDefauktGameIcon('BBIN', '120')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">色碟</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4532 swiper-slide-next" role="group" aria-label="2 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'GO169','招財龍小鋼珠')" onmouseover="appendGameProp('CQ9','招財龍小鋼珠','96.03','4532','CQ9.GO169',0,'Electron','GO169')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/GO169.png" onerror="showDefauktGameIcon('CQ9', 'GO169')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">招財龍小鋼珠</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4536" role="group" aria-label="3 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '200','跑跑愛麗絲')" onmouseover="appendGameProp('CQ9','跑跑愛麗絲','96.05','4536','CQ9.200',0,'Electron','200')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/200.png" onerror="showDefauktGameIcon('CQ9', '200')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">跑跑愛麗絲</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-381cc103133807c2a" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-381cc103133807c2a" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                    <section class="section-wrap section_randomRem">
                        <div class="container">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                    </div>
                                </div>
                                <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup1_GameList_Other swiper-container-coverflow swiper-container-3d swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events" style="cursor: grab;">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-d8220aa2e104df8a8" aria-live="polite" style="transition-duration: 0ms; transform: translate3d(-150px, 0px, 0px);">
                                        <div class="swiper-slide desktop gameid_4093 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="1 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BBIN', '119','骰寶')" onmouseover="appendGameProp('BBIN','骰寶','97.22','4093','BBIN.119',2,'Electron','119')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/119.png" onerror="showDefauktGameIcon('BBIN', '119')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">骰寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 2; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4532 swiper-slide-duplicate swiper-slide-prev swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="2 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'GO169','招財龍小鋼珠')" onmouseover="appendGameProp('CQ9','招財龍小鋼珠','96.03','4532','CQ9.GO169',2,'Electron','GO169')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/GO169.png" onerror="showDefauktGameIcon('CQ9', 'GO169')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">招財龍小鋼珠</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 1; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4093 swiper-slide-active" data-swiper-slide-index="0" role="group" aria-label="3 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px) rotateX(0deg) rotateY(0deg) scale(1); z-index: 1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BBIN', '119','骰寶')" onmouseover="appendGameProp('BBIN','骰寶','97.22','4093','BBIN.119',2,'Electron','119')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/119.png" onerror="showDefauktGameIcon('BBIN', '119')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">骰寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 0; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4532 swiper-slide-next swiper-slide-duplicate-prev" data-swiper-slide-index="1" role="group" aria-label="4 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -300px) rotateX(0deg) rotateY(-20deg) scale(1); z-index: 0;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'GO169','招財龍小鋼珠')" onmouseover="appendGameProp('CQ9','招財龍小鋼珠','96.03','4532','CQ9.GO169',2,'Electron','GO169')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/GO169.png" onerror="showDefauktGameIcon('CQ9', 'GO169')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">招財龍小鋼珠</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 1; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4093 swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="0" role="group" aria-label="5 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -600px) rotateX(0deg) rotateY(-40deg) scale(1); z-index: -1;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('BBIN', '119','骰寶')" onmouseover="appendGameProp('BBIN','骰寶','97.22','4093','BBIN.119',2,'Electron','119')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/119.png" onerror="showDefauktGameIcon('BBIN', '119')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">骰寶</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 2; transition-duration: 0ms;"></div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4532 swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="1" role="group" aria-label="6 / 6" style="transition-duration: 0ms; transform: translate3d(0px, 0px, -900px) rotateX(0deg) rotateY(-60deg) scale(1); z-index: -2;">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'GO169','招財龍小鋼珠')" onmouseover="appendGameProp('CQ9','招財龍小鋼珠','96.03','4532','CQ9.GO169',2,'Electron','GO169')"></span>
                                                    <div class="img-wrap">
                                                        <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/GO169.png" onerror="showDefauktGameIcon('CQ9', 'GO169')">
                                                    </div>
                                                </div>
                                                <div class="game-item-info">
                                                    <h3 class="game-item-name">招財龍小鋼珠</h3>
                                                </div>
                                            </div>
                                            <div class="swiper-slide-shadow-left" style="opacity: 0; transition-duration: 0ms;"></div>
                                            <div class="swiper-slide-shadow-right" style="opacity: 3; transition-duration: 0ms;"></div>
                                        </div>
                                    </div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>

            <div id="gameAreas4" class="divGameAreas" style="display: none">
                <div id="categoryPage_GameList_Brand" class="categoryPage" style="display: block;">
                    <div class="container">
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('PP')">PP</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('PP')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-1741c48f7a8f22a6" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_6189 swiper-slide-active" role="group" aria-label="1 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs15diamond','鑽石罷工')" onmouseover="appendGameProp('PP','鑽石罷工','96.96','6189','PP.vs15diamond',0,'Slot','vs15diamond')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs15diamond.png" onerror="showDefauktGameIcon('PP', 'vs15diamond')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">鑽石罷工</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6091 swiper-slide-next" role="group" aria-label="2 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', '204','超級輪盤')" onmouseover="appendGameProp('PP','超級輪盤','--','6091','PP.204',0,'Live','204')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/204.png" onerror="showDefauktGameIcon('PP', '204')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5985" role="group" aria-label="3 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', '401','真人百家樂')" onmouseover="appendGameProp('PP','真人百家樂','--','5985','PP.401',0,'Live','401')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/401.png" onerror="showDefauktGameIcon('PP', '401')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','401','真人百家樂')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">5985</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.401 btn btn-round" onclick="favBtnClcik('PP.401')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">真人百家樂</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">真人百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6112" role="group" aria-label="4 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'cs5moneyroll','財源滾滾')" onmouseover="appendGameProp('PP','財源滾滾','96.93','6112','PP.cs5moneyroll',0,'Slot','cs5moneyroll')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/cs5moneyroll.png" onerror="showDefauktGameIcon('PP', 'cs5moneyroll')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('PP','cs5moneyroll','財源滾滾')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category slot">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">PP</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">96.93</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">6112</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_PP.cs5moneyroll btn btn-round" onclick="favBtnClcik('PP.cs5moneyroll')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">財源滾滾</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">財源滾滾</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6296" role="group" aria-label="5 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25pandagold','熊貓財富')" onmouseover="appendGameProp('PP','熊貓財富','96.17','6296','PP.vs25pandagold',0,'Slot','vs25pandagold')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25pandagold.png" onerror="showDefauktGameIcon('PP', 'vs25pandagold')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">熊貓財富</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6300" role="group" aria-label="6 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25queenofgold','黃金女王')" onmouseover="appendGameProp('PP','黃金女王','96.5','6300','PP.vs25queenofgold',0,'Slot','vs25queenofgold')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25queenofgold.png" onerror="showDefauktGameIcon('PP', 'vs25queenofgold')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金女王</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_6311" role="group" aria-label="7 / 7">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('PP', 'vs25wildspells','法力無邊')" onmouseover="appendGameProp('PP','法力無邊','96.4','6311','PP.vs25wildspells',0,'Slot','vs25wildspells')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/PP/CHT/vs25wildspells.png" onerror="showDefauktGameIcon('PP', 'vs25wildspells')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">法力無邊</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-1741c48f7a8f22a6" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-1741c48f7a8f22a6" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('EVO')">EVO</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('EVO')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-dfc5ed339e9da023" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4875 swiper-slide-active" role="group" aria-label="1 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'XxxtremeLigh0001','XXXtreme閃電輪盤')" onmouseover="appendGameProp('EVO','XXXtreme閃電輪盤','--','4875','EVO.XxxtremeLigh0001',0,'Live','XxxtremeLigh0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/XxxtremeLigh0001.png" onerror="showDefauktGameIcon('EVO', 'XxxtremeLigh0001')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','XxxtremeLigh0001','XXXtreme閃電輪盤')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4875</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.XxxtremeLigh0001 btn btn-round" onclick="favBtnClcik('EVO.XxxtremeLigh0001')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">XXXtreme閃電輪盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4713 swiper-slide-next" role="group" aria-label="2 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'peekbaccarat0001','看牌百家樂')" onmouseover="appendGameProp('EVO','看牌百家樂','--','4713','EVO.peekbaccarat0001',0,'Live','peekbaccarat0001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/peekbaccarat0001.png" onerror="showDefauktGameIcon('EVO', 'peekbaccarat0001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">看牌百家樂</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4791" role="group" aria-label="3 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus addedGameProp">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'p36n5jvdx7bugh2g','沙龍私人二十一點G')" onmouseover="appendGameProp('EVO','沙龍私人二十一點G','--','4791','EVO.p36n5jvdx7bugh2g',0,'Live','p36n5jvdx7bugh2g')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/p36n5jvdx7bugh2g.png" onerror="showDefauktGameIcon('EVO', 'p36n5jvdx7bugh2g')">
                                                            </div>
                                                        </div>

                                                        <div class="game-item-info-detail open" onclick="window.parent.openGame('EVO','p36n5jvdx7bugh2g','沙龍私人二十一點G')">
                                                            <div class="game-item-info-detail-wrapper">
                                                                <div class="game-item-info-detail-moreInfo">
                                                                    <ul class="moreInfo-item-wrapper">
                                                                        <li class="moreInfo-item category live">
                                                                            <span class="value"><i class="icon icon-mask"></i></span>
                                                                        </li>
                                                                        <li class="moreInfo-item brand">
                                                                            <span class="title language_replace">廠牌</span>
                                                                            <span class="value GameBrand">EVO</span>
                                                                        </li>
                                                                        <li class="moreInfo-item RTP">
                                                                            <span class="title">RTP</span>
                                                                            <span class="value number valueRTP">--</span>
                                                                        </li>
                                                                        <li class="moreInfo-item gamecode">
                                                                            <span class="title">NO.</span>
                                                                            <span class="value number GameID">4791</span>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                                <div class="game-item-info-detail-indicator">
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name" style="font-size: 0.8rem;"></h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                                <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                                    <i class="icon icon-m-thumup"></i>
                                                                                </button>
                                                                                <button type="button" class="btn-like desktop gameCode_EVO.p36n5jvdx7bugh2g btn btn-round" onclick="favBtnClcik('EVO.p36n5jvdx7bugh2g')">
                                                                                    <i class="icon icon-m-favorite"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="game-item-info-detail-indicator-inner">
                                                                        <div class="info">
                                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                                        </div>
                                                                        <div class="action">
                                                                            <div class="btn-s-wrapper">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">沙龍私人二十一點G</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4847" role="group" aria-label="4 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'dealnodeal000001','一擲千金')" onmouseover="appendGameProp('EVO','一擲千金','--','4847','EVO.dealnodeal000001',0,'Live','dealnodeal000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/dealnodeal000001.png" onerror="showDefauktGameIcon('EVO', 'dealnodeal000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">一擲千金</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4850" role="group" aria-label="5 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'MegaBall00000001','超級球')" onmouseover="appendGameProp('EVO','超級球','--','4850','EVO.MegaBall00000001',0,'Live','MegaBall00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/MegaBall00000001.png" onerror="showDefauktGameIcon('EVO', 'MegaBall00000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">超級球</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4843" role="group" aria-label="6 / 6">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('EVO', 'TRPTable00000001','三重卡撲克')" onmouseover="appendGameProp('EVO','三重卡撲克','--','4843','EVO.TRPTable00000001',0,'Live','TRPTable00000001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/EVO/CHT/TRPTable00000001.png" onerror="showDefauktGameIcon('EVO', 'TRPTable00000001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">三重卡撲克</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-dfc5ed339e9da023" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-dfc5ed339e9da023" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('BNG')">BNG</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('BNG')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-57720c2a7132b231" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4313 swiper-slide-active" role="group" aria-label="1 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '263','火焰大贏家')" onmouseover="appendGameProp('BNG','火焰大贏家','96.15','4313','BNG.263',0,'Slot','263')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/263.png" onerror="showDefauktGameIcon('BNG', '263')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">火焰大贏家</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4331 swiper-slide-next" role="group" aria-label="2 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '156','狂野小丑: 100條賠付線')" onmouseover="appendGameProp('BNG','狂野小丑: 100條賠付線','96.46','4331','BNG.156',0,'Slot','156')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/156.png" onerror="showDefauktGameIcon('BNG', '156')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">狂野小丑: 100條賠付線</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4336" role="group" aria-label="3 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '164','天后')" onmouseover="appendGameProp('BNG','天后','95.78','4336','BNG.164',0,'Slot','164')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/164.png" onerror="showDefauktGameIcon('BNG', '164')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">天后</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4337" role="group" aria-label="4 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '166','諸神榮耀')" onmouseover="appendGameProp('BNG','諸神榮耀','95.6','4337','BNG.166',0,'Slot','166')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/166.png" onerror="showDefauktGameIcon('BNG', '166')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">諸神榮耀</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4339" role="group" aria-label="5 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '168','錢滾滾聖甲蟲')" onmouseover="appendGameProp('BNG','錢滾滾聖甲蟲','95.3','4339','BNG.168',0,'Slot','168')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/168.png" onerror="showDefauktGameIcon('BNG', '168')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">錢滾滾聖甲蟲</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4343" role="group" aria-label="6 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '176','王者凱薩')" onmouseover="appendGameProp('BNG','王者凱薩','96.23','4343','BNG.176',0,'Slot','176')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/176.png" onerror="showDefauktGameIcon('BNG', '176')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">王者凱薩</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4356" role="group" aria-label="7 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '191','蠻牛向錢衝: 集鴻運')" onmouseover="appendGameProp('BNG','蠻牛向錢衝: 集鴻運','95.04','4356','BNG.191',0,'Slot','191')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/191.png" onerror="showDefauktGameIcon('BNG', '191')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">蠻牛向錢衝: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4358" role="group" aria-label="8 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '197','錢龍 - 集鴻運')" onmouseover="appendGameProp('BNG','錢龍 - 集鴻運','95.71','4358','BNG.197',0,'Slot','197')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/197.png" onerror="showDefauktGameIcon('BNG', '197')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">錢龍 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4363" role="group" aria-label="9 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '202','太陽神殿2 - 集鴻運')" onmouseover="appendGameProp('BNG','太陽神殿2 - 集鴻運','95.64','4363','BNG.202',0,'Slot','202')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/202.png" onerror="showDefauktGameIcon('BNG', '202')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">太陽神殿2 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4368" role="group" aria-label="10 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '209','金鑽霸虎 - 集鴻運')" onmouseover="appendGameProp('BNG','金鑽霸虎 - 集鴻運','95.67','4368','BNG.209',0,'Slot','209')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/209.png" onerror="showDefauktGameIcon('BNG', '209')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">金鑽霸虎 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4371" role="group" aria-label="11 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '216','狼佐賀 - 集鴻運')" onmouseover="appendGameProp('BNG','狼佐賀 - 集鴻運','96.06','4371','BNG.216',0,'Slot','216')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/216.png" onerror="showDefauktGameIcon('BNG', '216')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">狼佐賀 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4372" role="group" aria-label="12 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '217','好運金財神-集鴻運')" onmouseover="appendGameProp('BNG','好運金財神-集鴻運','95.58','4372','BNG.217',0,'Slot','217')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/217.png" onerror="showDefauktGameIcon('BNG', '217')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">好運金財神-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4374" role="group" aria-label="13 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '219','致命毒蘋果-集鴻運')" onmouseover="appendGameProp('BNG','致命毒蘋果-集鴻運','95.76','4374','BNG.219',0,'Slot','219')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/219.png" onerror="showDefauktGameIcon('BNG', '219')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">致命毒蘋果-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4381" role="group" aria-label="14 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '228','淘金樂-集鴻運')" onmouseover="appendGameProp('BNG','淘金樂-集鴻運','95.66','4381','BNG.228',0,'Slot','228')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/228.png" onerror="showDefauktGameIcon('BNG', '228')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">淘金樂-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4384" role="group" aria-label="15 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '233','悟空傳-集鴻運')" onmouseover="appendGameProp('BNG','悟空傳-集鴻運','95.72','4384','BNG.233',0,'Slot','233')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/233.png" onerror="showDefauktGameIcon('BNG', '233')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">悟空傳-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4386" role="group" aria-label="16 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '241','皇家錢滾滾-集鴻運')" onmouseover="appendGameProp('BNG','皇家錢滾滾-集鴻運','95.64','4386','BNG.241',0,'Slot','241')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/241.png" onerror="showDefauktGameIcon('BNG', '241')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">皇家錢滾滾-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4387" role="group" aria-label="17 / 35">
                                            <div class="game-item crownLevel-2 crown-P-S">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '242','叢林之王-集鴻運')" onmouseover="appendGameProp('BNG','叢林之王-集鴻運','95.86','4387','BNG.242',0,'Slot','242')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/242.png" onerror="showDefauktGameIcon('BNG', '242')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">叢林之王-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4389" role="group" aria-label="18 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '249','黃金特快車-集鴻運')" onmouseover="appendGameProp('BNG','黃金特快車-集鴻運','95.64','4389','BNG.249',0,'Slot','249')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/249.png" onerror="showDefauktGameIcon('BNG', '249')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黃金特快車-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4390" role="group" aria-label="19 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '250','轟炸糖果')" onmouseover="appendGameProp('BNG','轟炸糖果','95.52','4390','BNG.250',0,'Slot','250')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/250.png" onerror="showDefauktGameIcon('BNG', '250')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">轟炸糖果</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4392" role="group" aria-label="20 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '252','金禧迎獅-集鴻運')" onmouseover="appendGameProp('BNG','金禧迎獅-集鴻運','95.76','4392','BNG.252',0,'Slot','252')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/252.png" onerror="showDefauktGameIcon('BNG', '252')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">金禧迎獅-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4395" role="group" aria-label="21 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '256','烈日女神-集鴻運')" onmouseover="appendGameProp('BNG','烈日女神-集鴻運','95.77','4395','BNG.256',0,'Slot','256')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/256.png" onerror="showDefauktGameIcon('BNG', '256')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">烈日女神-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4396" role="group" aria-label="22 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '259','採珠潛水員2: 藏寶箱')" onmouseover="appendGameProp('BNG','採珠潛水員2: 藏寶箱','95.67','4396','BNG.259',0,'Slot','259')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/259.png" onerror="showDefauktGameIcon('BNG', '259')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">採珠潛水員2: 藏寶箱</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4397" role="group" aria-label="23 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '261','快樂魚')" onmouseover="appendGameProp('BNG','快樂魚','95.61','4397','BNG.261',0,'Slot','261')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/261.png" onerror="showDefauktGameIcon('BNG', '261')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">快樂魚</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4398" role="group" aria-label="24 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '262','太陽神殿3 - 集鴻運')" onmouseover="appendGameProp('BNG','太陽神殿3 - 集鴻運','95.58','4398','BNG.262',0,'Slot','262')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/262.png" onerror="showDefauktGameIcon('BNG', '262')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">太陽神殿3 - 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4399" role="group" aria-label="25 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '264','獅王秘寶: 集鴻運')" onmouseover="appendGameProp('BNG','獅王秘寶: 集鴻運','95.55','4399','BNG.264',0,'Slot','264')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/264.png" onerror="showDefauktGameIcon('BNG', '264')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">獅王秘寶: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4400" role="group" aria-label="26 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '265','滿貫金財神-集鴻運')" onmouseover="appendGameProp('BNG','滿貫金財神-集鴻運','95.53','4400','BNG.265',0,'Slot','265')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/265.png" onerror="showDefauktGameIcon('BNG', '265')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">滿貫金財神-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4405" role="group" aria-label="27 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '270','蓮花奇緣-超百搭集鴻運')" onmouseover="appendGameProp('BNG','蓮花奇緣-超百搭集鴻運','95.78','4405','BNG.270',0,'Slot','270')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/270.png" onerror="showDefauktGameIcon('BNG', '270')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">蓮花奇緣-超百搭集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4406" role="group" aria-label="28 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '271','果汁夢工廠')" onmouseover="appendGameProp('BNG','果汁夢工廠','95','4406','BNG.271',0,'Slot','271')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/271.png" onerror="showDefauktGameIcon('BNG', '271')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">果汁夢工廠</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4408" role="group" aria-label="29 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '273','盧克索神廟: 集鴻運')" onmouseover="appendGameProp('BNG','盧克索神廟: 集鴻運','95.76','4408','BNG.273',0,'Slot','273')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/273.png" onerror="showDefauktGameIcon('BNG', '273')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">盧克索神廟: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4414" role="group" aria-label="30 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '279','皇家錢滾滾2: 集鴻運')" onmouseover="appendGameProp('BNG','皇家錢滾滾2: 集鴻運','95.64','4414','BNG.279',0,'Slot','279')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/279.png" onerror="showDefauktGameIcon('BNG', '279')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">皇家錢滾滾2: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4412" role="group" aria-label="31 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '277','鑽石寶庫: 集鴻運')" onmouseover="appendGameProp('BNG','鑽石寶庫: 集鴻運','95.55','4412','BNG.277',0,'Slot','277')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/277.png" onerror="showDefauktGameIcon('BNG', '277')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">鑽石寶庫: 集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4323" role="group" aria-label="32 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '14','快樂鳥')" onmouseover="appendGameProp('BNG','快樂鳥','93.7','4323','BNG.14',0,'Slot','14')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/14.png" onerror="showDefauktGameIcon('BNG', '14')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">快樂鳥</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4393" role="group" aria-label="33 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '254','黑狼-集鴻運')" onmouseover="appendGameProp('BNG','黑狼-集鴻運','95.63','4393','BNG.254',0,'Slot','254')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/254.png" onerror="showDefauktGameIcon('BNG', '254')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">黑狼-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4409" role="group" aria-label="34 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '274','驚天大盜')" onmouseover="appendGameProp('BNG','驚天大盜','95.71','4409','BNG.274',0,'Slot','274')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/274.png" onerror="showDefauktGameIcon('BNG', '274')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">驚天大盜</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4411" role="group" aria-label="35 / 35">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BNG', '276','小辣嬌-集鴻運')" onmouseover="appendGameProp('BNG','小辣嬌-集鴻運','95.65','4411','BNG.276',0,'Slot','276')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BNG/CHT/276.png" onerror="showDefauktGameIcon('BNG', '276')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">小辣嬌-集鴻運</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-57720c2a7132b231" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-57720c2a7132b231" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('XG')">XG</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('XG')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-8a4f195d5b4d63f1" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_3183 swiper-slide-active" role="group" aria-label="1 / 1">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('XG', 'E','百家樂E')" onmouseover="appendGameProp('XG','百家樂E','--','3183','XG.E',0,'Live','E')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/XG/CHT/E.png" onerror="showDefauktGameIcon('XG', 'E')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">百家樂E</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-8a4f195d5b4d63f1" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-8a4f195d5b4d63f1" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('BBIN')">BBIN</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('BBIN')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-25b88fbc1058ef72d" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4102 swiper-slide-active" role="group" aria-label="1 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BBIN', '117','搶莊牛牛')" onmouseover="appendGameProp('BBIN','搶莊牛牛','97.5','4102','BBIN.117',0,'Electron','117')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/117.png" onerror="showDefauktGameIcon('BBIN', '117')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">搶莊牛牛</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4278 swiper-slide-next" role="group" aria-label="2 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BBIN', '78','三國')" onmouseover="appendGameProp('BBIN','三國','96.58','4278','BBIN.78',0,'Slot','78')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/78.png" onerror="showDefauktGameIcon('BBIN', '78')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">三國</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4244" role="group" aria-label="3 / 3">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BBIN', '57','初音大進擊')" onmouseover="appendGameProp('BBIN','初音大進擊','96.82','4244','BBIN.57',0,'Slot','57')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BBIN/CHT/57.png" onerror="showDefauktGameIcon('BBIN', '57')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">初音大進擊</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-25b88fbc1058ef72d" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-25b88fbc1058ef72d" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('KGS')">KGS</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('KGS')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-937712a1cbc3513a" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_5257 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '44','5PK')" onmouseover="appendGameProp('KGS','5PK','96.78','5257','KGS.44',0,'Electron','44')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/44.png" onerror="showDefauktGameIcon('KGS', '44')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">5PK</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5258 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '43','7PK')" onmouseover="appendGameProp('KGS','7PK','96.52','5258','KGS.43',0,'Electron','43')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/43.png" onerror="showDefauktGameIcon('KGS', '43')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">7PK</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5262" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '28','金龍傳說')" onmouseover="appendGameProp('KGS','金龍傳說','95.99','5262','KGS.28',0,'Slot','28')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/28.png" onerror="showDefauktGameIcon('KGS', '28')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">金龍傳說</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5275" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '21','龍爭虎鬥')" onmouseover="appendGameProp('KGS','龍爭虎鬥','96.99','5275','KGS.21',0,'Slot','21')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/21.png" onerror="showDefauktGameIcon('KGS', '21')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">龍爭虎鬥</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5276" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '22','地精寶藏')" onmouseover="appendGameProp('KGS','地精寶藏','94.8','5276','KGS.22',0,'Slot','22')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/22.png" onerror="showDefauktGameIcon('KGS', '22')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">地精寶藏</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5288" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '48','角斗士')" onmouseover="appendGameProp('KGS','角斗士','96.52','5288','KGS.48',0,'Slot','48')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/48.png" onerror="showDefauktGameIcon('KGS', '48')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">角斗士</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5289" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '49','福爾摩斯')" onmouseover="appendGameProp('KGS','福爾摩斯','96.78','5289','KGS.49',0,'Slot','49')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/49.png" onerror="showDefauktGameIcon('KGS', '49')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">福爾摩斯</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5293" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '9','水果熊貓')" onmouseover="appendGameProp('KGS','水果熊貓','95.43','5293','KGS.9',0,'Slot','9')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/9.png" onerror="showDefauktGameIcon('KGS', '9')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">水果熊貓</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5296" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '8','糖果派對')" onmouseover="appendGameProp('KGS','糖果派對','97.63','5296','KGS.8',0,'Slot','8')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/8.png" onerror="showDefauktGameIcon('KGS', '8')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">糖果派對</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5261" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('KGS', '13','幸運水果盤')" onmouseover="appendGameProp('KGS','幸運水果盤','96.99','5261','KGS.13',0,'Slot','13')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/KGS/CHT/13.png" onerror="showDefauktGameIcon('KGS', '13')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">幸運水果盤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-937712a1cbc3513a" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-937712a1cbc3513a" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('GMW')">GMW</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('GMW')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-5b35b16f9fdfcc1f" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4935 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '889','小紅帽')" onmouseover="appendGameProp('GMW','小紅帽','96','4935','GMW.889',0,'Slot','889')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/889.png" onerror="showDefauktGameIcon('GMW', '889')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">小紅帽</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4939 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '893','深淵公主')" onmouseover="appendGameProp('GMW','深淵公主','96','4939','GMW.893',0,'Slot','893')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/893.png" onerror="showDefauktGameIcon('GMW', '893')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">深淵公主</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4941" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '895','斯巴達 最終一戰')" onmouseover="appendGameProp('GMW','斯巴達 最終一戰','69.09','4941','GMW.895',0,'Slot','895')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/895.png" onerror="showDefauktGameIcon('GMW', '895')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">斯巴達 最終一戰</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4946" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '900','幸運小丑')" onmouseover="appendGameProp('GMW','幸運小丑','96','4946','GMW.900',0,'Slot','900')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/900.png" onerror="showDefauktGameIcon('GMW', '900')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">幸運小丑</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4949" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '903','獅鷲獸')" onmouseover="appendGameProp('GMW','獅鷲獸','96','4949','GMW.903',0,'Slot','903')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/903.png" onerror="showDefauktGameIcon('GMW', '903')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">獅鷲獸</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4959" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '913','陰陽')" onmouseover="appendGameProp('GMW','陰陽','96.03','4959','GMW.913',0,'Slot','913')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/913.png" onerror="showDefauktGameIcon('GMW', '913')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">陰陽</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4960" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '914','波塞頓')" onmouseover="appendGameProp('GMW','波塞頓','96.05','4960','GMW.914',0,'Slot','914')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/914.png" onerror="showDefauktGameIcon('GMW', '914')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">波塞頓</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4961" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '915','阿斯嘉')" onmouseover="appendGameProp('GMW','阿斯嘉','96','4961','GMW.915',0,'Slot','915')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/915.png" onerror="showDefauktGameIcon('GMW', '915')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">阿斯嘉</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4967" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '921','霓虹之夜')" onmouseover="appendGameProp('GMW','霓虹之夜','96.22','4967','GMW.921',0,'Slot','921')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/921.png" onerror="showDefauktGameIcon('GMW', '921')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">霓虹之夜</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4972" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('GMW', '926','深海之王')" onmouseover="appendGameProp('GMW','深海之王','96','4972','GMW.926',0,'Slot','926')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/GMW/CHT/926.png" onerror="showDefauktGameIcon('GMW', '926')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">深海之王</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-5b35b16f9fdfcc1f" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-5b35b16f9fdfcc1f" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('HB')">HB</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('HB')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-b4c3d8fc872545c9" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4975 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '830','骰寶')" onmouseover="appendGameProp('HB','骰寶','90.3','4975','HB.830',0,'Electron','830')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/830.png" onerror="showDefauktGameIcon('HB', '830')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">骰寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4981 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '834','龍虎')" onmouseover="appendGameProp('HB','龍虎','96.27','4981','HB.834',0,'Electron','834')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/834.png" onerror="showDefauktGameIcon('HB', '834')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">龍虎</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5045" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '733','快樂聖誕')" onmouseover="appendGameProp('HB','快樂聖誕','96','5045','HB.733',0,'Slot','733')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/733.png" onerror="showDefauktGameIcon('HB', '733')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">快樂聖誕</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5085" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '774','比基尼島')" onmouseover="appendGameProp('HB','比基尼島','96','5085','HB.774',0,'Slot','774')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/774.png" onerror="showDefauktGameIcon('HB', '774')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">比基尼島</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5102" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '791','叢林怒吼')" onmouseover="appendGameProp('HB','叢林怒吼','96','5102','HB.791',0,'Slot','791')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/791.png" onerror="showDefauktGameIcon('HB', '791')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">叢林怒吼</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5104" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '793','太空小綠人')" onmouseover="appendGameProp('HB','太空小綠人','96','5104','HB.793',0,'Slot','793')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/793.png" onerror="showDefauktGameIcon('HB', '793')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">太空小綠人</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5111" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '800','台球鯊魚')" onmouseover="appendGameProp('HB','台球鯊魚','96','5111','HB.800',0,'Slot','800')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/800.png" onerror="showDefauktGameIcon('HB', '800')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">台球鯊魚</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5128" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '817','深海尋寶')" onmouseover="appendGameProp('HB','深海尋寶','96','5128','HB.817',0,'Slot','817')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/817.png" onerror="showDefauktGameIcon('HB', '817')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">深海尋寶</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5131" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '820','科學怪人')" onmouseover="appendGameProp('HB','科學怪人','96','5131','HB.820',0,'Slot','820')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/820.png" onerror="showDefauktGameIcon('HB', '820')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">科學怪人</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5132" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('HB', '821','宙斯')" onmouseover="appendGameProp('HB','宙斯','96','5132','HB.821',0,'Slot','821')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/HB/CHT/821.png" onerror="showDefauktGameIcon('HB', '821')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">宙斯</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-b4c3d8fc872545c9" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-b4c3d8fc872545c9" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('NE')">NE</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('NE')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-69ade3dd13efde4b" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_5721 swiper-slide-active" role="group" aria-label="1 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '1001','蒸汽之塔')" onmouseover="appendGameProp('NE','蒸汽之塔','97.04','5721','NE.1001',0,'Slot','1001')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/1001.png" onerror="showDefauktGameIcon('NE', '1001')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">蒸汽之塔</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5750 swiper-slide-next" role="group" aria-label="2 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '934','吸血男爵')" onmouseover="appendGameProp('NE','吸血男爵','96.01','5750','NE.934',0,'Slot','934')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/934.png" onerror="showDefauktGameIcon('NE', '934')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">吸血男爵</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5752" role="group" aria-label="3 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '936','猩猩王國')" onmouseover="appendGameProp('NE','猩猩王國','96.03','5752','NE.936',0,'Slot','936')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/936.png" onerror="showDefauktGameIcon('NE', '936')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">猩猩王國</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5754" role="group" aria-label="4 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '939','怒海狂濤')" onmouseover="appendGameProp('NE','怒海狂濤','96.04','5754','NE.939',0,'Slot','939')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/939.png" onerror="showDefauktGameIcon('NE', '939')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">怒海狂濤</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5772" role="group" aria-label="5 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '959','傑克和魔豆')" onmouseover="appendGameProp('NE','傑克和魔豆','96.28','5772','NE.959',0,'Slot','959')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/959.png" onerror="showDefauktGameIcon('NE', '959')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">傑克和魔豆</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5780" role="group" aria-label="6 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '967','財富小豬')" onmouseover="appendGameProp('NE','財富小豬','96.38','5780','NE.967',0,'Slot','967')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/967.png" onerror="showDefauktGameIcon('NE', '967')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">財富小豬</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5795" role="group" aria-label="7 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '984','太空戰爭')" onmouseover="appendGameProp('NE','太空戰爭','96.75','5795','NE.984',0,'Slot','984')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/984.png" onerror="showDefauktGameIcon('NE', '984')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">太空戰爭</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5797" role="group" aria-label="8 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '986','亡命對決 2')" onmouseover="appendGameProp('NE','亡命對決 2','96.8','5797','NE.986',0,'Slot','986')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/986.png" onerror="showDefauktGameIcon('NE', '986')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">亡命對決 2</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_5805" role="group" aria-label="9 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('NE', '995','凱旋')" onmouseover="appendGameProp('NE','凱旋','96.95','5805','NE.995',0,'Slot','995')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/NE/CHT/995.png" onerror="showDefauktGameIcon('NE', '995')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">凱旋</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-69ade3dd13efde4b" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-69ade3dd13efde4b" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('CG')">CG</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('CG')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-a102bd6f2104ef106010" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4435 swiper-slide-active" role="group" aria-label="1 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'Aladdin2','阿拉丁2')" onmouseover="appendGameProp('CG','阿拉丁2','95','4435','CG.Aladdin2',0,'Slot','Aladdin2')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/Aladdin2.png" onerror="showDefauktGameIcon('CG', 'Aladdin2')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">阿拉丁2</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4438 swiper-slide-next" role="group" aria-label="2 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'ArcadiaEX','新 電音大蜘蛛')" onmouseover="appendGameProp('CG','新 電音大蜘蛛','95','4438','CG.ArcadiaEX',0,'Slot','ArcadiaEX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/ArcadiaEX.png" onerror="showDefauktGameIcon('CG', 'ArcadiaEX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 電音大蜘蛛</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4426" role="group" aria-label="3 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'BenzBMW','賓士寶馬')" onmouseover="appendGameProp('CG','賓士寶馬','90','4426','CG.BenzBMW',0,'Electron','BenzBMW')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/BenzBMW.png" onerror="showDefauktGameIcon('CG', 'BenzBMW')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">賓士寶馬</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4520" role="group" aria-label="4 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'BreakAwayEX','新 極速賽車')" onmouseover="appendGameProp('CG','新 極速賽車','95','4520','CG.BreakAwayEX',0,'Slot','BreakAwayEX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/BreakAwayEX.png" onerror="showDefauktGameIcon('CG', 'BreakAwayEX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 極速賽車</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4521" role="group" aria-label="5 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'CircusEX','新 驚奇馬戲團')" onmouseover="appendGameProp('CG','新 驚奇馬戲團','95','4521','CG.CircusEX',0,'Slot','CircusEX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/CircusEX.png" onerror="showDefauktGameIcon('CG', 'CircusEX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 驚奇馬戲團</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4460" role="group" aria-label="6 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'FishingExpertEX','新 捕魚達人')" onmouseover="appendGameProp('CG','新 捕魚達人','95','4460','CG.FishingExpertEX',0,'Slot','FishingExpertEX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/FishingExpertEX.png" onerror="showDefauktGameIcon('CG', 'FishingExpertEX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 捕魚達人</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4523" role="group" aria-label="7 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'JurassicWorldEX','新 侏儸紀公園')" onmouseover="appendGameProp('CG','新 侏儸紀公園','95','4523','CG.JurassicWorldEX',0,'Slot','JurassicWorldEX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/JurassicWorldEX.png" onerror="showDefauktGameIcon('CG', 'JurassicWorldEX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 侏儸紀公園</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4431" role="group" aria-label="8 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'RichRunner','大富翁向錢跑')" onmouseover="appendGameProp('CG','大富翁向錢跑','90','4431','CG.RichRunner',0,'Electron','RichRunner')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/RichRunner.png" onerror="showDefauktGameIcon('CG', 'RichRunner')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">大富翁向錢跑</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4506" role="group" aria-label="9 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'TaikoDrumMasterEX','新 太鼓達人')" onmouseover="appendGameProp('CG','新 太鼓達人','95','4506','CG.TaikoDrumMasterEX',0,'Slot','TaikoDrumMasterEX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/TaikoDrumMasterEX.png" onerror="showDefauktGameIcon('CG', 'TaikoDrumMasterEX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 太鼓達人</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4510" role="group" aria-label="10 / 10">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CG', 'Triple7EX','新 777')" onmouseover="appendGameProp('CG','新 777','95','4510','CG.Triple7EX',0,'Slot','Triple7EX')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CG/CHT/Triple7EX.png" onerror="showDefauktGameIcon('CG', 'Triple7EX')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">新 777</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-a102bd6f2104ef106010" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-a102bd6f2104ef106010" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('BTI')">BTI</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('BTI')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-35cc91417e5df43c" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_224 swiper-slide-active" role="group" aria-label="1 / 1">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('BTI', 'Sport','BTI體育')" onmouseover="appendGameProp('BTI','BTI體育','--','224','BTI.Sport',0,'Sports','Sport')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/BTI/CHT/Sport.png" onerror="showDefauktGameIcon('BTI', 'Sport')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">BTI體育</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next swiper-button-disabled" tabindex="-1" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-35cc91417e5df43c" aria-disabled="true"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-35cc91417e5df43c" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                        <section class="section-wrap section-levelUp">
                            <div class="game_wrapper">
                                <div class="sec-title-container">
                                    <div class="sec-title-wrapper">
                                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i>
                                            <span class="language_replace title CategName langkey" onclick="window.parent.API_SearchGameByBrand('CQ9')">CQ9</span>
                                        </h3>
                                    </div>
                                    <a class="text-link">
                                        <span class="title-showAll" onclick="window.parent.API_SearchGameByBrand('CQ9')">全部顯示</span><i class="icon arrow arrow-right"></i>
                                    </a>
                                </div>
                                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup0_GameList_Brand data-showtype=0 swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-free-mode">
                                    <div class="swiper-wrapper GameItemGroupContent" id="swiper-wrapper-518d10bcfec85ea1" aria-live="polite">
                                        <div class="swiper-slide desktop gameid_4531 swiper-slide-active" role="group" aria-label="1 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'BT02','搶莊骰子牛牛')" onmouseover="appendGameProp('CQ9','搶莊骰子牛牛','96','4531','CQ9.BT02',0,'Electron','BT02')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/BT02.png" onerror="showDefauktGameIcon('CQ9', 'BT02')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">搶莊骰子牛牛</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4532 swiper-slide-next" role="group" aria-label="2 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', 'GO169','招財龍小鋼珠')" onmouseover="appendGameProp('CQ9','招財龍小鋼珠','96.03','4532','CQ9.GO169',0,'Electron','GO169')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/GO169.png" onerror="showDefauktGameIcon('CQ9', 'GO169')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">招財龍小鋼珠</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4536" role="group" aria-label="3 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '200','跑跑愛麗絲')" onmouseover="appendGameProp('CQ9','跑跑愛麗絲','96.05','4536','CQ9.200',0,'Electron','200')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/200.png" onerror="showDefauktGameIcon('CQ9', '200')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">跑跑愛麗絲</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4587" role="group" aria-label="4 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '180','金雞報囍3')" onmouseover="appendGameProp('CQ9','金雞報囍3','96.04','4587','CQ9.180',0,'Slot','180')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/180.png" onerror="showDefauktGameIcon('CQ9', '180')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">金雞報囍3</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4594" role="group" aria-label="5 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '188','板球狂熱')" onmouseover="appendGameProp('CQ9','板球狂熱','95.97','4594','CQ9.188',0,'Slot','188')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/188.png" onerror="showDefauktGameIcon('CQ9', '188')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">板球狂熱</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4596" role="group" aria-label="6 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '194','飛龍在天')" onmouseover="appendGameProp('CQ9','飛龍在天','96.16','4596','CQ9.194',0,'Slot','194')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/194.png" onerror="showDefauktGameIcon('CQ9', '194')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">飛龍在天</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4606" role="group" aria-label="7 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '205','蹦迪')" onmouseover="appendGameProp('CQ9','蹦迪','96.18','4606','CQ9.205',0,'Slot','205')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/205.png" onerror="showDefauktGameIcon('CQ9', '205')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">蹦迪</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4613" role="group" aria-label="8 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '214','忍者浣熊')" onmouseover="appendGameProp('CQ9','忍者浣熊','96.18','4613','CQ9.214',0,'Slot','214')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/214.png" onerror="showDefauktGameIcon('CQ9', '214')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">忍者浣熊</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide desktop gameid_4648" role="group" aria-label="9 / 9">
                                            <div class="game-item  ">
                                                <div class="game-item-inner">

                                                    <div class="game-item-focus">
                                                        <div class="game-item-img">
                                                            <span class="game-item-link" onclick="window.parent.openGame('CQ9', '64','宙斯')" onmouseover="appendGameProp('CQ9','宙斯','96.18','4648','CQ9.64',0,'Slot','64')"></span>
                                                            <div class="img-wrap">
                                                                <img class="gameimg lozad" src="https://img.ewin888.com/CQ9/CHT/64.png" onerror="showDefauktGameIcon('CQ9', '64')">
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="game-item-info">
                                                        <div class="game-item-info-inner">
                                                            <h3 class="game-item-name">宙斯</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-518d10bcfec85ea1" aria-disabled="false"></div>
                                    <div class="swiper-button-prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-518d10bcfec85ea1" aria-disabled="true"></div>
                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>

        </section>
        <!-- 遊戲-排名區-新版 遊戲內容-->
        <section class="game-area overflow-hidden" style="display: none">
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
                                                        <img src="">
                                                    </div>
                                                </div>
                                                <div class="game-item-info-detail open">
                                                    <div class="game-item-info-detail-wrapper">
                                                        <div class="game-item-info-detail-moreInfo">
                                                            <ul class="moreInfo-item-wrapper">
                                                                <!-- 判斷分類 加入class=> slot/live/etc/elec-->
                                                                <li class="moreInfo-item category slot">
                                                                    <span class="value"><i class="icon icon-mask"></i></span>
                                                                </li>
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
                                                                        <button type="button" class="btn-thumbUp btn btn-round is-hide">
                                                                            <i class="icon icon-m-thumup"></i>
                                                                        </button>
                                                                        <button type="button" class="btn-like btn btn-round">
                                                                            <i class="icon icon-m-favorite"></i>
                                                                        </button>
                                                                        <!-- <button type="button" class="btn-more btn btn-round">
                                                                            <i class="arrow arrow-down"></i>
                                                                        </button> -->
                                                                    </div>
                                                                    <!-- <button type="button" class="btn btn-play">
                                                                        <span class="language_replace">プレイ</span><i class="triangle"></i></button> -->
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
        <!-- 遊戲-隨機推薦-->


    </main>

    <div id="temCategItem" class="is-hide">
        <li class="tab-item">
            <span class="tab-item-link"><i class="icon icon-mask CategIcon"></i>
                <span class="title language_replace CategName" langkey=""></span></span>
        </li>
    </div>


    <div id="temCategArea2" class="is-hide">
        <section class="section-wrap section_randomRem">
            <div class="container-fluid">
                <div class="game_wrapper">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <!-- <h3 class="title">隨機推薦遊戲</h3> -->
                        </div>
                    </div>
                    <div class="game_slider swiper_container round-arrow swiper-cover GameItemGroup">
                        <div class="swiper-wrapper GameItemGroupContent">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <div id="temGameItem2" class="is-hide">
        <div class="swiper-slide">
            <div class="game-item">
                <div class="game-item-inner">
                    <span class="game-item-link"></span>
                    <div class="img-wrap">
                        <img class="gameimg lozad" src="">
                    </div>
                </div>
                <div class="game-item-info">
                    <h3 class="game-item-name"></h3>
                </div>
            </div>
        </div>
    </div>

    <div id="temCategArea3" class="is-hide">
        <section class="section-wrap section-levelUp">
            <div class="game_wrapper gameRanking">
                <div class="sec-title-container">
                    <div class="sec-title-wrapper">
                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="">排名</span></h3>
                    </div>
                </div>
                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow">
                    <div class="swiper-wrapper">
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
            </div>
        </section>
    </div>

    <div id="temGameItem3" class="is-hide">
        <div class="swiper-slide">
            <div class="game-item">
                <div class="game-item-inner">
                    <span class="game-item-mobile-popup" data-toggle="modal"></span>
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
                                                <span class="language_replace" langkey="プレイ">プレイ</span><i class="triangle"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>

    <footer class="footer-container">
        <div class="footer-inner">
            <div class="container">
                <ul class="company-info row">
                    <li class="info-item col">
                        <a id="Footer_About" onclick="window.parent.API_LoadPage('About','About.html')"><span class="language_replace" langkey="關於我們">關於我們</span></a>
                    </li>
                    <li class="info-item col">
                        <a id="Footer_ResponsibleGaming" onclick="window.parent.API_ShowPartialHtml('', 'ResponsibleGaming', true, null)">
                            <span class="language_replace" langkey="負責任的賭博">負責任的賭博</span>
                        </a>
                    </li>
                    <li class="info-item col">
                        <a id="Footer_Rules" onclick="window.parent.API_ShowPartialHtml('', 'Rules', true, null)">
                            <span class="language_replace" langkey="利用規約">利用規約</span>
                        </a>
                    </li>
                    <li class="info-item col">
                        <a id="Footer_PrivacyPolicy" onclick="window.parent.API_ShowPartialHtml('', 'PrivacyPolicy', true, null)">
                            <span class="language_replace" langkey="隱私權政策">隱私權政策</span>
                        </a>
                    </li>
                </ul>
                <div class="payment-supplier">
                    <div class="logo">
                        <div class="row">
                            <!-- <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-iwallet.png" alt="">
                                    </div>
                                </div> -->
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-nissinpay.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-bank.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-paypal.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="partner">
                    <div class="logo">
                        <div class="row">
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-eWIN.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-microgaming.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-kgs.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-bbin.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-gmw.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-cq9.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-red-tiger.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-evo.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-bco.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-cg.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-playngo.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-pg.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-netent.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-kx.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-evops.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-bti.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-zeus.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-biggaming.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-play.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-h.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-va.png" alt="">
                                </div>
                            </div>

                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="/images/logo/footer/logo-XG.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="company-detail">
                    <div class="company-license">
                        <iframe src="https://licensing.gaming-curacao.com/validator/?lh=73f82515ca83aaf2883e78a6c118bea3&amp;template=tseal" width="150" height="50" style="border: none;"></iframe>
                    </div>
                    <div class="company-address">

                        <span class="language_replace" langkey="マハラジャは(Online Chip World Co. N.V) によって所有および運営されています。（登録住所：Zuikertuintjeweg Z/N (Zuikertuin Tower)Willemstad Curacao）キュラソー政府からライセンス 登録番号：#365 / JAZ の認可を受け規制に準拠しています。">マハラジャは(Online Chip World Co. N.V) によって所有および運営されています。（登録住所：Zuikertuintjeweg Z/N (Zuikertuin Tower)Willemstad Curacao）キュラソー政府からライセンス 登録番号：#365 / JAZ の認可を受け規制に準拠しています。</span>
                    </div>
                </div>
                <div class="footer-copyright">
                    <p class="language_replace" langkey="Copyright © 2022 マハラジャ. All Rights Reserved.">Copyright © 2022 マハラジャ. All Rights Reserved.</p>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>

