<%@ Page Language="C#" %>

<%
    if (EWinWeb.IsInMaintain())
    {
        Response.Redirect("/Maintain.aspx");
    }

    string Token;
    int RValue;
    Random R = new Random();
    string Lang = "CHT";
    string SID = string.Empty;
    string CT = string.Empty;
    int RegisterType;
    int RegisterParentPersonCode;
    string Version = EWinWeb.Version;

    if (string.IsNullOrEmpty(Request["SID"]) == false)
    {
        SID = Request["SID"];
    }


    if (string.IsNullOrEmpty(Request["CT"]) == false)
        CT = Request["CT"];

    EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

    RValue = R.Next(100000, 9999999);
    Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());
    var CompanySite = lobbyAPI.GetCompanySite(Token, Guid.NewGuid().ToString());

    RegisterType = CompanySite.RegisterType;
    RegisterParentPersonCode = CompanySite.RegisterParentPersonCode;
    if (string.IsNullOrEmpty(Request["Lang"]))
    {
        string userLang = CodingControl.GetDefaultLanguage();

        if (userLang.ToUpper() == "zh-TW".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-HK".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-MO".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-CHT".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-CHS".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-SG".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-CN".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "en-US".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "en-CA".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "en-PH".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "en".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "ko-KR".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "ko-KP".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "ko".ToUpper())
        {
            Lang = "ENG";
        }
        else if (userLang.ToUpper() == "ja".ToUpper())
        {
            Lang = "JPN";
        }
        else { Lang = "JPN"; }
    }
    else
    {
        Lang = Request["Lang"];
    }

%>
<!doctype html>
<html id="myHTML" lang="zh-Hant-TW" class="mainHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%--<title>マハラジャ - 一番人気なオンラインカジノアミューズメント</title>--%>
    <title>Maharaja，The most popular online casino amusement.</title>

    <%--<meta name='keywords' content="カジノ、スロット、アミューズメント、ゲーム、ギャンブル" />
    <meta name='description' content="知名なオンラインゲームブランドを提携し、信頼価値もあるし、それにすぐ遊べることができます。お金の無駄遣いをせずに、今すぐサイトを登録して、ゲーム開始！" />--%>
    <meta name='keywords' content="Casino、Slot、Amusement、Game" />
    <meta name='description' content="We have partnered with well-known online game brands, and they are reliable and ready to play. Register your site now and start the game without wasting money!" />

    <%--<meta property="og:site_name" content="マハラジャ" />--%>
    <meta property="og:site_name" content="Maharaja" />

    <%--<meta property="og:title" content="一番人気なオンラインカジノアミューズメント - マハラジャ" />
   <meta property="og:Keyword" content="カジノ、スロット、アミューズメント、ゲーム、ギャンブル" />
    <meta property="og:description" content="知名なオンラインゲームブランドを提携し、信頼価値もあるし、それにすぐ遊べることができます。お金の無駄遣いをせずに、今すぐサイトを登録して、ゲーム開始！" />--%>
    <meta property="og:title" content="The most popular online casino amusement." />
    <meta property="og:Keyword" content="Casino、Slot、Amusement、Game" />
    <meta property="og:description" content="We have partnered with well-known online game brands, and they are reliable and ready to play. Register your site now and start the game without wasting money!" />

    <meta property="og:url" content="https://casino-maharaja.com/" />
    <!--日文圖片-->
    <%--<meta property="og:image" content="https://casino-maharaja.com/images/share_pic.png" />--%>
    <!--英文圖片-->
    <meta property="og:image" content="https://casino-maharaja.com/images/share_pic_en.png" />
    <meta property="og:type" content="website" />
    <!-- Share image -->
    <!--日文圖片-->
    <%--<link rel="image_src" href="https://casino-maharaja.com/images/share_pic.png">--%>
    <!--英文圖片-->
    <link rel="image_src" href="https://casino-maharaja.com/images/share_pic_en.png">

    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="css/main.css">
</head>
<% if (EWinWeb.IsTestSite == false)
    { %>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-WRNSR38PQ7"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'G-097DC2GB6H');
</script>
<% } %>
<script
    src="https://code.jquery.com/jquery-2.2.4.js"
    integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
    crossorigin="anonymous"></script>
