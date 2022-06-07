<%@ Page Language="C#" %>

<% string Version = EWinWeb.Version; %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <%--    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="Scripts/OutSrc/lib/swiper/css/swiper-bundle.min.css" type="text/css" />

    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/member.css" type="text/css" />
    <link rel="stylesheet" href="css/main.css" />--%>

    <link href="css/basic.min.css" rel="stylesheet" />
    <link href="Scripts/vendor/swiper/css/swiper-bundle.min.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <link href="css/member.css" rel="stylesheet" />

</head>
<script src="Scripts/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script src="Scripts/OutSrc/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/vendor/swiper/js/swiper-bundle.min.js"></script>
<script>

    if (self != top) {
        window.parent.API_LoadingStart();
    }

    var WebInfo;
    var p;
    var lang;
    var BackCardInfo = null;
    var v = "<%:Version%>";
    var swiper;

    function copyText(tag) {
        var copyText = document.getElementById(tag);
        copyText.select();
        copyText.setSelectionRange(0, 99999);

        copyToClipboard(copyText.textContent)
            .then(() => window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")))
            .catch(() => window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")));
    }

    function copyToClipboard(textToCopy) {
        // navigator clipboard api needs a secure context (https)
        if (navigator.clipboard && window.isSecureContext) {
            // navigator clipboard api method'
            return navigator.clipboard.writeText(textToCopy);
        } else {
            // text area method
            let textArea = document.createElement("textarea");
            textArea.value = textToCopy;
            // make the textarea out of viewport
            textArea.style.position = "fixed";
            textArea.style.left = "-999999px";
            textArea.style.top = "-999999px";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            return new Promise((res, rej) => {
                // here the magic happens
                document.execCommand('copy') ? res() : rej();
                textArea.remove();
            });
        }
    }

    function updateBaseInfo() {
        $("#RealName").val(WebInfo.UserInfo.RealName);
        $("#Email").val(WebInfo.UserInfo.EMail == undefined ? "" : WebInfo.UserInfo.EMail);
        $("#PhoneNumber").val(WebInfo.UserInfo.ContactPhonePrefix + " " + WebInfo.UserInfo.ContactPhoneNumber);
        if (WebInfo.UserInfo.ExtraData) {
            var ExtraData = JSON.parse(WebInfo.UserInfo.ExtraData);
            for (var i = 0; i < ExtraData.length; i++) {
                if (ExtraData[i].Name == "Birthday") {
                    var Birthdays = ExtraData[i].Value.split('/');
                    $("#idBornYear").val(Birthdays[0]);
                    $("#idBornMonth").val(Birthdays[1]);
                    $("#idBornDay").val(Birthdays[2]);
                }

                if (ExtraData[i].Name == "UserGetMail") {
                    $("#check_UserGetMail").prop("checked", ExtraData[i].Value);
                }
            }
        }
        $("#Address").val(WebInfo.UserInfo.ContactAddress == undefined ? "" : WebInfo.UserInfo.ContactAddress);
        //$("#idAmount").text(new BigNumber(WebInfo.UserInfo.WalletList.find(x => x.CurrencyType == window.parent.API_GetCurrency()).PointValue).toFormat());

        let wallet = WebInfo.UserInfo.WalletList.find(x => x.CurrencyType.toLocaleUpperCase() == WebInfo.MainCurrencyType);
        $("#idAmount").text(parseInt(wallet.PointValue));
        $("#PersonCode").text(WebInfo.UserInfo.PersonCode);
        $("#idCopyPersonCode").text(WebInfo.UserInfo.PersonCode);
        $('#QRCodeimg').attr("src", `/GetQRCode.aspx?QRCode=${"/**************************/"}/registerForQrCode.aspx?P=${WebInfo.UserInfo.PersonCode}&Download=2`);

        var ThresholdInfos = WebInfo.UserInfo.ThresholdInfo;
        if (ThresholdInfos && ThresholdInfos.length > 0) {
            let thresholdInfo = ThresholdInfos.find(x => x.CurrencyType.toLocaleUpperCase() == WebInfo.MainCurrencyType);
            if (thresholdInfo) {

                if (new BigNumber(thresholdInfo.ThresholdValue).toFormat() == "0") {
                    $("#divThrehold").addClass("enough");
                    $("#divThrehold").removeClass("lacking");
                } else {
                    $("#divThrehold").removeClass("enough");
                    $("#divThrehold").addClass("lacking");
                }

                $("#idThrehold").text(new BigNumber(thresholdInfo.ThresholdValue).toFormat());
            } else {
                $("#idThrehold").text("0");
                $("#divThrehold").addClass("enough");
                $("#divThrehold").removeClass("lacking");
            }
        } else {
            $("#idThrehold").text("0");
            $("#divThrehold").addClass("enough");
            $("#divThrehold").removeClass("lacking");
        }
    }

    function memberInit() {

    }

    function updateUserAccountRemoveReadOnly() {
        $('#idBornYear').removeAttr("readonly");
        $('#idBornMonth').removeAttr("readonly");
        $('#idBornDay').removeAttr("readonly");
        $('#Email').removeAttr("readonly");
        $('.data-item.password').show();
        $('#updateUserAccountRemoveReadOnlyBtn').addClass('is-hide');
        $('#updateUserAccountBtn').removeClass('is-hide');

    }

    function updateUserAccount() {

        let ExtraData = WebInfo.UserInfo.ExtraData ? JSON.parse(WebInfo.UserInfo.ExtraData) : [];
        let strExtraData = "";
        let strEmail = "";
        let strOldPassword = "";
        let strNewPassword = "";

        if ($("#idBornYear").val() != "" && $("#idBornMonth").val() != "" && $("#idBornDay").val() != "") {
            if (ExtraData.length != 0 && ExtraData.filter(x => x.Name == "Birthday").length > 0) {

                let findBirthday = ExtraData.filter(x => x.Name == "Birthday").length;
                if (findBirthday == 0) {
                    var data_Birthday = {
                        "Name": "Birthday",
                        "Value": $("#idBornYear").val() + "/" + $("#idBornMonth").val() + "/" + $("#idBornDay").val()
                    }

                    ExtraData.push(data_Birthday);
                }
                else {
                    for (var i = 0; i < ExtraData.length; i++) {
                        if (ExtraData[i].Name == "Birthday") {
                            ExtraData[i].Value = $("#idBornYear").val() + "/" + $("#idBornMonth").val() + "/" + $("#idBornDay").val();
                        }
                    }
                }
            } else {
                var data_Birthday = {
                    "Name": "Birthday",
                    "Value": $("#idBornYear").val() + "/" + $("#idBornMonth").val() + "/" + $("#idBornDay").val()
                }

                ExtraData.push(data_Birthday);
            }
        }
        if (ExtraData.length != 0 && ExtraData.filter(x => x.Name == "UserGetMail").length > 0) {
            for (var i = 0; i < ExtraData.length; i++) {
                if (ExtraData[i].Name == "UserGetMail") {
                    ExtraData[i].Value = $("#check_UserGetMail").prop("checked");
                }
            }
        } else {
            var data_UserGetMail = {
                "Name": "UserGetMail",
                "Value": $("#check_UserGetMail").prop("checked")
            }

            ExtraData.push(data_UserGetMail);
        }

        strExtraData = JSON.stringify(ExtraData);

        if ($("#Email").val() != "") {
            strEmail = $("#Email").val();
        }

        if ($("#idOldPassword").val() != "") {
            strOldPassword = $("#idOldPassword").val().trim();
        }

        if ($("#idNewPassword").val() != "") {
            strNewPassword = $("#idNewPassword").val().trim();
        }

        var updateinfo = {
            "EMail": strEmail,
            "ExtraData": strExtraData,
            "OldPassword": strOldPassword,
            "NewPassword": strNewPassword
        }

        p.UpdateUserAccount(WebInfo.SID, Math.uuid(), updateinfo, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    $('#idBornYear').attr("readonly", "readonly");
                    $('#idBornMonth').attr("readonly", "readonly");
                    $('#idBornDay').attr("readonly", "readonly");
                    $('#Email').attr("readonly", "readonly");
                    $('.data-item.password').hide();
                    $('#updateUserAccountRemoveReadOnlyBtn').removeClass('is-hide');
                    $('#updateUserAccountBtn').addClass('is-hide');
                    window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("成功"), function () {

                        window.top.API_RefreshUserInfo(function () {
                        });
                    });
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout") {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新嘗試"));
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), o);
                }
            }
        });

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

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            if (p != null)
                updateBaseInfo();
            else
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
        });

        memberInit();
        //changeAvatar(getCookie("selectAvatar"));

        $("#activityURL").attr("href", "https://casino-maharaja.net/lp/01/" + WebInfo.UserInfo.PersonCode);
        $("#activityURL1").attr("href", "https://casino-maharaja.net/lp/02/" + WebInfo.UserInfo.PersonCode);

        if (!WebInfo.UserInfo.IsWalletPasswordSet) {
            //document.getElementById('idWalletPasswordUnSet').style.display = "block";
        }
    }

    function copyActivityUrl() {

        navigator.clipboard.writeText("https://casino-maharaja.net/lp/01/" + WebInfo.UserInfo.PersonCode).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
        //alert("Copied the text: " + copyText.value);
    }

    function copyActivityUrl1() {

        navigator.clipboard.writeText("https://casino-maharaja.net/lp/02/" + WebInfo.UserInfo.PersonCode).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
        //alert("Copied the text: " + copyText.value);
    }

    window.onload = init;
