<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
    string type = Request["type"];
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
    var LobbyClient;
    var v = "<%:Version%>";
    var t = "<%:type%>";

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        LobbyClient = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        getUserAccountEventSummary();
        mlp = new multiLanguage(v);

        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            if (LobbyClient != null) {
                //window.parent.sleep(500).then(() => {
                //    if (WebInfo.UserLogined) {
                //        document.getElementById("idGoRegBtn").classList.add("is-hide");
                //        $(".register-list").hide();
                //    }
                //})

                if (t) {
                    switch (t) {
                        case "1":
                            GoActivityDetail(1, '/Activity/Act001/CenterPage/index.html');
                            break;
                        case "2":
                            GoActivityDetail(2, '/Activity/Act002/CenterPage/index.html');
                            break;
                    }
                }

            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });
    }

    function getUserAccountEventSummary() {
        LobbyClient.GetUserAccountEventSummary(WebInfo.SID, Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.Datas.length > 0) {
                        for (var i = 0; i < o.Datas.length; i++) {
                            if (o.Datas[i].ActivityName == 'RegisterBouns') {
                                if (o.Datas[i].CollectCount == o.Datas[i].JoinCount) {
                                    $('#ModalRegister .btn-secondary').removeClass('is-hide');    
                                } else {
                                    $('#ModalRegister .btn-full-sub').removeClass('is-hide');
                                }
                                $('#ModalRegister .btn-primary').addClass('is-hide');

                            } else if (o.Datas[i].ActivityName == 'Act001') {
                                if (o.Datas[i].CollectCount == o.Datas[i].JoinCount) {
                                    $('#ModalDeposit .btn-secondary').removeClass('is-hide');  
                                } else {
                                    $('#ModalDeposit .btn-full-sub').removeClass('is-hide');
                                }
                                $('#ModalDeposit .btn-primary').addClass('is-hide');
                            }
                        }
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                        //document.getElementById('gameTotalValidBetValue').textContent = 0;
                    }
                }
            }
        });
    }

    function GoActivityDetail(type,url) {
        event.stopPropagation();
        //001 入金
        //002 註冊
        //003 7日
        //004 BNG端午節
        if (url) {
            switch (type) {
                case 1:
                    $('#ModalDeposit .activity-popup-detail-inner').load(url);
                    $('#ModalDeposit').modal('show');
                    break;
                case 2:
                    $('#ModalRegister .activity-popup-detail-inner').load(url);
                    $('#ModalRegister').modal('show');
                    break;
                case 3:
                    $('#ModalDailylogin .activity-popup-detail-inner').load(url);
                    $('#ModalDailylogin').modal('show');
                    break;
                case 4:
                    $('#ModalPP1 .activity-popup-detail-inner').load(url);
                    $('#ModalPP1').modal('show');
                    break;
                case 5:
                    $('#ModalPP2 .activity-popup-detail-inner').load(url);
                    $('#ModalPP2').modal('show');

                    break;
                default:
                    break;
            }
           
        }
    }

    function activityBtnClick(type) {
        event.stopPropagation();

        switch (type) {
            case 1:
                window.parent.API_ComingSoonAlert();
                break;
            case 2:
                window.parent.API_LoadPage('Deposit', 'Deposit.aspx', true);
                break;
            case 3:
                window.parent.API_LoadPage('', 'Prize.aspx');
                break;
            case 4:
                $('#ModalPP1').modal('hide');
                window.parent.searchGameByBrandAndGameCategory("PP", "Slot");
                break;
            case 5:
                $('#ModalPP2').modal('hide');
                window.parent.searchGameByBrandAndGameCategory("PP", "Live");
                break;
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

    window.onload = init;
</script>
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <div class="container">
                <div class="sec-title-container sec-title-activity">
                    <!-- 領獎中心 link-->
                    <a class="btn btn-link btn-prize" onclick="window.parent.API_LoadPage('','Prize.aspx', true)">
                        <span class="title language_replace">前往領獎中心</span><i class="icon icon-mask icon-arrow-right-dot"></i>
                    </a>
                    <div class="sec-title-wrapper">
                        <h1 class="sec-title title-deco"><span class="language_replace">活動</span></h1>
                    </div>
                </div>
                <section class="section-wrap section-activity">
                    <div class="activity-item-group" onclick="GoActivityDetail(3,'/Activity/Act003/CenterPage/index.html')">
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(4,'/Activity/event/pp-1/index-jp.html')">                           
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp-1/img/img-act.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">この狛犬大吉がプラグマティックプレイさんをマハラジャに招き、みんなさんにギフトマネーをプレゼントするぞ！対象スロットゲームをプレイし、リーダーボードで高いポジションを争い、優勝ギフトマネーを獲得！ラッキーなプレイヤーの方々はサプライズ賞ももらえるぞ！</div>
                                        </div>
                                       <!-- 活動詳情 Popup-->
                                       <button type="button" onclick="activityBtnClick(4)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>                        
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(5,'/Activity/event/pp-2/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp-2/img/img-live-act.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace"></figcaption> -->
                                            <div class="desc language_replace">この狛犬大吉がプラグマティックプレイさんをマハラジャに招き、みんなさんにギフトマネーをプレゼントするぞ！ライブカジノをプレイし、リーダーボードで高いポジションを争い、優勝ギフトマネーを獲得しよう！。</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" onclick="activityBtnClick(5)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-03-m.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">簽到功能全新上市，神犬大吉奉女神之命給所有勤勞的MAHARAJA的會員帶來豐厚的簽到禮金！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" onclick="activityBtnClick(1)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(1,'/Activity/Act001/CenterPage/index.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-deposit.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">慶祝Maharaja改版新上市，四葉為此帶來女神的祝福，活動期間入金任意金額都能享有對應比值的回饋獎金(上限五萬)！！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(2,'/Activity/Act002/CenterPage/index.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-register.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">神犬大吉歡迎所有新朋友，無論是註冊新會員還是推廌朋友一起玩，都可以領到大吉送的見面禮金！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" onclick="activityBtnClick(3)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        

                    </div>
                </section>

            </div>

        </div>

    </main>



    <!-- Modal -->
    <div class="modal fade footer-center" id="ModalTest" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">我是標題</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDailylogin-->
    <div class="modal fade footer-center" id="ModalDailylogin" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">金曜日的禮物</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="window.parent.API_ComingSoonAlert()">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalDeposit" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">盛大開幕15日限定</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalRegister" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">MAHARAJA見面禮</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="window.parent.API_LoadPage('','Prize.aspx')">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalBNG" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">金熱門！</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade footer-center" id="ModalPP1" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">スロットトーナメントおよび現金配布</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="activityBtnClick(4)">參加活動</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade footer-center" id="ModalPP2" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">夏のウィークリートーナメント-ライブカジノ</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="activityBtnClick(5)">參加活動</button>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
