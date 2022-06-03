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

            if (LobbyClient != null) {
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
                    $('#ModalBNG .activity-popup-detail-inner').load(url);
                    $('#ModalBNG').modal('show');
                    break;
                default:
                    break;
            }
           
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
                    <a class="btn btn-link btn-prize" onclick="window.parent.API_LoadPage('','Prize.aspx')">
                        <span class="title language_replace">クイックピックアップ</span><i class="icon icon-mask icon-arrow-right-dot"></i>
                    </a>
                    <div class="sec-title-wrapper">
                        <h1 class="sec-title title-deco"><span class="language_replace">プロモーション</span></h1>
                    </div>
                </div>
                <section class="section-wrap section-activity">
                    <div class="activity-item-group">
                        <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-dailylogin.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">ゴールドヒット！</figcaption> -->
                                            <div class="desc language_replace">
                                                デイリーミッションキャンペーン機能実装！女神様のご命令で、この狛犬大吉が勤勉なマハラジャ全会員に豊かなデイリーギフトマネーをプレゼントするぞ！
                       
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button onclick="GoActivityDetail(3,'/Activity/Act003/CenterPage/index.html')" type="button" class="btn-popup btn btn-full-main"><span class="language_replace">今すぐチェック</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-deposit.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">ゴールドヒット！</figcaption> -->
                                            <div class="desc language_replace">
                                                リニューアルしたマハラジャのグランドオープンを祝うため、四葉が女神様の祝福をささげます。キャンペーン期間中任意金額を入金された方に、相応のボーナス（上限5万Ocoinまで）をプレゼントいたします！！

                       
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button onclick="GoActivityDetail(1,'/Activity/Act001/CenterPage/index.html')" type="button" class="btn-popup btn btn-full-main"><span class="language_replace">今すぐチェック</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-register.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">ゴールドヒット！</figcaption> -->
                                            <div class="desc language_replace">
                                                新しい友達大歓迎！新規登録の方にも、友達を招待した方にも、この狛犬大吉が歓迎ギフトマネーをプレゼントするぞ！
                       
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button onclick="GoActivityDetail(2,'/Activity/Act002/CenterPage/index.html')" type="button" class="btn-popup btn btn-full-main"><span class="language_replace">今すぐチェック</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                   <%--     <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-BNG.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">ゴールドヒット！</figcaption> -->
                                            <div class="desc language_replace"></div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button onclick="GoActivityDetail(4,'/Activity/Act004/CenterPage/index.html')" type="button" class="btn-popup btn btn-full-main"><span class="language_replace">今すぐチェック</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>--%>

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
                    <button type="button" class="btn btn-primary">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDailylogin-->
    <div class="modal fade footer-center" id="ModalDailylogin" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">ゴールドヒット！</h5>
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
                    <button type="button" class="btn btn-primary">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalDeposit" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">ゴールドヒット！</h5>
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
                    <button type="button" class="btn btn-primary">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalRegister" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">ゴールドヒット！</h5>
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
                    <button type="button" class="btn btn-primary">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalBNG" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">ゴールドヒット！</h5>
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
                    <button type="button" class="btn btn-primary">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
