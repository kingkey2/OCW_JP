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
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.1/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
    <script type="text/javascript" src="/Scripts/UIControl.js"></script>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/9.0.2/bignumber.min.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/date.js"></script>
    <script type="text/javascript" src="Scripts/DateExtension.js"></script>
    <script src="https://genieedmp.com/dmp.js?c=6780&ver=2" async></script>
</head>
<% if (EWinWeb.IsTestSite == false)
    { %>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-097DC2GB6H"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'G-097DC2GB6H');
</script>
<% } %>
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
    var search_Year;
    var search_Month;

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        LobbyClient = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);

        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            if (LobbyClient != null) {
                //可領取獎金
   
                //領取紀錄
                let now_date = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
                search_Year = now_date.split('/')[0];
                search_Month = now_date.split('/')[1];

                let beginDate = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
                let endDate = Date.today().moveToLastDayOfMonth().toString("yyyy/MM/dd");

                GetPromotionCollectHistory(beginDate, endDate);

            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });
    }

    function GetPromotionCollectHistory(BeginDate, EndDate) {
        var ParentMain = document.getElementById("div_History");
        ParentMain.innerHTML = "";
        document.getElementById("idSearchDate_P").innerText = new Date(EndDate).toString("yyyy/MM");
        var useType = -1;
        LobbyClient.GetGiftPaymentHistory(WebInfo.SID, Math.uuid(), BeginDate, EndDate, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.GiftList.length > 0) {
                        if ($('#li_bonus1').hasClass('active')) {
                            useType = 0;
                        } else {
                            useType = 1;
                        }
  
                        for (var i = 0; i < o.GiftList.length; i++) {
                            var collect = o.GiftList[i];
                            
                            if (useType == 0 && collect.PaymentGiftID.substr(0, 1) == 'S') {
                                var collectDate = Date.parse(collect.CreateDate);
                                var rowDom = c.getTemplate("IDHistoryRow");

                                rowDom.querySelector(".year").innerText = collectDate.toString("yyyy");
                                rowDom.querySelector(".month").innerText = collectDate.toString("MM");
                                rowDom.querySelector(".day").innerText = collectDate.toString("dd");
                                rowDom.querySelector(".value").innerText = new BigNumber(collect.Amount).toFormat();
                                rowDom.querySelector(".giftID").innerText = collect.PaymentGiftID;

                                if (collect.PaymentGiftStatus == 0) {
                                    rowDom.querySelector(".reciveStatus").innerText = mlp.getLanguageKey('未領取');
                                    $(rowDom).find('.copyGiftUrl').data('giftcode', collect.PaymentGiftCode);
                                    $(rowDom).find('.copyGiftUrl').data('amount', new BigNumber(collect.Amount).toFormat());
                                    $(rowDom).find('.copyGiftUrl').text(mlp.getLanguageKey('領取連結'));
                                    $(rowDom).find('.copyGiftUrl').show();
                                } else {
                                    rowDom.querySelector(".reciveStatus").innerText = mlp.getLanguageKey('已領取');
                                    $(rowDom).find('.copyGiftUrl').hide();
                                }

                              
                                ParentMain.appendChild(rowDom);
                            } else if (useType == 1 && collect.PaymentGiftID.substr(0, 1) == 'W') {
                                var collectDate = Date.parse(collect.CreateDate);
                                var rowDom = c.getTemplate("IDHistoryRow");

                                rowDom.querySelector(".year").innerText = collectDate.toString("yyyy");
                                rowDom.querySelector(".month").innerText = collectDate.toString("MM");
                                rowDom.querySelector(".day").innerText = collectDate.toString("dd");
                                rowDom.querySelector(".value").innerText = new BigNumber(collect.Amount).toFormat();
                                rowDom.querySelector(".giftID").innerText = collect.PaymentGiftID;

                                if (collect.PaymentGiftStatus == 0) {
                                    rowDom.querySelector(".reciveStatus").innerText = mlp.getLanguageKey('未領取');
                                    $(rowDom).find('.copyGiftUrl').data('giftcode', collect.PaymentGiftCode);
                                    $(rowDom).find('.copyGiftUrl').data('amount', new BigNumber(collect.Amount).toFormat());
                                    $(rowDom).find('.copyGiftUrl').text(mlp.getLanguageKey('領取連結'));
                                    $(rowDom).find('.copyGiftUrl').show();
                                } else {
                                    rowDom.querySelector(".reciveStatus").innerText = mlp.getLanguageKey('已領取');
                                    $(rowDom).find('.copyGiftUrl').hide();
                                }

                                ParentMain.appendChild(rowDom);
                            }
                        }

                        if ($("#div_History").children().length == 0) {
                            $(ParentMain).append(`<div class="no-Data"><div class="data"><span class="text language_replace">${mlp.getLanguageKey('沒有資料')}</span></div></div>`);
                            // $("#div_History").height(50);
                        }

                        window.top.API_LoadingEnd(1);
                    } else {
                        $(ParentMain).append(`<div class="no-Data"><div class="data"><span class="text language_replace">${mlp.getLanguageKey('沒有資料')}</span></div></div>`);
                        // $("#div_History").height(50);
                        window.top.API_LoadingEnd(1);
                    }
                } else {
                    $(ParentMain).append(`<div class="no-Data"><div class="data"><span class="text language_replace">${mlp.getLanguageKey('沒有資料')}</span></div></div>`);
                    // $("#div_History").height(50);
                    //window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                    window.top.API_LoadingEnd(1);
                }
            } else {
                if (o == "Timeout") {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新嘗試"));
                    window.top.API_LoadingEnd(1);
                } else {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), o);
                    window.top.API_LoadingEnd(1);
                }
            }
        });

    }

    function GetPromotionCollectAvailable(collectareatype) {
        window.parent.API_LoadingStart();
        $(".tab-scroller__content").find(".tab-item").removeClass("active");
        $("#li_bonus" + collectareatype).addClass("active");

        let newSearchDate = new Date(search_Year + "/" + search_Month + "/01");

        beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
        endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

        GetPromotionCollectHistory(beginDate, endDate);

    }

    function getLastDate(y, m) {
        var lastDay = new Date(y, m, 0);
        var year = lastDay.getFullYear();
        var month = lastDay.getMonth() + 1;
        month = month < 10 ? '0' + month : month;
        var day = lastDay.getDate();
        day = day < 10 ? '0' + day : day;

        return day;
    }

    function getPreMonth() {
        window.parent.API_LoadingStart();

        let newSearchDate = new Date(search_Year + "/" + search_Month + "/01").addMonths(-1);

        search_Year = newSearchDate.toString("yyyy/MM/dd").split('/')[0];
        search_Month = newSearchDate.toString("yyyy/MM/dd").split('/')[1];

        let beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
        let endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

        GetPromotionCollectHistory(beginDate, endDate);

    }

    function getNextMonth() {
        window.parent.API_LoadingStart();

        let newSearchDate = new Date(search_Year + "/" + search_Month + "/01").addMonths(1);

        let beginDate;
        let endDate;
        //時間超過當月
        if (Date.compare(newSearchDate, Date.parse("today")) > 0) {
            beginDate = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = Date.today().moveToLastDayOfMonth().toString("yyyy/MM/dd");

            GetPromotionCollectHistory(beginDate, endDate);
        } else {
            beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

            search_Year = newSearchDate.toString("yyyy/MM/dd").split('/')[0];
            search_Month = newSearchDate.toString("yyyy/MM/dd").split('/')[1];

            GetPromotionCollectHistory(beginDate, endDate);
        }

    }

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":

                break;
            case "BalanceChange":
                break;

            case "SetLanguage":
                var lang = param;

                mlp.loadLanguage(lang, function () {
                    window.parent.API_LoadingEnd(1);
                });
                break;
        }
    }

    function copyGiftUrl(doc) {
        var giftcode = $(doc).data('giftcode');
        var amount = $(doc).data('amount');
        var url = window.location.protocol + "//" + window.location.host + "/receiveGift.aspx?GiftCode=" + giftcode +
            "&Amount=" + amount;
        navigator.clipboard.writeText(url).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
    }

    window.onload = init;
