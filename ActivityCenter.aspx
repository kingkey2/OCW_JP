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

    function GoActivityDetail(url) {
        event.stopPropagation();

        if (url) {
            
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
                                <div class="activity-item-link" data-toggle="modal" data-target="#exampleModa11">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！</figcaption>
                                            <div class="desc language_replace">オンラインカジノで遊ぶならKonibet!!!コニベ島の住民になるだけで、限定$20体験ボーナスをプレゼント！この機会に是非、Konibetに登録しましょう！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button"  class="btn-popup btn btn-full-main"  onclick="GoActivityDetail()"><span class="language_replace">今すぐチェック</span></button>

                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link"  data-toggle="modal" data-target="#exampleModal2">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！</figcaption>
                                            <div class="desc language_replace">オンラインカジノで遊ぶならKonibet!!!コニベ島の住民になるだけで、限定$20体験ボーナスをプレゼント！この機会に是非、Konibetに登録しましょう！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"  onclick="GoActivityDetail()"><span class="language_replace">今すぐチェック</span></button>

                                    </div>
                                </div>
                            </div>
                        </figure>
                         <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link"  data-toggle="modal" data-target="#exampleModal2">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！</figcaption>
                                            <div class="desc language_replace">オンラインカジノで遊ぶならKonibet!!!コニベ島の住民になるだけで、限定$20体験ボーナスをプレゼント！この機会に是非、Konibetに登録しましょう！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"  onclick="GoActivityDetail()"><span class="language_replace">今すぐチェック</span></button>

                                    </div>
                                </div>
                            </div>
                        </figure>
                         <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link"  data-toggle="modal" data-target="#exampleModal2">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！</figcaption>
                                            <div class="desc language_replace">オンラインカジノで遊ぶならKonibet!!!コニベ島の住民になるだけで、限定$20体験ボーナスをプレゼント！この機会に是非、Konibetに登録しましょう！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"  onclick="GoActivityDetail()"><span class="language_replace">今すぐチェック</span></button>

                                    </div>
                                </div>
                            </div>
                        </figure>
                         <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link"  data-toggle="modal" data-target="#exampleModal2">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！</figcaption>
                                            <div class="desc language_replace">オンラインカジノで遊ぶならKonibet!!!コニベ島の住民になるだけで、限定$20体験ボーナスをプレゼント！この機会に是非、Konibetに登録しましょう！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"  onclick="GoActivityDetail()"><span class="language_replace">今すぐチェック</span></button>

                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner">
                                <!-- 活動連結 -->
                                <div class="activity-item-link"  data-toggle="modal" data-target="#exampleModal3">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <figcaption class="title language_replace">ゴールドヒット！</figcaption>
                                            <div class="desc language_replace">オンラインカジノで遊ぶならKonibet!!!コニベ島の住民になるだけで、限定$20体験ボーナスをプレゼント！この機会に是非、Konibetに登録しましょう！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"  onclick="GoActivityDetail()"><span class="language_replace">今すぐチェック</span></button>
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
    <div class="modal fade footer-center" id="exampleModa11" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <h5 class="modal-title"></h5>          -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                            <div class="activity-popup-detail-img">
                                <img src="images/activity-popup-b-01.jpg" class="desktop" alt="">
                                <img src="images/activity-popup-b-m-01.jpg" class="mobile" alt="">
                            </div>
                            <div class="activity-popup-detail-content">
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">開催期間</span></h6>
                                    <div class="section-content">
                                        <p>2021年1月1日(土) 00：00 ～ 2021年1月3日(月) 23：59</p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">対象者</span></h6>
                                    <div class="section-content">
                                        <p>開催期間中にログインし、【リアルマネー】でプレイしたプレイヤー様 </p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">プロモーション内容</span></h6>
                                    <div class="section-content">
                                        <p>
                                            開催期間中、1日の間にログインし、ゲームをリアルマネーでプレイしたプレイヤー様を12時間ごとにランダムで抽選し、$500のボーナスクーポンをお送りいたします。 ボーナスの進呈はインボックスでお知らせしますのでお見逃しなく！ ※ランダムでの進呈となりますので、ライブチャットへのお問い合わせはご遠慮ください。 ボーナスクーポンの賭け条件は5倍！スロットゲームでのみご使用いただけます(出金するために$2,500分のプレイが必要です）。 ボーナスクーポンの有効期限は配布から24時間です。 ボーナスクーポンを受け取ったプレイヤー様が受け取った旨をご自身のSNSにシェアし、そのスクリーンショットをカスタマサービスにご提出いただければ、追加の$500ボーナスクーポンをお送りいたします。 追加ボーナスも、賭け条件は5倍で、スロットゲームでのみご使用いただけます。有効期限は配布から24時間です。 翌日になると対象プレイヤーがまたリセットされるため、何度もボーナスを受け取れるチャンスがございます。3日間、12時間毎の抽選なので、3日連続でログインされたプレイヤー様は当たるチャンスがさらに高まります（1人当たりの最大当選回数は1日に1回となります） 
                                        </p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">申請方法</span></h6>
                                    <div class="section-content">
                                        <p>
                                            $500のボーナスクーポンはランダムで抽選されますので、申請する必要はございません。 追加の$500ボーナスクーポンは、SNSでシェアされたスクリーンショットをカスタマーサービスのライブチャットにご提出ください。 ※日時とユーザーネームが入ったスクリーンショットをお願い致します。※.LINE,Facebook,Twitter,Instagram（ストーリーを除く）でのご投稿をお願
                                        </p>
                                    </div>
                                </section>
                            </div>

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

    <!-- Modal -->
    <div class="modal fade footer-center" id="exampleModal2" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <h5 class="modal-title"></h5>          -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                            <div class="activity-popup-detail-img">
                                <img src="images/activity-popup-b-01.jpg" class="desktop" alt="">
                                <img src="images/activity-popup-b-m-01.jpg" class="mobile" alt="">
                            </div>
                            <div class="activity-popup-detail-content">
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">開催期間</span></h6>
                                    <div class="section-content">
                                        <p>2021年1月1日(土) 00：00 ～ 2021年1月3日(月) 23：59</p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">対象者</span></h6>
                                    <div class="section-content">
                                        <p>開催期間中にログインし、【リアルマネー】でプレイしたプレイヤー様 </p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">プロモーション内容</span></h6>
                                    <div class="section-content">
                                        <p>
                                            開催期間中、1日の間にログインし、ゲームをリアルマネーでプレイしたプレイヤー様を12時間ごとにランダムで抽選し、$500のボーナスクーポンをお送りいたします。 ボーナスの進呈はインボックスでお知らせしますのでお見逃しなく！ ※ランダムでの進呈となりますので、ライブチャットへのお問い合わせはご遠慮ください。 ボーナスクーポンの賭け条件は5倍！スロットゲームでのみご使用いただけます(出金するために$2,500分のプレイが必要です）。 ボーナスクーポンの有効期限は配布から24時間です。 ボーナスクーポンを受け取ったプレイヤー様が受け取った旨をご自身のSNSにシェアし、そのスクリーンショットをカスタマサービスにご提出いただければ、追加の$500ボーナスクーポンをお送りいたします。 追加ボーナスも、賭け条件は5倍で、スロットゲームでのみご使用いただけます。有効期限は配布から24時間です。 翌日になると対象プレイヤーがまたリセットされるため、何度もボーナスを受け取れるチャンスがございます。3日間、12時間毎の抽選なので、3日連続でログインされたプレイヤー様は当たるチャンスがさらに高まります（1人当たりの最大当選回数は1日に1回となります） 
                                        </p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">申請方法</span></h6>
                                    <div class="section-content">
                                        <p>
                                            $500のボーナスクーポンはランダムで抽選されますので、申請する必要はございません。 追加の$500ボーナスクーポンは、SNSでシェアされたスクリーンショットをカスタマーサービスのライブチャットにご提出ください。 ※日時とユーザーネームが入ったスクリーンショットをお願い致します。※.LINE,Facebook,Twitter,Instagram（ストーリーを除く）でのご投稿をお願
                                        </p>
                                    </div>
                                </section>
                            </div>

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

    <!-- Modal -->
    <div class="modal fade footer-center" id="exampleModal3" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <h5 class="modal-title"></h5>          -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                            <div class="activity-popup-detail-img">
                                <img src="images/activity-popup-b-01.jpg" class="desktop" alt="">
                                <img src="images/activity-popup-b-m-01.jpg" class="mobile" alt="">
                            </div>
                            <div class="activity-popup-detail-content">
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">開催期間</span></h6>
                                    <div class="section-content">
                                        <p>2021年1月1日(土) 00：00 ～ 2021年1月3日(月) 23：59</p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">対象者</span></h6>
                                    <div class="section-content">
                                        <p>開催期間中にログインし、【リアルマネー】でプレイしたプレイヤー様 </p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">プロモーション内容</span></h6>
                                    <div class="section-content">
                                        <p>
                                            開催期間中、1日の間にログインし、ゲームをリアルマネーでプレイしたプレイヤー様を12時間ごとにランダムで抽選し、$500のボーナスクーポンをお送りいたします。 ボーナスの進呈はインボックスでお知らせしますのでお見逃しなく！ ※ランダムでの進呈となりますので、ライブチャットへのお問い合わせはご遠慮ください。 ボーナスクーポンの賭け条件は5倍！スロットゲームでのみご使用いただけます(出金するために$2,500分のプレイが必要です）。 ボーナスクーポンの有効期限は配布から24時間です。 ボーナスクーポンを受け取ったプレイヤー様が受け取った旨をご自身のSNSにシェアし、そのスクリーンショットをカスタマサービスにご提出いただければ、追加の$500ボーナスクーポンをお送りいたします。 追加ボーナスも、賭け条件は5倍で、スロットゲームでのみご使用いただけます。有効期限は配布から24時間です。 翌日になると対象プレイヤーがまたリセットされるため、何度もボーナスを受け取れるチャンスがございます。3日間、12時間毎の抽選なので、3日連続でログインされたプレイヤー様は当たるチャンスがさらに高まります（1人当たりの最大当選回数は1日に1回となります） 
                                        </p>
                                    </div>
                                </section>
                                <section class="section-wrap">
                                    <h6 class="title"><i class="icon icon-mask ico-grid"></i><span class="">申請方法</span></h6>
                                    <div class="section-content">
                                        <p>
                                            $500のボーナスクーポンはランダムで抽選されますので、申請する必要はございません。 追加の$500ボーナスクーポンは、SNSでシェアされたスクリーンショットをカスタマーサービスのライブチャットにご提出ください。 ※日時とユーザーネームが入ったスクリーンショットをお願い致します。※.LINE,Facebook,Twitter,Instagram（ストーリーを除く）でのご投稿をお願
                                        </p>
                                    </div>
                                </section>
                            </div>

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
