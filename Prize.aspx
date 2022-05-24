<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
%>

<!doctype html>
<html lang="zh-Hant-TW" class="innerHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Maharaja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/activity.css">
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/vendor/swiper/js/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="Scripts/theme.js"></script>
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
    var LobbyClient;
    var v = "<%:Version%>";

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }


        WebInfo = window.parent.API_GetWebInfo();
        LobbyClient = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);

        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            if (WebClient != null) {
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
    }

    function GoActivityDetail(url) {
        event.stopPropagation();

        if (url) {

        }
    }

    function GetPromotionCollectHistory(BeginDate, EndDate) {
        LobbyClient.GetPromotionCollectHistory(WebInfo.SID, Math.uuid(), BeginDate, EndDate, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.collectListField.length > 0) {
                        for (var i = 0; i < o.collectListField.length; i++) {
                            var collect = o.collectListField[i];
                            var collectDate = Date.parse(CollectDate);
                            var rowDom = c.getTemplate("IDHistoryRow");
                            

                            k.querySelector(".year").innerText = collectDate.toString("yyyy");
                            k.querySelector(".month").innerText = collectDate.toString("MM");
                            k.querySelector(".day").innerText = collectDate.toString("dd");
                            k.querySelector(".actTitle").innerText = collectDate.toString("dd");
                            k.querySelector(".pointValue").innerText = collectDate.toString("dd");

                            if (rowDom) {

                            } else {

                            }
                        }
                    } else {

                    }
                } else {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout") {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新嘗試"));
                } else {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), o);
                }
            }
        });
    }

    function GetPromotionCollectAvailable() {

    }
