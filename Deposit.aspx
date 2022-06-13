<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/wallet.css" type="text/css" />
    <link href="css/footer-new.css" rel="stylesheet" />
    <style>
        
    </style>
</head>

<script src="Scripts/OutSrc/lib/jquery/jquery.min.js"></script>
<script src="Scripts/OutSrc/js/wallet.js"></script>
<script src="Scripts/OutSrc/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/libphonenumber.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script>
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var WebInfo;
    var lang;
    var mlp;
    var v = "<%:Version%>";

    function init() {

        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();

        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {

            if (WebInfo.UserInfo.LoginAccount == 'test002') {
                document.getElementById('idDepositPaypal').classList.add('is-hide');
            }

            window.parent.API_LoadingEnd();
        }, "PaymentAPI");
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
                    window.parent.API_LoadingEnd(1);
                });
                break;
        }
    }

    function TempAlert() {
        window.parent.API_ShowMessageOK("", "<p style='font-size:2em;text-align:center;margin:auto'>" +  mlp.getLanguageKey("近期開放") + "</p>");
    }

    window.onload = init;

</script>
<body>
    <div class="page-container">
        <!-- Heading-Top -->
        <div id="heading-top"></div>

        <div class="page-content">

            <section class="sec-wrap">
                <!-- 頁面標題 -->
                <div class="page-title-container">
                    <div class="page-title-wrap">
                        <div class="page-title-inner">
                            <h3 class="title language_replace">存款</h3>
                        </div>
                    </div>
                </div>

                <!-- 步驟 -->
                <div class="progress-container progress-line">
                    <div class="progress-step cur">
                        <div class="progress-step-item"></div>
                    </div>
                    <div class="progress-step">
                        <div class="progress-step-item"></div>
                    </div>
                    <div class="progress-step">
                        <div class="progress-step-item"></div>
                    </div>
                    <div class="progress-step">
                        <div class="progress-step-item"></div>
                    </div>
                </div>
                <div class="text-wrap progress-title">
                    <p class="language_replace">選擇存款管道</p>
                </div>

                <!-- 選擇存款管道  -->
                <div class="card-container">
                    <!-- PayPal -->
                    <div class="card-item sd-08" id="idDepositPaypal">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositPayPal','DepositPayPal.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">電子錢包</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center">
                                    <img src="images/assets/card-surface/icon-logo-paypal-w.svg">
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-08.svg" class="card-item-bg">
                        </a>
                    </div>
                    <!-- 虛擬錢包 -->
                    <div class="card-item sd-02" style="">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositCrypto','DepositCrypto.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span>Crypto Wallet</span>
                                </div>
                                <div class="title vertical-center">
                                    <span class="language_replace">虛擬貨幣</span>
                                </div>
                                <!-- <div class="desc">
                                    <b>30</b> € -  <b>5,000</b> € No Fee                                   
                                </div> -->
                                <div class="logo">
                                    <i class="icon-logo-usdt"></i>
                                    <!-- <i class="icon-logo-eth-o"></i> -->
                                    <!-- <i class="icon-logo-nissin"></i> -->
                                    <i class="icon-logo-eth"></i>
                                    <i class="icon-logo-btc"></i>
                                    
                                    <!-- <i class="icon-logo-doge"></i> -->
                                    <!-- <i class="icon-logo-tron"></i> -->
                                </div>
                                <!-- <div class="instructions-crypto">
                                    <i class="icon-info_circle_outline"></i>
                                    <span onclick="window.open('instructions-crypto.html')" class="language_replace">使用說明</span>
                                </div>                                -->
                            </div>
                            <img src="images/assets/card-surface/card-02.svg" class="card-item-bg">
                        </a>
                    </div>
                    <!-- EPay -->
                    <div class="card-item sd-03" id="idDepositEPay">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositEPay','DepositEPay.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">Maharaja</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center text-center">
                                    <!-- <span class="text language_replace">銀行振込</span> -->
                                    <img src="images/assets/card-surface/icon-logo-NissinPay-2.svg">
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-03.svg" class="card-item-bg">
                        </a>
                    </div>

                    <!-- EPay -->
                    <div class="card-item tempCard" id="idDepositJKC" <%--onclick="TempAlert()"--%> onclick="window.parent.API_LoadPage('DepositJKCEPay','DepositJKCEPay.aspx')">                   
                        <a class="card-item-link" style="background-image: url(../images/assets/card-surface/card-jkc.svg)">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span>マハラジャ</span> 
                                </div>
                                <div class="logo vertical-center">                                   
                                    <img src="images/assets/card-surface/jkc-font.svg">                                   
                                </div>
                            </div>                           
                            <img src="images/assets/card-surface/card-jkc.svg"  class="card-item-bg">
                        </a>
                        <%--<img class="comingSoon" src="../images/assets/card-surface/cs.png">--%>
                    </div>
                </div>
                <!-- 存款紀錄 -->
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-wallet"></i>
                        <div class="text-wrap">
                            <p class="title language_replace text-link" onclick="window.parent.API_LoadPage('record','record.aspx', true)">檢視存款紀錄</p>
                        </div>
                    </div>
                </div>
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace" style="cursor:pointer" onclick="window.parent.API_LoadPage('record','Guide/EPayJKC/index.html', true)">JKC専用入金の流れ</p>
                        </div>
                    </div>
                </div>
                <!-- 溫馨提醒 -->
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace">溫馨提醒</p>
                            <p class="language_replace">1.OCOIN是客人在マハラジャ遊玩的幣別總稱</p>
                            <p class="language_replace">2.因為選擇的送金方法有所不同，在帳戶上反映的時間是入金之後最多一個營業日為範圍。</p>
                            <p class="language_replace">3.ローリング倍率について​</p>
                            <p class="language_replace">Paypal・主要暗号資産＝入金額の1.5倍</p>
                            <p class="language_replace">JKETH＝入金額の8倍​ ボーナス＝20倍​</p>
                            <p class="language_replace">（計算例）</p>
                            <p class="language_replace">PayPal　10,000+ボーナス10,000の場合​</p>
                            <p class="language_replace">10,000×1.5倍+10,000×20倍=215,000​</p>
                            <p class="language_replace">ローリングについての詳しい説明は<span class="link" style="cursor: pointer" onclick="window.parent.API_LoadPage('guide_Rolling', 'guide_Rolling.html', false)">こちら</span></p>
                            <p class="language_replace">4.既存の出金制限ローリングを解除するには、所有のOcoinが100以下になった時に</p>
                            <p class="language_replace">入金をするか受取箱のOcoin受取るかで解除できます。</p>
                        </div>
                    </div>
                </div>

            </section>


        </div>
    </div>
</body>
</html>
