﻿<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
%>

<!DOCTYPE html>

<html lang="zh-Hant-TW" class="innerHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Maharaja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="js/vendor/swiper/css/swiper-bundle.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/record.css">

    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/vendor/swiper/js/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
    <script type="text/javascript" src="/Scripts/UIControl.js"></script>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/date.js"></script>
    <script type="text/javascript" src="Scripts/DateExtension.js"></script>
</head>
<script>
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
    var search_Year_G;
    var search_Month_G;
    var search_Year_P;
    var search_Month_P;

    //#region 遊戲
    function getPreMonth_Game() {
        window.parent.API_ShowLoading();

        let newSearchDate = new Date(search_Year_G + "/" + search_Month_G + "/01").addMonths(-1);

        search_Year_G = newSearchDate.toString("yyyy/MM/dd").split('/')[0];
        search_Month_G = newSearchDate.toString("yyyy/MM/dd").split('/')[1];

        let beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
        let endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

        updateGameHistory(beginDate, endDate);

    }

    function getNextMonth_Game() {
        window.parent.API_ShowLoading();

        let newSearchDate = new Date(search_Year_G + "/" + search_Month_G + "/01").addMonths(1);

        let beginDate;
        let endDate;
        //時間超過當月
        if (Date.compare(newSearchDate, Date.parse("today")) > 0) {
            beginDate = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = Date.today().moveToLastDayOfMonth().toString("yyyy/MM/dd");

            updateGameHistory(beginDate, endDate);
        } else {
            beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

            search_Year_G = newSearchDate.toString("yyyy/MM/dd").split('/')[0];
            search_Month_G = newSearchDate.toString("yyyy/MM/dd").split('/')[1];

            updateGameHistory(beginDate, endDate);
        }

    }

    function updateGameHistory(startDate, endDate) {
        var ParentMain = document.getElementById("divGame");
        ParentMain.innerHTML = "";

        LobbyClient.GetGameOrderSummaryHistoryGroupGameCode(WebInfo.SID, Math.uuid(), startDate, endDate, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.SummaryList.length > 0) {
                        for (var i = 0; i < o.SummaryList.length; i++) {
                            var daySummary = o.SummaryList[i];
                            var RecordDom;
                            var summaryDate = new Date(daySummary.SummaryDate);

                            if (daySummary.TotalRewardValue >= 0) {
                                RecordDom = c.getTemplate("tmpGame_W")
                            } else {
                                RecordDom = c.getTemplate("tmpGame_L")
                            }

                            c.setClassText(RecordDom, "SummaryDate", null, summaryDate.toString("yyyy/MM/dd"));
                            c.setClassText(RecordDom, "orderValue", null, new BigNumber(daySummary.TotalOrderValue).toFormat());
                            c.setClassText(RecordDom, "validBet", null, new BigNumber(daySummary.TotalValidBetValue).toFormat());
                            c.setClassText(RecordDom, "rewardValue", null, new BigNumber(daySummary.TotalRewardValue).toFormat());


                            RecordDom.dataset.queryDate = daySummary.SummaryDate;
                            RecordDom.querySelector(".btn-toggle").onclick = function () {
                                var nowJQ = $(this);
                                var summaryDateDom = nowJQ.parents(".record-table-item").get(0);
                                var queryDate = summaryDateDom.dataset.queryDate;

                                //Loading => 不重複點擊
                                //Loaded => 只做切換，不重新撈取數據
                                if (!summaryDateDom.classList.contains("Loading")) {
                                    if (summaryDateDom.classList.contains("Loaded")) {
                                        nowJQ.toggleClass('cur');
                                        nowJQ.parents('.record-table-item').find('.record-table-drop-panel').slideToggle();
                                    } else {
                                        summaryDateDom.classList.add("Loading");
                                        getGameOrderDetail(summaryDateDom, queryDate, function (success) {
                                            if (success) {
                                                nowJQ.toggleClass('cur');
                                                nowJQ.parents('.record-table-item').find('.record-table-drop-panel').slideToggle();
                                                summaryDateDom.classList.add("Loaded");
                                            }

                                            summaryDateDom.classList.remove("Loading");
                                        });
                                    }
                                }
                            };

                            ParentMain.prepend(RecordDom);

                        }
                        window.parent.API_CloseLoading();

                    } else {

                        window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                        window.parent.API_CloseLoading();
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("取得資料失敗"));
                    window.parent.API_CloseLoading();
                }
            } else {
                window.parent.API_CloseLoading();
            }
        });
    }

    function getGameOrderDetail(Dom, QueryDate, cb) {
        LobbyClient.GetGameOrderHistoryBySummaryDateAndGameCode(WebInfo.SID, Math.uuid(), QueryDate, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    var panel = Dom.querySelector(".GameDetailDropPanel");
                    panel.innerHTML = "";

                    if (o.DetailList.length > 0) {
                        for (var i = 0; i < o.DetailList.length; i++) {
                            var record = o.DetailList[i];
                            var RecordDom;

                            if (record.RewardValue >= 0) {
                                RecordDom = c.getTemplate("tmpGameDetail_W");
                            } else {
                                RecordDom = c.getTemplate("tmpGameDetail_L");
                            }

                            c.setClassText(RecordDom, "gameName", null, window.parent.API_GetGameLang(2, "", record.GameCode));
                            RecordDom.querySelector(".gameName").setAttribute("gameLangkey", record.GameCode);
                            RecordDom.querySelector(".gameName").classList.add("gameLangkey");

                            c.setClassText(RecordDom, "rewardValue", null, new BigNumber(record.RewardValue).toFormat());
                            c.setClassText(RecordDom, "orderValue", null, new BigNumber(record.OrderValue).toFormat());
                            c.setClassText(RecordDom, "validBet", null, new BigNumber(record.ValidBetValue).toFormat());

                            let GI_img = RecordDom.querySelector(".gameimg");
                            let GameBrand = record.GameCode.split('.')[0];
                            let GameName = record.GameCode.split('.')[1];

                            if (GameBrand == "EWin") {
                                GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + GameBrand + "/PC/" + WebInfo.Lang + "/EWinGaming.png";
                            } else {
                                GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + GameBrand + "/PC/" + WebInfo.Lang + "/" + GameName + ".png";
                            }

                            panel.appendChild(RecordDom);
                        }

                        if (cb) {
                            cb(true);
                        }
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));

                        if (cb) {
                            cb(false);
                        }
                    }

                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("取得資料失敗"));

                    if (cb) {
                        cb(false);
                    }
                }
            } else {
                if (cb) {
                    cb(false);
                }
            }
        });
    }
    //#endregion 

    //#region 出入金
    function getPreMonth_Payment() {
        window.parent.API_ShowLoading();

        let newSearchDate = new Date(search_Year_P + "/" + search_Month_P + "/01").addMonths(-1);

        search_Year_P = newSearchDate.toString("yyyy/MM/dd").split('/')[0];
        search_Month_P = newSearchDate.toString("yyyy/MM/dd").split('/')[1];

        let beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
        let endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

        updatePaymentHistory(beginDate, endDate);

    }

    function getNextMonth_Payment() {
        window.parent.API_ShowLoading();

        let newSearchDate = new Date(search_Year_P + "/" + search_Month_P + "/01").addMonths(1);

        let beginDate;
        let endDate;
        //時間超過當月
        if (Date.compare(newSearchDate, Date.parse("today")) > 0) {
            beginDate = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = Date.today().moveToLastDayOfMonth().toString("yyyy/MM/dd");

            updatePaymentHistory(beginDate, endDate);
        } else {
            beginDate = newSearchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = newSearchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

            search_Year_P = newSearchDate.toString("yyyy/MM/dd").split('/')[0];
            search_Month_P = newSearchDate.toString("yyyy/MM/dd").split('/')[1];

            updatePaymentHistory(beginDate, endDate);
        }

    }

    function updatePaymentHistory(startDate, endDate) {

        //減1小時進ewin做搜尋
        startDate = c.addHours(startDate + " 00:00", -1).format("yyyy/MM/dd");

        var ParentMain = document.getElementById("divPayment");
        var ParentMain_M = document.getElementById("divPayment_M");
        ParentMain.innerHTML = "";
        ParentMain_M.innerHTML = "";

        p.GetClosePayment(WebInfo.SID, Math.uuid(), startDate, endDate, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.Datas.length > 0) {
                        var RecordDom;
                        var RecordDom_M;
                        let Amount;

                        for (var i = 0; i < o.Datas.length; i++) {
                            var record = o.Datas[i];
                            if (record.PaymentType == 0) {
                                RecordDom = c.getTemplate("tmpPayment_D");
                                RecordDom_M = c.getTemplate("tmpPayment_M_D");
                            } else {
                                RecordDom = c.getTemplate("tmpPayment_W");
                                RecordDom_M = c.getTemplate("tmpPayment_M_W");
                            }

                            //ewin資料存GMT+8，取出後改+9看是否該資料符合搜尋區間
                            if (c.addHours(record.FinishDate, 1).format("MM") == search_Month_P) {
                                var paymentRecordText;
                                var BasicType;

                                switch (record.PaymentFlowType) {
                                    case 2:
                                        paymentRecordStatus = 2;
                                        paymentRecordText = mlp.getLanguageKey('完成');
                                        $(RecordDom_M).find('.success').show();
                                        break;
                                    case 3:
                                        paymentRecordStatus = 3;
                                        paymentRecordText = mlp.getLanguageKey('主動取消');
                                        $(RecordDom_M).find('.fail').show();
                                        break;
                                    case 4:
                                        paymentRecordStatus = 4;
                                        paymentRecordText = mlp.getLanguageKey('審核拒絕');
                                        $(RecordDom_M).find('.fail').show();
                                        break;
                                }

                                // 0=一般/1=銀行卡/2=區塊鏈
                                switch (record.BasicType) {
                                    case 0:
                                        BasicType = mlp.getLanguageKey('一般');
                                        break;
                                    case 1:
                                        BasicType = mlp.getLanguageKey('銀行卡');
                                        break;
                                    case 2:
                                        BasicType = mlp.getLanguageKey('區塊鏈');
                                        break;
                                    default:
                                }

                                if (record.PaymentType == 0) {
                                    Amount = record.Amount;
                                } else {
                                    Amount = record.Amount * -1;
                                }

                                //金額處理
                                var countDom = RecordDom.querySelector(".amount");
                                var countDom_M = RecordDom_M.querySelector(".amount");
                                if (Amount >= 0) {
                                    countDom.classList.add("positive");
                                    countDom.innerText = "+ " + new BigNumber(Math.abs(Amount)).toFormat();

                                    countDom_M.classList.add("positive");
                                    countDom_M.innerText = "+ " + new BigNumber(Math.abs(Amount)).toFormat();
                                } else {
                                    countDom.classList.add("negative");
                                    countDom.innerText = "- " + new BigNumber(Math.abs(Amount)).toFormat();

                                    countDom_M.classList.add("negative");
                                    countDom_M.innerText = "- " + new BigNumber(Math.abs(Amount)).toFormat();
                                }

                                c.setClassText(RecordDom, "PaymentStatus", null, paymentRecordText);
                                c.setClassText(RecordDom, "FinishDate", null, c.addHours(record.FinishDate, 1).format("yyyy/MM/dd hh:mm:ss"));
                                c.setClassText(RecordDom, "BasicType", null, BasicType);
                                c.setClassText(RecordDom, "PaymentSerial", null, record.PaymentSerial);

                                c.setClassText(RecordDom_M, "PaymentStatus", null, paymentRecordText);
                                c.setClassText(RecordDom_M, "FinishDate", null, c.addHours(record.FinishDate, 1).format("yyyy/MM/dd hh:mm:ss"));
                                c.setClassText(RecordDom_M, "BasicType", null, BasicType);
                                c.setClassText(RecordDom_M, "PaymentSerial", null, record.PaymentSerial);

                                RecordDom_M.querySelector(".btn-toggle").onclick = function () {
                                    var nowJQ = $(this);

                                    nowJQ.toggleClass('cur');
                                    nowJQ.parents('.record-table-item').find('.record-table-drop-panel').slideToggle();
                                };

                                $(RecordDom).find('.inputPaymentSerial').val(record.PaymentSerial);
                                $(RecordDom_M).find('.inputPaymentSerial').val(record.PaymentSerial);

                                ParentMain.appendChild(RecordDom);
                                ParentMain_M.appendChild(RecordDom_M);

                                if ($(ParentMain).length == 0) {
                                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                                }
                            }
                        }

                        window.parent.API_CloseLoading();
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                        window.parent.API_CloseLoading();
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                    window.parent.API_CloseLoading();
                }
            } else {
                // 忽略 timeout 
            }
        });
    }
    //#endregion

    function GetUserTwoMonthSummaryData() {
        LobbyClient.GetUserTwoMonthSummaryData(WebInfo.SID, Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    for (var i = 0; i < o.GameResult.length; i++) {
                        $("#Game_O_" + i).text(new BigNumber(o.GameResult[i].OrderValue).toFormat());
                        $("#Game_R_" + i).text(new BigNumber(o.GameResult[i].RewardValue).toFormat());
                    }

                    for (var j = 0; j < o.PaymentResult.length; j++) {
                        $("#Paymeny_D_" + j).text(new BigNumber(o.PaymentResult[j].DepositAmount).toFormat());
                        $("#Paymeny_W_" + j).text(new BigNumber(o.PaymentResult[j].WithdrawalAmount).toFormat());
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("取得資料失敗"));
                }
            } else {
            }
        });
    }

    function showRecord(type) {
        window.parent.API_ShowLoading();
        let searchDate;
        let beginDate;
        let endDate;

        if (type == 1) {
            $("#div_Payment").hide();
            $("#div_Game").show();

            searchDate = new Date(search_Year_G + "/" + search_Month_G + "/01");

            beginDate = searchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = searchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

            updateGameHistory(beginDate, endDate);
        } else {
            $("#div_Payment").show();
            $("#div_Game").hide();

            searchDate = new Date(search_Year_P + "/" + search_Month_P + "/01");

            beginDate = searchDate.moveToFirstDayOfMonth().toString("yyyy/MM/dd");
            endDate = searchDate.moveToLastDayOfMonth().toString("yyyy/MM/dd");

            updatePaymentHistory(beginDate, endDate);
        }
    }

    function copyText(tag) {

        var copyText = $(tag).parent().find('.inputPaymentSerial')[0];

        copyText.select();
        copyText.setSelectionRange(0, 99999);

        copyToClipboard(copyText.value).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
    }

    function copyToClipboard(textToCopy) {
        if (navigator.clipboard && window.isSecureContext) {
            return navigator.clipboard.writeText(textToCopy);
        } else {
            let textArea = document.createElement("textarea");
            textArea.value = textToCopy;
            textArea.style.position = "fixed";
            textArea.style.left = "-999999px";
            textArea.style.top = "-999999px";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            return new Promise((res, rej) => {
                document.execCommand('copy') ? res() : rej();
                textArea.remove();
            });
        }
    }

    function updateBaseInfo() {
        let now_date = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
        let beginDate;
        let endDate;

        search_Year_G = now_date.split('/')[0];
        search_Month_G = now_date.split('/')[1];
        search_Year_P = now_date.split('/')[0];
        search_Month_P = now_date.split('/')[1];

        beginDate = Date.today().moveToFirstDayOfMonth().toString("yyyy/MM/dd");
        endDate = Date.today().moveToLastDayOfMonth().toString("yyyy/MM/dd");

        updatePaymentHistory(beginDate, endDate);
        GetUserTwoMonthSummaryData();
    }

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":

                break;
            case "BalanceChange":
                break;

            case "SetLanguage":
                var lang = param;

                mlp.loadLanguage(lang);
                break;
        }
    }

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetPaymentAPI();
        LobbyClient = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            if (p != null) {
                updateBaseInfo();
            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });
    }

    window.onload = init;
