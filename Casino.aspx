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
    var nowCateg = "All";
    var nowSubCateg = "Hot";
    var LobbyGameList;
    var lang;
    var nowGameBrand = "All";
    var gameBrandList = [];
    var v = "<%:Version%>";
    var GCB;
    var iframeWidth;
    var selectedCategoryCode;

    function showSearchGameModel() {
        window.parent.API_ShowSearchGameModel();
    }
 
    function loginRecover() {
        window.location.href = "LoginRecover.aspx";
    }

    function selGameCategory(categoryCode, doc) {
        $('#idGameItemTitle .tab-item').removeClass('active');
        $(doc).addClass('active');

        updateGameList(categoryCode);
    }

    function updateGameList(categoryCode) {
    
        selectedCategoryCode = categoryCode;
        iframeWidth = $(window.parent.document).find('#IFramePage').width();
        var FavoGames = window.parent.API_GetFavoGames();
        var idGameItemGroup = document.getElementById("gameAreas");
        idGameItemGroup.innerHTML = "";

        if (LobbyGameList) {
           
            var companyCategoryDatasCount = 0;
            var categName;

            var categorys = LobbyGameList.find(e => e.Location == categoryCode);

            if (categorys) {
              
                categorys.Categories.forEach(category => {
                    var count = 0;
                    var categArea;
                    companyCategoryDatasCount++;

                    if (category.Datas.length > 0) {

                        if (category.ShowType == 0) {
                            categArea = c.getTemplate("temCategArea");
                            categName = category.CategoryName.replace('@', '').replace('#', '');
                            $(categArea).find('.CategName').text(mlp.getLanguageKey(categName));
                            $(categArea).find('.CategName').attr('langkey', categName);

                            if (category.SortIndex>=90) {
                                $(categArea).find('.text-link').css('display', 'block');
                                $(categArea).find('.title-showAll').text(mlp.getLanguageKey('全部顯示'));
                               
                            }
                        } else {
                            categArea = c.getTemplate("temCategArea2");
                        }

                        $(categArea).find('.GameItemGroup').attr('id', 'GameItemGroup_' + companyCategoryDatasCount);
                        $(categArea).find('.GameItemGroupContent').attr('id', 'GameItemGroupContent_' + companyCategoryDatasCount);
                        category.Datas.sort(function (a, b) {
                            return b.SortIndex - a.SortIndex;
                        });
                        category.Datas.forEach(gameItem => {
                            var GI;
                            var showAllbtn = categArea.querySelector('.title-showAll');
                            showAllbtn.onclick = new Function("window.parent.API_SearchGameByBrand('" + gameItem.GameBrand + "')");

                            if (category.SortIndex >= 90) {
                                var categNamebtn = categArea.querySelector('.CategName');
                                categNamebtn.onclick = new Function("window.parent.API_SearchGameByBrand('" + gameItem.GameBrand + "')");
                            }

                            if (category.ShowType == 0) {
                                GI = c.getTemplate("temGameItem");
                                $(GI).addClass('gameid_' + gameItem.GameID);
                                var GI_a = GI.querySelector(".btn-play");
                                var GI_Favor = GI.querySelector(".btn-like");

                                if (FavoGames.filter(e => e.GameID === gameItem.GameID).length > 0) {
                                    $(GI_Favor).addClass("added");
                                }

                                GI_Favor.onclick = new Function("window.parent.favBtnEvent(" + gameItem.GameID + ",this)");

                                if (iframeWidth<936) {
                                   $(categArea).find('.text-link').css('display', 'none');

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

                                    GI.onclick = new Function("window.parent.API_MobileDeviceGameInfo('" + gameItem.GameBrand + "','" + RTP + "','" + gameItem.GameName + "'," + gameItem.GameID + ")");
                                } else {
                                    var GI_gameitemlink = GI.querySelector(".game-item-link");
                                    GI_gameitemlink.onclick = new Function("window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameItem.GameText[lang] + "')");
                                    GI_a.onclick = new Function("window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameItem.GameText[lang] + "')");
                                }

                                $(GI).find('.btn-more').click(function () {
                                    // $(this).toggleClass('show');
                                    $(this).closest('.game-item-info-detail').toggleClass('open');
                                });

                                $(GI).find('.btn-more').closest('.game-item-info-detail').toggleClass('open');
                            } else {
                                GI = c.getTemplate("temGameItem2");
                            }

                            var GI_img = GI.querySelector(".gameimg");

                            if (GI_img != null) {
                                GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + WebInfo.Lang + "/" + gameItem.GameName + ".png";
                                var el = GI_img;
                                var observer = lozad(el); // passing a `NodeList` (e.g. `document.querySelectorAll()`) is also valid
                                observer.observe();
                            }

                            $(GI).find(".GameBrand").text(gameItem.GameBrand);
                            if (gameItem.RTPInfo) {
                                var RtpInfoObj = JSON.parse(gameItem.RTPInfo);

                                if (RtpInfoObj.RTP && RtpInfoObj.RTP != 0) {
                                    $(GI).find(".valueRTP").text(RtpInfoObj.RTP);
                                } else {
                                    $(GI).find(".valueRTP").text('--');
                                }
                            } else {
                                $(GI).find(".valueRTP").text('--');
                            }

                            $(GI).find(".GameID").text(gameItem.GameID);
                            $(GI).find(".game-item-name").text(gameItem.GameText[WebInfo.Lang]);

                            $(categArea).find('.GameItemGroupContent').append(GI);

                        });

                        gameAreas.append(categArea);

                        if (category.ShowType == 0) {
                            new Swiper("#" + 'GameItemGroup_' + companyCategoryDatasCount, {
                                slidesPerView: "auto",
                                // loop:true,
                                // slidesPerGroup: 2,
                                // loopedSlides: 8,
                                lazy: true,
                                freeMode: true,
                                navigation: {
                                    nextEl: "#" + 'GameItemGroup_' + companyCategoryDatasCount + " .swiper-button-next",
                                    prevEl: "#" + 'GameItemGroup_' + companyCategoryDatasCount + " .swiper-button-prev",
                                },
                                //滿版時的斷點 slidesPerGroup
                                // breakpoints: {
                                //     // 576: {
                                //     //  slidesPerGroup: 3,
                                //     // },
                                //     // 640: {
                                //     //     slidesPerGroup: 4,
                                //     // },
                                //     936: {
                                //         slidesPerGroup: 6, //index:992px
                                //     },
                                //     1144: {
                                //         slidesPerGroup: 7, //index:1200px
                                //     },
                                //     1384: {
                                //         slidesPerGroup: 8, //index:1440px
                                //     },
                                //     1544: {
                                //         slidesPerGroup: 9, //index:1600px
                                //     },
                                //     1864: {
                                //         slidesPerGroup: 10, //index:1920px
                                //     },
                                //     1920: {
                                //         slidesPerGroup: 10, //index:1920px up
                                //     },
                                // },

                                //非滿版時的斷點 slidesPerGroup
                                breakpoints: {
                                
                                    936: {
                                        freeMode: false,
                                        slidesPerGroup: 6, //index:992px
                                    },
                                    1144: {
                                        slidesPerGroup: 7, //index:1200px
                                    },
                                    1384: {
                                        slidesPerGroup: 7, //index:1440px
                                    },
                                    1544: {
                                        slidesPerGroup: 7, //index:1600px
                                    },
                                    1864: {
                                        slidesPerGroup: 8, //index:1920px
                                    },
                                    1920: {
                                        slidesPerGroup: 8, //index:1920px up
                                    },
                              }


                            });
                        }
                        else {
                            new Swiper("#" + 'GameItemGroup_' + companyCategoryDatasCount, {
                                effect: "coverflow",
                                grabCursor: true,
                                centeredSlides: true,
                                slidesPerView: "auto",
                                // slidesPerView: 5,
                                coverflowEffect: {
                                    rotate: 20,
                                    stretch: 0,
                                    depth: 200,
                                    modifier: 1,
                                    slideShadows: true,
                                },
                                // pagination: {
                                //     el: ".swiper-pagination",
                                // },
                                loop: true,
                                autuplay: {
                                    delay: 100,
                                    disableOnInteraction: false,
                                }
                            });
                        }
                    }
                });
            }
        }
    }

    function updateGameCode() {
        iframeWidth = $(window.parent.document).find('#IFramePage').width();
        LobbyGameList = GCB.GetCategories("GameList");
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

            if (!LobbyGameList.find(function (d) { return d.Location == 'GameList_All' }).Categories.find(function (e) { return e.CategoryName == "EWin" })) {
         
                var EwinGame = {
                    CategoryID: 0,
                    CategoryName: "EWin",
                    Datas: [{
                        AllowDemoPlay: 1,
                        BrandText: {
                            CHT: "真人百家樂(eWIN)",
                            JPN: "EWinゲーミング"
                        },
                        CategoryID: 0,
                        GameBrand: "EWin",
                        GameCategoryCode: "Live",
                        GameCategorySubCode: "Baccarat",
                        GameCode: null,
                        GameID: 0,
                        GameName: "EWinGaming",
                        GameText: {
                            CHT: "真人百家樂(eWIN)",
                            JPN: "EWinゲーミング"
                        },
                        Info: "",
                        IsHot: 0,
                        IsNew: 0,
                        RTPInfo: "",
                        SortIndex: 99,
                        Tag: null
                    }],
                    Location: "GameList_All",
                    ShowType: 0,
                    SortIndex: 99,
                    State: 0
                }

                var BGindex= LobbyGameList.find(function (d) { return d.Location == 'GameList_All' }).Categories.findIndex(function (e) { return e.CategoryName == "BTI" });
                if (BGindex != -1) {
                    LobbyGameList.find(function (d) { return d.Location == 'GameList_All' }).Categories.splice(BGindex, 0, EwinGame);
                } else {
                    LobbyGameList.find(function (d) { return d.Location == 'GameList_All' }).Categories.unshift(EwinGame);
                }
            }
      
            for (var i = 0; i < LobbyGameList.length; i++) {
                //="API_LoadPage('Casino', 'Casino.aspx', true)"

                RecordDom = c.getTemplate("temCategItem");
                c.setClassText(RecordDom, "CategName", null, mlp.getLanguageKey(LobbyGameList[i].Location));
                $(RecordDom).find('.CategName').attr('langkey', LobbyGameList[i].Location);
                switch (LobbyGameList[i].Location) {
                    case 'GameList_All':
                        $(RecordDom).find('.CategIcon').addClass('icon-hot-tt');
                        break;
                    case 'GameList_Live':
                        $(RecordDom).find('.CategIcon').addClass('icon-live-tt');
                        break;
                    case 'GameList_Electron':
                        $(RecordDom).find('.CategIcon').addClass('icon-elec-tt');
                        break;
                    case 'GameList_Other':
                        $(RecordDom).find('.CategIcon').addClass('icon-etc-tt');
                        break;
                    case 'GameList_Slot':
                        $(RecordDom).find('.CategIcon').addClass('icon-slot-tt');
                        break;
                    default:
                }
                RecordDom.onclick = new Function("selGameCategory('" + LobbyGameList[i].Location + "',this)");
                idGameItemTitle.appendChild(RecordDom);
            }

            $('#idGameItemTitle').append('<div class="tab-slide"></div>');
        }
        updateGameList("GameList_All");

    }

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        GCB = window.parent.API_GetGCB();
        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        nowCateg = c.getParameter("Category");
        nowSubCateg = c.getParameter("SubCategory");
        lang = window.parent.API_GetLang();

        if (nowCateg == undefined || nowCateg == "") {
            nowCateg = "All";
        }

        if (nowSubCateg == undefined || nowSubCateg == "") {
            nowSubCateg = "Hot";
        }


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
                if (GCB.FirstLoaded) {
                    updateGameCode();
                    window.parent.API_LoadingEnd();
                }
            } else {
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
                    updateGameList(selectedCategoryCode);
                }

                break;
            case "SetLanguage":
                lang = param;

                mlp.loadLanguage(lang, function () {
                    window.parent.API_LoadingEnd(1);
                    updateGameCode();
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
                    <div class="swiper-slide">
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
                    </div>
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
                <div class="tab-search" onclick="showSearchGameModel()"><img src="images/icon/ico-search-dog.svg" alt=""><span class="title language_replace">找遊戲</span></div>            
                <div class="tab-scroller tab-5">
                    <div class="tab-scroller__area">
                        <ul class="tab-scroller__content" id="idGameItemTitle">
                            <div class="tab-slide"></div>
                        </ul>
                    </div>
                </div>
            </div>           
        </div>
        <section class="game-area overflow-hidden">
            <div class="container" id="gameAreas">
            </div>
        </section>
    </main>
    <div id="temCategArea" class="is-hide">
        <section class="section-wrap section-levelUp">
            <%--<div class="container">--%>
            <div class="game_wrapper">
                <div class="sec-title-container">
                    <div class="sec-title-wrapper">
                        <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="language_replace title CategName"></span></h3>
                    </div>
                     <a class="text-link" style="display:none;">
                       <span class="title-showAll"></span><i class="icon arrow arrow-right"></i>             
                     </a>
                </div>
                <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup">
                    <div class="swiper-wrapper GameItemGroupContent">
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
            </div>
            <%--</div>--%>
        </section>
    </div>
    <!-- 若是 JS套入 class "game-item-focus"=>  請套入 default/sideLeft/sideRight 三個class -->

    <div id="temGameItem" class="is-hide">
        <div class="swiper-slide">
            <!-- 設定 遊戲 NEW/HOT Label ： class=> "label-new"/"label-hot" -->
            <div class="game-item">
                <div class="game-item-inner">
                    <span class="game-item-mobile-popup" data-toggle="modal"></span>
                    <div class="game-item-focus">
                        <div class="game-item-img">
                            <span class="game-item-link"></span>
                            <div class="img-wrap">
                                <img class="gameimg" src="">
                            </div>
                        </div>
                        <div class="game-item-info-detail">
                            <div class="game-item-info-detail-wrapper">
                                <div class="game-item-info-detail-moreInfo">
                                    <ul class="moreInfo-item-wrapper">
                                        <li class="moreInfo-item brand">
                                            <span class="title language_replace">品牌</span>
                                            <span class="value GameBrand"></span>
                                        </li>
                                        <li class="moreInfo-item RTP">
                                            <span class="title">RTP</span>
                                            <span class="value number valueRTP"></span>
                                        </li>
                                        <li class="moreInfo-item gamecode">
                                            <span class="title">NO.</span>
                                            <span class="value number GameID"></span>
                                        </li>
                                    </ul>
                                </div>
                                <div class="game-item-info-detail-indicator">
                                    <div class="game-item-info-detail-indicator-inner">
                                        <div class="info">
                                            <h3 class="game-item-name"></h3>
                                        </div>
                                        <div class="action">
                                            <div class="btn-s-wrapper">
                                                <!-- 遊戲 NEW/HOT Label -->
                                                <%--<span class="label-push-status"></span>--%>
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
                                                <span class="language_replace">遊玩</span><i class="triangle"></i></button>
                                        </div>
                                    </div>
                                </div>
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
    </div>
    <%--推薦遊戲--%>
    <div id="temCategArea2" class="is-hide">
        <section class="section-wrap section_randomRem">
            <div class="container-fluid">
                <div class="game_wrapper">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <!-- <h3 class="title">隨機推薦遊戲</h3> -->
                        </div>
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup">
                        <div class="swiper-wrapper GameItemGroupContent">
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

    <div id="temCategItem" class="is-hide">
        <li class="tab-item">
            <span class="tab-item-link"><i class="icon icon-mask CategIcon"></i>
                <span class="title language_replace CategName"></span></span>
        </li>
    </div>

    <!-- Modal - Game Info for Mobile Device-->

</body>
</html>
