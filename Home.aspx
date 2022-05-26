<%@ Page Language="C#" %>

<%
    //int RValue;
    //string Token;
    string MarqueeText = "";
    string Version = EWinWeb.Version;
    //Random R = new Random();

    //EWin.Lobby.APIResult Result;
    //EWin.Lobby.LobbyAPI LobbyAPI = new EWin.Lobby.LobbyAPI();

    //RValue = R.Next(100000, 9999999);
    //Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());
    //Result = LobbyAPI.GetCompanyMarqueeText(Token, Guid.NewGuid().ToString());
    //if (Result.Result == EWin.Lobby.enumResult.OK)
    //{
    //    MarqueeText = Result.Message;
    //}
%>

<!doctype html>
<html lang="zh-Hant-TW" class="innerHtml">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Maharaja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/basic.min.css" rel="stylesheet" />
    <link href="Scripts/vendor/swiper/css/swiper-bundle.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/main.css?a=1">
    <link rel="stylesheet" href="css/index.css?a=1">

    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/vendor/swiper/js/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
    <script type="text/javascript" src="/Scripts/UIControl.js"></script>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/date.js"></script>
</head>
<script type="text/javascript">
    if (self != top) {
        window.parent.API_LoadingStart();
    }

    var c = new common();
    var ui = new uiControl();
    var mlp;
    var lang;
    var WebInfo;
    //var marqueeText = "<%=MarqueeText%>";
    var HotList;
    var v ="<%:Version%>";
    //temp
    var tempGame = [
        {
            GameName: "legacyofdead",
            GameBrand: "PNG"
        },
        {
            GameName: "sweetalchemy",
            GameBrand: "PNG"
        },
        {
            GameName: "101",
            GameBrand: "PG"
        },
        {
            GameName: "109",
            GameBrand: "PG"
        },
        {
            GameName: "89",
            GameBrand: "PG"
        },
        {
            GameName: "196",
            GameBrand: "CQ9"
        },
        {
            GameName: "52",
            GameBrand: "CQ9"
        },
        {
            GameName: "16",
            GameBrand: "KGS"
        },
        {
            GameName: "52",
            GameBrand: "KX"
        },
        {
            GameName: "830",
            GameBrand: "KX"
        },
    ];

    var tempGame2 = [
        {
            GameName: "402",
            GameBrand: "PP"
        },
        {
            GameName: "66",
            GameBrand: "CQ9"
        },
        {
            GameName: "45",
            GameBrand: "KGS"
        },
        {
            GameName: "46",
            GameBrand: "KGS"
        },
        {
            GameName: "416",
            GameBrand: "KGS"
        },
        {
            GameName: "950",
            GameBrand: "KX"
        },
        {
            GameName: "510",
            GameBrand: "KX"
        },
        {
            GameName: "152",
            GameBrand: "VA"
        },
        {
            GameName: "153",
            GameBrand: "VA"
        }
    ];

    var MyGames;

    var FavoGames;

    function initSwiper() {
        //HERO 
        var heroIndex = new Swiper("#hero-slider", {
            loop: true,
            slidesPerView: 1,
            effect: "fade",
            speed: 1000, //Duration of transition between slides (in ms)
            autoplay: {
                delay: 5000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
                renderBullet: function (index, className) {
                    //   return '<span class="' + className + '">' + (index + 1) + "</span>";
                    return '<span class="' + className + '">' + '<img src="images/banner/thumb-' + (index + 1) + '.png"></span>';
                },
            },

        });

        // 推薦遊戲
        var gameRecommend = new Swiper("#game-recommend", {
            loop: true,
            slidesPerView: "auto",
            slidesPerGroup: 8,
            navigation: {
                nextEl: "#game-recommend .swiper-button-next",
                prevEl: "#game-recommend .swiper-button-prev",
            },
            // breakpoints: {
            //     768: {
            //         slidesPerView: 4,
            //         freeMode: false                
            //     },
            //     1200: {
            //         slidesPerView: 6,
            //         freeMode: false                
            //     }
            // }


        });
    }

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }


        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        HotList = window.parent.API_GetGameList(1);
        window.parent.API_LoadingStart();
        mlp.loadLanguage(lang, function () {
            if (WebInfo.FirstLoaded) {
                window.parent.API_LoadingEnd();
            }

            if (p != null) {
                //window.parent.sleep(500).then(() => {
                //    if (WebInfo.UserLogined) {
                //        document.getElementById("idGoRegBtn").classList.add("is-hide");
                //        $(".register-list").hide();
                //    }
                //})
            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });

        initSwiper();

        setBulletinBoard();
    }

    function setBulletinBoard() {
        var GUID = Math.uuid();
        p.GetBulletinBoard(GUID, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    var ParentMain = document.getElementById("idBulletinBoardContent");
                    ParentMain.innerHTML = "";

                    if (o.Datas.length > 0) {
                        var RecordDom;
                        //var numGameTotalValidBetValue = new BigNumber(0);
                        for (var i = 0; i < o.Datas.length; i++) {
                            var record = o.Datas[i];

                            RecordDom = c.getTemplate("idTempBulletinBoard");

                            var recordDate = new Date(parseInt(record.CreateDate.replace(')/', '').replace('/Date(', '')));
                            var date = recordDate.getFullYear() + '.' + (recordDate.getMonth() + 1) + '.' + recordDate.getDate();
                            c.setClassText(RecordDom, "CreateDate", null, date);
                            c.setClassText(RecordDom, "BulletinTitle", null, record.BulletinTitle);

                            RecordDom.onclick = new Function("window.parent.showBoardMsg('" + record.BulletinTitle + "','" + record.BulletinContent + "','" + recordDate.toString("yyyy/MM/dd") + "')");

                            ParentMain.appendChild(RecordDom);

                        }
                    }
                }
            }
        });
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
                    //updateBaseInfo();
                });

                break;
            case "IndexFirstLoad":
                window.parent.API_LoadingEnd();

                break;
        }
    }

    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    window.onload = init;

