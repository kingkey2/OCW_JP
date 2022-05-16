<%@ Page Language="C#" %>

<%
    if (EWinWeb.IsInMaintain()) {
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

    if (string.IsNullOrEmpty(Request["SID"]) == false) {
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
    if (string.IsNullOrEmpty(Request["Lang"])) {
        string userLang = CodingControl.GetDefaultLanguage();

        if (userLang.ToUpper() == "zh-TW".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-HK".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-MO".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-CHT".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-CHS".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-SG".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-CN".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "en-US".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "en-CA".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "en-PH".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "en".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "ko-KR".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "ko-KP".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "ko".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "ja".ToUpper()) {
            Lang = "JPN";
        } else { Lang = "JPN"; }
    } else {
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
<% if (EWinWeb.IsTestSite == false) { %>
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
<script src="Scripts/theme.js"></script>
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
    var ui = new uiControl();
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
    var messageModal;
    var SiteInfo;
    var selectedCurrency = '';
    var GameInfoModal;
    var v = "<%=Version%>";
    var LoginMessage;
    var LoginMessageVersion;
    var test = "";
    var gameWindow;
    var LobbyGameList;

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

    // 打開客服系統
    function API_OpenServiceChat() {
        if (!EWinWebInfo.UserLogined) {
            showMessageOK(mlp.getLanguageKey(""), mlp.getLanguageKey("請先登入"), function () {
                API_LoadPage("Login", "Login.aspx");
            });
        } else {
            var idChatDivE = document.getElementById("idChatDiv");
            var idChatFrameParent = document.getElementById("idChatFrameParent");
            var idChatFrame = document.createElement("IFRAME");

            if (idChatDivE.classList.contains("show")) {
                idChatDivE.classList.remove("show");
                idChatFrameParent.style.display = "none";
            }
            else {
                //<iframe id="idChatFrame" name="idChatFrame" class="ChatFrame" border="0" frameborder="0" marginwidth="0" marginheight="0" allowtransparency="no" scrolling="no"></iframe>
                if (idChatDivE.getAttribute("isLoad") != "1") {
                    idChatDivE.setAttribute("isLoad", "1");
                    idChatFrame.id = "idChatFrame";
                    idChatFrame.name = "idChatFrame";
                    idChatFrame.className = "ChatFrame";
                    idChatFrame.border = "0";
                    idChatFrame.frameBorder = "0";
                    idChatFrame.marginWidth = "0";
                    idChatFrame.marginHeight = "0";
                    idChatFrame.allowTransparency = "no";
                    idChatFrame.scrolling = "no";

                    idChatFrameParent.appendChild(idChatFrame);

                    idChatFrame.src = "ChatMain.aspx?" + "SID=" + EWinWebInfo.SID + "&Acc=" + EWinWebInfo.UserInfo.LoginAccount + "&Url=" + EWinWebInfo.EWinUrl;

                }

                idChatFrameParent.style.display = "";
                c.addClassName(idChatDivE, "show");

            }
        }
    }

    //打開熱門文章
    function API_OpenHotArticle() {
        openHotArticle();
    }

    function API_SetLogin(_SID, cb) {
        var sourceLogined = EWinWebInfo.UserLogined;
        checkUserLogin(_SID, function (logined) {
            var raiseCurrencyChange = false;
            updateBaseInfo();

            if (cb) {
                cb(logined);
            }

            if (sourceLogined == logined) {
                notifyWindowEvent("LoginState", logined);
            }

            if (raiseCurrencyChange) {
                notifyWindowEvent("BalanceChange", logined);
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

    function API_ShowMask(text, scope, cbClick) {
        var IFramePage = document.getElementById("IFramePage");
        var fullScope = false;

        if (scope != null) {
            if ((scope == true) || (scope == "f") || (scope == "full"))
                fullScope = true;
        }

        if (fullScope == false)
            ui.showMask(IFramePage, text, cbClick);
        else
            ui.showMask(null, text, cbClick);
    }

    function API_HideMask() {
        ui.hideMask();
    }

    function API_LoadingStart() {
        $('.loader-container').show();
        $('.loader-backdrop').removeClass('is-show');
    }

    function API_LoadingEnd(type) {
        var footerDom = c.getTemplate("footer");
        if (document.getElementById("IFramePage").contentDocument) {
            if (type && type == 1) {

            } else {
                //document.getElementById("IFramePage").contentDocument.body.appendChild(footerDom);
            }
        }
        $('.loader-backdrop').addClass('is-show');
        $('.loader-container').fadeOut(250, function () {
            $('.iframe-container').addClass('is-show');
        });

        resize();
    }

    function API_OpenGameCode(gameBrand, gameName) {
        var gameItem = LobbyGameList.GameList.find(x => x.GameBrand == gameBrand && x.GameName == gameName);
        var rtpInfoJson = gameItem.RTPInfo;
        var categ = gameItem.Categ;

        var divMessageBox = document.getElementById("alertGameIntro");
        var isInFavoGames = checkInFavoriteGame(gameBrand, gameName);

        if (divMessageBox != null) {
            divMessageBox.querySelector(".gameRealName").innerText = API_GetGameLang(1, gameBrand, gameName);
            divMessageBox.querySelector(".GameID").innerText = c.padLeft(gameItem.GameID.toString(), 5);
            divMessageBox.querySelector(".GameImg").src = EWinWebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameBrand + "/PC/" + EWinWebInfo.Lang + "/" + gameName + ".png";
            divMessageBox.querySelector(".GameImg").onerror = new Function("setDefaultIcon('" + gameBrand + "', '" + gameName + "')");

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

            divMessageBox.querySelector(".game-myFavorite").onclick = new Function("favBtnEvent('" + gameBrand + "', '" + gameName + "')");

            if (gameItem.AllowDemoPlay == 1) {
                divMessageBox.querySelector(".game-demo").classList.remove("is-hide");
                divMessageBox.querySelector(".game-demo").onclick = new Function("openDemo('" + gameBrand + "', '" + gameName + "' , '" + categ + "')");
            } else {
                divMessageBox.querySelector(".game-demo").classList.add("is-hide");
            }


            if (EWinWebInfo.UserLogined) {
                divMessageBox.querySelector(".game-login").innerText = mlp.getLanguageKey("開始遊戲");
                divMessageBox.querySelector(".game-login").onclick = new Function("openGame('" + gameBrand + "', '" + gameName + "' , '" + categ + "')");
            } else {
                divMessageBox.querySelector(".game-login").innerText = mlp.getLanguageKey("登入玩遊戲");
                divMessageBox.querySelector(".game-login").onclick = new Function("openGame('" + gameBrand + "', '" + gameName + "' , '" + categ + "')");
            }

            GameInfoModal.toggle();
        }
    }

    function API_LoadPage(title, url, checkLogined) {
        if (EWinWebInfo.IsOpenGame) {
            EWinWebInfo.IsOpenGame = false;
            SwitchGameHeader(0)
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
                IFramePage.style.height = "0px";
                IFramePage.src = url;
                //IFramePage.
            }

        }
    }


    function API_CloseGamePage() {
        var GameIFDiv = document.querySelector(".GameHeader")
        var IFramePage = document.getElementById("GameIFramePage");

        GameIFDiv.classList.add("is-hide");

        if (IFramePage) {
            GameIFDiv.removeChild(IFramePage)
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

    function API_ShowMessage(title, msg, cbOK, cbCancel) {
        return showMessage(title, msg, cbOK, cbCancel);
    }

    function API_ShowMessageOK(title, msg, cbOK) {
        return showMessageOK(title, msg, cbOK);
    }

    function API_NonCloseShowMessageOK(title, msg, cbOK) {
        return nonCloseShowMessageOK(title, msg, cbOK);
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

    //#endregion

    //#region Alert
    function showMessage(title, message, cbOK, cbCancel) {
        if ($("#alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            if (messageModal == null) {
                messageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });
            }

            if (divMessageBox != null) {
                messageModal.toggle();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.remove("is-hide");
                    divMessageBoxCloseButton.onclick = function () {
                        messageModal.hide();

                        if (cbCancel != null) {
                            cbCancel();
                        }
                    }
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        messageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showMessageOK(title, message, cbOK) {
        if ($("#alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            if (messageModal == null) {
                messageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });
            }

            if (divMessageBox != null) {
                messageModal.show();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        messageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function WithCheckBoxShowMessageOK(title, message, cbOK) {
        var alertDom = $("#alertContactWithCheckBox")
        if (alertDom.attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContactWithCheckBox");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");
            var checkBoxmessageModal;
            if (checkBoxmessageModal == null) {
                checkBoxmessageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });
            }

            if (divMessageBox != null) {
                checkBoxmessageModal.show();
                alertDom.attr("aria-hidden", 'false');

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        checkBoxmessageModal.hide();
                        alertDom.attr("aria-hidden", 'true');
                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function nonCloseShowMessageOK(title, message, cbOK) {
        var nonCloseDom = $("#nonClose_alertContact");
        if (nonCloseDom.attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("nonClose_alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");
            var nonCloseMessageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });

            if (divMessageBox != null) {
                nonCloseMessageModal.show();
                nonCloseDom.attr("aria-hidden", 'false');

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        nonCloseMessageModal.hide();
                        nonCloseDom.attr("aria-hidden", 'true');
                        if (cbOK != null)
                            cbOK();
                    }
                }
                divMessageBoxContent.innerHTML = message;
            }
        }
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
    //#endregion

    //#region Game
    function SwitchGameHeader(type, gameBrand, gameName, categ) {
        var headers = document.querySelectorAll(".header-container .header-inner");

        switch (type) {
            case 0:
                //Close

                for (var i = 0; i < headers.length; i++) {
                    var dom = headers[i];

                    if (dom.classList.contains("GameHeader")) {
                        dom.classList.add("is-hide");
                    } else {
                        dom.classList.remove("is-hide");
                    }
                }

                break;
            case 1:
                //Open          

                for (var i = 0; i < headers.length; i++) {
                    var dom = headers[i];

                    if (dom.classList.contains("GameHeader")) {
                        var logoDom = dom.querySelector(".GameLogo");
                        var nameDom = dom.querySelector(".GameName");
                        dom.classList.remove("is-hide");
                        logoDom.src = EWinWebInfo.EWinGameUrl + "/Lobby/images/lobby/logo/" + gameBrand + "/logoPC_" + categ + ".png";
                        logoDom.alt = gameBrand;
                        nameDom.innerText = API_GetGameLang(1, gameBrand, gameName);

                    } else {
                        dom.classList.add("is-hide");
                    }
                }

                break;
        }
    }

    function GameLoadPage(url, gameBrand, gameName) {
        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            if (IFramePage.tagName.toUpperCase() == "IFRAME".toUpperCase()) {
                API_LoadingStart();
                IFramePage.src = url;
                IFramePage.onload = function () {
                    API_LoadingEnd();
                }
            }
        }
    }

    function setDefaultIcon(brand, name) {
        var img = event.currentTarget;
        img.onerror = null;
        img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + brand + "/PC/" + WebInfo.Lang + "/" + name + ".png";
    }

    function openGame(gameBrand, gameName, categ) {
        if (gameWindow) {
            gameWindow.close();
        }

        if (!EWinWebInfo.UserLogined) {
            showMessageInGameInfo(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                GameInfoModal.hide();
                API_LoadPage("Login", "Login.aspx");
            }, null);
        } else {
            EWinWebInfo.IsOpenGame = true;
            setGameCodeToMyGames(gameBrand, gameName);
            //GameInfoModal.hide();

            if (gameBrand.toUpperCase() != "EWin".toUpperCase()) {
                if (EWinWebInfo.DeviceType == 1) {
                    gameWindow = window.open("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
                } else {
                    SwitchGameHeader(1, gameBrand, gameName, categ);
                    GameLoadPage("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href);
                }
            } else {
                setGameCodeToMyGames(gameBrand, gameName);
                GameInfoModal.hide();
                gameWindow = window.open("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
            }
        }
    }

    function openDemo(gameBrand, gameName, categ) {
        EWinWebInfo.IsOpenGame = true;
        setGameCodeToMyGames(gameBrand, gameName);
        GameInfoModal.hide();

        if (gameWindow) {
            gameWindow.close();
        }

        if (gameBrand.toUpperCase() != "EWin".toUpperCase()) {
            if (EWinWebInfo.DeviceType == 1) {
                gameWindow = window.open("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
            } else {
                SwitchGameHeader(1, gameBrand, gameName, categ);
                GameLoadPage("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href);
            }
        } else {
            setGameCodeToMyGames(gameBrand, gameName);
            GameInfoModal.hide();
            gameWindow = window.open("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "Maharaja Game")
        }
    }
    //#endregion

    //#region Game    
    function favBtnEvent(gameBrand, gameName) {
        var target = event.currentTarget;
        var type = target.classList.contains("add") ? 1 : 0;

        if (type == 0) {

            showMessageInGameInfo(mlp.getLanguageKey("我的最愛"), mlp.getLanguageKey("加入我的最愛"), function () {
                target.classList.add("add");
                setFavoriteGame(gameBrand, gameName, type);
                if (document.getElementById('IFramePage').contentWindow.refreshFavoGame) {
                    document.getElementById('IFramePage').contentWindow.refreshFavoGame();
                }
                //setGameLobbySection(nowWebTag);
            }, null);
        } else {
            showMessageInGameInfo(mlp.getLanguageKey("我的最愛"), mlp.getLanguageKey("是否從我的最愛移除"), function () {
                target.classList.remove("add");
                setFavoriteGame(gameBrand, gameName, type);
                if (document.getElementById('IFramePage').contentWindow.refreshFavoGame) {
                    document.getElementById('IFramePage').contentWindow.refreshFavoGame();
                }
                //setGameLobbySection(nowWebTag);
            }, null);
        }
    };

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
                if (arrayMyGames.length == 14) {
                    arrayMyGames.pop();
                    arrayMyGames.unshift(objMyGame);
                } else {
                    arrayMyGames.unshift(objMyGame);
                }
            }

            localStorage.setItem('MyGames', JSON.stringify(arrayMyGames));
        }

        if (document.getElementById('IFramePage').contentWindow.refreshMyGmae) {
            document.getElementById('IFramePage').contentWindow.refreshMyGmae();
        }

    }
    //#endregion

    function copyText(copyVal) {
        navigator.clipboard.writeText(copyVal).then(
            () => {
                //window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功"))
            },
            () => {
                //window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗"))
            });
    }

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


            // 已登入
            idMenuLogin.classList.remove("is-hide");
            idLoginBtn.classList.add("is-hide");
            idWalletDiv.innerText = new BigNumber(wallet.PointValue).toFormat();
            selectedCurrency = wallet.CurrencyType;
            document.getElementById('idLogoutItem').classList.remove('is-hide');

            //idWalletDiv.insertAdjacentHTML('beforeend', `<div class="currencyDiv">${EWinWebInfo.UserInfo.WalletList[0].CurrencyType}</div><div class="balanceDiv">${EWinWebInfo.UserInfo.WalletList[0].PointValue}</div>`);
        } else {
            // 尚未登入
            idMenuLogin.classList.add("is-hide");
            idLoginBtn.classList.remove("is-hide");
            document.getElementById('idLogoutItem').classList.add('is-hide');

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

        switch (Lang) {
            case "JPN":
                LangText = "日本語";
                break;
            case "CHT":
                LangText = "繁體中文";
                break;
            case "ENG":
                LangText = "English";
                break;
            case "CHS":
                LangText = "簡體中文";
                break;
            default:
                LangText = "日本語";
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

    function showErrorPage() {
        $('#system-msg').show();
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

    function openServiceChat() {
        var idChatDivE = document.getElementById("idChatDiv");
        var idChatFrameParent = document.getElementById("idChatFrameParent");
        var idChatFrame = document.createElement("IFRAME");

        if (idChatDivE.classList.contains("show")) {
            idChatDivE.classList.remove("show");
            idChatFrameParent.style.display = "none";
        }
        else {
            //<iframe id="idChatFrame" name="idChatFrame" class="ChatFrame" border="0" frameborder="0" marginwidth="0" marginheight="0" allowtransparency="no" scrolling="no"></iframe>
            if (idChatDivE.getAttribute("isLoad") != "1") {
                idChatDivE.setAttribute("isLoad", "1");
                idChatFrame.id = "idChatFrame";
                idChatFrame.name = "idChatFrame";
                idChatFrame.className = "ChatFrame";
                idChatFrame.border = "0";
                idChatFrame.frameBorder = "0";
                idChatFrame.marginWidth = "0";
                idChatFrame.marginHeight = "0";
                idChatFrame.allowTransparency = "no";
                idChatFrame.scrolling = "no";

                idChatFrameParent.appendChild(idChatFrame);

                idChatFrame.src = "ChatMain.aspx?SID=" + EWinWebInfo.SID + "&Acc=" + EWinWebInfo.UserInfo.LoginAccount + "&Url=" + EWinWebInfo.EWinUrl;
            }

            idChatFrameParent.style.display = "";
            c.addClassName(idChatDivE, "show");

        }
    }

    function sleep(time) {
        return new Promise((resolve) => setTimeout(resolve, time));
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

    function init() {
        mlp = new multiLanguage(v);
        mlpByGameCode = new multiLanguage(v);
       
        if (window.localStorage.getItem("Lang")) {
            EWinWebInfo.Lang = window.localStorage.getItem("Lang");
        }

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

                //登入Check
                window.setTimeout(function () {
                    lobbyClient.GetCompanySite(Math.uuid(), function (success, o) {
                        if (success) {
                            if (o.Result == 0) {
                                SiteInfo = o;
                                if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                    API_SetLogin(EWinWebInfo.SID, function (logined) {
                                        //顯示登入資訊 
                                        getLoginMessage(function () {
                                            if (LoginMessage) {
                                                if (!localStorage.getItem("LoginMessage")) {
                                                    if (LoginMessageVersion > parseInt(localStorage.getItem("LoginMessage"))) {
                                                        WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                                            sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                                            if (document.getElementById("cboxLoginMessage").checked) {
                                                                localStorage.setItem("LoginMessage", LoginMessageVersion);
                                                            }
                                                        });
                                                    } else {
                                                        if (!sessionStorage.getItem("LoginMessage")) {
                                                            WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                                                sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                                                if (document.getElementById("cboxLoginMessage").checked) {
                                                                    localStorage.setItem("LoginMessage", LoginMessageVersion);
                                                                }
                                                            });
                                                        } else {
                                                            if (LoginMessageVersion > parseInt(sessionStorage.getItem("LoginMessage"))) {
                                                                WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                                                    sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                                                    if (document.getElementById("cboxLoginMessage").checked) {
                                                                        localStorage.setItem("LoginMessage", LoginMessageVersion);
                                                                    }
                                                                });
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    if (LoginMessageVersion > parseInt(localStorage.getItem("LoginMessage"))) {
                                                        WithCheckBoxShowMessageOK('', LoginMessage, function () {
                                                            sessionStorage.setItem("LoginMessage", LoginMessageVersion);
                                                            if (document.getElementById("cboxLoginMessage").checked) {
                                                                localStorage.setItem("LoginMessage", LoginMessageVersion);
                                                            }
                                                        });
                                                    }
                                                }
                                            }
                                        });

                                        if (logined == false) {
                                            userRecover();
                                        } else {
                                            var srcPage = window.sessionStorage.getItem("SrcPage");

                                            if (srcPage) {
                                                window.sessionStorage.removeItem("SrcPage");
                                                API_LoadPage("SrcPage", srcPage, true);
                                            }
                                        }
                                    });
                                } else {
                                    updateBaseInfo();
                                }
                                API_HideMask();
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

                window.setInterval(function () {
                    resize();
                }, 1000);
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

    <header class="header_area" id="">
        <div class="main_menu ">
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
                            <span class="btn btn__closefullsearch"   onclick="closeFullSearch(this)"><i class="icon icon-ewin-input-compress"></i></span>
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
                                    <li class="nav-item submenu dropdown" onclick="API_LoadPage('Casino', 'Casino.aspx', true)">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-ewin-user"></i>
                                            <span class="title language_replace">賭場</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-ewin-user-multi"></i>
                                            <span class="title language_replace">體育</span></a>
                                    </li>
                                    <li class="nav-item submenu dropdown">
                                        <a class="nav-link">
                                            <i class="icon icon-mask icon-ewin-user-multi"></i>
                                            <span class="title language_replace">麻將</span></a>
                                    </li>
                                </ul>
                            </li>
                            <!-- <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown with Mask <span class="caret"></span></a>
                                <ul class="dropdown-menu list-inline">
                                  <li><strong>Tools:</strong></li>
                                  <li><a class="btn btn-default" href="#">Foo</a></li>
                                  <li><a class="btn btn-default" href="#">Bar</a></li>
                                </ul>
                              </li>                   -->
                            <li class="nav-item submenu dropdown" id="idLogoutItem">
                                <a class="nav-link" onclick="API_Logout(true)">
                                    <!-- <i class="icon icon2020-ico-login"></i> -->
                                    <i class="icon icon-mask icon-ewin-logout"></i>
                                    <span class="language_replace" langkey="登出">登出</span></a>
                            </li>
                        </ul>
                    </div>
                    <!-- 頂部 NavBar -->
                    <div class="header_topNavBar">
                        <!-- 左上角 -->
                        <div class="header_leftWrapper navbar-nav" onclick="API_LoadPage('Home','Home.aspx')">
                            <div class="logo">
                                <div class="img-wrap">
                                    <a>
                                        <img src="images/logo.svg" alt=""></a>
                                </div>
                            </div>
                        </div>
                        <!-- 右上角 -->
                        <div class="header_rightWrapper">

                            <div class="header_setting">
                                <ul class="nav">
                                    <!-- Search -->
                                    <li class="navbar-search nav-item">
                                        <button type="button" class="btn btn-round nav-link" data-toggle="modal" data-target="#alertSearch"><i class="icon icon-mask icon-search"></i>
                                        </button>
                                    </li>
                                    <!-- ==== 登入前 ====-->
                                    <li class="nav-item unLogIn_wrapper " id="idLoginBtn">
                                        <ul class="horiz-list">
                                            <li class="login">
                                                <button class="btn btn-full-main" type="button" onclick="onBtnLoginShow()"><span class="language_replace">登入</span></button>
                                            </li>
                                            <li class="register">
                                                <button class="btn btn-full-sub" type="button" onclick="API_LoadPage('Register', 'Register.aspx')"><span class="language_replace">註冊</span></button>
                                            </li>
                                        </ul>
                                    </li>
                                    <!--  ==== 登入後 ====-->
                                    <li class="nav-item logIned_wrapper is-hide" id="idMenuLogin">
                                        <ul class="horiz-list">
                                            <li class="nav-item ">
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
                                                    </span>
                                                </span>
                                            </li>
                                            <!-- User -->
                                            <li class="nav-item submenu dropdown">
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
                                            </li>
                                        </ul>
                                    </li>

                                    <!-- 語系 -->
                                    <%--<li class="nav-item submenu dropdown">
                                        <a onclick="dataToggleDropdown(this)"
                                            class="btn btn-round nav-link btnDropDown"
                                            data-toggle="dropdown" role="button" aria-haspopup="true"
                                            aria-expanded="false" id="dropdown_navbar_Lang">
                                            <i class="icon icon-mask icon-user"></i></a>
                                        <ul class="dropdown-menu" aria-labelledby="dropdown_navbar_Lang">
                                            <li class="nav-item">
                                                <a class="nav-link language_replace" onclick="switchLang('JPN', true)">日本語</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link language_replace" onclick="switchLang('ENG', true)">English</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link language_replace" onclick="switchLang('CHT', true)">繁體中文</a>
                                            </li>
                                        </ul>
                                    </li>
                                    --%>
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
    <div class="main_area" style="height: auto;">
        <!-- iframe高度 自動計算高度-->
        <iframe id="IFramePage" class="mainIframe" name="mainiframe" style="height: 100%; min-height: calc(100vh - 60px)"></iframe>
    </div>
    <!-- footer -->
    <div id="footer">
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
                            <option class="searchFilter-option" value="" ><span class="language_replace">PG</span></option>
                        </select>
                    </div>
                    <div class="searchFilter-item input-group">                   
                        <select class="custom-select">
                            <option class="title" selected><span class="language_replace">遊戲類型</span></option>
                            <option class="searchFilter-option" value="" ><span class="language_replace">真人</span></option>
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

     <!--alert-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertContact" aria-hidden="true" id="alertContact">
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
                            <p class="alertContact_Text language_replace">變更個人資訊，請透過客服進行 ！</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertContact_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                        <button type="button" class="alertContact_Close btn btn-outline-primary btn-sm" data-dismiss="modal"><span class="language_replace">取消</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
