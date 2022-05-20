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
    <title>Maharaja2</title>
    <link href="css/basic.min.css" rel="stylesheet" />
    <link href="Scripts/vendor/swiper/css/swiper-bundle.min.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <link href="css/lobby.css" rel="stylesheet" />
    <!--===========JS========-->
    <script type="text/javascript" src="/Scripts/Common.js?<%:Version%>"></script>
    <%--<script type="text/javascript" src="/Scripts/UIControl.js"></script>--%>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
    <script src="Scripts/vendor/swiper/js/swiper-bundle.min.js"></script>
    <script src="Scripts/theme.js"></script>
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
    function loginRecover() {
        window.location.href = "LoginRecover.aspx";
    }

    function selGameCategory(categoryCode, doc) {
        $('#idGameItemTitle .tab-item').removeClass('active');
        $(doc).addClass('active');
        var idGameItemTitle = document.getElementById("idGameItemTitle");
        nowCateg = categoryCode;

        if (categoryCode != 'All') {
            LobbyGameList.CategoryList.find(x => x.Categ == nowCateg).SubCategList.forEach(sc => {
                if (sc != 'Other' && sc != 'others') {
                    //上方tab

                    var li = document.createElement("li");
                    var li_span = document.createElement("span");
                    li.classList.add("menu-item");
                    li_span.innerText = mlp.getLanguageKey(sc);
                    //上方tab
                    li.appendChild(li_span);

                    li.onclick = new Function("updateGameList('" + sc + "')");
                    //idGameItemSubTitle.appendChild(li);
                }
            });
        }

        updateGameList(categoryCode);
    }

    function selSubGameCategory(subCategoryCode) {
        var idGameItemSubTitle = document.getElementById("idGameItemSubTitle");

        if (subCategoryCode) {
            nowSubCateg = subCategoryCode;
        } else {
            nowSubCateg = "Hot";
        }


        //idGameItemSubTitle.querySelectorAll(".tab-item").forEach(GI => {
        //    GI.classList.remove("actived");

        //    if (GI.classList.contains("tab_" + nowSubCateg)) {
        //        GI.classList.add("actived");
        //        //history.replaceState(null, null, "?" + "Category=" + categoryCode);
        //        history.replaceState(null, null, "?" + "Category=" + nowCateg + "&" + "SubCategory=" + nowSubCateg);
        //    }
        //});

        showGame(nowCateg, nowSubCateg);
    }

    function changeGameBrand() {
        nowGameBrand = document.getElementById("idGameBrandSel").value;
        showGame(nowCateg, nowSubCateg);
    }

    function showGame(categoryCode, subCategoryCode) {
        //var idNoGameExist = document.getElementById("idNoGameExist");
        //idNoGameExist.classList.add("is-hide");

        document.querySelectorAll(".game-item").forEach(GI => {
            var orderVal = 3;

            if (subCategoryCode == 'Hot' || subCategoryCode == 'New') {
                GI.classList.remove("is-hide");

                if (categoryCode == "All") {

                } else {
                    if (!GI.classList.contains("gc_" + nowCateg)) {
                        GI.classList.add("is-hide");
                    }
                }

                if (GI.classList.contains("subGc_Hot") || GI.classList.contains("subGc_New")) {
                    if (GI.classList.contains("subGc_Hot") && GI.classList.contains("subGc_New")) {
                        orderVal = 0;
                    } else if (GI.classList.contains("subGc_" + subCategoryCode)) {
                        orderVal = 1;
                    } else {
                        orderVal = 2;
                    }
                }
            } else {
                GI.classList.add("is-hide");

                if (categoryCode == "All") {
                    if (GI.classList.contains("subGc_" + subCategoryCode)) {
                        GI.classList.remove("is-hide");
                    }
                } else {
                    if (GI.classList.contains("gc_" + nowCateg) && GI.classList.contains("subGc_" + subCategoryCode)) {
                        GI.classList.remove("is-hide");
                    }
                }
            }

            GI.style.order = orderVal;


            //補上遊戲廠牌篩選
            if (nowGameBrand == "All") {

            } else {
                if (!GI.classList.contains("brand_" + nowGameBrand)) {
                    GI.classList.add("is-hide");
                }
            }
        });

        //if (!document.querySelector(".game-item:not(.is-hide)")) {
        //    idNoGameExist.classList.remove("is-hide");
        //}
    }

    function updateGameList(categoryCode) {


        var idGameItemGroup = document.getElementById("idGameItemGroupContent");

        idGameItemGroup.innerHTML = "";
        // 尋找新增+
    
  
        var count = 0;
        if (LobbyGameList.GameList) {
            LobbyGameList.GameList.forEach(gameItem => {

                if (gameItem.Categ == categoryCode || categoryCode == "All") {
                    count++;
                    if (count > 30) {
                        return false;
                    }

                    var GI = c.getTemplate("temGameItem");
                    var GI_img = GI.querySelector(".gameimg");
                    var GI_gameitem = GI.querySelector(".game-item");
                    var GI_a = GI.querySelector(".btn-play");

                    if (GI_img != null) {
                        GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + WebInfo.Lang + "/" + gameItem.GameName + ".png";
                        //GI_img.onerror = new Function("setDefaultIcon('" + gameItem.GameBrand + "', '" + gameItem.GameName + "')");
                    }

                    c.setClassText(GI, "game-item-name", null, window.parent.API_GetGameLang(1, gameItem.GameBrand, gameItem.GameName));
                    //c.setClassText(GI, "GameID", null, c.padLeft(gameItem.GameID.toString(), 5));
                    GI_a.onclick = new Function("window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "' , '" + gameItem.Categ + "')");

                    //GI.classList.add("is-hide");
                    GI_gameitem.classList.add("gc_" + gameItem.Categ);
                    GI_gameitem.classList.add("subGc_" + gameItem.SubCateg);
                    GI_gameitem.classList.add("brand_" + gameItem.GameBrand);

                    if (gameItem.IsHot == 1) {
                        GI.classList.add("subGc_Hot");
                        GI.classList.add("label-hot");
                    }

                    if (gameItem.IsNew == 1) {
                        GI.classList.add("subGc_New");
                        GI.classList.add("label-new");
                    }

                    idGameItemGroup.appendChild(GI);
                    console.log(gameItem.GameBrand);
                }


            });
        }

        new Swiper("#idGameItemGroup", {
            loop: true,
            slidesPerView: 2,
            freeMode: true,
            navigation: {
                nextEl: "#idGameItemGroup .swiper-button-next",
                prevEl: "#idGameItemGroup .swiper-button-prev",
            }
        });


        //new Swiper("#idGameItemGroup", {
        //    loop: true,
        //    slidesPerView: 2,
        //    freeMode: true,
        //    navigation: {
        //        nextEl: "#lobbyGame-1 .swiper-button-next",
        //        prevEl: "#lobbyGame-1 .swiper-button-prev",
        //    }
        //    ,
        //    breakpoints: {
        //        540: {
        //            slidesPerView: 3,

        //        },
        //        768: {
        //            slidesPerView: 5,

        //        },
        //        1200: {
        //            slidesPerView: 7,
        //        },
        //        1920: {
        //            slidesPerView: 10,
        //        },
        //    }
        //});
    }

    function updateGameCode() {
        var idGameItemTitle = document.getElementById("idGameItemTitle");
        //var idSecContent = document.getElementById("idSecContent");

        var idGameItemGroup = document.getElementById("idGameItemGroupContent");

        idGameItemTitle.innerHTML = "";
        idGameItemGroup.innerHTML = "";
        // 尋找新增+
        var RecordDom;
        var record;

        if (LobbyGameList) {
            if (LobbyGameList.CategoryList) {
                for (var i = 0; i < LobbyGameList.CategoryList.length; i++) {
                    //="API_LoadPage('Casino', 'Casino.aspx', true)"

                    RecordDom = c.getTemplate("temCategItem");
                    c.setClassText(RecordDom, "CategName", null, mlp.getLanguageKey(LobbyGameList.CategoryList[i].Categ));
                    switch (LobbyGameList.CategoryList[i].Categ) {
                        case 'All':
                            $(RecordDom).find('.CategIcon').addClass('icon-all');
                            break;
                        case 'Live':
                            $(RecordDom).find('.CategIcon').addClass('icon-real');
                            break;
                        case 'Electron':
                            $(RecordDom).find('.CategIcon').addClass('icon-ect');
                            break;
                        case 'Fish':
                            $(RecordDom).find('.CategIcon').addClass('icon-ect');
                            break;
                        case 'Slot':
                            $(RecordDom).find('.CategIcon').addClass('icon-slot');
                            break;
                        default:
                    }
                    RecordDom.onclick = new Function("selGameCategory('" + LobbyGameList.CategoryList[i].Categ + "',this)");
                    idGameItemTitle.appendChild(RecordDom);
                }

                $('#idGameItemTitle').append('<div class="tab-slide"></div>');
            }
            var count = 0;
            if (LobbyGameList.GameList) {
                LobbyGameList.GameList.forEach(gameItem => {
                    count++;
                    if (count > 30) {
                        return false;
                    }
                    /* 
                      <div id="idTemGameItem" class="is-hide">
                           <div class="game-item">
                               <a class="game-item-link" href="#"></a>
                               <div class="img-wrap">
                                   <img src="../src/img/games/icon/icon-01.jpg">
                               </div>
                           </div>
                       </div>
                    */
                    //if (gameBrandList.findIndex(x => x == gameItem.GameBrand) == -1) {
                    //    gameBrandList.push(gameItem.GameBrand);
                    //    var opt = document.createElement("option");
                    //    opt.value = gameItem.GameBrand;
                    //    opt.innerText = mlp.getLanguageKey(gameItem.GameBrand);
                    //    idGameBrandSel.appendChild(opt);
                    //}

                    var GI = c.getTemplate("temGameItem");
                    var GI_img = GI.querySelector(".gameimg");
                    var GI_gameitem = GI.querySelector(".game-item");
                    var GI_a = GI.querySelector(".btn-play");

                    if (GI_img != null) {
                        GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + WebInfo.Lang + "/" + gameItem.GameName + ".png";
                        //GI_img.onerror = new Function("setDefaultIcon('" + gameItem.GameBrand + "', '" + gameItem.GameName + "')");
                    }

                    c.setClassText(GI, "game-item-name", null, window.parent.API_GetGameLang(1, gameItem.GameBrand, gameItem.GameName));
                    //c.setClassText(GI, "GameID", null, c.padLeft(gameItem.GameID.toString(), 5));
                    GI_a.onclick = new Function("window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "' , '" + gameItem.Categ + "')");

                    //GI.classList.add("is-hide");
                    GI_gameitem.classList.add("gc_" + gameItem.Categ);
                    GI_gameitem.classList.add("subGc_" + gameItem.SubCateg);
                    GI_gameitem.classList.add("brand_" + gameItem.GameBrand);

                    if (gameItem.IsHot == 1) {
                        GI.classList.add("subGc_Hot");
                        GI.classList.add("label-hot");
                    }

                    if (gameItem.IsNew == 1) {
                        GI.classList.add("subGc_New");
                        GI.classList.add("label-new");
                    }

                    idGameItemGroup.appendChild(GI);
                 
                    console.log(gameItem.GameBrand);

                });
                new Swiper("#idGameItemGroup", {
                    slidesPerView: "auto",
                    freeMode: true,
                    navigation: {
                        nextEl: "#idGameItemGroup .swiper-button-next",
                        prevEl: "#idGameItemGroup .swiper-button-prev",
                    }
                });
            }
        }
    }

    function updateBaseInfo() {
        //LobbyGameList = window.parent.API_GetGameList();
        //updateGameCode();
        //selGameCategory(nowCateg);
    }

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }

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

        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();
            if ((WebInfo.SID != null)) {
                //updateBaseInfo()
                LobbyGameList = window.parent.API_GetGameList();
                updateGameCode();
                //selGameCategory(nowCateg, nowSubCateg);
            } else {
                loginRecover();
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
            case "SetLanguage":
                lang = param;

                mlp.loadLanguage(lang, function () {
                    updateGameCode();
                    //selGameCategory(nowCateg);
                });
                break;
        }
    }

    function createITag(Category) {
        var iTag = document.createElement("i");
        var iTagCls = "";
        switch (Category) {
            case "All":
                iTagCls = "icon-casinoworld-menu";
                break;
            case "Baccarat":
                iTagCls = "icon-casino";
                break;
            case "Live":
                iTagCls = "icon-casino";
                break;
            case "Sports":
                iTagCls = "icon-casinoworld-football";
                break;
            case "Classic":
                iTagCls = "icon-poker";
                break;
            case "Electron":
                iTagCls = "icon-casinoworld-poker";
                break;
            case "Slot":
                iTagCls = "icon-slot";
                break;
            case "Fish":
                iTagCls = "icon-casinoworld-fish-1";
                break;
            case "Finance":
                iTagCls = "icon-casinoworld-linear-chart-2";
                break;
            default:
                iTagCls = "icon-casinoworld-game-default";
                break;
        }

        iTag.classList.add(iTagCls);

        return iTag;
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
                  <a class="hero-item-link" href="#"></a>
                  <div class="img-wrap">
                    <img src="http://onlinecasinoworld-jp.dev.mts.idv.tw/images/games/hero/hero-10.jpg?20211004" class="bg">                    
                  </div>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="hero-item">
                  <a class="hero-item-link" href="#"></a>
                  <div class="img-wrap">   
                    <img src="http://onlinecasinoworld-jp.dev.mts.idv.tw/images/games/hero/hero-11.jpg" class="bg">             
                  </div>                  
              </div>
            </div>
            <div class="swiper-slide">
              <div class="hero-item">
                  <a class="hero-item-link" href="#"></a>
                  <div class="img-wrap">   
                    <img src="http://onlinecasinoworld-jp.dev.mts.idv.tw/images/games/hero/OpenIntroBonus-11.jpg" class="bg">             
                  </div>                  
              </div>
            </div>
            
          </div> 
          <div class="swiper-pagination"></div>                
        </div>
    </section>
        <div class="menu-game tab-scroller">
            <div class="tab-scroller__area">
                <ul class="tab-scroller__content" id="idGameItemTitle">

                    <div class="tab-slide"></div>
                </ul>
            </div>
        </div>
       
        <section class="game-area overflow-hidden">
            <!-- Lobby-1 遊戲 -->
            <!-- <section class="section-wrap section-levelUp" style="position: relative; z-index: 99;"> -->
            <section class="section-wrap section-levelUp" style="z-index: 99;">
                <div class="container-fluid">
                    <div class="game_wrapper">
                        <div class="sec_title_container">
                            <div class="sec_titl_wrapper">
                                <h3 class="sec-title"><i class="icon icon-mask icon-poker"></i><span class="">新品上市</span></h3>>
                            </div>
                        </div>
                        <div class="game_slider swiper_container gameinfo-hover round-arrow" id="idGameItemGroup">
                            <div class="swiper-wrapper" id="idGameItemGroupContent">
                            </div>
                             <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                    </div>
                </div>
            </section>

                  <!-- Lobby-2 遊戲 -->
        <section class="section-wrap section-levelUp">
            <div class="container-fluid">
                <div class="game_wrapper">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <h3 class="sec-title"><i class="icon icon-mask icon-poker"></i><span class="">熱門遊戲</span></h3>
                        </div>
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover round-arrow" id="lobbyGame-2">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <div class="game-item">
                                    <div class="game-item-inner">
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
                                                        <div class="game-item-info-detail-inner">
                                                            <div class="info">
                                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                                            </div>
                                                            <div class="action">
                                                                <div class="btn-s-wrapper">
                                                                    <button type="button" class="btn-thumbUp btn btn-round">
                                                                        <i class="icon icon-thumup"></i>
                                                                    </button>
                                                                    <button type="button" class="btn-like btn btn-round">
                                                                        <i class="icon icon-heart-o"></i>
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
                                        <div class="game-item-info">
                                            <div class="game-item-info-inner">
                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="game-item">
                                    <div class="game-item-inner">
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
                                                        <div class="game-item-info-detail-inner">
                                                            <div class="info">
                                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                                            </div>
                                                            <div class="action">
                                                                <div class="btn-s-wrapper">
                                                                    <button type="button" class="btn-thumbUp btn btn-round">
                                                                        <i class="icon icon-thumup"></i>
                                                                    </button>
                                                                    <button type="button" class="btn-like btn btn-round">
                                                                        <i class="icon icon-heart-o"></i>
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
                                        <div class="game-item-info">
                                            <div class="game-item-info-inner">
                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="game-item">
                                    <div class="game-item-inner">
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
                                                        <div class="game-item-info-detail-inner">
                                                            <div class="info">
                                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                                            </div>
                                                            <div class="action">
                                                                <div class="btn-s-wrapper">
                                                                    <button type="button" class="btn-thumbUp btn btn-round">
                                                                        <i class="icon icon-thumup"></i>
                                                                    </button>
                                                                    <button type="button" class="btn-like btn btn-round">
                                                                        <i class="icon icon-heart-o"></i>
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
                                        <div class="game-item-info">
                                            <div class="game-item-info-inner">
                                                <h3 class="game-item-name">バタフライブロッサム</h3>
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
            </div>
        </section>
        
            <!-- 隨機推薦遊戲 -->   
        <section class="section-wrap section_randomRem">
            <div class="container-fluid">
            <div class="game_wrapper">
                <div class="sec-title-container">
                <div class="sec-title-wrapper">
                    <!-- <h3 class="title">隨機推薦遊戲</h3> -->
                </div>
                </div>
                <div class="game_slider swiper-container round-arrow swiper-cover" id="lobbyGame-randomRem">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <div class="game-item">
                                <div class="game-item-inner">
                                    <span class="game-item-link"></span>
                                    <div class="img-wrap">
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info">
                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="game-item">
                                <div class="game-item-inner">
                                    <span class="game-item-link"></span>
                                    <div class="img-wrap">
                                        <img
                                            src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PNG/PC/JPN/moonprincess.png">
                                    </div>                     
                                </div>
                                <div class="game-item-info">
                                    <h3 class="game-item-name">Game Name</h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="game-item">
                                <div class="game-item-inner">
                                    <span class="game-item-link"></span>
                                    <div class="img-wrap">
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/89.png">
                                    </div>                     
                                </div>
                                <div class="game-item-info">
                                    <h3 class="game-item-name">Game Name</h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="game-item">
                                <div class="game-item-inner">
                                    <span class="game-item-link"></span>
                                    <div class="img-wrap">
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info">
                                    <h3 class="game-item-name">バタフライブロッサム</h3>
                                </div>
                            </div>
                        </div>
                        <div class="swiper-slide">
                            <div class="game-item">
                                <div class="game-item-inner">
                                    <span class="game-item-link"></span>
                                    <div class="img-wrap">
                                        <img
                                            src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PNG/PC/JPN/moonprincess.png">
                                    </div>                     
                                </div>
                                <div class="game-item-info">
                                    <h3 class="game-item-name">Game Name</h3>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            </div>
        </section>
    </section>
  </main>
    <div id="temGameItem" class="is-hide">
         <div class="swiper-slide">
            <div class="game-item">
                <div class="game-item-inner">
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
                                    <div class="game-item-info-detail-inner">
                                        <div class="info">
                                            <h3 class="game-item-name"></h3>
                                        </div>
                                        <div class="action">
                                            <div class="btn-s-wrapper">
                                                <button type="button" class="btn-thumbUp btn btn-round">
                                                    <i class="icon icon-thumup"></i>
                                                </button>
                                                <button type="button" class="btn-like btn btn-round">
                                                    <i class="icon icon-heart-o"></i>
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
                    <div class="game-item-info">
                        <div class="game-item-info-inner">
                            <h3 class="game-item-name"></h3>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div id="temCategArea" class="is-hide">


    </div>
     <div id="temCategItem" class="is-hide">
        <li class="tab-item">
                    <span class="tab-item-link"> <i class="icon icon-mask CategIcon"></i>
                        <span class="title language_replace CategName"></span></span>
        </li>
    </div>
</body>
</html>
