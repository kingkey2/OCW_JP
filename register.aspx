﻿<%@ Page Language="C#" %>

<%
    string PCode = Request["PCode"];
    string Version = EWinWeb.Version;
    string DefaultPersonCode = string.Empty;

    if (EWinWeb.IsTestSite) { // 測試機
        DefaultPersonCode = "A43015788512541";
    } else { // 正式機
        DefaultPersonCode = "N78316595789476";
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />
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
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="Scripts/OutSrc/js/script.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/libphonenumber.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script>      
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var c = new common();
    var pCode = "<%=PCode%>";
    var DefaultPersonCode = "<%=DefaultPersonCode%>";
    var WebInfo;
    var p;
    var mlp;
    var lang;
    var PhoneNumberUtil = libphonenumber.PhoneNumberUtil.getInstance();
    var v ="<%:Version%>";
    var isSent = false;
    var isSent_Phone = false;
    var LoginAccount;

    function BackHome() {
        window.parent.API_Home();
    }

    function startCountDown(duration) {
        isSent = true;
        let secondsRemaining = duration;
        let min = 0;
        let sec = 0;

        let countInterval = setInterval(function () {
            let BtnSend = document.getElementById("divSendValidateCodeBtn");

            //min = parseInt(secondsRemaining / 60);
            //sec = parseInt(secondsRemaining % 60);
            BtnSend.querySelector("span").innerText = secondsRemaining + "s"

            secondsRemaining = secondsRemaining - 1;
            if (secondsRemaining < 0) {
                clearInterval(countInterval);
                SetBtnSend();
            };

        }, 1000);
    }

    function startCountDown_Phone(duration) {
        isSent_Phone = true;
        let secondsRemaining = duration;

        let countInterval = setInterval(function () {
            let BtnSend = document.getElementById("divSendValidateCodeBtn_Phone");
            
            BtnSend.querySelector("span").innerText = secondsRemaining + "s"

            secondsRemaining = secondsRemaining - 1;
            if (secondsRemaining < 0) {
                clearInterval(countInterval);
                SetBtnSend_Phone();
            };

        }, 1000);
    }

    function CheckMailExist(cb) {
        var idLoginAccount = document.getElementById("idLoginAccount");

        if (idLoginAccount.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入信箱"));
            cb(false);
            return;
        } else if (idLoginAccount.value.indexOf('+') > 0) {
            window.parent.showMessageOK("", mlp.getLanguageKey("不得包含+"));
            cb(false);
            return;
        } else {
            if (!IsEmail(idLoginAccount.value)) {
                window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確信箱"));
                cb(false);
                return;
            }
        }

        p.CheckAccountExist(Math.uuid(), idLoginAccount.value, function (success, o) {
            if (success) {
                if (o.Result != 0) {
                    cb(true);
                } else {
                    cb(false);
                    window.parent.showMessageOK("", mlp.getLanguageKey("信箱已存在"));
                }
            }

        });
    }

    function CheckPhoneExist(cb) {
        var PhonePrefix = document.getElementById("idPhonePrefix").value;
        var PhoneNumber = document.getElementById("idPhoneNumber").value;

        if (PhonePrefix.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入國碼"));
            cb(false);
            return;
        } else if (PhoneNumber.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確電話"));
            cb(false);
            return;
        } else {
            var phoneValue = idPhonePrefix.value + idPhoneNumber.value;
            var phoneObj;

            try {
                phoneObj = PhoneNumberUtil.parse(phoneValue);

                var type = PhoneNumberUtil.getNumberType(phoneObj);

                if (type != libphonenumber.PhoneNumberType.MOBILE && type != libphonenumber.PhoneNumberType.FIXED_LINE_OR_MOBILE) {
                    window.parent.showMessageOK("", mlp.getLanguageKey("電話格式有誤"));
                    cb(false);
                    return;
                }
            } catch (e) {

                window.parent.showMessageOK("", mlp.getLanguageKey("電話格式有誤"));

                cb(false);
                return;
            }
        }

        p.CheckAccountExistEx(Math.uuid(), "", idPhonePrefix.value, idPhoneNumber.value, "", function (success, o) {
            if (success) {
                if (o.Result != 0) {
                    cb(true);
                } else {
                    cb(false);
                    window.parent.showMessageOK("", mlp.getLanguageKey("電話已存在"));
                }
            }

        });
    }

    function CheckUserAccountExist(cb) {
        var idLoginAccount = document.getElementById("idLoginAccount");

        if (idLoginAccount.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入信箱"));
            return false;
        } else {
            if (!IsEmail(idLoginAccount.value)) {
                window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確信箱"));
                return false;
            }
        }
        return true;
    }

    function CheckPassword() {
        var idLoginPassword = document.getElementById("idLoginPassword");
        var idLoginCheckPassword = document.getElementById("idLoginCheckPassword");
        var rules = new RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,20}$');

        if (idLoginPassword.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入登入密碼"));
            return false;
        } else if (idLoginPassword.value.length < 6) {
            window.parent.showMessageOK("", mlp.getLanguageKey("登入密碼需大於6位"));
            return false;
        } else if (idLoginPassword.value.length > 20) {
            window.parent.showMessageOK("", mlp.getLanguageKey("登入密碼需小於20位"));
            return false;
        } else if (!rules.test(idLoginPassword.value)) {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入半形的英文大小寫/數字，至少要有一個英文大寫與英文小寫與數字"));
            return false;
        } else if (idLoginPassword.value.trim() != idLoginCheckPassword.value.trim()) {
            window.parent.showMessageOK("", mlp.getLanguageKey("確認密碼與登入密碼不符"));
            return false;
        }

        return true;
    }

    function onBtnSendValidateCode() {
        if (isSent == false) {
            CheckMailExist(function (check) {
                if (check) {
                    window.top.API_LoadingStart();
                    p.SetUserMail(Math.uuid(), 0, 0, $("#idLoginAccount").val(), $("#idPhonePrefix").val(), $("#idPhoneNumber").val(), "", function (success, o) {
                        window.top.API_LoadingEnd(1);
                        if (success) {
                            if (o.Result != 0) {
                                window.parent.showMessageOK("", mlp.getLanguageKey("發送驗證碼失敗"));
                            } else {
                                window.parent.showMessageOK("", mlp.getLanguageKey("發送驗證碼成功"));

                                startCountDown(120);
                            }
                        }
                    });
                } else {
                    
                }
            });
        } else {
            window.parent.showMessageOK("", mlp.getLanguageKey("已發送驗證碼，短時間內請勿重複發送"));
        }
    }

    function onBtnSendValidateCode_Phone() {
        if (isSent_Phone == false) {
            CheckPhoneExist(function (check) {
                if (check) {
                    window.top.API_LoadingStart();
                    p.SetUserMail(Math.uuid(), 1, 0, $("#idLoginAccount").val(), $("#idPhonePrefix").val(), $("#idPhoneNumber").val(), "", function (success, o) {
                        window.top.API_LoadingEnd(1);
                        if (success) {
                            if (o.Result != 0) {
                                window.parent.showMessageOK("", mlp.getLanguageKey("發送驗證碼失敗"));
                            } else {
                                window.parent.showMessageOK("", mlp.getLanguageKey("發送簡訊驗證碼成功"));

                                startCountDown_Phone(120);
                            }
                        }
                    });
                } else {
                    
                }
            });
        } else {
            window.parent.showMessageOK("", mlp.getLanguageKey("已發送驗證碼，短時間內請勿重複發送"));
        }
    }

    function SetBtnSend() {
        let BtnSend = document.getElementById("divSendValidateCodeBtn");
        BtnSend.querySelector("span").innerText = mlp.getLanguageKey("傳送驗證碼");
        isSent = false;
    }

    function SetBtnSend_Phone() {
        let BtnSend = document.getElementById("divSendValidateCodeBtn_Phone");
        BtnSend.querySelector("span").innerText = mlp.getLanguageKey("傳送驗證碼");
        isSent_Phone = false;
    }

    function onBtnUserRegisterStep1() {
        if ($("#idValidateCode").val() == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入驗證碼"));
        } else {
            p.CheckValidateCode(Math.uuid(), 0, $("#idLoginAccount").val(), "", "", $("#idValidateCode").val(), function (success, o) {
                if (success) {
                    if (o.Result != 0) {
                        window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確驗證碼"));
                    } else {
                        onBtnUserRegisterStep2();
                    }
                } else {
                    window.parent.showMessageOK("", mlp.getLanguageKey("驗證碼錯誤"));
                }
            });
        }
    }

    function onBtnUserRegisterStep2() {
        //完整註冊
        if ($("#li_register2").hasClass("active")) {
            FullRegistrationCreateUser();
        } else {
            SimpleRegistrationCreateUser();
        }
    }

     //完整註冊
    function FullRegistrationCreateUser() {

        if ($("#idValidateCode_Phone").val() == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入驗證碼"));
        } else {
            p.CheckValidateCode(Math.uuid(), 1, "", $("#idPhonePrefix").val(), $("#idPhoneNumber").val(), $("#idValidateCode_Phone").val(), function (success, o) {
                if (success) {
                    if (o.Result != 0) {
                        window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確驗證碼"));
                    } else {
                        var form2 = document.getElementById("registerStep2");
                        var CurrencyList = WebInfo.RegisterCurrencyType;

                        let nowYear = new Date().getFullYear();

                        if (form2.Name1.value == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入姓"));
                            return;
                        } else if (form2.Name2.value == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入名"));
                            return;
                        } else if (form2.BornYear.value.length != 4) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確年分"));
                            return;
                        } else if (parseInt(form2.BornYear.value) < 1900) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確年分"));
                            return;
                        } else if (parseInt(form2.BornYear.value) > nowYear) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確年分"));
                            return;
                        } else if (form2.PhonePrefix.value == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入國碼"));
                            return;
                        } else if (form2.PhoneNumber.value == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確電話"));
                            return;
                        } else if (form2.ValidateCode_Phone.value == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入驗證碼"));
                            return;
                        }

                        if ($("#NickName").val() == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入暱稱"));
                            return;
                        }

                        if (!$("#CheckAge").prop("checked")) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請確認已年滿20歲"));
                            return;
                        }
                        var LoginAccount = document.getElementById("idLoginAccount").value;
                        var LoginPassword = document.getElementById("idLoginPassword").value;
                        var ParentPersonCode = $("#PersonCode").val();
                        var PhonePrefix = document.getElementById("idPhonePrefix").value;
                        var PhoneNumber = document.getElementById("idPhoneNumber").value;
                        var PS;

                        if (typeof (ParentPersonCode) == "string") {
                            ParentPersonCode = ParentPersonCode.trim();
                        }

                        if (ParentPersonCode == "") {
                            ParentPersonCode = DefaultPersonCode;
                        }

                        if (PhonePrefix.substring(0, 1) == "+") {
                            PhonePrefix = PhonePrefix.substring(1, PhonePrefix.length);
                        }

                        if (PhoneNumber.substring(0, 1) == "0") {
                            PhoneNumber = PhoneNumber.substring(1, PhoneNumber.length);
                        }

                        if (LoginAccount.indexOf('+') > 0) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("不得包含+"));
                            return false;
                        }

                        if (!CheckPassword()) {
                            return false;
                        }

                        PS = [
                            { Name: "IsFullRegistration", Value: 1 },
                            { Name: "RealName", Value: $("#NickName").val() },
                            { Name: "KYCRealName", Value: form2.Name1.value + form2.Name2.value },
                            { Name: "ContactPhonePrefix", Value: PhonePrefix },
                            { Name: "ContactPhoneNumber", Value: PhoneNumber },
                            { Name: "EMail", Value: document.getElementById("idLoginAccount").value },
                            { Name: "Birthday", Value: form2.BornYear.value + "/" + form2.BornMonth.options[form2.BornMonth.selectedIndex].value + "/" + form2.BornDate.options[form2.BornDate.selectedIndex].value },
                        ];

                        p.CreateAccount(Math.uuid(), LoginAccount, LoginPassword, ParentPersonCode, CurrencyList, PS, function (success, o) {
                            if (success) {
                                if (o.Result == 0) {
                                    sendThanksMail();
                                    window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("註冊成功, 請按登入按鈕進行登入"), function () {
                                        document.getElementById("idRegister").classList.add("is-hide");
                                        window.parent.API_LoadPage('registerFinish', 'registerFinish.aspx');
                                    });
                                } else {
                                    window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o.Message), function () {
                                        window.parent.API_LoadPage("Register", "Register.aspx")
                                    });
                                }
                            } else {
                                if (o == "Timeout") {
                                    window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey("網路異常, 請重新嘗試"), function () {
                                        window.parent.API_LoadPage("Register", "Register.aspx")
                                    });
                                } else {
                                    window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o), function () {
                                        window.parent.API_LoadPage("Register", "Register.aspx")
                                    });
                                }
                            }
                        });
                    }
                } else {
                    window.parent.showMessageOK("", mlp.getLanguageKey("驗證碼錯誤"));
                }
            });
        }
    }
     //簡易註冊
    function SimpleRegistrationCreateUser() {
        var form2 = document.getElementById("registerStep2");
        var CurrencyList = WebInfo.RegisterCurrencyType;

        let nowYear = new Date().getFullYear();

        if ($("#NickName").val() == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入暱稱"));
            return;
        }

        if (!$("#CheckAge").prop("checked")) {
            window.parent.showMessageOK("", mlp.getLanguageKey("請確認已年滿20歲"));
            return;
        }

        var LoginAccount = document.getElementById("idLoginAccount").value;
        var LoginPassword = document.getElementById("idLoginPassword").value;
        var ParentPersonCode = $("#PersonCode").val();
        var PS;

        if (typeof (ParentPersonCode) == "string") {
            ParentPersonCode = ParentPersonCode.trim();
        }

        if (ParentPersonCode == "") {
            ParentPersonCode = DefaultPersonCode;
        }

        if (LoginAccount.indexOf('+') > 0) {
            window.parent.showMessageOK("", mlp.getLanguageKey("不得包含+"));
            return false;
        }

        if (!CheckPassword()) {
            return false;
        }

        PS = [
            { Name: "IsFullRegistration", Value: 0 },
            { Name: "RealName", Value: $("#NickName").val() },
            { Name: "EMail", Value: document.getElementById("idLoginAccount").value },
        ];

        p.CreateAccount(Math.uuid(), LoginAccount, LoginPassword, ParentPersonCode, CurrencyList, PS, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    sendThanksMail();
                    window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("註冊成功, 請按登入按鈕進行登入"), function () {
                        document.getElementById("idRegister").classList.add("is-hide");
                        window.parent.API_LoadPage('registerFinish', 'registerFinish.aspx');
                    });
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o.Message), function () {
                        window.parent.API_LoadPage("Register", "Register.aspx")
                    });
                }
            } else {
                if (o == "Timeout") {
                    window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey("網路異常, 請重新嘗試"), function () {
                        window.parent.API_LoadPage("Register", "Register.aspx")
                    });
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o), function () {
                        window.parent.API_LoadPage("Register", "Register.aspx")
                    });
                }
            }
        });

    }

    function updateBaseInfo() {

    }

    function sendThanksMail() {
        p.SetUserMail(Math.uuid(), 0, 2, $("#idLoginAccount").val(), "", "", "", function (success, o) {
            if (success) {
                if (o.Result != 0) {

                } else {

                }
            }
        });
    }

    function sendReceiveRegisterRewardMail() {
        let emailRule = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
        let Email = $("#idLoginAccount").val();
        if (Email.search(emailRule) != -1) {
            let ReceiveRegisterRewardURL = "<%=EWinWeb.CasinoWorldUrl%>" + "/ReceiveRegisterReward.aspx?LoginAccount=" + LoginAccount;

            p.SetUserMail(Math.uuid(), 0, 3, $("#idLoginAccount").val(), "", "", ReceiveRegisterRewardURL, function (success, o) {
                if (success) {
                    if (o.Result == 0) {

                    } else {

                    }
                }
            });
        }
    }

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();

        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {

            if (pCode) {
                $("input[name=PersonCode]").val(pCode);
                $("input[name=PersonCode]").prop('disabled', true);
            }

            window.parent.API_LoadingEnd(1);
        });

        AdjustDate();
    }

    function initValid(form) {
        if (form.tagName.toUpperCase() == "FORM") {
            var formInputs = form.getElementsByTagName("input");
            for (var i = 0; i < formInputs.length; i++) {
                formInputs[i].setCustomValidity('');
            }
        }
    }

    function onChangePhonePrefix() {
        var value = event.currentTarget.value;
        if (value && typeof (value) == "string" && value.length > 0) {
            if (value[0] != "+") {
                event.currentTarget.value = "+" + value;
            }
        }
    }

    function showPassword(btn) {
        var x = document.getElementById(btn);
        var iconEye = event.currentTarget.querySelector("i");
        if (x.type === "password") {
            x.type = "text";
            if (iconEye) {
                iconEye.classList.remove("icon-eye-off");
                iconEye.classList.add("icon-eye");
            }
        } else {
            x.type = "password";
            if (iconEye) {
                iconEye.classList.add("icon-eye-off");
                iconEye.classList.remove("icon-eye");
            }
        }
    }

    function AdjustDate() {
        var idBornYear = document.getElementById("idBornYear");
        var idBornMonth = document.getElementById("idBornMonth");
        var idBornDate = document.getElementById("idBornDate");
        idBornDate.options.length = 0;

        var year = idBornYear.value;
        var month = parseInt(idBornMonth.value);

        //get the last day, so the number of days in that month
        var days = new Date(year, month, 0).getDate();

        //lets create the days of that month
        for (var d = 1; d <= days; d++) {
            var dayElem = document.createElement("option");
            dayElem.value = d;
            dayElem.textContent = d;

            if (d == 1) {
                dayElem.selected = true;
            }

            idBornDate.append(dayElem);
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

    function IsEmail(email) {
        var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!regex.test(email)) {
            return false;
        } else {
            return true;
        }
    }

    function CheckValidateCode() {
        if ($("#idValidateCode").val() == "") {
            $("#btnSendValidateCode").removeAttr("disabled");
        } else {
            $("#btnSendValidateCode").attr("disabled", "disabled");
        }
    }

    function CheckValidateCode_Phone() {
        if ($("#idValidateCode_Phone").val() == "") {
            $("#btnSendValidateCode_Phone").removeAttr("disabled");
        } else {
            $("#btnSendValidateCode_Phone").attr("disabled", "disabled");
        }
    }

    function ChangeRegister(registertype) {
        $(".tab-scroller__content").find(".tab-item").removeClass("active");
        $("#li_register" + registertype).addClass("active");

        if (registertype == 2) {
            $("#contentStep2").removeClass("is-hide");
        } else {
            $("#contentStep2").addClass("is-hide");
        }
    }

    window.onload = init;
</script>
<body>
    <div class="layout-full-screen sign-container" data-form-group="signContainer">

        <!-- <div class="logo" data-click-btn="backToHome">
            <img src="images/assets/logo-icon.png">
        </div> -->

        <div class="btn-back is-hide" data-click-btn="backToSign">
            <div></div>
        </div>

        <!-- 主內容框 -->
        <div class="main-panel">
            <!-- 註冊 -->
            <div id="idRegister" class="form-container">
                <div class="sec-title-wrapper">
                    <div class="heading-title">
                        <h3 class="language_replace">創建新帳號</h3>
                    </div>
                    <span class="sec-title-intro-link ml-2" data-toggle="modal" data-target="#ModalRegisterWay">
                        <span class="btn btn-Q-mark btn-full-stress btn-round"><i class="icon icon-mask icon-question"></i></span>
                    </span>
                </div>

                <!-- 步驟 -->
                <div class="progress-container mb-4 pb-2 is-hide">
                    <div id="progressStep1" class="progress-step cur">
                        <div class="progress-step-item"></div>
                    </div>
                    <div id="progressStep2" class="progress-step">
                        <div class="progress-step-item"></div>
                    </div>
                </div>

                <!-- 簡易/完整步驟 -->
                <div class="tab-register">
                    <div class="tab-primary tab-scroller tab-2">
                        <div class="tab-scroller__area">
                            <ul class="tab-scroller__content">
                                <li class="tab-item active" id="li_register1" onclick="ChangeRegister(1)">
                                    <span class="tab-item-link"><span class="title language_replace">簡易註冊</span>
                                    </span>
                                </li>
                                <li class="tab-item" id="li_register2" onclick="ChangeRegister(2)">
                                    <span class="tab-item-link">
                                        <span class="title language_replace">完整註冊</span>
                                    </span> 
                                </li>
                                <li class="tab-slide"></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 簡易註冊 -->
                <div id="contentStep1" class="form-content" data-form-group="registerStep1">
                    <form id="registerStep1">
                        <div class="form-group mt-4">
                            <label class="form-title language_replace">信箱</label>
                            <div class="input-group">
                                <input id="idLoginAccount" name="LoginAccount" type="text" language_replace="placeholder" class="form-control custom-style" placeholder="請填寫正確的E-mail信箱" inputmode="email">
                                <div class="invalid-feedback language_replace">請輸入正確信箱</div>
                            </div>
                        </div>
                        <div class="btn-container register" id="divSendValidateCodeBtn">
                            <button type="button" class="btn btn-primary btn-ValidateCode" onclick="onBtnSendValidateCode()" id="btnSendValidateCode">
                                <span class="language_replace">傳送驗證碼</span>
                            </button>
                        </div>
                        <div class="form-group">
                            <div class="text-s text-indent">
                                <label class=" language_replace">E-mail驗證相關說明：</label></br>
                                <label class=" language_replace">1.輸入信箱後點擊『傳送驗證碼』後，驗證碼將會發送到您填寫的E-mail。</label></br>
                                <label class=" language_replace">2.將驗證碼回填於下方輸入框內。</label></br>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-title language_replace">驗證碼</label>
                            <div class="input-group">
                                <input id="idValidateCode" name="ValidateCode" type="text" class="form-control custom-style" onkeyup="CheckValidateCode()">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-title language_replace">暱稱</label>
                            <div class="input-group">
                                <input type="text" class="form-control custom-style" language_replace="placeholder" placeholder="暱稱請輸入英文與數字，長度12位元以內" inputmode="" id="NickName" name="NickName">
                                <div class="invalid-feedback language_replace">提示</div>
                            </div>
                        </div>                       
                        <div class="form-group">
                            <label class="form-title language_replace">密碼</label>
                            <div class="input-group">
                                <input id="idLoginPassword" name="LoginPassword" style="letter-spacing:0 !important" type="password" class="form-control custom-style" language_replace="placeholder" placeholder="字母和數字的組合在20個字符以內" inputmode="email">
                                <div class="invalid-feedback language_replace">請輸入密碼</div>
                            </div>
                            <button class="btn btn-icon" type="button" onclick="showPassword('idLoginPassword')">
                                <i class="icon-eye-off"></i>
                            </button>
                        </div>
                        <div class="form-group">
                            <label class="form-title language_replace">確認密碼</label>
                            <div class="input-group">
                                <input id="idLoginCheckPassword" name="LoginPassword" style="letter-spacing:0 !important" type="password" class="form-control custom-style" language_replace="placeholder" placeholder="字母和數字的組合在20個字符以內" inputmode="email">
                                <div class="invalid-feedback language_replace">確認密碼</div>
                            </div>
                            <button class="btn btn-icon" type="button" onclick="showPassword('idLoginCheckPassword')">
                                <i class="icon-eye-off"></i>
                            </button>
                        </div>                                              
                    </form>
                </div>

                <!-- 以下為 完整註冊-進階版 -->
                <div id="contentStep2" class="form-content is-hide" data-form-group="registerStep2">
                    <form id="registerStep2">
                        <div class="form-row">
                            <div class="form-group col phonePrefix">
                                <label class="form-title language_replace">國碼</label>
                                <div class="input-group">
                                    <input id="idPhonePrefix" type="text" class="form-control custom-style"name="PhonePrefix" placeholder="+81" inputmode="decimal" value="+81" onchange="onChangePhonePrefix()">
                                    <div class="invalid-feedback language_replace">請輸入國碼</div>
                                </div>
                            </div>
                            <div class="form-group col">
                                <label class="form-title language_replace">手機電話號碼</label>
                                <div class="input-group">
                                    <input id="idPhoneNumber" type="text" class="form-control custom-style"name="PhoneNumber" language_replace="placeholder" placeholder="000-0000-0000 (最前面的00請勿輸入)" inputmode="decimal">
                                    <div class="invalid-feedback language_replace">請輸入正確電話</div>
                                </div>
                            </div>
                        </div>
                        <div class="btn-container mb-3" id="divSendValidateCodeBtn_Phone">
                            <button type="button" class="btn btn-primary btn-ValidateCode" onclick="onBtnSendValidateCode_Phone()" id="btnSendValidateCode_Phone">
                                <span class="language_replace">傳送簡訊驗證碼</span>
                            </button>
                        </div>
                        <div class="form-group">
                            <label class="form-title language_replace">驗證碼</label>
                            <div class="input-group">
                                <input id="idValidateCode_Phone" name="ValidateCode_Phone" type="text" class="form-control custom-style" onkeyup="CheckValidateCode_Phone()"  >
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md form-input-focus-tip">
                                <label class="form-title language_replace">姓</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style" language_replace="placeholder" placeholder="請輸入姓" inputmode="email" name="Name1">
                                    <div class="invalid-feedback language_replace">提示</div>
                                    <div class="custom-input-focus-tip">
                                        <div class="notice align-items-start">
                                            <span class="icon-warn"></span>
                                            <span class="text language_replace">請填寫真實姓名供後續身份認證時驗證</span></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md form-input-focus-tip">
                                <label class="form-title language_replace">名</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style" language_replace="placeholder" placeholder="請輸入名" inputmode="email" name="Name2">
                                    <div class="invalid-feedback language_replace">提示</div>
                                    <div class="custom-input-focus-tip">
                                        <div class="notice align-items-start">
                                            <span class="icon-warn"></span>
                                            <span class="text language_replace">請填寫真實姓名供後續身份認證時驗證</span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col">
                                <label class="form-title language_replace">出生年</label>
                                <div class="input-group">
                                    <input id="idBornYear" type="text" class="form-control custom-style" placeholder="1900" inputmode="numeric" name="BornYear" onchange="AdjustDate()" value="1990">
                                </div>
                            </div>
                            <div class="form-group col">
                                <label class="form-title language_replace">月</label>
                                <div class="input-group">
                                    <select id="idBornMonth" class="form-control custom-style" name="BornMonth" onchange="AdjustDate()">
                                        <option value="1" selected>1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group col">
                                <label class="form-title language_replace">日</label>
                                <div class="input-group">
                                    <select id="idBornDate" class="form-control custom-style" name="BornDate">
                                    </select>
                                </div>
                            </div>
                        </div>             
                    </form>
                </div>

                <div id="" class="form-content">
                    <div class="form-group">
                        <label class="form-title language_replace">推廣碼</label>
                        <div class="input-group">
                            <input type="text" class="form-control custom-style" language_replace="placeholder" placeholder="若無推廣碼可不填寫" inputmode="" id="PersonCode" name="PersonCode">
                        </div>
                    </div>   
                    <div class="form-group">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="CheckAge" name="eighteenCheck">
                            <label class=" language_replace text-s" for="CheckAge">我已年滿20歲，且我已了解資料僅作為本網站會員所使用，不會在其他地方使用。</label>
                        </div>
                    </div>
                    <div class="form-group rules-privacy text-small">
                        <p class="language_replace text-s">點選「開設帳號」就代表理解隱私權政策，也同意利用規約還有在マハラジャ不能持有複數的帳號這個條件。</p>
                    </div>
                    <div class="btn-container">
                        <button type="button" class="btn btn-primary" onclick="onBtnUserRegisterStep1()">
                            <span class="language_replace">註冊</span>
                        </button>
                    </div>

                    <div class="get-start-header">
                        <div class="language_replace">已有帳號了?</div>
                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="window.parent.API_LoadPage('Login', 'Login.aspx')">
                            <span class="language_replace">前往登入</span>
                        </button>
                    </div>
                    <div class="form-group">
                        <div class="LineOfficialQrcode">
                            <p class="QrCode"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPoAAAD6AQAAAACgl2eQAAABrklEQVR4Xu2YXYrDMAyEBT5AjuSr+0g+gEGrmXHYbFna1w5YuMGRvpdBP3Ya+d5GvHpe7ACyA8gOICMwouwaOXtcyTUWXIrZAPVbVzaSbfZVwLX9RkCJohOrZQZfIdwPQJoqWjKdgYHQlVQKvXZAsuSCZUb/+Lcmvxyo7MRdcnvBpZgLINvZgcDZH14ngMWGOaY0SawVgNSkJnD0NoNDAE8vIGcsHCWxdu9jlDWmzAgI+FNRhTTQvIDSFVHJykoW8lXu6AhbAWp8JIvR0lgbOY2AqrcFXaUXTqpGK1kBfC2ZXCSxeci0ARbbBNEJgX+HmAWAxiHWU2JnoPcnYz5AY9VhIMvPw0UZ9AE2gycbH3DaAdhjAvBYUcug5J7HogOwy6wMoa7GSZoRQKWdBGYyxpd6xwsoXXhLtUxCKSR7AY0XRbY/OmhRr/LlA8hQeJRMuCK/Mi2AAVV7CGMj1TgirYDE5Qo5Qu1hdlGmG8A5XEMYehNZ4+ZRk05A5YiftIsHyrPkrICe90VLTi8gUXJIVuJMBxz7XzgnoAoMnvtLUIxU+wDv7ACyA8gOIPsM/AA5dNe87D/VlAAAAABJRU5ErkJggg==" alt=""></p>
                            <p class="text-note text-gray language_replace">* 若有任何問題歡迎資詢マハラジャ官方Line客服</p>
                        </div>
                    </div>

                </div>
            </div>

            <!-- 註冊完成 -->
            <div id="contentFinish" class="form-container is-hide">
                <div class="heading-title">
                    <h1>Welcome</h1>
                </div>
                <div class="heading-sub-desc text-wrap">
                    <h5 class="mb-4 language_replace">歡迎來到 Maharaja！</h5>
                    <p class="language_replace">感謝您註冊我們的新會員，真正非常的感謝您 ！</p>
                    <p>
                        <span class="language_replace">您現在可以馬上進入遊戲裡盡情的遊玩我們為您準備的優質遊戲。</span>
                        <br>
                        <span class="language_replace">另外還準備了很多的特典在等待您!</span>

                    </p>
                    <p class="language_replace">如果有任何不清楚的地方，歡迎您利用客服與我們聯絡。</p>
                </div>

                <div class="btn-container pt-4 mb-4">
                    <button type="button" class="btn btn-primary" onclick="window.parent.API_LoadPage('Login','Login.aspx')"><span class="language_replace">立刻登入</span></button>
                </div>
                <div class="d-flex justify-content-center">
                    <a class="text-link underline" onclick="BackHome()">
                        <span class="language_replace">首頁</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

      <!-- Modal RegisterWay -->
      <div class="modal fade footer-center" id="ModalRegisterWay" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <h5 class="modal-title"></h5> -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="registerWay-popup-wrapper popup-tip">
                        <ul class="registerWay-popup-list">
                            <li class="item">
                            <h3 class="title language_replace">簡易註冊與完整註冊</h3>
                            <p class="desc language_replace">簡易註冊可讓玩家填入最低限度的內容，即可進入網站體驗，但完整註冊才能享有領取獎勵、充值、提款等完整會員才有的特定功能喔!</p>  
                            </li>
                            <li class="item">
                                <h3 class="title language_replace">簡易註冊後如何升級完整會員?</h3>
                                <p class="desc language_replace">於會員中心按下『進行認證』之按鈕，或欲使用被限制之功能時，提供填寫介面以利會員完成認證。</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-primary">確定</button>
                </div>--%>
            </div>
        </div>
    </div>
    
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