</script>
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <div class="container">
                <div class="sec-title-container sec-title-prize">
                    <!-- 活動中心 link-->
                    <a class="btn btn-link btn-activity">
                        <span class="title language_replace">クイックピックアップ</span><i class="icon icon-mask icon-arrow-right-dot"></i>
                    </a>
                    <div class="sec-title-wrapper">
                        <h1 class="sec-title title-deco"><span class="language_replace">コレクションセンター</span></h1>
                        <!-- 獎金/禮金 TAB -->
                        <div class="menu-prize tab-scroller">
                            <div class="tab-scroller__area">
                                <ul class="tab-scroller__content">
                                    <li class="tab-item active">
                                        <span class="tab-item-link"><span class="title language_replace">ボーナス</span>
                                        </span>
                                    </li>
                                    <li class="tab-item">
                                        <span class="tab-item-link"><span class="title language_replace">ギフトマネー</span></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <section class="section-wrap section-prize">
                    <div class="prize-item-wrapper">
                        <div class="prize-item-group">
                            <figure class="prize-item">
                                <div class="prize-item-inner">
                                    <!-- 活動連結 prize-item-link-->
                                    <div class="prize-item-link">
                                        <div class="prize-item-img">
                                            <div class="img-wrap">
                                                <img class="" src="images/prize-01.jpg">
                                            </div>
                                        </div>
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</figcaption>
                                            <div class="date-period language_replace">
                                                <span class="date-period-start">
                                                    <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                                </span>
                                                <span class="date-period-end">
                                                    <span class="year">2022</span><span class="month">06</span><span class="day">06</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 獎金Button - 不可領取 -->
                                    <button type="button" class="btn btn-bouns bouns-get" disabled><span class="btn-bouns-num language_replace">$5000000</span></button>
                                </div>
                            </figure>
                            <figure class="prize-item">
                                <div class="prize-item-inner">
                                    <!-- 活動連結 prize-item-link-->
                                    <div class="prize-item-link">
                                        <div class="prize-item-img">
                                            <div class="img-wrap">
                                                <img class="" src="images/prize-01.jpg">
                                            </div>
                                        </div>
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</figcaption>
                                            <div class="date-period language_replace">
                                                <span class="date-period-start">
                                                    <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                                </span>
                                                <span class="date-period-end">
                                                    <span class="year">2022</span><span class="month">06</span><span class="day">06</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 獎金Button - 可領取 -->
                                    <button type="button" class="btn btn-bouns bouns-get"><span class="btn-bouns-num language_replace">受け取る</span></button>
                                </div>
                            </figure>
                            <figure class="prize-item">
                                <div class="prize-item-inner">
                                    <!-- 活動連結 prize-item-link-->
                                    <div class="prize-item-link">
                                        <div class="prize-item-img">
                                            <div class="img-wrap">
                                                <img class="" src="images/prize-01.jpg">
                                            </div>
                                        </div>
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</figcaption>
                                            <div class="date-period language_replace">
                                                <span class="date-period-start">
                                                    <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                                </span>
                                                <span class="date-period-end">
                                                    <span class="year">2022</span><span class="month">06</span><span class="day">06</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 獎金Button - 不可領取 -->
                                    <button type="button" class="btn btn-bouns bouns-get" disabled><span class="btn-bouns-num language_replace">$5000000</span></button>
                                </div>
                            </figure>
                            <figure class="prize-item">
                                <div class="prize-item-inner">
                                    <!-- 活動連結 prize-item-link-->
                                    <div class="prize-item-link">
                                        <div class="prize-item-img">
                                            <div class="img-wrap">
                                                <img class="" src="images/prize-01.jpg">
                                            </div>
                                        </div>
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</figcaption>
                                            <div class="date-period language_replace">
                                                <span class="date-period-start">
                                                    <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                                </span>
                                                <span class="date-period-end">
                                                    <span class="year">2022</span><span class="month">06</span><span class="day">06</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 獎金Button - 可領取 -->
                                    <button type="button" class="btn btn-bouns bouns-get"><span class="btn-bouns-num language_replace">受け取る</span></button>
                                </div>
                            </figure>
                        </div>
                    </div>
                </section>

                <!-- 獎金 - 已領取紀錄區 -->
                <section class="section-wrap section-prize-record">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                            <h1 class="sec-title title-deco"><span class="language_replace">ボーナス履歴</span></h1>
                        </div>
                        <!-- 前/後 月 -->
                        <div class="sec_link">
                            <button class="btn btn-link btn-gray" type="button"><i class="icon arrow arrow-left mr-1"></i><span class="language_replace">先月</span></button>
                            <button class="btn btn-link btn-gray" type="button"><span class="language_replace">来月︎</span><i class="icon arrow arrow-right ml-1"></i></button>
                        </div>

                    </div>
                    <div class="MT__table">
                        <!-- thead  -->
                        <div class="thead">
                            <div class="thead__tr">
                                <div class="thead__th"><span class="language_replace">領取日期</span></div>
                                <div class="thead__th"><span class="language_replace">活動名稱</span></div>
                                <div class="thead__th"><span class="language_replace">金額</span></div>
                            </div>
                        </div>
                        <!-- tbody -->
                        <div class="tbody">

                            <div class="tbody__tr">
                                <div class="tbody__td">
                                    <span class="td__content">
                                        <span class="date-period">
                                            <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                        </span>
                                    </span>
                                </div>
                                <div class="tbody__td">
                                    <span class="td__content"><span class="">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</span></span>
                                </div>
                                <div class="tbody__td">
                                    <span class="td__content"><span class="">999,999,999</span></span>
                                </div>
                            </div>
                            <div class="tbody__tr">
                                <div class="tbody__td">
                                    <span class="td__content">
                                        <span class="date-period">
                                            <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                        </span>
                                    </span>
                                </div>
                                <div class="tbody__td">
                                    <span class="td__content"><span class="">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</span></span>
                                </div>
                                <div class="tbody__td">
                                    <span class="td__content"><span class="">999,999,999</span></span>
                                </div>
                            </div>
                            <div class="tbody__tr">
                                <div class="tbody__td">
                                    <span class="td__content">
                                        <span class="date-period">
                                            <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                                        </span>
                                    </span>
                                </div>
                                <div class="tbody__td">
                                    <span class="td__content"><span class="">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</span></span>
                                </div>
                                <div class="tbody__td">
                                    <span class="td__content"><span class="">999,999,999</span></span>
                                </div>
                            </div>

                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <div id="IDHistoryRow">
        <div class="tbody__tr">
            <div class="tbody__td">
                <span class="td__content">
                    <span class="date-period">
                        <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                    </span>
                </span>
            </div>
            <div class="tbody__td">
                <span class="td__content"><span class="actTitle">ゴールドヒット！ゴールドヒット！ ゴールドヒット！</span></span>
            </div>
            <div class="tbody__td">
                <span class="td__content"><span class="pointValue">999,999,999</span></span>
            </div>
        </div>
    </div>
</body>

</html>