</script>
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <!-- 總覽 -->
            <section class="section-record-overview section-wrap">
                <div class="container">
                    <div class="sec-title-container sec-title-prize">
                        <div class="sec-title-wrapper">
                            <h1 class="sec-title title-deco"><span class="language_replace">紀錄總覽</span></h1>
                        </div>
                    </div>
                    <div class="record-overview-wrapper">
                        <!-- 出入金總覽 -->
                        <div class="record-overview-box payment" onclick="showRecord(0)">
                            <div class="record-overview-inner">
                                <div class="record-overview-title-wrapper">
                                    <div class="title">出入金紀錄資訊</div>
                                    <%--<div class="btn btn-detail-link">詳細</div>--%>
                                </div>
                                <div class="record-overview-content">
                                    <div class="MT__table">
                                        <!-- Thead  -->
                                        <div class="Thead">
                                            <div class="thead__tr">
                                                <div class="thead__th">
                                                    <span class="title language_replace">先月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                                <div class="thead__th">
                                                    <span class="title language_replace">這個月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Tbody -->
                                        <div class="Tbody">
                                            <div class="tbody__tr">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">入金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount" id="Paymeny_D_0">0</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">入金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount" id="Paymeny_D_1">0</span>
                                                    </span>
                                                </div>

                                            </div>
                                            <div class="tbody__tr stress">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">出金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount" id="Paymeny_W_0">0</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">出金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount" id="Paymeny_W_1">0</span>
                                                    </span>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 遊戲總覽-->
                        <div class="record-overview-box game" onclick="showRecord(1)">
                            <div class="record-overview-inner">
                                <div class="record-overview-title-wrapper">
                                    <div class="title">ゴールドフロー履歴情報</div>
                                    <%--<div class="btn btn-detail-link">詳細</div>--%>
                                </div>
                                <div class="record-overview-content">
                                    <div class="MT__table">
                                        <!-- Thead  -->
                                        <div class="Thead">
                                            <div class="thead__tr">
                                                <div class="thead__th">
                                                    <span class="title language_replace">先月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                                <div class="thead__th">
                                                    <span class="title language_replace">今月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Tbody -->
                                        <div class="Tbody">
                                            <div class="tbody__tr">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">ベット</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount" id ="Game_O_0">0</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">ベット</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount" id ="Game_O_1">0</span>
                                                    </span>
                                                </div>

                                            </div>
                                            <div class="tbody__tr stress">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">勝/負</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount" id ="Game_R_0">0</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">勝/負</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount" id ="Game_R_1">0</span>
                                                    </span>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 紀錄 - Table -->
            <section class="section-wrap section-record">
                <div class="container">

                    <!-- 出入金紀錄-->
                    <section class="section-record-payment" id="div_Payment">
                        <!-- TABLE TITLE -->
                        <div class="sec-title-container sec-title-record sec-record-payment">
                            <!-- 活動中心 link-->
                            <!-- 前/後 月 -->
                            <div class="sec_link">
                                <button class="btn btn-link btn-gray" type="button" onclick="getPreMonth_Payment()">
                                    <i class="icon arrow arrow-left mr-1"></i><span
                                        class="language_replace">先月</span></button>
                                <button class="btn btn-link btn-gray" type="button" onclick="getNextMonth_Payment()">
                                    <span class="language_replace">来月︎</span><i
                                        class="icon arrow arrow-right ml-1"></i></button>
                            </div>
                            <div class="sec-title-wrapper">
                                <h1 class="sec-title title-deco"><span class="language_replace">出入金紀錄</span></h1>
                                <!-- 獎金/禮金 TAB -->
                                <div class="tab-record tab-scroller tab-2">
                                    <div class="tab-scroller__area">
                                        <ul class="tab-scroller__content">
                                            <li class="tab-item active" onclick="showRecord(0)">
                                                <span class="tab-item-link"><span class="title language_replace">出入金紀錄</span>
                                                </span>
                                            </li>
                                            <li class="tab-item" onclick="showRecord(1)">
                                                <span class="tab-item-link"><span class="title language_replace">遊戲紀錄</span></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- TABLE for Desktop -->
                        <div class="MT__table table-RWD table-payment table-desktop">
                            <!-- thead  -->
                            <div class="Thead">
                                <div class="thead__tr">
                                    <div class="thead__th"><span class="language_replace"></span></div>
                                    <div class="thead__th">
                                        <span class="language_replace">日期</span>
                                        <%--<span class="arrow arrow-down"></span>--%>
                                    </div>
                                    <div class="thead__th"><span class="language_replace">OCOIN</span><%--<span class="arrow arrow-up"></span>--%></div>
                                    <div class="thead__th"><span class="language_replace">支付方式</span><%--<span class="arrow arrow-up"></span>--%></div>
                                    <div class="thead__th"><span class="language_replace">編號</span></div>
                                    <div class="thead__th"><span class="language_replace">狀態</span></div>
                                </div>
                            </div>
                            <!-- tbody -->
                            <div class="Tbody" id="divPayment">
                            </div>
                        </div>
                        <!-- TABLE for Mobile -->
                        <div class="record-table-container table-mobile">
                            <div class="record-table payment-record">
                                <div id="divPayment_M">
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- 遊戲紀錄細詳  -->
                    <section class="section-record-game" id="div_Game" style="display: none">

                        <!-- TABLE TITLE -->
                        <div class="sec-title-container sec-title-record sec-record-games">
                            <!-- 活動中心 link-->
                            <!-- 前/後 月 -->
                            <div class="sec_link">
                                <button class="btn btn-link btn-gray" type="button" onclick="getPreMonth_Game()">
                                    <i class="icon arrow arrow-left mr-1"></i><span
                                        class="language_replace">先月</span></button>
                                <button class="btn btn-link btn-gray" type="button" onclick="getNextMonth_Game()">
                                    <span class="language_replace">来月︎</span><i
                                        class="icon arrow arrow-right ml-1"></i></button>
                            </div>
                            <div class="sec-title-wrapper">
                                <h1 class="sec-title title-deco"><span class="language_replace">遊戲紀錄</span></h1>
                                <!-- 獎金/禮金 TAB -->
                                <div class="tab-record tab-scroller tab-2">
                                    <div class="tab-scroller__area">
                                        <ul class="tab-scroller__content">
                                            <li class="tab-item " onclick="showRecord(0)">
                                                <span class="tab-item-link"><span class="title language_replace">出入金紀錄</span>
                                                </span>
                                            </li>
                                            <li class="tab-item active" onclick="showRecord(1)">
                                                <span class="tab-item-link"><span class="title language_replace">遊戲紀錄</span></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- TABLE -->
                        <div class="record-table-container">
                            <div class="record-table games-record">

                                <div class="record-table-item header">
                                    <div class="record-table-cell td-date">
                                        <span class="language_replace">日期</span>
                                    </div>
                                    <div class="record-table-cell td-gameName">
                                        <span class="language_replace">GAME</span>
                                    </div>
                                    <div class="record-table-cell td-orderValue">
                                        <span class="language_replace">投注</span>
                                    </div>
                                    <div class="record-table-cell td-validBet">
                                        <span class="language_replace">有效投注</span>
                                    </div>
                                    <div class="record-table-cell td-rewardValue">
                                        <span class="language_replace">勝/負</span>
                                    </div>
                                </div>

                                <div id="divGame">
                                </div>
                            </div>
                        </div>

                    </section>

                </div>
            </section>
        </div>
    </main>
    <footer class="footer"></footer>

    <!-- 存款 -->
    <div id="tmpPayment_D" style="display: none">
        <div class="tbody__tr deposit">
            <div class="tbody__td td-payment">
                <span class="td__content">
                    <span class="payment-status">
                        <span class="label-status deposit language_replace">預け入れ</span>
                    </span>
                </span>
            </div>
            <div class="tbody__td td-date">
                <span class="td__content">
                    <span class="date-period">
                        <%-- <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                    class="time">13:00</span>--%>
                        <span class="FinishDate"></span>
                    </span>
                </span>
            </div>
            <div class="tbody__td td-amount td-number">
                <span class="td__content"><span class="amount"></span></span>
            </div>
            <div class="tbody__td td-paymentWay">
                <span class="td__content"><span class="BasicType"></span></span>
            </div>
            <div class="tbody__td td-orderNo">
                <span class="td__content">
                    <span class="PaymentSerial"></span>
                    <input class="inputPaymentSerial is-hide" />
                    <button type="button"
                        class="btn btn-round btn-copy" onclick="copyText(this)">
                        <i class="icon icon-mask icon-copy"></i>
                    </button>
                </span>
            </div>
            <div class="tbody__td td-transesult">
                <span class="td__content"><span class="PaymentStatus"></span></span>
            </div>
        </div>
    </div>

    <!-- 出款 -->
    <div id="tmpPayment_W" style="display: none">
        <div class="tbody__tr withdraw">
            <div class="tbody__td td-payment">
                <span class="td__content">
                    <span class="payment-status">
                        <span class="label-status withdraw language_replace">引き出し</span>
                    </span>
                </span>
            </div>
            <div class="tbody__td td-date">
                <span class="td__content">
                    <span class="date-period">
                        <%-- <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                    class="time">13:00</span>--%>
                        <span class="FinishDate"></span>
                    </span>
                </span>
            </div>
            <div class="tbody__td td-amount td-number">
                <span class="td__content"><span class="amount"></span></span>
            </div>
            <div class="tbody__td td-paymentWay">
                <span class="td__content"><span class="BasicType"></span></span>
            </div>
            <div class="tbody__td td-orderNo">
                <span class="td__content">
                    <span class="PaymentSerial"></span>
                    <input class="inputPaymentSerial is-hide" />
                    <button type="button"
                        class="btn btn-round btn-copy" onclick="copyText(this)">
                        <i class="icon icon-mask icon-copy"></i>
                    </button>
                </span>
            </div>
            <div class="tbody__td td-transesult">
                <span class="td__content"><span class="PaymentStatus">成功</span></span>
            </div>
        </div>
    </div>

    <!-- 存款 手機-->
    <div id="tmpPayment_M_D" style="display: none">
        <div class="record-table-item deposit">
            <div class="record-table-tab">
                <div class="record-table-cell td-status">
                    <div class="data">
                        <span class="label-status language_replace">預け入れ</span>
                    </div>
                </div>
                <div class="record-table-cell td-amount">
                    <div class="data-amount td-number">
                        <span class="data count amount">999,999,999</span>
                        <!-- 出入金訂單狀態 -->
                        <span class="label order-status success" style="display: none"><i class="icon icon-mask icon-check"></i></span>
                        <span class="label order-status fail" style="display: none"><i class="icon icon-mask icon-error"></i></span>
                        <span class="label order-status processing" style="display: none"><i class="icon icon-mask icon-exclamation"></i></span>
                    </div>
                </div>
                <div class="record-table-cell td-paymentWay-date">
                    <div class="record-table-cell-wrapper">
                        <div class="td-paymentWay">
                            <span class="data BasicType">paypal</span>
                        </div>
                        <div class="td-date">
                            <span class="date-period">
                                <span class="FinishDate"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="record-table-cell td-toggle">
                    <div class="btn-toggle">
                        <i class="arrow arrow-down"></i>
                    </div>
                </div>
            </div>
            <!-- 下拉明細 -->
            <div class="record-table-drop-panel" style="display: none;">
                <table class="table">
                    <thead class="thead">
                        <tr class="thead-tr">
                            <th class="thead-th"><span class="title language_replace ">單號編號</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="tbody-tr">
                            <td class="tbody-td">
                                <span class="PaymentSerial"></span>
                                <input class="inputPaymentSerial is-hide" />
                                <button type="button"
                                    class="btn btn-round btn-copy" onclick="copyText(this)">
                                    <i class="icon icon-mask icon-copy"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 出款 手機-->
    <div id="tmpPayment_M_W" style="display: none">
        <div class="record-table-item withdraw">
            <div class="record-table-tab">
                <div class="record-table-cell td-status">
                    <div class="data">
                        <span class="label-status language_replace">預け入れ</span>
                    </div>
                </div>

                <div class="record-table-cell td-amount">
                    <div class="data-amount td-number">
                        <span class="data count amount">999,999,999</span>
                    </div>
                </div>
                <div class="record-table-cell td-paymentWay-date">
                    <div class="record-table-cell-wrapper">
                        <div class="td-paymentWay">
                            <span class="data BasicType">paypal</span>
                        </div>
                        <div class="td-date">
                            <span class="date-period">
                                <span class="FinishDate"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="record-table-cell td-toggle">
                    <div class="btn-toggle">
                        <i class="arrow arrow-down"></i>
                    </div>
                </div>
            </div>
            <!-- 下拉明細 -->
            <div class="record-table-drop-panel" style="display: none;">
                <table class="table">
                    <thead class="thead">
                        <tr class="thead-tr">
                            <th class="thead-th"><span class="title language_replace">單號編號</span></th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr class="tbody-tr">
                            <td class="tbody-td">
                                <span class="PaymentSerial"></span>
                                <input class="inputPaymentSerial is-hide" />
                                <button type="button"
                                    class="btn btn-round btn-copy" onclick="copyText(this)">
                                    <i class="icon icon-mask icon-copy"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 贏 -->
    <div id="tmpGame_W" style="display: none">
        <div class="record-table-item win">
            <%--show--%>
            <div class="record-table-tab">
                <div class="record-table-cell td-status">
                    <div class="data">
                        <span class="label-status deposit language_replace">贏</span>
                    </div>
                </div>

                <div class="record-table-wrapper">
                    <!-- 日期 -->
                    <div class="record-table-cell td-date">
                        <span class="date-period">
                            <%-- <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                    class="time">13:00</span>--%>
                            <span class="SummaryDate"></span>
                        </span>
                    </div>
                    <!-- 投注 -->
                    <div class="record-table-cell td-orderValue">
                        <span class="title language_replace">ベット</span>
                        <span class="data number orderValue">995</span>
                    </div>
                    <!-- 有效投注 -->
                    <div class="record-table-cell td-validBet">
                        <span class="title language_replace">実際ベット</span>
                        <span class="data number validBet">50090</span>
                    </div>
                    <!-- 勝/負 -->
                    <div class="record-table-cell td-rewardValue">
                        <span class="data number rewardValue">+50000</span>
                    </div>
                </div>
                <div class="record-table-cell td-toggle">
                    <div class="btn-toggle">
                        <i class="arrow arrow-down"></i>
                    </div>
                </div>
            </div>
            <!-- 下拉明細 -->
            <div class="record-table-drop-panel" style="display: none">
                <!-- 下拉明細 Header---->
                <div class="record-drop-item header">
                    <div class="record-table-cell cell-gameName">
                        <span class="language_replace">GAME</span>
                    </div>
                    <div class="record-table-cell cell-orderValue">
                        <span class="language_replace">投注</span>
                    </div>
                    <div class="record-table-cell cell-validBet">
                        <span class="language_replace">有效投注</span>
                    </div>
                    <div class="record-table-cell cell-rewardValue">
                        <span class="language_replace">勝/負</span>
                    </div>
                </div>
                <div class="GameDetailDropPanel">
                </div>
            </div>
        </div>
    </div>

    <!-- 輸 -->
    <div id="tmpGame_L" style="display: none">
        <div class="record-table-item lose ">
            <div class="record-table-tab">
                <div class="record-table-cell td-status">
                    <div class="data">
                        <span class="label-status deposit language_replace">輸</span>
                    </div>
                </div>

                <div class="record-table-wrapper">
                    <!-- 日期 -->
                    <div class="record-table-cell td-date">
                        <span class="date-period">
                            <%-- <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                    class="time">13:00</span>--%>
                            <span class="SummaryDate"></span>
                        </span>
                    </div>
                    <!-- 投注 -->
                    <div class="record-table-cell td-orderValue">
                        <span class="title language_replace">ベット</span>
                        <span class="data number orderValue">995</span>
                    </div>
                    <!-- 有效投注 -->
                    <div class="record-table-cell td-validBet">
                        <span class="title language_replace">実際ベット</span>
                        <span class="data number validBet">50090</span>
                    </div>
                    <!-- 勝/負 -->
                    <div class="record-table-cell td-rewardValue">
                        <span class="data number rewardValue">+50000</span>
                    </div>
                </div>
                <div class="record-table-cell td-toggle">
                    <div class="btn-toggle">
                        <i class="arrow arrow-down"></i>
                    </div>
                </div>
            </div>
            <!-- 下拉明細 -->
            <div class="record-table-drop-panel" style="display: none">
                <!-- 下拉明細 Header---->
                <div class="record-drop-item header">
                    <div class="record-table-cell cell-gameName">
                        <span class="language_replace">GAME</span>
                    </div>
                    <div class="record-table-cell cell-orderValue">
                        <span class="language_replace orderValue">投注</span>
                    </div>
                    <div class="record-table-cell cell-validBet">
                        <span class="language_replace validBet">有效投注</span>
                    </div>
                    <div class="record-table-cell cell-rewardValue">
                        <span class="language_replace rewardValue">勝/負</span>
                    </div>
                </div>
                <div class="GameDetailDropPanel">
                </div>
            </div>
        </div>
    </div>

    <!-- 下拉明細 Item : 贏---->
    <div id="tmpGameDetail_W" style="display: none">
        <div class="record-drop-item win">
            <div class="record-drop-item-inner">
                <div class="record-drop-item-img record-item">
                    <div class="img-wrap">
                        <img class="gameimg" src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/126.png">
                    </div>
                </div>
                <div class="record-drop-item-rewardValue record-item">
                    <span class="data number rewardValue">+999</span>
                </div>
                <div class="record-drop-item-wrapper">
                    <div class="record-drop-item-gameName record-item">
                        <span class="data language_replace gameName">火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試</span>
                    </div>
                    <div class="record-drop-item-orderValue record-item">
                        <span class="title language_replace">ベット</span>
                        <span class="data number orderValue">9999</span>
                    </div>
                    <div class="record-drop-item-validBet record-item">
                        <span class="title language_replace">実際ベット</span>
                        <span class="data number  validBet">9,99999</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 下拉明細 Item : 輸---->
    <div id="tmpGameDetail_L" style="display: none">
        <div class="record-drop-item lose">
            <div class="record-drop-item-inner">
                <div class="record-drop-item-img record-item">
                    <div class="img-wrap">
                        <img class="gameimg" src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/126.png">
                    </div>
                </div>
                <div class="record-drop-item-rewardValue record-item">
                    <span class="data number rewardValue">+999</span>
                </div>
                <div class="record-drop-item-wrapper">
                    <div class="record-drop-item-gameName record-item">
                        <span class="data language_replace gameName">火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試</span>
                    </div>
                    <div class="record-drop-item-orderValue record-item">
                        <span class="title language_replace">ベット</span>
                        <span class="data number orderValue">999</span>
                    </div>
                    <div class="record-drop-item-validBet record-item">
                        <span class="title language_replace">実際ベット</span>
                        <span class="data number validBet">9,99999</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

</html>