</script>
<body class="innerBody">
    <main class="innerMain">
        <section class="section-wrap hero">
            <div class="hero_slider swiper_container round-arrow" id="hero-slider">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <!-- <div class="hero-item" style="background-color: #010d4b;"> -->
                        <div class="hero-item">
                            <a class="hero-item-link" href="#"></a>
                            <div class="img-wrap">
                                <img src="Images/banner/b1.png" class="bg">
                                <div class="anim container">
                                    <div class="role role-R">
                                        <img src="images/banner/girl.png" alt="">
                                    </div>
                                    <div class="role role-L">
                                        <img src="images/banner/dog.png" alt="">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <a class="hero-item-link" href="#"></a>
                            <div class="img-wrap">
                                <img src="https://images2.alphacoders.com/108/1083491.jpg" class="bg">
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <!-- <div class="hero-item" style="background-color: #010d4b;"> -->
                        <div class="hero-item">
                            <a class="hero-item-link" href="#"></a>
                            <div class="img-wrap">
                                <img src="https://images6.alphacoders.com/114/1145091.png" class="bg">
                                <div class="anim container">
                                    <div class="role role-R">
                                        <img src="images/banner/girl.png" alt="">
                                    </div>
                                    <div class="role role-L">
                                        <img src="images/banner/dog.png" alt="">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">
                            <a class="hero-item-link" href="#"></a>
                            <div class="img-wrap">
                                <img src="https://images2.alphacoders.com/108/1083491.jpg" class="bg">
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="hero-item">

                            <a class="hero-item-link" href="#"></a>
                            <div class="img-wrap">
                                <img src="https://images2.alphacoders.com/108/1083491.jpg" class="bg">
                            </div>
                        </div>
                    </div>

                    <div class="swiper-mask"></div>
                </div>

                <div class="container">
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </section>
        <!--  -->
        <section class="section_publicize section-wrap">
            <div class="container">
                <div class="publicize_wrapper publicize_top">
                    <div class="publicize_top_inner">
                        <div class="item writer">
                            <img src="images/index/writer.png" alt="">
                        </div>
                        <div class="item vtuber">
                            <img src="images/index/vtuber.png" alt="">
                        </div>
                    </div>
                </div>
                <div class="publicize_wrapper publicize_bottom">
                    <div class="publicize_bottom_inner">
                        <div class="publicize-wrap way_payment">
                            <div class="item payment">
                                <img src="images/index/way-payment-mobile.png" class="mobile" alt="">
                                <img src="images/index/way-payment.png" class="desktop" alt="">
                            </div>
                        </div>
                        <div class="publicize-wrap bulletin-login">
                            <div class="item bulletin">
                                <div class="bulletin_inner">
                                    <h2 class="title">重要な新しい情報</h1>
                   
                                        <ul class="bulletin_list" id="idBulletinBoardContent">
                                        </ul>
                                </div>
                            </div>
                            <div class="item login">
                                <img src="images/index/daily-prize-login.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="game-area section-wrap container overflow-hidden">
            <!-- 推薦遊戲 -->
            <section class="section-wrap section-levelUp recommend">
                <div class="game_wrapper">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="title  language_replace">推薦遊戲</span></h3>
                        </div>
                        <a class="text-link" href="casino.html">
                            <span>全部顯示</span><i class="icon arrow arrow-right"></i>
                        </a>
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover gameinfo-pack-bg round-arrow" id="game-recommend">
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
                                        <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                        <div class="game-item-focus">
                                            <div class="game-item-img">
                                                <span class="game-item-link"></span>
                                                <div class="img-wrap">
                                                    <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/1.png">
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
                                        <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                        <div class="game-item-focus">
                                            <div class="game-item-img">
                                                <span class="game-item-link"></span>
                                                <div class="img-wrap">
                                                    <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PP/PC/CHT/vswayssamurai.png">
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
                                        <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                        <div class="game-item-focus">
                                            <div class="game-item-img">
                                                <span class="game-item-link"></span>
                                                <div class="img-wrap">
                                                    <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/spirit-wonder.png">
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
                                        <span class="game-item-mobile-popup" data-toggle="modal" data-target="#popupGameInfo"></span>
                                        <div class="game-item-focus">
                                            <div class="game-item-img">
                                                <span class="game-item-link"></span>
                                                <div class="img-wrap">
                                                    <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/CQ9/PC/CHT/BT02.png">
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
                                                    <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/KX/PC/CHT/8200.png">
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

            </section>

            <!-- 最新遊戲 -->
            <section class="section-wrap section-levelUp new">
                <div class="game_wrapper">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="title  language_replace">最新遊戲</span></h3>
                        </div>
                        <a class="text-link" href="casino.html">
                            <span>全部顯示</span><i class="icon arrow arrow-right"></i>
                        </a>
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover round-arrow" id="game-new">
                    </div>
                </div>
            </section>

            <!-- 我的最愛 -->
            <section class="section-wrap section-levelUp new">
                <div class="game_wrapper">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <h3 class="sec-title"><i class="icon icon-mask icon-star"></i><span class="title  language_replace">我的最愛</span></h3>
                        </div>
                        <a class="text-link" href="casino.html">
                            <span>全部顯示</span><i class="icon arrow arrow-right"></i>
                        </a>
                    </div>
                    <div class="game_slider swiper_container gameinfo-hover round-arrow" id="pop-casino">
                    </div>
                </div>
            </section>

        </section>

    </main>
    <footer class="footer"></footer>
    <!-- Modal - Game Info for Mobile Device-->
    <div class="modal fade no-footer popupGameInfo " id="popupGameInfo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="game-info-mobile-wrapper gameinfo-pack-bg">
                        <div class="game-item">
                            <div class="game-item-inner">
                                <div class="game-item-focus">
                                    <div class="game-item-img">
                                        <span class="game-item-link"></span>
                                        <div class="img-wrap">
                                            <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                        </div>
                                    </div>
                                    <div class="game-item-info-detail open">
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
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>

    <div class="tmpModel" style="display: none;">
        <div id="idTempBulletinBoard" style="display: none;">
            <div>
                <li class="item">
                    <span class="date CreateDate"></span>
                    <span class="info BulletinTitle" style="cursor: pointer"></span>
                </li>
            </div>
        </div>
    </div>


</body>

</html>