<script type="text/javascript" src="/Scripts/PaymentAPI.js?<%:Version%>"></script>
<script type="text/javascript" src="/Scripts/LobbyAPI.js?<%:Version%>"></script>
<script src="Scripts/vendor/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script src="Scripts/OutSrc/lib/swiper/js/swiper-bundle.min.js"></script>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script type="text/javascript">
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var c = new common();
    var mlp;
    var mlpByGameCode;
    var mlpByGameBrand;
    var lobbyClient;
    var paymentClient;
    var needCheckLogin = false;
    var lastWalletList = null; // 記錄最後一次同步的錢包, 用來分析是否錢包有變動    
    var EWinWebInfo = {
        EWinUrl: "<%=EWinWeb.EWinUrl %>",
        EWinGameUrl: "<%=EWinWeb.EWinGameUrl %>",
        MainCurrencyType: "<%=EWinWeb.MainCurrencyType %>",
        RegisterCurrencyType: "<%=EWinWeb.RegisterCurrencyType %>",
        SID: "<%=SID%>",
        CT: "<%=CT%>",
        UserLogined: false,
        FirstLoaded: false,
        Lang: "<%=Lang%>",
        UserInfo: null,
        RegisterType: "<%=RegisterType%>",
        RegisterParentPersonCode: "<%=RegisterParentPersonCode%>",
        GameCodeList: {
            CategoryList: [],
            GameBrandList: [],
            GameList: null
        },
        DeviceType: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ? 1 : 0,
        IsOpenGame: false
    };

    var selectedWallet = null;
    var v = "<%=Version%>";

    var GameInfoModal;
    var MessageModal;
    var gameWindow;
    var LobbyGameList;
    var LobbyGameList2 = {};
    //#region TOP API

    function API_GetWebInfo() {
        return EWinWebInfo;
    }

    function API_GetLang() {
        return EWinWebInfo.Lang;
    }

    function API_GetLobbyAPI() {
        return lobbyClient;
    }

    function API_GetPaymentAPI() {
        return paymentClient;
    }


    function API_GetCurrency() {
        var selectedCurrency;

        if (selectedWallet) {
            selectedCurrency = selectedWallet.CurrencyType;
        } else {
            selectedCurrency = "";
        }

        return selectedCurrency;
    }

    function API_GetGameLang(type, gameBrand, gameName) {
        if (type == 0) {
            return gameBrand;
            //return mlpByGameBrand.getLanguageKey(gameBrand);
        } else if (type == 1) {
            return mlpByGameCode.getLanguageKey(gameBrand + "." + gameName);
        } else if (type == 2) {
            return mlpByGameCode.getLanguageKey(gameName);
        } else {
            return "";
        }
    }

    //打開熱門文章
    function API_OpenHotArticle() {
        openHotArticle();
    }

    function API_SetLogin(_SID, cb) {
        var sourceLogined = EWinWebInfo.UserLogined;
        checkUserLogin(_SID, function (logined) {
            updateBaseInfo();

            if (cb) {
                cb(logined);
            }

            if (sourceLogined == logined) {
                notifyWindowEvent("LoginState", logined);
            }
        });
    }

    // 強制登出
    function API_Logout(isRefresh) {
        EWinWebInfo.UserInfo = null;
        EWinWebInfo.UserLogined = false;
        window.sessionStorage.clear();
        delCookie("RecoverToken");
        delCookie("LoginAccount");
        delCookie("CT");
        delCookie("SID");

        if (isRefresh) {
            window.location.href = "Refresh.aspx?index.aspx";
        }
    }

    function API_RefreshUserInfo(cb) {
        checkUserLogin(EWinWebInfo.SID, function (logined) {
            updateBaseInfo();

            notifyWindowEvent("LoginState", logined);

            if (cb != null)
                cb();
        });
    }

    function API_LoadingStart() {
        $('.loader-container').show();
        $('.loader-backdrop').removeClass('is-show');
    }

    function API_LoadingEnd(type) {
        var iframeDom = document.getElementById("IFramePage").contentDocument;
        if (iframeDom) {
            if (type && type == 1) {

            } else {


                var footerDom = c.getTemplate("footer");

                if (true) {

                }

                document.getElementById("IFramePage").contentDocument.body.appendChild(footerDom);
            }
        }
        $('.loader-backdrop').addClass('is-show');
        $('.loader-container').fadeOut(250, function () {
            $('.iframe-container').addClass('is-show');
        });

        //resize();
    }

    function API_ShowGameDetail(gameItem) {
        var rtpInfoJson = gameItem.RTPInfo;
        var categ = gameItem.Categ;

        var divMessageBox = document.getElementById("alertGameIntro");
        var isInFavoGames = checkInFavoriteGame(gameItem.gameBrand, gameItem.gameName);

        if (divMessageBox != null) {
            divMessageBox.querySelector(".gameRealName").innerText = API_GetGameLang(1, gameItem.gameBrand, gameItem.gameName);
            divMessageBox.querySelector(".GameID").innerText = c.padLeft(gameItem.GameID.toString(), 5);
            divMessageBox.querySelector(".GameImg").src = EWinWebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.gameBrand + "/PC/" + EWinWebInfo.Lang + "/" + gameItem.gameName + ".png";
            divMessageBox.querySelector(".GameImg").onerror = new Function("setDefaultIcon('" + gameItem.gameBrand + "', '" + gameItem.gameName + "')");

            if (rtpInfoJson) {
                let JSON_RTPInfo = JSON.parse(rtpInfoJson);
                divMessageBox.querySelector(".game-rtp").classList.remove("is-hide");

                if (JSON_RTPInfo["RTP"] == "0") {
                    divMessageBox.querySelector(".game-rtp").classList.add("is-hide");
                } else {
                    divMessageBox.querySelector(".RtpContent").innerText = JSON_RTPInfo["RTP"];
                }
            } else {
                divMessageBox.querySelector(".game-rtp").classList.remove("is-hide");
                divMessageBox.querySelector(".RtpContent").innerText = "-";
            }

            if (isInFavoGames) {
                divMessageBox.querySelector(".game-myFavorite").classList.add("add");
                divMessageBox.querySelector(".FavoText").innerText = mlp.getLanguageKey("移除最愛");
            } else {
                divMessageBox.querySelector(".game-myFavorite").classList.remove("add");
                divMessageBox.querySelector(".FavoText").innerText = mlp.getLanguageKey("加入我的最愛");
            }

            divMessageBox.querySelector(".game-myFavorite").onclick = new Function("favBtnEvent('" + gameItem.gameBrand + "', '" + gameItem.gameName + "')");

            if (gameItem.AllowDemoPlay == 1) {
                divMessageBox.querySelector(".game-demo").classList.remove("is-hide");
                divMessageBox.querySelector(".game-demo").onclick = new Function("openDemo('" + gameItem.gameBrand + "', '" + gameItem.gameName + "' , '" + categ + "')");
            } else {
                divMessageBox.querySelector(".game-demo").classList.add("is-hide");
            }


            if (EWinWebInfo.UserLogined) {
                divMessageBox.querySelector(".game-login").innerText = mlp.getLanguageKey("開始遊戲");
                divMessageBox.querySelector(".game-login").onclick = new Function("openGame('" + gameItem.gameBrand + "', '" + gameItem.gameName + "' , '" + categ + "')");
            } else {
                divMessageBox.querySelector(".game-login").innerText = mlp.getLanguageKey("登入玩遊戲");
                divMessageBox.querySelector(".game-login").onclick = new Function("openGame('" + gameItem.gameBrand + "', '" + gameItem.gameName + "' , '" + categ + "')");
            }

            GameInfoModal.toggle();
        }
    }

    function API_LoadPage(title, url, checkLogined) {
        if (EWinWebInfo.IsOpenGame) {
            EWinWebInfo.IsOpenGame = false;
            //SwitchGameHeader(0)
        }

        if (checkLogined) {
            if (!EWinWebInfo.UserLogined) {
                showMessageOK(mlp.getLanguageKey("尚未登入"), mlp.getLanguageKey("請先登入"), function () {
                    GameInfoModal.hide();
                    window.sessionStorage.setItem("SrcPage", url);
                    API_LoadPage("Login", "Login.aspx");
                });
                return;
            }
        }

        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            // if (IFramePage.children.length > 0) {
            //var ifrm = IFramePage.children[0];

            if (IFramePage.tagName.toUpperCase() == "IFRAME".toUpperCase()) {
                //loadingStart();
                //上一頁針對iframe的問題，只能將loading的function都放於頁面中
                //API_LoadingStart(); 
                //IFramePage.style.height = "0px";
                IFramePage.src = url;



                //IFramePage.
            }

        }
    }

    function API_Home() {
        //Game
        API_LoadPage("Home", "Home.aspx");
    }

    function API_Reload() {
        //Game
        window.location.reload();
    }

    function API_GetGameList(type) {
        if (type) {
            if (type == 1) {
                return LobbyGameList.HotList;
            } else if (type == 2) {
                return LobbyGameList.NewList;
            }
        } else {
            return LobbyGameList;
        }
    }

    function API_GetGameList2() {
        return LobbyGameList2;
    }

    function API_ShowMessage(title, msg, cbOK, cbCancel) {
        return showMessage(title, msg, cbOK, cbCancel);
    }

    function API_ShowMessageOK(title, msg, cbOK) {
        return showMessageOK(title, msg, cbOK);
    }

    function API_MobileDeviceGameInfo(brandName, RTP, gameName, GameID) {
        return showMobileDeviceGameInfo(brandName, RTP, gameName, GameID);
    }

    function API_ShowPartialHtml(title, pathName, isNeedLang, cbOK) {
        //return window.open(pathName);
        return showPartialHtml(title, pathName, isNeedLang, cbOK);
    }

    function API_ShowContactUs() {
        return showContactUs();
    }

    function API_changeAvatarImg(avatar) {
        if (avatar) {
            document.getElementById("idAvatarImg").src = "images/assets/avatar/" + avatar + ".jpg"
        }
    }

    function API_GetFavoGames() {
        return getFavoriteGames();
    }

    function API_GetMyGames() {
        return getMyGames();
    }

    function API_SendSerivceMail(subject, body, email) {
        lobbyClient.SendCSMail(EWinWebInfo.SID, Math.uuid(), email, subject, body, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("已成功通知客服，將回信至您輸入或註冊的信箱"));
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

    function API_ShowLoading() {
        $('.loader-container').show();
        $('.loader-backdrop').removeClass('is-show');
    }

    function API_CloseLoading() {
        $('.loader-backdrop').addClass('is-show');
        $('.loader-container').fadeOut(250, function () {
            $('.iframe-container').addClass('is-show');
        });
    }

    //#endregion

    //#region Alert
    function showMessage(title, message, cbOK, cbCancel) {
        if ($("#alertMsg").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertMsg");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertMsg_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertMsg_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertMsg_Text");

            if (MessageModal == null) {
                MessageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });
            }

            if (divMessageBox != null) {
                MessageModal.toggle();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.remove("is-hide");
                    divMessageBoxCloseButton.onclick = function () {
                        MessageModal.hide();

                        if (cbCancel != null) {
                            cbCancel();
                        }
                    }
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        MessageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showMessageOK(title, message, cbOK) {
        if ($("#alertMsg").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertMsg");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertMsg_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertMsg_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertMsg_Text");

            if (MessageModal == null) {
                MessageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });
            }

            if (divMessageBox != null) {
                MessageModal.show();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        MessageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showBoardMsg(title, message, time) {
        if ($("#alertBoardMsg").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertBoardMsg");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alert_OK");
            var divMessageBoxTitle = divMessageBox.querySelector(".alert_Title");
            var divMessageBoTime = divMessageBox.querySelector(".alert_Time");
            var divMessageBoxContent = divMessageBox.querySelector(".alert_Text");
            var modal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });

            if (divMessageBox != null) {
                modal.show();

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        modal.hide();
                    }
                }

                divMessageBoxTitle.innerHTML = title;
                divMessageBoTime.innerHTML = time;
                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    //#endregion

    function showMobileDeviceGameInfo(brandName, RTP, gameName, GameID) {
     
        $('#popupMoblieGameInfo .BrandName').text(brandName);
        $('#popupMoblieGameInfo .valueRTP').text(RTP);
        $('#popupMoblieGameInfo .gameName').text(API_GetGameLang(1, brandName, gameName));
        $('#popupMoblieGameInfo .GameID').text(GameID);

        var playgamebtn = document.getElementById('popupMoblieGameInfo').querySelector(".btn-play");
        playgamebtn.onclick = new Function("openGame('" + brandName + "', '" + gameName + "')");

        var btnmore = document.getElementById('popupMoblieGameInfo').querySelector(".btn-more");
        btnmore.onclick = new Function("popupMoblieGameInfoShowMore(this)");

        var GI_img = document.getElementById('popupMoblieGameInfo').querySelector(".imgsrc");
        if (GI_img != null) {
            GI_img.src = EWinWebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + brandName + "/PC/" + EWinWebInfo.Lang + "/" + gameName + ".png";
            //var el = GI_img;
            //var observer = lozad(el); // passing a `NodeList` (e.g. `document.querySelectorAll()`) is also valid
            //observer.observe();
        }
        $('#popupMoblieGameInfo').modal('show');
    }

    function popupMoblieGameInfoShowMore(doc) {
        $(doc).closest('.game-item-info-detail').toggleClass('open');
    }
  
    function showPartialHtml(title, pathName, isNeedLang, cbOK) {
        var realPath;
        var divMessageBox = document.getElementById("alertPartialHtml");
        var divMessageBoxOKButton = divMessageBox.querySelector(".alertPartialHtml_OK");
        var divMessageBoxTitle = divMessageBox.querySelector(".alertPartialHtml_Title");
        var divMessageBoxContent = divMessageBox.querySelector(".alertPartialHtml_Content");
        var modal = new bootstrap.Modal(divMessageBox);

        if (isNeedLang) {
            realPath = pathName + "_" + EWinWebInfo.Lang + ".html";
        } else {
            realPath = pathName + ".html";
        }

        if (divMessageBox != null) {
            if (divMessageBoxOKButton != null) {
                divMessageBoxOKButton.onclick = function () {
                    divMessageBoxContent.innerHTML = "";
                    modal.hide();

                    if (cbOK != null)
                        cbOK();
                }
            }

            divMessageBoxTitle.innerHTML = title;
            $(divMessageBoxContent).load(realPath);

            modal.toggle();
        }
    }

    function showContactUs() {
        var divMessageBox = document.getElementById("alertContactUs");
        var divMessageBoxCrossButton = divMessageBox.querySelector(".close");

        var modal = new bootstrap.Modal(divMessageBox);

        if (divMessageBox != null) {
            modal.toggle();
        }
    }

    function sendContactUs() {
        var contactUsDom = document.querySelector(".inbox_customerService");
        var subjectText = contactUsDom.querySelector(".contectUs_Subject").value;
        var emailText = contactUsDom.querySelector(".contectUs_Eamil").value;
        var bodyText = contactUsDom.querySelector(".contectUs_Body").value;
        var NickName = contactUsDom.querySelector(".contectUs_NickName").value;
        var Phone = contactUsDom.querySelector(".contectUs_Phone").value;
        //}

        API_SendSerivceMail(subjectText, "ニックネーム：" + NickName + "<br/>" + "携帯電話：" + Phone + "<br/>" + bodyText, emailText);
    }

    //#region Game
    function GameLoadPage(url, gameBrand, gameName) {
        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            if (IFramePage.tagName.toUpperCase() == "IFRAME".toUpperCase()) {
                API_LoadingStart();
                IFramePage.src = url;
      
            }
        }
    }

    function setDefaultIcon(brand, name) {
        var img = event.currentTarget;
        img.onerror = null;
        img.src = EWinWebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + brand + "/PC/" + EWinWebInfo.Lang + "/" + name + ".png";
    }

    function openGame(gameBrand, gameName) {

        //先關閉Game彈出視窗(如果存在)
        if (gameWindow) {
            gameWindow.close();
        }

        if (!EWinWebInfo.UserLogined) {
            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                API_LoadPage("Login", "Login.aspx");
            }, null);
        } else {
            EWinWebInfo.IsOpenGame = true;
            setGameCodeToMyGames(gameBrand, gameName);

            if (gameBrand.toUpperCase() != "EWin".toUpperCase()) {
                if (EWinWebInfo.DeviceType == 1) {
                    gameWindow = window.open("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
                } else {
                    GameLoadPage("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href);
                }
            } else {
                gameWindow = window.open("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
            }
        }
    }

    function openDemo(gameBrand, gameName) {
        //先關閉Game彈出視窗(如果存在)
        EWinWebInfo.IsOpenGame = true;
        setGameCodeToMyGames(gameBrand, gameName);

        //先關閉Game彈出視窗(如果存在)
        if (gameWindow) {
            gameWindow.close();
        }

        if (gameBrand.toUpperCase() != "EWin".toUpperCase()) {
            if (EWinWebInfo.DeviceType == 1) {
                gameWindow = window.open("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
            } else {
                GameLoadPage("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href);
            }
        } else {
            gameWindow = window.open("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
        }
    }

    function favBtnEvent(gameBrand, gameName) {
        var target = event.currentTarget;
        var type = target.classList.contains("add") ? 1 : 0;

        if (type == 0) {

            showMessageOK(mlp.getLanguageKey("我的最愛"), mlp.getLanguageKey("加入我的最愛"), function () {
                target.classList.add("add");
                setFavoriteGame(gameBrand, gameName, type);
                if (document.getElementById('IFramePage').contentWindow.refreshFavoGame) {
                    document.getElementById('IFramePage').contentWindow.refreshFavoGame();
                }
                //setGameLobbySection(nowWebTag);
            }, null);
        } else {
            showMessageOK(mlp.getLanguageKey("我的最愛"), mlp.getLanguageKey("是否從我的最愛移除"), function () {
                target.classList.remove("add");
                setFavoriteGame(gameBrand, gameName, type);
                if (document.getElementById('IFramePage').contentWindow.refreshFavoGame) {
                    document.getElementById('IFramePage').contentWindow.refreshFavoGame();
                }
                //setGameLobbySection(nowWebTag);
            }, null);
        }
    };
    //#endregion

    //#region FavoriteGames And MyGames

    function getFavoriteGames() {
        var favoriteGamesStr = window.localStorage.getItem("FavoriteGames");
        var favoriteGames;

        if (favoriteGamesStr) {
            favoriteGames = JSON.parse(favoriteGamesStr);
        } else {
            favoriteGames = [];
        }

        return favoriteGames;
    }

    function setFavoriteGame(gameBrand, gameName, type) {
        var favoriteGames = getFavoriteGames();
        var favoriteGame = {
            GameBrand: gameBrand,
            GameName: gameName
        };

        if (type == 0) {
            //add
            favoriteGames.splice(0, 0, favoriteGame);
            window.localStorage.setItem("FavoriteGames", JSON.stringify(favoriteGames));
        } else {
            //remove
            var index = favoriteGames.findIndex(x => x.GameBrand == gameBrand && x.GameName == gameName);
            if (index > -1) {
                favoriteGames.splice(index, 1);
            }

            window.localStorage.setItem("FavoriteGames", JSON.stringify(favoriteGames));
        }

        notifyWindowEvent("RefreshFavoriteGames", null);
    }

    function checkInFavoriteGame(gameBrand, gameName) {
        var FavoGames = getFavoriteGames();
        var index = FavoGames.findIndex(x => x.GameBrand == gameBrand && x.GameName == gameName);

        if (index > -1) {
            return true
        } else {
            return false;
        }
    }

    function setGameCodeToMyGames(gameBrand, gameName) {
        var TotalCount = 14;
        var objMyGame = new Object();
        objMyGame.GameBrand = gameBrand;
        objMyGame.GameName = gameName;

        if (!localStorage.getItem('MyGames')) {
            var arrayMyGames = new Array();
            arrayMyGames.push(objMyGame);
            localStorage.setItem('MyGames', JSON.stringify(arrayMyGames));
        } else {
            var arrayMyGames = JSON.parse(localStorage.getItem('MyGames'));
            var isDuplicate = false;
            for (var i = 0; i < arrayMyGames.length; i++) {
                if (arrayMyGames[i].GameBrand == gameBrand && arrayMyGames[i].GameName == gameName) {
                    isDuplicate = true;
                    break;
                }
            }

            if (!isDuplicate) {
                if (arrayMyGames.length == TotalCount) {
                    arrayMyGames.pop();
                    arrayMyGames.unshift(objMyGame);
                } else {
                    arrayMyGames.unshift(objMyGame);
                }
            }

            localStorage.setItem('MyGames', JSON.stringify(arrayMyGames));
        }

        notifyWindowEvent("RefreshMyGames", null);
    }

    function getMyGames() {
        var MyGames;
        if (window.localStorage.getItem('MyGames')) {
            MyGames = JSON.parse(window.localStorage.getItem('MyGames'));
        } else {
            MyGames = [];
        }

        return MyGames;
    }
    //#endregion

    function checkUserLogin(SID, cb) {
        var guid = Math.uuid();

        lobbyClient.GetUserInfo(SID, guid, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    //EXTRA DATA 處理
                    var ExtraData;

                    if (o.ExtraData != null && o.ExtraData != '') {
                        ExtraData = JSON.parse(o.ExtraData);
                        o.KYCRealName = ExtraData.KYCRealName;
                        o.Country = ExtraData.Country;
                        o.CountryName = ExtraData.CountryName;
                    } else {
                        o.KYCRealName = '';
                        o.Country = '';
                        o.CountryName = '';
                    }

                    EWinWebInfo.SID = SID;
                    EWinWebInfo.UserLogined = true;
                    EWinWebInfo.UserInfo = o;

                    if (cb)
                        cb(true);
                } else {
                    if (o.Message == "InvalidSID" || o.Message == "InvalidWebSID") {
                        // login fail
                        EWinWebInfo.UserLogined = false;
                    } else {
                        EWinWebInfo.UserLogined = false;

                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                    }

                    if (cb)
                        cb(false);
                }
            } else {
                // 忽略 timeout 
            }
        });
    }

    function notifyWindowEvent(eventName, o) {
        //#region eventNameList
        //LoginState param: (bool)logined
        //BalanceChange (number)point
        //RefreshMyGame null
        //RefreshFavoriteGames null
        //#endregion
        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            isDisplay = true;
            if (!EWinWebInfo.IsOpenGame) {
                if (IFramePage.contentWindow && IFramePage.contentWindow.EWinEventNotify) {
                    try {
                        IFramePage.contentWindow.EWinEventNotify(eventName, isDisplay, o)
                    } catch (e) {

                    }
                }
            }
        }
    }

    function updateBaseInfo() {
        var idMenuLogin = document.getElementById("idMenuLogin");
        var idLoginBtn = document.getElementById("idLoginBtn");
        //var idUserNameTitle = document.getElementById("idUserNameTitle");
        var idWalletDiv = idMenuLogin.querySelector(".amount")
        if (EWinWebInfo.UserLogined) {
            var wallet = EWinWebInfo.UserInfo.WalletList.find(x => x.CurrencyType.toLocaleUpperCase() == EWinWebInfo.MainCurrencyType);

            //Check Balance Change
            if (selectedWallet != null) {
                if (wallet.PointValue != selectedWallet.PointValue) {
                    idWalletDiv.innerText = new BigNumber(wallet.PointValue).toFormat();
                    notifyWindowEvent("BalanceChange", wallet.PointValue);
                }
            } else {
                idWalletDiv.innerText = new BigNumber(wallet.PointValue).toFormat();
            }

            selectedWallet = wallet;

            // 已登入
            idMenuLogin.classList.remove("is-hide");
            idLoginBtn.classList.add("is-hide");
            document.getElementById('idLogoutItem').classList.remove('is-hide');
            $(".avater-name").text(EWinWebInfo.UserInfo.EMail);

            //idWalletDiv.insertAdjacentHTML('beforeend', `<div class="currencyDiv">${EWinWebInfo.UserInfo.WalletList[0].CurrencyType}</div><div class="balanceDiv">${EWinWebInfo.UserInfo.WalletList[0].PointValue}</div>`);
        } else {
            // 尚未登入
            idMenuLogin.classList.add("is-hide");
            idLoginBtn.classList.remove("is-hide");
            document.getElementById('idLogoutItem').classList.add('is-hide');
            $(".avater-name").text("");
            selectedWallet = null;
        }
    }

    function userRecover(cb) {

        var recoverToken = getCookie("RecoverToken");
        var LoginAccount = getCookie("LoginAccount");

        if ((recoverToken != null) && (recoverToken != "")) {
            var postData;

            //API_ShowMask(mlp.getLanguageKey("登入復原中"), "full");
            //postData = encodeURI("RecoverToken=" + recoverToken + "&" + "LoginAccount=" + LoginAccount);
            postData = {
                "RecoverToken": recoverToken,
                "LoginAccount": LoginAccount
            }
            c.callService("/LoginRecover.aspx", postData, function (success, o) {
                //API_HideMask();

                if (success) {
                    var obj = c.getJSON(o);

                    if (obj.ResultCode == 0) {
                        EWinWebInfo.SID = obj.SID;
                        setCookie("RecoverToken", obj.RecoverToken, 365);
                        setCookie("LoginAccount", obj.LoginAccount, 365);
                        setCookie("SID", obj.SID, 365);
                        setCookie("CT", obj.CT, 365);


                        API_RefreshUserInfo(function () {
                            updateBaseInfo();

                            if (cb)
                                cb(true);
                        });
                    } else {
                        EWinWebInfo.UserLogined = false;
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請重新登入") + ":" + mlp.getLanguageKey(obj.Message), function () {
                            API_Logout(true);
                        });

                        if (cb)
                            cb(false);
                    }
                } else {
                    if (o == "Timeout") {
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"));
                    } else {
                        showMessageOK(mlp.getLanguageKey("錯誤"), o);
                    }

                    if (cb)
                        cb(false);
                }
            });
        }
    }

    function setLanguage(c, cb) {
        EWinWebInfo.Lang = c;
        window.localStorage.setItem("Lang", c);

        mlp.loadLanguage(c, function () {
            if (cb)
                cb();
        });

        mlpByGameCode.loadLanguageByOtherFile(EWinWebInfo.EWinUrl + "/GameCode.", c, function () {
            notifyWindowEvent("SetLanguage", c);
        });
        //mlpByGameBrand.loadLanguageByOtherFile(EWinWebInfo.EWinUrl + "/GameBrand.", c);      
    }

    function switchLang(Lang, isReload) {
        var LangText;
        $("#btn_switchlang").children().remove();

        switch (Lang) {
            case "JPN":
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                break;
            case "CHT":
                LangText = "繁體中文";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-ZH"></i>`);
                break;
            case "ENG":
                LangText = "English";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-EN"></i>`);
                break;
            case "CHS":
                LangText = "簡體中文";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-ZH"></i>`);
                break;
            default:
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                break;
        }

        //document.getElementById("idLangText").innerText = LangText;
        if (isReload) {
            setLanguage(Lang);
        }

        if (EWinWebInfo.Lang == "ENG") {
            $("#Footer_PrivacyPolicy").attr("onclick", "window.parent.API_ShowPartialHtml('', 'KnowYourCustomer_ENG', false, null)");
            $("#Footer_Rules").attr("onclick", "window.parent.API_ShowPartialHtml('', 'Terms&Conditions_ENG', false, null)");
            $("#Footer_About").attr("onclick", "window.parent.API_ShowPartialHtml('', 'ResponsibleGambling_ENG', false, null)");
            $("#li_HotArticle").hide();
            $("#li_RegisterActivityReceive").hide();
            $("#Footer_HotArticle").hide();
        } else {
            $("#Footer_PrivacyPolicy").attr("onclick", "window.parent.API_ShowPartialHtml('', 'PrivacyPolicy', true, null)");
            $("#Footer_Rules").attr("onclick", "window.parent.API_ShowPartialHtml('', 'Rules', true, null)");
            $("#Footer_About").attr("onclick", "window.parent.API_LoadPage('About','About.html')");
            $("#li_HotArticle").show();
            $("#li_RegisterActivityReceive").show();
            $("#Footer_HotArticle").show();
        }

        $("#btn_PupLangClose").click();
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

    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function delCookie(name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        cval = getCookie(name);
        if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
    }

    function onBtnLoginShow() {
        API_LoadPage("Login", "Login.aspx");
    }

    function getLoginMessage(cb) {
        lobbyClient.GetLoginMessage(EWinWebInfo.SID, Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    LoginMessage = o.Message;
                    LoginMessageVersion = o.Version;
                    if (cb != null) {
                        cb();
                    }
                }
            }
        });
    }

    function getCompanyGameCode2(cb) {

        var CategoryList = ['GameList_All', 'GameList_Solt', 'GameList_Electron', 'GameList_Live','GameList_Other'];

        var EWinGame = { GameBrand: "EWin", GameCategoryCode: "Slot", GameName: "EWinGaming" };
        lobbyClient.GetCompanyGameCode2(Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.CompanyCategoryDatas.find(e => e.CategoryName == 'Hot')) {
                        o.CompanyCategoryDatas.find(e => e.CategoryName == 'Hot').Datas.unshift(EWinGame);
                    }

                    LobbyGameList2.CompanyCategoryDatas = o.CompanyCategoryDatas;

                    LobbyGameList2.CategoryList = CategoryList;
                } else {
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("獲取遊戲資料錯誤") + ":" + mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout")
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新操作"));
                else
                    if ((o != null) && (o != ""))
                        alert(o);
            }

            if (cb)
                cb(success);
        });
    }

    function getCompanyGameCode(cb) {
        LobbyGameList = {
            HotList: [{ Description: "EWin", Categ: "Live", SubCateg: "Baccarat", GameBrand: "EWin", GameName: "EWinGaming", GameID: "0", IsHot: 1, IsNew: 0, RTPInfo: '{ "RTP": "0" }', AllowDemoPlay: 0 }],
            NewList: [],
            CategoryList: [{
                Categ: "All",
                SubCategList: ["Baccarat"],
                CategBrandList: ["EWin"]
            }, {
                Categ: "Live",
                SubCategList: ["Baccarat"],
                CategBrandList: ["EWin"]
            }],
            GameList: [{ Description: "EWin", Categ: "Live", SubCateg: "Baccarat", GameBrand: "EWin", GameName: "EWinGaming", GameID: "0", IsHot: 1, IsNew: 0, RTPInfo: '{ "RTP": "0" }', AllowDemoPlay: 0 }],
        };

        lobbyClient.GetCompanyGameCode(Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    //WebInfo.GameCodeList = o.GameCodeList;
                    o.GameCodeList.forEach(e => {
                        var tempSubCateg;



                        if (e.GameCategorySubCode == '') {
                            tempSubCateg = 'Other';
                        } else {
                            tempSubCateg = e.GameCategorySubCode;
                        }

                        var gameData = {
                            GameName: e.GameName,
                            GameBrand: e.BrandCode,
                            GameID: e.GameID,
                            Description: e.GameName,
                            Categ: e.GameCategoryCode,
                            SubCateg: tempSubCateg,
                            IsHot: e.IsHot,
                            IsNew: e.IsNew,
                            RTPInfo: e.RTPInfo,
                            AllowDemoPlay: e.AllowDemoPlay
                        };

                        if (e.IsNew == 1) {
                            LobbyGameList.NewList.push(gameData);
                        }

                        if (e.IsHot == 1) {
                            LobbyGameList.HotList.push(gameData);
                        }

                        //all
                        if (LobbyGameList.CategoryList[0].CategBrandList.find(eb => eb == e.BrandCode) == undefined)
                            LobbyGameList.CategoryList[0].CategBrandList.push(e.BrandCode);

                        if (LobbyGameList.CategoryList[0].SubCategList.find(eb => eb == tempSubCateg) == undefined)
                            LobbyGameList.CategoryList[0].SubCategList.push(tempSubCateg);

                        if (LobbyGameList.CategoryList.find(eb => eb.Categ == e.GameCategoryCode) == undefined) {
                            let data = {
                                Categ: e.GameCategoryCode,
                                SubCategList: [tempSubCateg],
                                CategBrandList: [
                                    e.BrandCode
                                ]
                            }
                            LobbyGameList.CategoryList.push(data);
                        } else {
                            LobbyGameList.CategoryList.forEach(cl => {
                                if (cl.Categ == e.GameCategoryCode) {
                                    if (cl.CategBrandList.find(cbl => cbl == e.BrandCode) == undefined)
                                        cl.CategBrandList.push(e.BrandCode)

                                    if (cl.SubCategList.find(cbl => cbl == tempSubCateg) == undefined)
                                        cl.SubCategList.push(tempSubCateg)
                                }
                            })
                        }

                        LobbyGameList.GameList.push(gameData);
                    }
                    );
                } else {
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("獲取遊戲資料錯誤") + ":" + mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout")
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新操作"));
                else
                    if ((o != null) && (o != ""))
                        alert(o);
            }

            if (cb)
                cb(success);
        });
    }

    function openHotArticle() {
        var orgin = "guides";

        switch (EWinWebInfo.Lang) {
            case "JPN":
                orgin = orgin + "_jp";
                break;
            case "CHT":
                break;
            case "ENG":
                orgin = orgin + "_en";
                break;
            default:
                break;
        }

        orgin = "Article/" + orgin + ".html";

        API_LoadPage("Article", orgin);
    }


    function resize() {
        if (IFramePage.contentWindow.document.body) {
            let iframebodyheight = IFramePage.contentWindow.document.body.offsetHeight;
            let iframeheight = $("#IFramePage").height();

            if (iframeheight != iframebodyheight) {
                $("#IFramePage").height(iframebodyheight);
            }
        }
    }

    function initByArt() {
        $('[data-btn-click="openLag"]').click(function () {
            $('.lang-select-panel').fadeToggle('fast');
        });

        $('.lang-select-panel a').click(function () {
            var curLang = $(this).text();
            $('.lang-select-panel').fadeToggle('fast');
            $('[data-btn-click="openLag"]').find('span').text(curLang);
        });

        //主選單收合
        $('.navbar-toggler').click(function () {
            $('.vertical-menu').toggleClass('navbar-show');
            $('.header_menu').toggleClass('show');
        });
        $('.header_area .mask_overlay').click(function () {
            $('.header_menu, .navbarMenu').removeClass('show');
            $('.navbar-toggler').attr("aria-expanded", "false");
        });
    }

    function init() {
        mlp = new multiLanguage(v);
        mlpByGameCode = new multiLanguage(v);

        if (window.localStorage.getItem("Lang")) {
            EWinWebInfo.Lang = window.localStorage.getItem("Lang");
        }

        initByArt();
        switchLang(EWinWebInfo.Lang, false);

        mlp.loadLanguage(EWinWebInfo.Lang, function () {
            mlpByGameCode.loadLanguageByOtherFile(EWinWebInfo.EWinUrl + "/GameCode.", EWinWebInfo.Lang, function () {
                var dstPage = c.getParameter("DstPage");
                lobbyClient = new LobbyAPI("/API/LobbyAPI.asmx");
                paymentClient = new PaymentAPI("/API/PaymentAPI.asmx");

                if (dstPage) {
                    var loadPage;
                    switch (dstPage.toUpperCase()) {
                        case "Home".toUpperCase():
                            loadPage = "Home";
                            break;
                        case "Reg".toUpperCase():
                            loadPage = "register";
                            break;
                        case "Login".toUpperCase():
                            loadPage = "Login";
                            break;
                        default:
                            loadPage = "Home";
                            break;
                    }

                    history.replaceState(null, null, "?" + c.removeParameter("DstPage"));
                    API_LoadPage(loadPage, loadPage + ".aspx");

                } else {
                    API_Home();
                }

                getCompanyGameCode();
                getCompanyGameCode2();
                //登入Check
                window.setTimeout(function () {
                    lobbyClient.GetCompanySite(Math.uuid(), function (success, o) {
                        if (success) {
                            if (o.Result == 0) {
                                SiteInfo = o;
                                if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                    API_SetLogin(EWinWebInfo.SID, function (logined) {
                                        //顯示登入資訊 
                                        //getLoginMessage(function () {
                                        //    if (LoginMessage) {
                                        //        if (!localStorage.getItem("LoginMessage")) {
                                        //            if (LoginMessageVersion > parseInt(localStorage.getItem("LoginMessage"))) {
                                        //                WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                        //                    sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                    if (document.getElementById("cboxLoginMessage").checked) {
                                        //                        localStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                    }
                                        //                });
                                        //            } else {
                                        //                if (!sessionStorage.getItem("LoginMessage")) {
                                        //                    WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                        //                        sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                        if (document.getElementById("cboxLoginMessage").checked) {
                                        //                            localStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                        }
                                        //                    });
                                        //                } else {
                                        //                    if (LoginMessageVersion > parseInt(sessionStorage.getItem("LoginMessage"))) {
                                        //                        WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                        //                            sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                            if (document.getElementById("cboxLoginMessage").checked) {
                                        //                                localStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                            }
                                        //                        });
                                        //                    }
                                        //                }
                                        //            }
                                        //        } else {
                                        //            if (LoginMessageVersion > parseInt(localStorage.getItem("LoginMessage"))) {
                                        //                WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                        //                    sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                    if (document.getElementById("cboxLoginMessage").checked) {
                                        //                        localStorage.setItem("LoginMessage", LoginMessageVersion);
                                        //                    }
                                        //                });
                                        //            }
                                        //        }
                                        //    }
                                        //});

                                        if (logined == false) {
                                            userRecover();
                                        } else {
                                            var srcPage = window.sessionStorage.getItem("SrcPage");

                                            if (srcPage) {
                                                window.sessionStorage.removeItem("SrcPage");
                                                API_LoadPage("SrcPage", srcPage, true);
                                            }
                                        }

                                        notifyWindowEvent("IndexFirstLoad", logined);
                                        EWinWebInfo.FirstLoaded = true;
                                    });
                                } else {
                                    updateBaseInfo();
                                }

                                //if (cb)
                                //    cb(true);
                            } else {
                                if (o.Message == "InvalidSID") {
                                    // login fail
                                    EWinWebInfo.UserLogined = false;
                                } else {
                                    EWinWebInfo.UserLogined = false;

                                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                                }

                            }
                        }
                        else {
                            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                                window.location.href = "index.aspx"
                            });
                        }

                    })
                }, 500);

                window.setInterval(function () {
                    // refresh SID and Token;
                    var guid = Math.uuid();

                    if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                        lobbyClient.KeepSID(EWinWebInfo.SID, guid, function (success, o) {
                            if (success == true) {
                                if (o.ResultCode == 0) {
                                    needCheckLogin = true;
                                } else {
                                    if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                        needCheckLogin = true;
                                    }
                                }
                            }
                        });

                    }
                }, 10000);

                window.setInterval(function () {
                    if (needCheckLogin == true) {
                        needCheckLogin = false;

                        if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                            API_SetLogin(EWinWebInfo.SID, function (logined) {
                                if (logined == false) {
                                    userRecover();
                                }
                            });
                        } else {
                            updateBaseInfo();
                        }
                    }
                }, 1000);

                //window.setInterval(function () {
                //    resize();
                //}, 1000);
            });
        });

        API_changeAvatarImg(getCookie("selectAvatar"));
        GameInfoModal = new bootstrap.Modal(document.getElementById("alertGameIntro"), { backdrop: 'static', keyboard: false });

        //resize();
    }

    //openFullSearch
    function openFullSearch(e) {
        var header_SearchFull = document.getElementById("header_SearchFull");
        header_SearchFull.classList.add("open");
    }

    //openFullSearch
    function closeFullSearch(e) {

        var header_SearchFull = document.getElementById("header_SearchFull");

        if (header_SearchFull.classList.contains("open")) {
            header_SearchFull.classList.remove("open");
        }
    }

    window.onload = init;
