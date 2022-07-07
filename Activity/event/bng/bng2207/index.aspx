﻿<%@ Page Language="C#" AutoEventWireup="true"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
	<style>
	.act-wrapper{
		margin: 0 auto;
		padding: 0 5%;
		color: #666;
		font-family: 'Noto Sans JP', sans-serif!important;
	}
	h3{
		font-size: 1.2rem;
		color: #333;
	}
	.section-wrap p{
	    font-size: 1rem;
	    line-height: 1.5;
	    color: #555;
	    margin-left: 25px;
	}
	.act-title{
		width: 100%;
		margin: 10px auto!important;
		color: #0185FF!important;
		font-size: 1em;
		font-weight: bold;
	}
	.act-title2{
		width: 100%;
		margin: 10px auto!important;
		color: #AC580B!important;
		font-size: 1em;
		font-weight: bold;
	}
	.act-subtitle{
		font-size: 1.2em;
		color: #0185FF!important;
		font-weight: bold;
		margin-right: 10px;
	}

	.activity-popup-detail-content .section-wrap-title:before {
	    width: 10px;
	    height: 14px;

	}
	.act-notice{
		color: #666;
	}
	.mark-red{
		color: #940202;
		font-weight: bold;
	}
	.act-Button {
	background-color:#2dabf9;
	border-radius:28px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:17px;
	padding:16px 31px;
	text-decoration:none;
	text-shadow:0px 1px 0px #263666;
	box-shadow: 0px 1px 10px #333;
	}
	.act-Button:hover {
		background-color:#0688fa;
	}
	.act-Button:active {
		position:relative;
		top:1px;
	}
	.act-game-list{
		list-style: none;
		font-size: 14px;
		width: 60%;
		margin: 0 auto;
	}
	.act-game-list li{
		float: left;
		margin:15px 15px 0 0;
	}
	
	
	@media screen and (max-width: 414px) {

		.act-game-list{
			width: 90%;
			padding: 0;
		}
		.act-game-list img{
			width: 100%;
			height: 100%;
		}
		.act-game-list li{
		float: left;
		margin:10px 10px 0 0;
	    }
	}
	@media screen and (min-width: 320px) and (max-width: 410px){

		.act-game-list{
			width: 105%;
		}

	}
	
</style>

<!-- 活動 Banner Start "activity-popup-detail-img" ====-->
<div class="activity-popup-detail-img">
	<img src="/Activity/event/bng/bng2207/img/popup_top_img.jpg" class="desktop" alt=""/>
	<img src="/Activity/event/bng/bng2207/img/actList-img.jpg" class="mobile" alt=""/>


</div>
<!-- 活動 Banner END ===================-->


<div class="act-wrapper">
	<section class="section-wrap">

	<p class="act-title">この狛犬大吉と一緒にBNGの周年記念キャンペーンに参加するぞ！対象ゲームで100ラウンドベットして、ポイントの高い人はボーナスが多くもらえるぞ！</p>
	<!--活動期間-->
	<h3 class="section-wrap-title">【 キャンペーン期間 】</h3>
	<p>2022/07/11 13:00 ~ 2022/07/18 13:00</p>

	<!--活動對象-->
	<h3 class="section-wrap-title">【 キャンペーン対象 】</h3>
	<p>マハラジャ全会員</p>

	<!--活動規則連結-->
	<h3 class="section-wrap-title">【 キャンペーンルール 】</h3>
	<p align="center"><a href="https://servicebooongo.com/bngevent/event?event=202207WR&lang=jp&currency=JPY" class="act-Button" target="_blank">キャンペーン詳細及びルール説明</a></p>

	<!--活動內容-->
	<h3 class="section-wrap-title">【 キャンペーン内容 】</h3>
	<p>イベント期間中にBNGの対象ゲームで合計100ラウンドベットすれば、ポイントによりランキング順位が計算され、高額なボーナスがもらえます！</p>

	<!--活動對象遊戲-->
	<h3 class="section-wrap-title">【 対象ゲーム 】</h3>
	<ul class="act-game-list">
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/01_sun_of_egypt_3_icon_150x150_en.png" alt="太陽の神殿3-幸運が集う" title="太陽の神殿3-幸運が集う"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/02_diver2_icon_150x150_en.png" alt="ザ キング オブ ヒーローズ" title="ザ キング オブ ヒーローズ"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/03_happy_fish_icon_150x150_en.png" alt="ハッピー・フィッシュ" title="ハッピー・フィッシュ"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/04_eggs_of_gold_icon_150x150_en.png" alt="エッグス オブ ゴールド" title="エッグス オブ ゴールド"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/05_magic_apple_2_icon_150x150_en.png" alt="マジック アップル 2" title="マジック アップル 2"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/06_hit_the_gold_icon_150x150_en.png" alt="ゴールドヒット！" title="ゴールドヒット！"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/07_BW_HW_icon_150x150_en.png" alt="ブラック ウルフ" title="ブラック ウルフ"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/08_caishen_wealth_icon_150x150_en.png" alt="カイシェン・ウェルス" title="カイシェン・ウェルス"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/09_tiger_jungle_icon_150x150_en.png" alt="タイガー ジャングル" title="タイガー ジャングル"/></a></li>
		<li><a onclick="window.parent.openGame('','','')"><img src="Activity/event/bng/bng2207/img/icon/010_candy_boom_icon_150x150_en.png" alt="キャンディー ブーム" title="キャンディー ブーム"/></a></li>

	</ul>


	<div style="margin-bottom: 0.875rem;clear: both;"></div>

	<!--注意事項-->
	<h3 class="section-wrap-title">【 注意事項 】</h3>
	<p class="act-notice">1. BNGのキャンペーン説明ページに書かれている時間はすべて UTC+8となります。</p>

    <p class="act-notice">2. キャンペーンの資格を満たせば、キャンペーン期間中のすべての有効な賭けラウンドがポイントに換算されます。</p>

    <p class="act-notice">3. ポイントは小数点以下第2位に四捨五入して計算します。</p>

    <p class="act-notice">4. このイベントに参加できるのは、有効なベットラウンドのみです。</p>

    <p class="act-notice">5. 同一アカウント・電話番号・IPアドレス・共有PC・ネット環境につき、一回のみ参加できます。</p>

    <p class="act-notice">6. 公正なゲーム環境を確保するため、不正行為でゲームしたり、ほかの会員を妨害したりし、ゲーム規約に違反したことが確認された場合、該当アカウントを凍結させていただきます。 </p>

    <p class="act-notice">7. 主催者(BNG)はいつでも予告なしに、プロモーションを修正、停止、キャンセルする権利を留保します。</p>

    <p class="act-notice">8. マハラジャはキャンペーンの修正およびキャンセルする権利を留保します。</p>
	</section>

</div>
</body>
</html>
