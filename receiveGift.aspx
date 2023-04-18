<%@ Page Language="C#" %>

<%
    string Amount = Request["Amount"];
    string GiftCode = Request["GiftCode"];
    string Version = EWinWeb.Version;

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
    var WebInfo;
    var p;
    var mlp;
    var lang;
    var PhoneNumberUtil = libphonenumber.PhoneNumberUtil.getInstance();
    var v ="<%:Version%>";
    var isSent = false;
    var isSent_Phone = false;
    var LoginAccount;

    function init() {

        //WebInfo = window.parent.API_GetWebInfo();
        //p = window.parent.API_GetLobbyAPI();
        //lang = window.parent.API_GetLang();

        //mlp = new multiLanguage(v);
        //mlp.loadLanguage(lang, function () {
        //    window.parent.API_LoadingEnd(1);
        //});
        $("#reciveBtn").click(function () {
            window.location.href = "/index.aspx?GiftCode=" + "<%:GiftCode%>";
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
                    //window.parent.API_LoadingEnd(1);
                });
                break;
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
            <!-- 註冊完成 -->
            <div id="contentFinish" class="form-container">
                 <div class="heading-title">
                    <h1>領取禮品</h1>
                </div>
                <div class="heading-sub-desc text-wrap">
                    <h5 class="mb-4 language_replace">禮品金額 : <%:Amount%></h5>
                    <p class="language_replace">點擊領取後，如尚未登入 Maharaja ，將會引導至登入頁面</p>
                    <p>
                        <span class="language_replace">登入後禮金即會匯入您的點數錢包內。</span>
                        <br>
                        <span class="language_replace">如已登入禮金將即時匯入您的點數錢包內!</span>

                    </p>
                    <p class="language_replace">如果有任何不清楚的地方，歡迎您利用客服與我們聯絡。</p>
                </div>

                <div class="btn-container pt-4 mb-4">
                    <button type="button" class="btn btn-primary" id="reciveBtn"><span class="language_replace">領取</span></button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
