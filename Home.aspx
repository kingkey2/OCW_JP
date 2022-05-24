<%@ Page Language="C#" %>

<%
    int RValue;
    string Token;
    string MarqueeText = "";
    string Version = EWinWeb.Version;
    Random R = new Random();

    EWin.Lobby.APIResult Result;
    EWin.Lobby.LobbyAPI LobbyAPI = new EWin.Lobby.LobbyAPI();

    RValue = R.Next(100000, 9999999);
    Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());
    Result = LobbyAPI.GetCompanyMarqueeText(Token, Guid.NewGuid().ToString());
    if (Result.Result == EWin.Lobby.enumResult.OK) {
        MarqueeText = Result.Message;
    }
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
    var marqueeText = "<%=MarqueeText%>";
    var HotList;
    var v ="<%:Version%>";
    //temp
    var HotCasino = [
        {
            GameName: "401",
            GameBrand: "PP"
        },
        {
            GameName: "204",
            GameBrand: "PP"
        },
        {
            GameName: "baccarat-deluxe",
            GameBrand: "PG"
        },
        {
            GameName: "blackjack-us",
            GameBrand: "PG"
        },
        {
            GameName: "Baccarat5T2",
            GameBrand: "CG"
        },
        {
            GameName: "InternationalSicbo",
            GameBrand: "CG"
        }
    ];

    //temp
    var HotSlot = [
        {
            GameName: "blackjack-us",
            GameBrand: "PG"
        },
        {
            GameName: "rla",
            GameBrand: "PP"
        },
        {
            GameName: "bjmb",
            GameBrand: "PP"
        },
        {
            GameName: "blackjack-eu",
            GameBrand: "PG"
        },
        {
            GameName: "InternationalSicbo",
            GameBrand: "CG"
        },
        {
            GameName: "bjma",
            GameBrand: "PP"
        }
    ];

    var MyGames;

    var FavoGames;

    var FourGames = [
        {
            GameName: "EWinGaming",
            GameBrand: "EWin",
            Description: "元祖ライブバカラ新しいサービス初めました！"
        },
        {
            GameName: "moonprincess",
            GameBrand: "PNG",
            Description: "言わずと知れた高級キャバクラ！！"
        },
        {
            GameName: "legacyofdead",
            GameBrand: "PNG",
            Description: "言わずと知れたBOOK系の元祖！大きな当たりが魅力。"
        },
        {
            GameName: "sweetalchemy",
            GameBrand: "PNG",
            Description: "ボーナス中のミッションクリアで突入する獲得ボーナス倍増ゲームがたまらない！"
        },
        {
            GameName: "101",
            GameBrand: "PG",
            Description: "連鎖すると賞金倍率が上昇ボーナ中で更に上昇でドキドキ感が堪らない！"
        },
        {
            GameName: "89",
            GameBrand: "PG",
            Description: "最高32400のマルチウェイ！最高倍率はなんと10万倍だ！熱い！"
        },
        {
            GameName: "125",
            GameBrand: "PG",
            Description: "最高勝利金5万倍！蝶がもたらす効果は嫌いな人も好きにさせてしまうはず！"
        },
        {
            GameName: "AzurLaneEX",
            GameBrand: "CG",
            Description: "戦艦マニアにはたまらないグラフスロット。ドカンと一発！！"
        }
    ];

    function initSwiper() {
        //首頁banner
        new Swiper("#hero-slider", {
            loop: true,
            slidesPerView: 1,
            effect: "fade",
            speed: 1000, //Duration of transition between slides (in ms)
            autoplay: {
                delay: 3500,
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
            // loop: true,
            slidesPerView: 3,
            freeMode: true,
            navigation: {
                nextEl: "#game-recommend .swiper-button-next",
            },
            breakpoints: {
                768: {
                    slidesPerView: 4,
                    freeMode: false
                },
                1200: {
                    slidesPerView: 6,
                    freeMode: false
                }
            }


        });

        // 最新遊戲
        var gameNew = new Swiper("#game-new", {
            // loop: true,
            slidesPerView: 3,
            freeMode: true,
            navigation: {
                nextEl: "#game-new .swiper-button-next",
            },
            breakpoints: {
                768: {
                    slidesPerView: 4,
                    freeMode: true
                },
                1200: {
                    slidesPerView: 6,
                    freeMode: true
                }
            }

        });

        // 賭場遊戲
        var gameCasino = new Swiper("#pop-casino", {
            // loop: true,
            slidesPerView: 3,
            freeMode: true,
            navigation: {
                nextEl: "#pop-casino .swiper-button-next",
            },
            breakpoints: {
                768: {
                    slidesPerView: 4,
                    freeMode: true
                },
                1200: {
                    slidesPerView: 6,
                    freeMode: true
                }
            }

        });
    }

    function init() {

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        HotList = window.parent.API_GetGameList(1);
        window.parent.API_LoadingStart();
        mlp.loadLanguage(lang, function () {
            if (WebInfo.UserLogined) {
                //document.getElementById("idRegisterBonus").classList.add("is-hide");
            }

            //window.parent.API_LoadingEnd();
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

        window.parent.API_LoadingEnd();

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

                            RecordDom.onclick = new Function("window.parent.showMessageOK('','" + record.BulletinContent + "')");

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
                      <div class="role role-R"><img src="images/banner/girl.png" alt=""></div>
                      <div class="role role-L"><img src="images/banner/dog.png" alt=""></div>                    
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
                      <div class="role role-R"><img src="images/banner/girl.png" alt=""></div>
                      <div class="role role-L"><img src="images/banner/dog.png" alt=""></div>                    
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
          
          <div class="container"><div class="swiper-pagination"></div></div> 
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
                <img src="images/index/way-payment.png"  class="desktop" alt="">
              </div>
            </div>
            <div class="publicize-wrap bulletin-login">
              <div class="item bulletin">
                <div class="bulletin_inner">
                  <h2 class="title">重要な新しい情報</h1>
                    <ul class="bulletin_list">
                      <li class="item">
                        <span class="date">2022.4.16</span>
                        <span class="info">マハラジャからプレイヤーとワンツーManキャンペーン!!!!</span>
                      </li>
                      <li class="item">
                        <span class="date">2022.4.16</span>
                        <span class="info">マハラジャからプレイヤーとワンツーManキャンペーン!!!!</span>
                      </li>
                      <li class="item">
                        <span class="date">2022.4.16</span>
                        <span class="info">マハラジャからプレイヤーとワンツーManキャンペーン!!!!</span>
                      </li>

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
                <h3 class="title"><i class="icon icon2020-ico-coin-o"></i>推薦遊戲</h3>
              </div>
              <a class="text-link" href="casino.html">
                <span>全部顯示</span><i class="icon arrow arrow-right"></i>             
              </a>
            </div>
            <div class="game_slider swiper_container gameinfo-hover round-arrow" id="game-recommend">
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
                                    <div class="game-item-info-detail-wapper">
                                        <div class="game-item-info-detail-inner">
                                            <div class="info">
                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                            </div>
                                            <div class="action">
                                                <div class="btn-s-wrapper">
                                                    <!-- 已"按讚" class=> "added" -->
                                                    <button type="button" class="btn-thumbUp btn btn-round">
                                                        <i class="icon icon-thumup"></i>
                                                    </button>
                                                    <!-- 已"加入最愛" class=> "added" -->
                                                    <button type="button" class="btn-like btn btn-round">
                                                        <i class="icon icon-heart-o"></i>
                                                    </button>
                                                    <button type="button" class="btn-more btn btn-round">
                                                        <i class="arrow arrow-down"></i>
                                                    </button>
                                                </div>
                                                <button type="button" class="btn btn-play">
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info-detail">
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info-detail">
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info-detail">
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
            </div>
          </div>
       
      </section>

      <!-- 最新遊戲 -->
      <section class="section-wrap section-levelUp new">        
          <div class="game_wrapper">
            <div class="sec-title-container">
              <div class="sec-title-wrapper">
                <h3 class="title"><i class="icon icon2020-ico-coin-o"></i>最新遊戲</h3>
              </div>
              <a class="text-link" href="casino.html">
                <span>全部顯示</span><i class="icon arrow arrow-right"></i>             
              </a>
            </div>
            <div class="game_slider swiper_container gameinfo-hover round-arrow" id="game-new">
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
                                    <div class="game-item-info-detail-wapper">
                                        <div class="game-item-info-detail-inner">
                                            <div class="info">
                                                <h3 class="game-item-name">バタフライブロッサム</h3>
                                            </div>
                                            <div class="action">
                                                <div class="btn-s-wrapper">
                                                    <!-- 已"按讚" class=> "added" -->
                                                    <button type="button" class="btn-thumbUp btn btn-round">
                                                        <i class="icon icon-thumup"></i>
                                                    </button>
                                                    <!-- 已"加入最愛" class=> "added" -->
                                                    <button type="button" class="btn-like btn btn-round">
                                                        <i class="icon icon-heart-o"></i>
                                                    </button>
                                                    <button type="button" class="btn-more btn btn-round">
                                                        <i class="arrow arrow-down"></i>
                                                    </button>
                                                </div>
                                                <button type="button" class="btn btn-play">
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info-detail">
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info-detail">
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                    </div>
                                </div>
                                <div class="game-item-info-detail">
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
                                    <div class="game-item-info-detail-wapper">
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
                                                    <span class="language_replace">プレイ</span><i
                                                        class="triangle"></i></button>
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
            </div>
          </div>
      </section>

      <!-- 賭場遊戲 -->
      <section class="section-wrap section-levelUp new">        
        <div class="game_wrapper">
          <div class="sec-title-container">
            <div class="sec-title-wrapper">
              <h3 class="title"><i class="icon icon2020-ico-coin-o"></i>賭場遊戲</h3>
            </div>
            <a class="text-link" href="casino.html">
              <span>全部顯示</span><i class="icon arrow arrow-right"></i>             
            </a>
          </div>
          <div class="game_slider swiper_container gameinfo-hover round-arrow" id="pop-casino">
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
                                  <div class="game-item-info-detail-wapper">
                                      <div class="game-item-info-detail-inner">
                                          <div class="info">
                                              <h3 class="game-item-name">バタフライブロッサム</h3>
                                          </div>
                                          <div class="action">
                                              <div class="btn-s-wrapper">
                                                  <!-- 已"按讚" class=> "added" -->
                                                  <button type="button" class="btn-thumbUp btn btn-round">
                                                      <i class="icon icon-thumup"></i>
                                                  </button>
                                                  <!-- 已"加入最愛" class=> "added" -->
                                                  <button type="button" class="btn-like btn btn-round">
                                                      <i class="icon icon-heart-o"></i>
                                                  </button>
                                                  <button type="button" class="btn-more btn btn-round">
                                                      <i class="arrow arrow-down"></i>
                                                  </button>
                                              </div>
                                              <button type="button" class="btn btn-play">
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                      <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                  </div>
                              </div>
                              <div class="game-item-info-detail">
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                      <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                  </div>
                              </div>
                              <div class="game-item-info-detail">
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                      <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                  </div>
                              </div>
                              <div class="game-item-info-detail">
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
                                  <div class="game-item-info-detail-wapper">
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
                                                  <span class="language_replace">プレイ</span><i
                                                      class="triangle"></i></button>
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
          </div>
        </div>
    </section>
     
    </section>
    
  </main>
</body>

</html>
