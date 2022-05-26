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
    <script src="Scripts/lozad.min.js"></script>
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
            LobbyGameList.CategoryList.forEach(sc => {
               

                    var li = document.createElement("li");
                    var li_span = document.createElement("span");
                    li.classList.add("menu-item");
                    li_span.innerText = mlp.getLanguageKey(sc);
                    //上方tab
                    li.appendChild(li_span);

                    li.onclick = new Function("updateGameList('" + sc + "')");
                    //idGameItemSubTitle.appendChild(li);
     
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

        var idGameItemGroup = document.getElementById("gameAreas");
        idGameItemGroup.innerHTML = "";

        if (LobbyGameList && LobbyGameList.CompanyCategoryDatas) {

            var companyCategoryDatasCount = 0;
            var categName;
            LobbyGameList.CompanyCategoryDatas.forEach(category => {
                var count = 0;
                var categArea;
                companyCategoryDatasCount++;

                if (category.Location == categoryCode) {
              
                    if (category.ShowType==0) {
                        categArea = c.getTemplate("temCategArea");
                        categName = category.CategoryName.replace('@', '').replace('#', '');
                        $(categArea).find('.CategName').text(categName);
                    } else {
                        categArea = c.getTemplate("temCategArea2");
                    }

                    $(categArea).find('.GameItemGroup').attr('id', 'GameItemGroup_' + companyCategoryDatasCount);
                    $(categArea).find('.GameItemGroupContent').attr('id', 'GameItemGroupContent_' + companyCategoryDatasCount);

                    category.Datas.forEach(gameItem => {
                        var GI;
                        count++;
                        if (count > 30) {
                            return false;
                        }

                        if (category.ShowType == 0) {
                            GI = c.getTemplate("temGameItem");
                            var GI_a = GI.querySelector(".btn-play");
                            if (WebInfo.DeviceType == 1) {

                                var RTP = "";
                                if (gameItem.RTPInfo) {
                                    RTP = JSON.parse(gameItem.RTPInfo).RTP;
                                }

                                GI.onclick = new Function("window.parent.API_MobileDeviceGameInfo('" + gameItem.GameBrand + "','" + RTP + "','" + gameItem.GameName + "'," + gameItem.GameID + ")");
                            } else {
                                GI_a.onclick = new Function("window.parent.openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "')");
                            }

                            $(GI).find('.btn-more').click(function () {
                                // $(this).toggleClass('show');
                                $(this).closest('.game-item-info-detail').toggleClass('open');
                            });

                        } else {
                            GI = c.getTemplate("temGameItem2");
                        }




                        var GI_img = GI.querySelector(".gameimg");
                        var GI_gameitem = GI.querySelector(".game-item");


                        if (GI_img != null) {
                            GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + WebInfo.Lang + "/" + gameItem.GameName + ".png";
                            var el = GI_img;
                            var observer = lozad(el); // passing a `NodeList` (e.g. `document.querySelectorAll()`) is also valid
                            observer.observe();
                        }

                        $(GI).find(".BrandName").text(gameItem.GameBrand);
                        if (gameItem.RTPInfo) {
                            $(GI).find(".valueRTP").text(JSON.parse(gameItem.RTPInfo).RTP);
                        }

                        $(GI).find(".GameID").text(gameItem.GameID);
                        $(GI).find(".game-item-name").text(window.parent.API_GetGameLang(1, gameItem.GameBrand, gameItem.GameName));

                        $(categArea).find('.GameItemGroupContent').append(GI);

                    });

                    gameAreas.append(categArea);

                    if (category.ShowType == 0) {
                        new Swiper("#" + 'GameItemGroup_' + companyCategoryDatasCount, {
                            slidesPerView: "auto",
                            slidesPerGroup: 8,
                            loopedSlides: 8,
                            freeMode: true,
                            navigation: {
                                nextEl: "#" + 'GameItemGroup_' + companyCategoryDatasCount + " .swiper-button-next",
                                prevEl: "#" + 'GameItemGroup_' + companyCategoryDatasCount + " .swiper-button-prev",
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

    function updateGameCode() {
        var idGameItemTitle = document.getElementById("idGameItemTitle");
 
        idGameItemTitle.innerHTML = "";
        // 尋找新增+
        var RecordDom;
        var record;

        if (LobbyGameList) {
            if (LobbyGameList.CategoryList) {
                for (var i = 0; i < LobbyGameList.CategoryList.length; i++) {
                    //="API_LoadPage('Casino', 'Casino.aspx', true)"

                    RecordDom = c.getTemplate("temCategItem");
                    c.setClassText(RecordDom, "CategName", null, mlp.getLanguageKey(LobbyGameList.CategoryList[i]));
                    switch (LobbyGameList.CategoryList[i]) {
                        case 'GameList_All':
                            $(RecordDom).find('.CategIcon').addClass('icon-all');
                            break;
                        case 'GameList_Live':
                            $(RecordDom).find('.CategIcon').addClass('icon-real');
                            break;
                        case 'GameList_Electron':
                            $(RecordDom).find('.CategIcon').addClass('icon-ect');
                            break;
                        case 'GameList_Other':
                            $(RecordDom).find('.CategIcon').addClass('icon-ect');
                            break;
                        case 'GameList_Solt':
                            $(RecordDom).find('.CategIcon').addClass('icon-slot');
                            break;
                        default:
                    }
                    RecordDom.onclick = new Function("selGameCategory('" + LobbyGameList.CategoryList[i] + "',this)");
                    idGameItemTitle.appendChild(RecordDom);
                }

                $('#idGameItemTitle').append('<div class="tab-slide"></div>');
            }
            updateGameList("GameList_All");
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
                LobbyGameList = window.parent.API_GetGameList2();
                updateGameCode();
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
        <div class="tab-game tab-scroller tab-5">
            <div class="tab-scroller__area">
                <ul class="tab-scroller__content" id="idGameItemTitle">
                    <div class="tab-slide"></div>
                </ul>
            </div>
        </div>
       
        <section class="game-area overflow-hidden" id="gameAreas">
         
    </section>
  </main>
    <div id="temCategArea" class="is-hide">
           <section class="section-wrap section-levelUp">
                <div class="container-fluid">
                    <div class="game_wrapper">
                         <div class="sec-title-container">
                            <div class="sec-title-wrapper">
                                <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="title CategName"></span></h3>
                            </div>
                        </div>
                        <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow GameItemGroup">
                            <div class="swiper-wrapper GameItemGroupContent">
                            </div>
                             <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                    </div>
                </div>
            </section>

    </div>

    <div id="temGameItem" class="is-hide">
         <div class="swiper-slide">
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
                                            <span class="title">メーカー</span>
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
                    <span class="tab-item-link"> <i class="icon icon-mask CategIcon"></i>
                        <span class="title language_replace CategName"></span></span>
        </li>
    </div>

    <!-- Modal - Game Info for Mobile Device-->

</body>
</html>