</script>
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <div class="container">
                <article class="article-member-center">
                    <!-- 個人資料 -->
                    <section class="section-member-profile">
                        <div class="member-profile-avater-wrapper">
                            <span class="avater">
                                <span class="avater-img">
                                    <img src="images/avatar/avater-2.png" alt="">
                                </span>
                                <%--<button type="button" class="btn btn-round btn-full-main btn-exchange-avater" data-toggle="modal" data-target="#ModalAvatar">
                                    <i class="icon icon-mask icon-camera "></i>
                                </button>--%>
                            </span>
                        </div>
                        <div class="member-profile-data-wrapper dataList">
                            <fieldset class="dataFieldset">
                                <legend class="sec-title-container sec-title-member">
                                    <div class="sec-title-wrapper">
                                        <h1 class="sec-title title-deco"><span class="language_replace">會員中心</span></h1>
                                    </div>
                                    <!-- 資料更新 Button-->
                                    <button id="updateUserAccountRemoveReadOnlyBtn" type="button" class="btn btn-edit btn-full-main" onclick="updateUserAccountRemoveReadOnly()"><i class="icon icon-mask icon-pencile"></i></button>
                                </legend>

                                <!-- 當點擊 資料更新 Button時 text input可編輯的項目 會移除 readonly-->
                                <div class="dataFieldset-content row no-gutters">
                                    <div class="data-item name" style="width: 50%">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-people"></i>
                                                <span class="title-name language_replace">姓名</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" class="custom-input-edit" id="RealName" value="" readonly>
                                        </div>
                                    </div>
                                    <div class="data-item password" style="width: 50%; display: none;">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-lock-closed"></i>
                                                <span class="title-name language_replace">舊密碼</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="password" class="custom-input-edit" id="idOldPassword" value="">
                                        </div>
                                    </div>
                                    <div class="data-item birth" style="width: 50%">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-people"></i>
                                                <span class="title-name language_replace">出生年月日</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" style="width: 30%" class="custom-input-edit" id="idBornYear" value="" readonly>
                                            <input type="text" style="width: 30%" class="custom-input-edit" id="idBornMonth" value="" readonly>
                                            <input type="text" style="width: 30%" class="custom-input-edit" id="idBornDay" value="" readonly>
                                        </div>
                                    </div>
                                    <div class="data-item password" style="width: 50%; display: none;">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-lock-closed"></i>
                                                <span class="title-name language_replace">新密碼</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="password" class="custom-input-edit" id="idNewPassword" value="">
                                        </div>
                                    </div>
                                    <div class="data-item mobile">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-mobile"></i>
                                                <span class="title-name language_replace">手機號碼</span>
                                            </label>
                                            <%--<div class="labels labels-status">
                                                <span class="label language_replace update">更新</span>
                                                <span class="label language_replace validated">認證</span>
                                                <span class="label language_replace unvalidated">未認證</span>
                                            </div>--%>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" class="custom-input-edit" id="PhoneNumber" value="" readonly>
                                        </div>
                                    </div>
                                    <div class="data-item email" style="width: 100%">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-mail"></i>
                                                <span class="title-name language_replace">E-mail</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" class="custom-input-edit" id="Email" value="" readonly>
                                        </div>
                                    </div>
                                    <div class="data-item-group">
                                        <div class="data-item home" id="divAddress">
                                            <div class="data-item-title">
                                                <label class="title">
                                                    <i class="icon icon-mask icon-location"></i>
                                                    <span class="title-name language_replace">地址</span>
                                                </label>
                                            </div>
                                            <div class="data-item-content">
                                                <input type="text" class="custom-input-edit" id="Address" value="" readonly>
                                            </div>
                                        </div>
                                        <div class="data-item news">
                                            <div class="data-item-title">
                                                <label class="title">
                                                    <i class="icon icon-mask icon-flag"></i>
                                                    <span class="title-name language_replace">訊息通知</span>
                                                </label>
                                            </div>
                                            <div class="data-item-content">
                                                <div class="custom-control custom-checkboxValue custom-control-inline">
                                                    <label class="custom-label">
                                                        <input type="checkbox" class="custom-control-input-hidden" checked="checked" id="check_UserGetMail">
                                                        <div class="custom-input checkbox"><span class="language_replace">接收最新資訊</span></div>
                                                    </label>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="wrapper_center">
                                            <button id="updateUserAccountBtn" onclick="updateUserAccount()" type="button" class="btn btn-confirm btn-full-stress-2 is-hide"><span class="language_replace">確認</span></button>
                                        </div>
                                        <div class="data-item qrcode">
                                            <div class="data-item-title">
                                                <label class="title">
                                                    <i class="icon icon-mask icon-qrocde"></i>
                                                    <span class="title-name language_replace">推薦碼</span>
                                                </label>
                                            </div>
                                            <div class="data-item-content">
                                                <div class="member-profile-QRcode">
                                                    <div class="qrcode-img">
                                                        <span class="img">
                                                            <img id="QRCodeimg" src="" alt="">
                                                        </span>
                                                    </div>
                                                    <div class="qrcode-number">
                                                        <span class="number" id="PersonCode"></span>
                                                        <input id="idCopyPersonCode" class="is-hide">

                                                        <button type="button" class="btn btn-transparent btn-exchange-avater">
                                                            <i class="icon icon-mask icon-copy" onclick="copyText('idCopyPersonCode')"></i>

                                                        </button>

                                                    </div>

                                                </div>


                                            </div>
                                        </div>

                                        <div class="activity-container">
                                            <div class="activity-inner">
                                                <h5 class="subject-title language_replace">熱門活動</h5>
                                                <div class="text-wrap promo-container">
                                                    <ul class="promo-list row">
                                                        <li class="item col-12 col-sm-6 col-md-4 col-xl-3">
                                                            <div class="promo-inner">
                                                                <div class="promo-img">
                                                                    <a id="activityURL1" href="https://www.casino-maharaja.net/lp/02/N00000000"
                                                                        target="_blank">
                                                                        <div class="img-crop">
                                                                            <img src="images/activity/promo-02.jpg"
                                                                                alt="パチンコって何？それっておいしいの？">
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                                <div class="promo-content">
                                                                    <h6 class="title">お客様活用、紹介ランディングページその②（パチンコ好き）</h6>
                                                                    <button type="button" class="btn btn-outline-primary btn-link" onclick="copyActivityUrl1()">
                                                                        <span class="language_replace">複製活動連結</span>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li class="item col-12 col-sm-6 col-md-4 col-xl-3">
                                                            <div class="promo-inner">
                                                                <div class="promo-img">
                                                                    <a id="activityURL" href="https://casino-maharaja.net/lp/01/N00000000"
                                                                        target="_blank">
                                                                        <div class="img-crop">
                                                                            <img src="images/activity/promo-01.jpg"
                                                                                alt="とりあえず、当社のドメインで紹介用LPをアップしてみました。">
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                                <div class="promo-content">
                                                                    <h6 class="title">お客様活用、紹介ランディングページその①（主婦）</h6>
                                                                    <button type="button" class="btn btn-outline-primary btn-link" onclick="copyActivityUrl()">
                                                                        <span class="language_replace">複製活動連結</span>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </section>

                    <!-- 會員簽到進度顯示 + 活動中心 -->
                    <section class="section-member-activity">

                        <!-- 會員簽到進度顯示 -->
                        <div class="activity-dailylogin-wrapper">
                            <div class="dailylogin-bouns-wrapper coming-soon">
                                <div class="dailylogin-bouns-inner">
                                    <div class="dailylogin-bouns-content">
                                        <h3 class="title">
                                            <span class="name ">金曜日的禮物</span></h3>
                                        <ul class="dailylogin-bouns-list">
                                            <!-- 已領取 bouns => got-->
                                            <li class="bouns-item got">
                                                <span class="day"><span class="language_replace">金</span></span></li>
                                            <li class="bouns-item saturday">
                                                <span class="day"><span class="language_replace">土</span></span>
                                            </li>
                                            <li class="bouns-item sunday">
                                                <span class="day"><span class="language_replace">日</span></span></li>
                                            <li class="bouns-item">
                                                <span class="day"><span class="language_replace">月</span></span>
                                            </li>
                                            <li class="bouns-item">
                                                <span class="day"><span class="language_replace">火</span></span></li>
                                            <li class="bouns-item">
                                                <span class="day"><span class="language_replace">水</span></span>
                                            </li>
                                            <li class="bouns-item">
                                                <span class="day"><span class="language_replace">木</span></span>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 活動中心 -->
                        <div class="activity-center-wrapper" onclick="window.top.API_LoadPage('','ActivityCenter.aspx')">
                            <div class="activity-center-inner">
                                <div class="title">活動中心</div>
                            </div>
                        </div>

                    </section>


                    <!-- 會員錢包中心 - 入金 + 履歷紀錄 / 出金 -->
                    <section class="section-member-wallet-transaction">
                        <div class="member-wallet-deposit-wrapper">
                            <!-- 錢包中心 -->
                            <div class="member-wallet-wrapper">
                                <div class="member-wallet-inner">
                                    <div class="member-wallet-contnet">
                                        <h3 class="member-wallet-title">ウォレット</h3>
                                        <div class="member-wallet-amount">
                                            <span class="unit">Ocoin</span>
                                            <div class="member-deposit">
                                                <span class="amount" id="idAmount">999,999,999</span>
                                                <!-- 入金 Button -->
                                                <span class="btn btn-deposit btn-full-stress btn-round" onclick="window.top.API_LoadPage('Deposit','Deposit.aspx', true)"><i class="icon icon-add"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 履歷紀錄 -->
                                    <div class="member-record-wrapper">
                                        <div class="btn" onclick="window.top.API_LoadPage('record','record.aspx', true)">
                                            <div class="member-record-title">
                                                <i class="icon icon-mask icon-list-time"></i>
                                                <h3 class="title language_replace">履歷一覧</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 出金門檻: class判斷=> 不足:lacking  足夠:enough-->
                        <div class="member-withdraw-wrapper lacking" id="divThrehold">
                            <div class="member-withdraw-limit-wrapper">
                                <div class="member-withdraw-limit-inner ">
                                    <i class="icon icon-mask icon-lock"></i>
                                    <span class="member-withdraw-limit-content">
                                        <!-- 出金門檻 不足-->
                                        <span class="title lacking">出金不可</span>
                                        <!-- 出金門檻 足夠-->
                                        <span class="title enough">出金可</span>
                                        <!-- 出入金說明 -->
                                        <span class="btn btn-QA-transaction btn-full-stress btn-round"><i class="icon icon-mask icon-question"></i></span>
                                        <!-- 出金門檻 -->
                                        <span class="limit-amount" id="idThrehold"></span>
                                    </span>

                                </div>


                            </div>


                        </div>
                    </section>
                </article>
            </div>
        </div>
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
</body>
</html>