</script>
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <div class="container">
                <div class="sec-title-container sec-title-prize ">
                     <div class="sec-title-wrapper">
                        <h1 class="sec-title title-deco"><span class="language_replace">禮品中心</span></h1>
                        <!-- 使用說明LINK -->
                       <%-- <span class="sec-title-intro-link" onclick="window.parent.API_LoadPage('Prize','/Guide/prize.html?form=Prize', true)">
                            <span class="btn btn-QA-transaction btn-full-stress btn-round"><i class="icon icon-mask icon-question"></i></span><span class="title language_replace">領獎中心使用說明</span>
                        </span>     --%>             
                    </div>   
                     <!-- 獎金/禮金 TAB -->
                     <div class="tab-prize tab-scroller tab-2 tab-primary">
                        <div class="tab-scroller__area">
                            <ul class="tab-scroller__content">
                                <li class="tab-item active" id="li_bonus1" onclick="GetPromotionCollectAvailable(1)">
                                    <span class="tab-item-link"><span class="title language_replace">購買紀錄</span>
                                    </span>
                                </li>
                                <li class="tab-item" id="li_bonus2" onclick="GetPromotionCollectAvailable(2)">
                                    <span class="tab-item-link"><span class="title language_replace">領取紀錄</span></span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 獎金 - 已領取紀錄區 -->
                <section class="section-wrap section-prize-record">
                    <div class="sec-title-container">
                        <div class="sec-title-wrapper">
                         <%--   <h1 class="sec-title title-deco"><span class="language_replace">領取紀錄</span></h1>--%>
                        </div>
                        <!-- 前/後 月 -->
                        <div class="sec_link sec-month">
                            <button class="btn btn-link btn-gray" type="button" onclick="getPreMonth()"><i class="icon arrow arrow-left mr-1"></i><span class="language_replace">上個月</span></button>
                            <span id="idSearchDate_P" class="date_text"></span>
                            <button class="btn btn-link btn-gray" type="button" onclick="getNextMonth()"><span class="language_replace">下個月</span><i class="icon arrow arrow-right ml-1"></i></button>
                        </div>

                    </div>
                    <div class="MT__table table-prize-record">
                        <!-- Thead  -->
                        <div class="Thead">
                            <div class="thead__tr">
                                <div class="thead__th"><span class="language_replace">訂單編號</span></div>
                                <div class="thead__th"><span class="language_replace">建立時間</span></div>
                                <div class="thead__th"><span class="language_replace">金額</span></div>
                                <div class="thead__th"><span class="language_replace">領取狀態</span></div>
                                <div class="thead__th"><span class="language_replace">領取連結</span></div>
                            </div>
                        </div>
                        <!-- Tbody -->
                        <div class="Tbody"  id="div_History">
                            <%--<div></div>
                             <!-- 無資料 ========================= -->
                            <div class="no-Data" id="idNoHistoryData">
                                <div class="data">
                                    <span class="text language_replace">沒有資料</span>
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <div id="IDHistoryRow" style="display: none">
        <div class="tbody__tr">
             <div class="tbody__td">
                <span class="td__content"><span class="giftID"></span></span>
            </div>
            <div class="tbody__td">
                <span class="td__content">
                    <span class="date-period">
                        <span class="year">2022</span><span class="month">04</span><span class="day">04</span>
                    </span>
                </span>
            </div>
         
            <div class="tbody__td">
                <span class="td__content"><span class="value">0</span></span>
            </div>
              <div class="tbody__td">
                <span class="td__content"><span class="reciveStatus"></span></span>
            </div>
                <div class="tbody__td">
                <span class="td__content"><button class="copyGiftUrl" onclick="copyGiftUrl(this)"></button></span>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>

</html>
