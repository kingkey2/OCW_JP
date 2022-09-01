<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="/Activity/event/basic.css" />
</head>
<script>
    function init() {
        var SID = window.top.EWinWebInfo.SID;
        var btn = document.getElementById("btn1");
        if (SID != "") {
            btn.setAttribute('href', "https://servicebooongo.com/bngevent/event?event=202209BR&lang=jp&currency=JPY&project=kingkey&player_token=OCoin_" + window.top.EWinWebInfo.SID);
        } else {
            btn.setAttribute('href', "https://servicebooongo.com/bngevent/event?event=202209BR&lang=jp&currency=JPY&project=kingkey");
        }
    }

    window.onload = init();
</script>
<body>
    <!-- 活動 Banner Start "activity-popup-detail-img" ====-->
    <div class="activity-popup-detail-img">
        <img src="/Activity/event/bng/09092022moonfestival/img/img-w.jpg" class="desktop" alt="" />
        <img src="/Activity/event/bng/09092022moonfestival/img/img-act.jpg" class="mobile" alt="" />
    </div>
    <!-- 活動 Banner END ===================-->

    <div class="section-act-wrapper">
        <article class="article-act">
            <p class="act-title act-intro">名月の候、大吉と共にお月見ベットレースに参加し、ブンーゴーの対象ゲームで100ラウンドベットし、誰が最も沢山ギフトマネーをもらえるかを競い合おう！</p>
            <p class="act-title"></p>

            <!--活動期間-->
            <section class="section-act-wrap">
                <h3 class="section-act-title">【 キャンペーン期間 】</h3>
                <div class="section-act-content">
                    <p>2022/09/09 13:00 ~ 2022/09/16 13:00 (UTC+9)</p>
                </div>
            </section>

            <!--活動內容-->
            <section class="section-act-wrap">
                <h3 class="section-act-title">【 キャンペーン内容 】</h3>
                <div class="section-act-content">
                    <p>キャンペーン期間中にブン―ゴーの対象ゲームをプレイし、合計100ラウンドベットすれば、換算されたポイントによりランキングされ、高額なギフトマネーがもらえます！</p>
                </div>
            </section>

            <!--活動規則-->
            <section class="section-act-wrap">
                <p class="btn-wrap">
                    <a id="btn1" href=""
                        class="act-Button" target="_blank">キャンペーン詳細及びルール説明</a>
                </p>
            </section>

            <!--活動對象遊戲-->
            <section class="section-act-wrap">
                <h3 class="section-act-title">【 対象ゲーム 】</h3>
                <ul class="act-game-list row">
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','270','ロータス チャーム')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/270.png" alt="チャーム" title="チャーム"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','265','カイシェン・ウェルス')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/265.png" alt="カイシェン・ウェルス" title="カイシェン・ウェルス"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','267','ザ キング オブ ヒーローズ')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/267.png" alt="ザ キング オブ ヒーローズ" title="ザ キング オブ ヒーローズ"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','269','エッグス オブ ゴールド')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/269.png" alt="エッグス オブ ゴールド" title="エッグス オブ ゴールド"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','242','タイガー ジャングル')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/242.png" alt="タイガー ジャングル" title="タイガー ジャングル"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','228','ゴールドヒット！')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/228.png" alt="ゴールドヒット！" title="ゴールドヒット！"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','254','ブラック ウルフ')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/254.png" alt="ブラック ウルフ" title="ブラック ウルフ"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','262','太陽の神殿3-幸運が集う')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/262.png" alt="太陽の神殿3-幸運が集う" title="太陽の神殿3-幸運が集う"></span></a></li>
                    <li class="act-game-item col-6 col-smd-4 col-lg-3"><a onclick="window.parent.openGame('BNG','261','ハッピー・フィッシュ')"><span class="img-crop">
                        <img src="Activity/event/bng/09092022moonfestival/img/icon/261.png" alt="ハッピー・フィッシュ" title="ハッピー・フィッシュ"></span></a></li>

                </ul>
            </section>

            <!--注意事項-->
            <section class="section-act-wrap">
                <h3 class="section-act-wrap-title">【 注意事項 】</h3>
                <div class="section-act-content">
                    <ul class="act-notice-list">
                        <li class="act-notice-item">1. プレイヤーがランキングの資格を得ると、キャンペーン期間中のすべての有効な賭けラウンドがポイント計算に含まれます。</li>
                        <li class="act-notice-item">2. ポイントは小数点以下第2位に四捨五入して計算します。</li>
                        <li class="act-notice-item">3. このキャンペーンに参加できるのは、有効なベットラウンドのみです。</li>
                        <li class="act-notice-item">4. 同一アカウント・電話番号・IPアドレス・共有PC・ネット環境につき、一回のみ参加できます。</li>
                        <li class="act-notice-item">5.
						公正なゲーム環境を確保するため、不正行為でゲームしたり、ほかの会員を妨害したりし、ゲーム規約に違反したことが確認された場合、該当アカウントを凍結させていただきます。</li>
                        <li class="act-notice-item">6. マハラジャはキャンペーンの修正およびキャンセルする権利を留保します。</li>
                    </ul>
                    <!-- <p class="act-notice">1. プレイヤーがランキングの資格を得ると、キャンペーン期間中のすべての有効な賭けラウンドがポイント計算に含まれます。</p>
				<p class="act-notice">2. ポイントは小数点以下第2位に四捨五入して計算します。</p>
				<p class="act-notice">3. このキャンペーンに参加できるのは、有効なベットラウンドのみです。</p>
				<p class="act-notice">4. 同一アカウント・電話番号・IPアドレス・共有PC・ネット環境につき、一回のみ参加できます。
					<p class="act-notice">5. 公正なゲーム環境を確保するため、不正行為でゲームしたり、ほかの会員を妨害したりし、ゲーム規約に違反したことが確認された場合、該当アカウントを凍結させていただきます。
					</p>
					<p class="act-notice">6. マハラジャはキャンペーンの修正およびキャンセルする権利を留保します。</p> -->
                </div>
            </section>
        </article>
    </div>
</body>
</html>