</script>
<body class="mainBody vertical-menu">
    <div class="loader-container" style="display:block; ">
        <div class="loader-box">
            <div class="loader-spinner">
                <div class="sk-fading-circle">
                    <div class="loader-logo"></div>  
                    <div class="sk-circle1 sk-circle"></div>
                    <div class="sk-circle2 sk-circle"></div>
                    <div class="sk-circle3 sk-circle"></div>
                    <div class="sk-circle4 sk-circle"></div>
                    <div class="sk-circle5 sk-circle"></div>
                    <div class="sk-circle6 sk-circle"></div>
                    <div class="sk-circle7 sk-circle"></div>
                    <div class="sk-circle8 sk-circle"></div>
                    <div class="sk-circle9 sk-circle"></div>
                    <div class="sk-circle10 sk-circle"></div>
                    <div class="sk-circle11 sk-circle"></div>
                    <div class="sk-circle12 sk-circle"></div>
                </div>
                  <div class="loader-text language_replace">正在加載...</div>    
            </div>
           
            
        </div>
        <div class="loader-backdrop is-show"></div>
    </div> 
    <header class="header_area" id="">
        <div class="header_menu ">
            <!-- class="navbar-expand-xl" trigger hidden -->
            <nav class="navbar">
                <!-- TOP Search-->
                <div class="search-full" id="header_SearchFull">
                    <div class="container-fluid">
                        <form class="search__wrapper">
                            <div class="form-group-search search-plusbutton">
                                <input id="" type="search" class="form-control custom-search" name="search" language_replace="placeholder" placeholder="輸入帳號">
                                <label for="search" class="form-label"><span class="language_replace">輸入帳號</span></label>
                                <div class="btn btnSearch"><span class="language_replace">搜尋</span></div>
                                <button type="reset" class="btn btnReset"><i class="icon icon-ewin-input-reset"></i></button>
                            </div>
                            <span class="btn btn__closefullsearch" onclick="closeFullSearch(this)"><i class="icon icon-ewin-input-compress"></i></span>
                        </form>
                    </div>
                </div>
                <div class="container-fluid navbar__content">
                    <!--MENU BUTTON -->
                    <button id="navbar_toggler" class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarMenu" aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- Sidebar Menu 側邊選單-->
                    <div class="navbarMenu collapse navbar-menu navbar-collapse offset" id="navbarMenu">
                        <ul class="nav navbar-nav menu_nav no-gutters">
                            <li class="nav-item navbarMenu__catagory">
                                <ul class="catagory">
                                    <li class="nav-item submenu dropdown"
                                        onclick="API_LoadPage('Casino', 'Casino.aspx', false)">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon icon-mask icon-all"></i>
                                            <span class="title language_replace">遊戲大廳</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-poker"></i>
                                            <span class="title language_replace">撲克</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-real"></i>
                                            <span class="title language_replace">真人</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-slot"></i>
                                            <span class="title language_replace">SLOT</span>
                                        </a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-mahjong"></i>
                                            <span class="title language_replace">麻將</span>
                                        </a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-sport"></i>
                                            <span class="title language_replace">體育</span>
                                        </a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-ect"></i>
                                            <span class="title language_replace">其他</span>
                                        </a>
                                    </li>                                   
                                </ul>
                            </li>
                            <li class="nav-item navbarMenu__catagory">
                                <ul class="catagory">
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link" onclick="API_LoadPage('MemberCenter', 'MemberCenter.aspx', true)">
                                            <%--<i class="icon icon-mask icon-loudspeaker"></i>--%>
                                            <span class="title language_replace">會員中心</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link" onclick="API_LoadPage('','ActivityCenter.aspx')">
                                            <i class="icon icon-mask icon-loudspeaker"></i>
                                            <span class="title language_replace">活動中心</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link" onclick="API_LoadPage('','Prize.aspx')">
                                            <i class="icon icon-mask icon-loudspeaker"></i>
                                            <span class="title language_replace">領獎中心</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link" onclick="API_LoadPage('WalletCenter','WalletCenter.aspx', true)">
                                            <%--<i class="icon icon-mask icon-loudspeaker"></i>--%>
                                            <span class="title language_replace">個人錢包</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <%--<i class="icon icon-mask icon-loudspeaker"></i>--%>
                                            <span class="title language_replace">履歷記錄</span></a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item navbarMenu__catagory">
                                <ul class="catagory">
                                    <li class="nav-item submenu dropdown" onclick="openHotArticle()">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-hot"></i>
                                            <span class="title language_replace">熱門文章</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown"
                                        onclick="API_LoadPage('QA','/Article/guide_Q&A_jp.html')">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-QA"></i>
                                            <span class="title language_replace">Q&A</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <%--<i class="icon icon-mask icon-logo"></i>--%>
                                            <span class="title language_replace">聯絡客服</span></a>
                                    </li>
                                </ul>
                            </li>                                                      
                            <li class="nav-item submenu dropdown" id="idLogoutItem">
                                <a class="nav-link" onclick="API_Logout(true)">
                                    <!-- <i class="icon icon2020-ico-login"></i> -->
                                    <i class="icon icon-mask icon-logout"></i>
                                    <span class="language_replace" langkey="登出">登出</span></a>
                            </li>
                        </ul>
                    </div>
                    <!-- 頂部 NavBar -->
                    <div class="header_topNavBar">
                        <!-- 左上角 -->
                        <div class="header_leftWrapper navbar-nav" onclick="API_LoadPage('Home','Home.aspx')">
                            <div class="navbar-brand">
                                <div class="logo"><a></a></div>
                            </div>
                        </div>
                        <!-- 右上角 -->
                        <div class="header_rightWrapper">

                            <div class="header_setting">
                                <ul class="nav">
                                    <!-- Search -->
                                    <li class="navbar-search nav-item">
                                        <button type="button" class="btn btn-round nav-link btn-search" data-toggle="modal" data-target="#alertSearch">
                                            <i class="icon icon-mask icon-search"></i>
                                        </button>
                                    </li>
                                    <!-- ==== 登入前 ====-->
                                    <li class="nav-item unLogIn_wrapper " id="idLoginBtn">
                                        <ul class="horiz-list">
                                            <li class="login">
                                                <button class="btn-login btn" type="button" onclick="onBtnLoginShow()"><span class="avater"><img src="images/avatar/avater-2.png" alt=""></span>
                                                    <span class="language_replace">登入</span></button>
                                            </li>
                                            <li class="register">
                                                <button class="btn-register btn " type="button" onclick="API_LoadPage('Register', 'Register.aspx')"><span class="language_replace">註冊</span></button>
                                            </li>
                                        </ul>
                                    </li>
                                    <!--  ==== 登入後 ====-->
                                    <li class="nav-item logIned_wrapper is-hide" id="idMenuLogin">
                                        <ul class="horiz-list">
                                            <li class="nav-item "  onclick="API_LoadPage('Deposit','Deposit.aspx', true)">
                                                <span class="balance-container">
                                                    <span class="balance-inner">
                                                        <span class="game-coin">
                                                            <!-- 未完成存款訂單小紅點 -->
                                                            <%--<span class="notify"><span class="notify-dot"></span></span>--%>
                                                            <img src="images/ico/coin-Ocoin.png" alt="">
                                                        </span>
                                                        <span class="balance-info">
                                                            <span class="amount">0</span>
                                                        </span>
                                                        <button class="btn btn-deposit btn-sub-main" onclick="">
                                                            <span class="icon-add"></span>
                                                        </button>
                                                    </span>
                                                </span>
                                            </li>
                                            <!-- User -->
                                            <li class="nav-item submenu dropdown">
                                                <a onclick="API_LoadPage('MemberCenter', 'MemberCenter.aspx', true)" class="btn nav-link btnDropDown avater_wrapper" role="button">
                                                    <span class="avater">
                                                        <span class="avater-img">
                                                            <img src="images/avatar/avater-2.png" alt="">
                                                        </span>
                                                        <span class="avater-name"></span>
                                                    </span>
                                                </a>
                                                <%--
                                                <a class="btn btn-round nav-link btnDropDown avater_wrapper"
                                                    data-toggle="dropdown" role="button" aria-haspopup="true"
                                                    aria-expanded="false" id="dropdown_navbar_Member">
                                                    <span class="avater">
                                                        <img src="images/avatar/avater-1.png" alt=""></span>
                                                </a>
                                                <!--下拉 dropdown-menu 選單 -->
                                                <ul class="dropdown-menu" aria-labelledby="dropdown_navbar_Member">
                                                    <li class="nav-item" onclick="API_LoadPage('Deposit','Deposit.aspx', true)">
                                                        <a class="nav-link"><i class="icon icon-mask icon-user"></i><span class="language_replace">入金</span></a>
                                                    </li>
                                                    <li class="nav-item" onclick="API_LoadPage('Withdrawal','Withdrawal.aspx', true)">
                                                        <a class="nav-link"><i class="icon icon-mask icon-user"></i><span class="language_replace">出金</span></a>
                                                    </li>
                                                    <li class="nav-item" onclick="API_LoadPage('MemberCenter', 'MemberCenter.aspx', true)">
                                                        <a class="nav-link"><i class="icon icon-mask icon-user"></i><span class="language_replace">會員設定</span></a>
                                                    </li>
                                                    <li class="nav-item" onclick="API_LoadPage('WalletCenter','WalletCenter.aspx', true)">
                                                        <a class="nav-link"><i class="icon icon-mask icon-user"></i><span class="language_replace">錢包中心</span></a>
                                                    </li>
                                                </ul>
                                                --%>
                                            </li>
                                        </ul>
                                    </li>

                                    <!-- 語系 -->
                                    <li class="nav-item submenu dropdown">
                                        <button type="button" class="btn nav-link btn-langExchange" data-toggle="modal" data-target="#ModalLanguage" id="btn_switchlang">
                                            <!-- 語系 轉換 ICON -->
                                            <%--<i class="icon icon-mask icon-flag-JP"></i>
                                            <i class="icon icon-mask icon-flag-EN"></i>
                                            <i class="icon icon-mask icon-flag-ZH"></i>--%>
                                        </button>   
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <div id="mask_overlay" class="mask_overlay"></div>
    </header>
    <!-- main_area = iframe高度 + Footer高度-->
    <%--    <div class="main_area" style="height: auto;">--%>
    <div class="main_area">
        <!-- iframe高度 自動計算高度-->
        <%--        <iframe id="IFramePage" class="mainIframe" name="mainiframe" style="height: 100%; min-height: calc(100vh - 60px)"></iframe>--%>
        <iframe id="IFramePage" class="mainIframe" name="mainiframe"></iframe>
    </div>
    <!-- footer -->
    <div id="footer" style="display: none">
        <footer class="footer">
            <div class="footer_inner">
                <div class="container">
                    <div class="row content">
                        <div class="footer_provider col-12 col-md-6">
                            <ul class="row ">
                                <li class="col logo-item">
                                    <img src="images/logo/logo-PG.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-CG.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-PP.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-BG.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-VA.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-BNG.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-pagcor.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-Bti.png" alt="">
                                </li>
                                <li class="col logo-item">
                                    <img src="images/logo/logo-zeus.png" alt="">
                                </li>
                            </ul>
                        </div>
                        <div class="footer_company col-12 col-md-6">
                            <ul class="company-info row">
                                <li class="info-item col">
                                    <a id="Footer_About" onclick="window.parent.API_LoadPage('About','About.html')"><span class="language_replace">關於我們</span></a>
                                </li>
                                <li class="info-item col">
                                    <a onclick="window.parent.API_ShowContactUs()">
                                        <span class="language_replace">聯絡客服</span>
                                    </a>
                                </li>
                                <li class="info-item col">
                                    <a id="Footer_Rules" onclick="window.parent.API_ShowPartialHtml('', 'Rules', true, null)">
                                        <span class="language_replace">利用規約</span>
                                    </a>
                                </li>
                                <li class="info-item col">
                                    <a id="Footer_PrivacyPolicy" onclick="window.parent.API_ShowPartialHtml('', 'PrivacyPolicy', true, null)">
                                        <span class="language_replace">隱私權政策</span>
                                    </a>
                                </li>
                                <li class="info-item col" id="li_HotArticle">
                                    <a onclick="openHotArticle()">
                                        <span class="language_replace">熱門文章</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
                <div class="col-12 copy_right ">
                    <div class="container">
                        <p class="text">Copyright © 2022 All Rights Reserved</p>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- mask_overlay 黑色半透明遮罩-->
    <div id="mask_overlay_popup" class="mask_overlay_popup"></div>


    <!-- Modal Language -->
    <div class="modal fade footer-center" id="ModalLanguage" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><span class="language_replace">言語を選択してください</span></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="lang-popup-wrapper">
                        <ul class="lang-popup-list">
                            <li class="lang-item custom-control custom-radioValue-lang" onclick="switchLang('JPN', true)">
                                <label class="custom-label">
                                    <input type="radio" name="button-langExchange" class="custom-control-input-hidden"
                                        checked>
                                    <div class="custom-input radio-button">
                                        <span class="flag JP"><i class="icon icon-mask icon-flag-JP"></i></span>
                                        <span class="name">日本文</span>
                                    </div>
                                </label>
                            </li>
                            <li class="lang-item custom-control custom-radioValue-lang" onclick="switchLang('ENG', true)">
                                <label class="custom-label">
                                    <input type="radio" name="button-langExchange" class="custom-control-input-hidden">
                                    <div class="custom-input radio-button">
                                        <span class="flag EN"><i class="icon icon-mask icon-flag-EN"></i></span>
                                        <span class="name">English</span>
                                    </div>
                                </label>
                            </li>
                            <li class="lang-item custom-control custom-radioValue-lang" onclick="switchLang('CHT', true)">
                                <label class="custom-label">
                                    <input type="radio" name="button-langExchange" class="custom-control-input-hidden">
                                    <div class="custom-input radio-button">
                                        <span class="flag ZH"><i class="icon icon-mask icon-flag-ZH"></i></span>
                                        <span class="name">繁體中文</span>
                                    </div>
                                </label>
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

    <!-- Search Modal -->
    <div class="modal fade no-footer " id="alertSearch" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <h5 class="modal-title"></h5> -->
                    <div class="searchFilter-wrapper">
                        <div class="searchFilter-item input-group">
                            <input type="text" class="form-control" language_replace="placeholder" placeholder="請輸入關鍵字">
                            <label for="" class="form-label"><span class="language_replace">請輸入關鍵字</span></label>
                        </div>
                        <div class="searchFilter-item input-group">
                            <select class="custom-select">
                                <option class="title" selected><span class="language_replace">遊戲品牌</span></option>
                                <option class="searchFilter-option" value=""><span class="language_replace">PG</span></option>
                            </select>
                        </div>
                        <div class="searchFilter-item input-group">
                            <select class="custom-select">
                                <option class="title" selected><span class="language_replace">遊戲類型</span></option>
                                <option class="searchFilter-option" value=""><span class="language_replace">真人</span></option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary btn-sm"><span class="">搜尋</span></button>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="game-search-wrapper">

                        <div class="search-result-wrapper">
                            <div class="search-result-inner">
                                <div class="search-result-list game-item-group">
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
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
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
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
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
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
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
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
                                    <div class="game-item">
                                        <div class="game-item-inner">
                                            <div class="game-item-focus">
                                                <div class="game-item-img">
                                                    <span class="game-item-link"></span>
                                                    <div class="img-wrap">
                                                        <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
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

    <!-- 遊戲介紹 Modal-->
    <div class="modal fade modal-game" tabindex="-1" role="dialog" aria-labelledby="alertGameIntro" aria-hidden="true" id="alertGameIntro">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title gameRealName language_replace"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <div class="game-intro-box">
                            <div class="game-img">
                                <div class="img-wrap">
                                    <img class="GameImg" src="" alt="">
                                </div>
                            </div>
                            <div class="game-info">
                                <div class="game-detail">
                                    <div class="info-item game-num">
                                        <div class="num title">NO.</div>
                                        <div class="data GameID">01234</div>
                                    </div>
                                    <div class="info-item game-rtp">
                                        <div class="rtp-name title">RTP</div>
                                        <div class="rtp-data RtpContent"></div>
                                    </div>
                                    <!-- 當加入最愛時=> class 加 "add" -->
                                    <div class="info-item game-myFavorite add">
                                        <div class="myFavorite-name title">
                                            <span class="language_replace FavoText">加入我的最愛</span>
                                            <!-- <span class="language_replace">移除最愛</span> -->
                                        </div>
                                        <div class="myFavorite-icon">
                                            <i class="icon-casinoworld-favorite"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="game-play">
                                    <button type="button" class="btn-game game-demo">
                                        <span class="language_replace">試玩</span>
                                        <div class="triangle"></div>
                                    </button>
                                    <button type="button" class="btn-primary btn-game game-login">
                                        <span class="language_replace">登入玩遊戲</span>
                                    </button>
                                </div>
                            </div>
                            <div class="game-intro is-hide">
                                遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertPartialHtml" aria-hidden="true" id="alertPartialHtml">
        <div class="modal-dialog modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title alertPartialHtml_Title">
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content alertPartialHtml_Content">
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertPartialHtml_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--alert-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertContactUs" aria-hidden="true" id="alertContactUs">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header border-bottom align-items-center">
                    <i class="icon-service"></i>
                    <h5 class="modal-title language_replace ml-1">客服信箱</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <!-- <div class="service-contact">
                            <span class="titel language_replace">客服信箱</span><span class="data"> : service@BBC117.com</span>
                        </div> -->
                        <div class="inbox_customerService" id="sendMail">
                            <div class="form-group">
                                <label class="form-title language_replace">問題分類</label>
                                <select class="form-control custom-style contectUs_Subject">
                                    <option class="language_replace">出入金</option>
                                    <option class="language_replace">註冊</option>
                                    <option class="language_replace">獎勵</option>
                                    <option class="language_replace">遊戲</option>
                                    <option class="language_replace">其他</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">信箱</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style contectUs_Eamil" language_replace="placeholder" placeholder="請輸入回覆信箱" autocomplete="off">
                                    <div class="invalid-feedback language_replace">錯誤提示</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">暱稱</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style contectUs_NickName" autocomplete="off" name="NickName">
                                    <div class="invalid-feedback language_replace">錯誤提示</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">電話</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style contectUs_Phone" autocomplete="off" name="Phone">
                                    <div class="invalid-feedback language_replace">錯誤提示</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">問題敘述</label>
                                <textarea class="form-control custom-style contectUs_Body" rows="5" language_replace="placeholder" placeholder=""></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <!-- <button class="btn btn-icon">
                        <i class="icon-copy" onclick="copyText('service@BBC117.com')"></i>
                    </button> -->
                    <div class="btn-container">
                        <button type="button" class="alertContact_OK btn btn-primary btn-block" data-dismiss="modal" onclick="sendContactUs();"><span class="language_replace">寄出</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--alert Msg-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertMsg" aria-hidden="true" id="alertMsg">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><%--<i class="icon-close-small is-hide"></i>--%></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <i class="icon-error_outline primary"></i>
                        <div class="text-wrap">
                            <p class="alertMsg_Text language_replace">變更個人資訊，請透過客服進行 ！</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertMsg_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                        <button type="button" class="alertMsg_Close btn btn-outline-primary btn-sm" data-dismiss="modal"><span class="language_replace">取消</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--alert Board Msg-->
    <div class="modal fade footer-center" tabindex="-1" role="dialog" aria-labelledby="alertBoardMsg" aria-hidden="true" id="alertBoardMsg">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="alert_Title"></div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><%--<i class="icon-close-small is-hide"></i>--%></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <article class="popup-detail-wrapper">
                            <div class="popup-detail-inner">                               
                                <div class="popup-detail-content">
                                  <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">公告時間</span></h6>
                                    <div class="section-content">
                                        <div class="alert_Time"></div>
                                    </div>
                                  </section>                    
                                  <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">公告詳情</span></h6>
                                    <div class="section-content">
                                        <p class="alert_Text language_replace">變更個人資訊，請透過客服進行 ！</p>                     
                                    </div>
                                  </section>
                                </div>
            
                            </div>
                        </article>
                        <!-- <i class="icon-error_outline primary"></i>
                        <div class="language_replace">公告時間：</div>
                        <div class="alert_Time"></div>
                        <div class="text-wrap">
                            <div class="language_replace">公告詳情：</div>
                            <p class="alert_Text language_replace">變更個人資訊，請透過客服進行 ！</p>
                        </div> -->
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alert_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade no-footer popupGameInfo" id="popupMoblieGameInfo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="game-info-mobile-wrapper">
                        <div class="game-item">
                            <div class="game-item-inner">
                                <div class="game-item-focus">
                                    <div class="game-item-img">
                                        <span class="game-item-link"></span>
                                        <div class="img-wrap">
                                            <img class="imgsrc" src="">
                                        </div>
                                    </div>
                                    <div class="game-item-info-detail open">
                                        <div class="game-item-info-detail-wrapper">
                                            <div class="game-item-info-detail-moreInfo">
                                                <ul class="moreInfo-item-wrapper">
                                                    <li class="moreInfo-item brand">
                                                        <span class="title language_replace">メーカー</span>
                                                        <span class="value BrandName"></span>
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
                                                        <h3 class="game-item-name GameName"></h3>
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
</body>
</html>
