﻿<%@ Page Language="C#" %>

<!DOCTYPE html>

<html lang="zh-Hant-TW" class="innerHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Maharaja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="js/vendor/swiper/css/swiper-bundle.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/record.css">
</head>

<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <!-- 總覽 -->
            <section class="section-record-overview section-wrap">
                <div class="container">
                    <div class="sec-title-container sec-title-prize">
                        <div class="sec-title-wrapper">
                            <h1 class="sec-title title-deco"><span class="language_replace">紀錄總覽</span></h1>
                        </div>
                    </div>
                    <div class="record-overview-wrapper">
                        <!-- 出入金總覽 -->
                        <div class="record-overview-box payment">
                            <div class="record-overview-inner">
                                <div class="record-overview-title-wrapper">
                                    <div class="title">ゴールドフロー履歴情報</div>
                                    <div class="btn btn-detail-link">詳細</div>
                                </div>
                                <div class="record-overview-content">
                                    <div class="MT__table">
                                        <!-- Thead  -->
                                        <div class="Thead">
                                            <div class="thead__tr">
                                                <div class="thead__th">
                                                    <span class="title language_replace">先月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                                <div class="thead__th">
                                                    <span class="title language_replace">今月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Tbody -->
                                        <div class="Tbody">
                                            <div class="tbody__tr">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">入金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount">199,999</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">入金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount">0</span>
                                                    </span>
                                                </div>

                                            </div>
                                            <div class="tbody__tr stress">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">出金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount">199,999</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">出金</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount">0</span>
                                                    </span>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 遊戲總覽-->
                        <div class="record-overview-box game">
                            <div class="record-overview-inner">
                                <div class="record-overview-title-wrapper">
                                    <div class="title">ゴールドフロー履歴情報</div>
                                    <div class="btn btn-detail-link">詳細</div>
                                </div>
                                <div class="record-overview-content">
                                    <div class="MT__table">
                                        <!-- Thead  -->
                                        <div class="Thead">
                                            <div class="thead__tr">
                                                <div class="thead__th">
                                                    <span class="title language_replace">先月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                                <div class="thead__th">
                                                    <span class="title language_replace">今月</span>
                                                    <span class="unit">OCoin</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Tbody -->
                                        <div class="Tbody">
                                            <div class="tbody__tr">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">ベット</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount">199,999</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">ベット</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="deposit-amount amount">0</span>
                                                    </span>
                                                </div>

                                            </div>
                                            <div class="tbody__tr stress">
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">勝/負</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount">199,999</span>
                                                    </span>
                                                </div>
                                                <div class="tbody__td">
                                                    <span class="td__title">
                                                        <span class="title language_replace">勝/負</span>
                                                    </span>
                                                    <span class="td__content">
                                                        <span class="withdraw-amount amount">0</span>
                                                    </span>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 紀錄 - Table -->
            <section class="section-wrap section-record">
                <div class="container">

                    <!-- 出入金紀錄-->
                    <section class="section-record-payment">
                        <!-- TABLE TITLE -->
                        <div class="sec-title-container sec-title-record sec-record-payment">
                            <!-- 活動中心 link-->
                            <!-- 前/後 月 -->
                            <div class="sec_link">
                                <button class="btn btn-link btn-gray" type="button">
                                    <i class="icon arrow arrow-left mr-1"></i><span
                                        class="language_replace">先月</span></button>
                                <button class="btn btn-link btn-gray" type="button">
                                    <span class="language_replace">来月︎</span><i
                                        class="icon arrow arrow-right ml-1"></i></button>
                            </div>
                            <div class="sec-title-wrapper">
                                <h1 class="sec-title title-deco"><span class="language_replace">出入金紀錄</span></h1>
                                <!-- 獎金/禮金 TAB -->
                                <div class="tab-record tab-scroller tab-2">
                                    <div class="tab-scroller__area">
                                        <ul class="tab-scroller__content">
                                            <li class="tab-item active">
                                                <span class="tab-item-link"><span class="title language_replace">出入金紀錄</span>
                                                </span>
                                            </li>
                                            <li class="tab-item">
                                                <span class="tab-item-link"><span class="title language_replace">遊戲紀錄</span></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- TABLE for Desktop -->
                        <div class="MT__table table-RWD table-payment table-desktop">
                            <!-- thead  -->
                            <div class="Thead">
                                <div class="thead__tr">
                                    <div class="thead__th"><span class="language_replace"></span></div>
                                    <div class="thead__th">
                                        <span class="language_replace">日期</span>
                                        <span class="arrow arrow-down"></span>
                                    </div>
                                    <div class="thead__th"><span class="language_replace">OCOIN</span><span class="arrow arrow-up"></span></div>
                                    <div class="thead__th"><span class="language_replace">支付方式</span><span class="arrow arrow-up"></span></div>
                                    <div class="thead__th"><span class="language_replace">編號</span></div>
                                    <div class="thead__th"><span class="language_replace">狀態</span></div>
                                </div>
                            </div>
                            <!-- tbody -->
                            <div class="Tbody">
                                <div class="tbody__tr deposit">
                                    <div class="tbody__td td-payment">
                                        <span class="td__content">
                                            <span class="payment-status">
                                                <!-- 存款 -->
                                                <span class="label-status deposit language_replace">預け入れ</span>
                                            </span>
                                        </span>
                                    </div>
                                    <div class="tbody__td td-date">
                                        <span class="td__content">
                                            <span class="date-period">
                                                <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                                                    class="time">13:00</span>
                                            </span>
                                        </span>
                                    </div>
                                    <div class="tbody__td td-amount td-number">
                                        <span class="td__content"><span class="">999,999,999</span></span>
                                    </div>
                                    <div class="tbody__td td-paymentWay">
                                        <span class="td__content"><span class="">paypal</span></span>
                                    </div>
                                    <div class="tbody__td td-orderNo">
                                        <span class="td__content">
                                            <span class="">PD080N6001579596232017481720220401173951</span>
                                            <button type="button"
                                                class="btn btn-round btn-copy">
                                                <i class="icon icon-mask icon-copy"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <div class="tbody__td td-transesult">
                                        <span class="td__content"><span class="">成功</span></span>
                                    </div>
                                </div>
                                <div class="tbody__tr withdraw">
                                    <div class="tbody__td td-payment">
                                        <span class="td__content">
                                            <span class="payment-status">
                                                <!-- 出款 -->
                                                <span class="label-status withdraw language_replace">引き出し</span>
                                            </span>
                                        </span>
                                    </div>
                                    <div class="tbody__td td-date">
                                        <span class="td__content">
                                            <span class="date-period">
                                                <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                                                    class="time">13:00</span>
                                            </span>
                                        </span>
                                    </div>
                                    <div class="tbody__td td-amount td-number">
                                        <span class="td__content"><span class="">999,999,999</span></span>
                                    </div>
                                    <div class="tbody__td td-paymentWay">
                                        <span class="td__content"><span class="">paypal</span></span>
                                    </div>
                                    <div class="tbody__td td-orderNo">
                                        <span class="td__content">
                                            <span class="">PD080N6001579596232017481720220401173951</span>
                                            <button type="button"
                                                class="btn btn-round btn-copy">
                                                <i class="icon icon-mask icon-copy"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <div class="tbody__td td-transesult">
                                        <span class="td__content"><span class="">成功</span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- TABLE for Mobile -->
                        <div class="record-table-container table-mobile">
                            <div class="record-table payment-record">

                                <!-- 入金 -->
                                <div class="record-table-item deposit show">
                                    <div class="record-table-tab">
                                        <div class="record-table-cell td-status">
                                            <div class="data">
                                                <span class="label-status language_replace">預け入れ</span>
                                            </div>
                                        </div>
                                        <div class="record-table-cell td-amount">
                                            <div class="data-amount td-number">
                                                <span class="data count">999,999,999</span>
                                                <!-- 出入金訂單狀態 -->
                                                <span class="label order-status success"><i class="icon icon-mask icon-check"></i></span>
                                                <span class="label order-status fail"><i class="icon icon-mask icon-error"></i></span>
                                                <span class="label order-status processing"><i class="icon icon-mask icon-exclamation"></i></span>
                                            </div>
                                        </div>
                                        <div class="record-table-cell td-paymentWay-date">
                                            <div class="record-table-cell-wrapper">
                                                <div class="td-paymentWay">
                                                    <span class="data">paypal</span>
                                                </div>
                                                <div class="td-date">
                                                    <span class="date-period">
                                                        <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                                                            class="time">13:00</span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="record-table-cell td-toggle">
                                            <div class="btn-toggle">
                                                <i class="arrow arrow-down"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 下拉明細 -->
                                    <div class="record-table-drop-panel">
                                        <table class="table">
                                            <thead class="thead">
                                                <tr class="thead-tr">
                                                    <th class="thead-th"><span class="title language_replace">單號編號</span></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="tbody-tr">
                                                    <td class="tbody-td">PD080N6001579596232017481720220401173951
                                                        <button type="button"
                                                            class="btn btn-round btn-copy">
                                                            <i class="icon icon-mask icon-copy"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- 出金 -->
                                <div class="record-table-item withdraw">
                                    <div class="record-table-tab">
                                        <div class="record-table-cell td-status">
                                            <div class="data">
                                                <span class="label-status language_replace">預け入れ</span>
                                            </div>
                                        </div>

                                        <div class="record-table-cell td-amount">
                                            <div class="data-amount td-number">
                                                <span class="data count">999,999,999</span>
                                            </div>
                                        </div>
                                        <div class="record-table-cell td-paymentWay-date">
                                            <div class="record-table-cell-wrapper">
                                                <div class="td-paymentWay">
                                                    <span class="data">paypal</span>
                                                </div>
                                                <div class="td-date">
                                                    <span class="date-period">
                                                        <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                                                            class="time">13:00</span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="record-table-cell td-toggle">
                                            <div class="btn-toggle">
                                                <i class="arrow arrow-down"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 下拉明細 -->
                                    <div class="record-table-drop-panel">
                                        <table class="table">
                                            <thead class="thead">
                                                <tr class="thead-tr">
                                                    <th class="thead-th"><span class="title language_replace">單號編號</span></th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="tbody-tr">
                                                    <td class="tbody-td">PD080N6001579596232017481720220401173951
                                                        <button type="button"
                                                            class="btn btn-round btn-copy">
                                                            <i class="icon icon-mask icon-copy"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </section>

                    <!-- 遊戲紀錄細詳  -->
                    <section class="section-record-game">

                        <!-- TABLE TITLE -->
                        <div class="sec-title-container sec-title-record sec-record-games">
                            <!-- 活動中心 link-->
                            <!-- 前/後 月 -->
                            <div class="sec_link">
                                <button class="btn btn-link btn-gray" type="button">
                                    <i class="icon arrow arrow-left mr-1"></i><span
                                        class="language_replace">先月</span></button>
                                <button class="btn btn-link btn-gray" type="button">
                                    <span class="language_replace">来月︎</span><i
                                        class="icon arrow arrow-right ml-1"></i></button>
                            </div>
                            <div class="sec-title-wrapper">
                                <h1 class="sec-title title-deco"><span class="language_replace">遊戲紀錄</span></h1>
                                <!-- 獎金/禮金 TAB -->
                                <div class="tab-record tab-scroller tab-2">
                                    <div class="tab-scroller__area">
                                        <ul class="tab-scroller__content">
                                            <li class="tab-item active">
                                                <span class="tab-item-link"><span class="title language_replace">出入金紀錄</span>
                                                </span>
                                            </li>
                                            <li class="tab-item">
                                                <span class="tab-item-link"><span class="title language_replace">遊戲紀錄</span></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- TABLE -->
                        <div class="record-table-container">
                            <div class="record-table games-record">

                                <div class="record-table-item header">
                                    <div class="record-table-cell td-date">
                                        <span class="language_replace">日期</span><span
                                            class="arrow arrow-up"></span>
                                    </div>
                                    <div class="record-table-cell td-gameName">
                                        <span class="language_replace">GAME</span><span
                                            class="arrow arrow-up"></span>
                                    </div>
                                    <div class="record-table-cell td-orderValue">
                                        <span class="language_replace">投注</span><span
                                            class="arrow arrow-up"></span>
                                    </div>
                                    <div class="record-table-cell td-validBet">
                                        <span class="language_replace">有效投注</span><span
                                            class="arrow arrow-up"></span>
                                    </div>
                                    <div class="record-table-cell td-rewardValue">
                                        <span class="language_replace">輸/贏</span><span
                                            class="arrow arrow-up"></span>
                                    </div>
                                </div>

                                <!-- 贏 -->
                                <div class="record-table-item win show">
                                    <div class="record-table-tab">
                                        <div class="record-table-cell td-status">
                                            <div class="data">
                                                <span class="label-status deposit language_replace">勝つ</span>
                                            </div>
                                        </div>

                                        <div class="record-table-wrapper">
                                            <!-- 日期 -->
                                            <div class="record-table-cell td-date">
                                                <span class="date-period">
                                                    <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                                                        class="time">13:00</span>
                                                </span>
                                            </div>
                                            <!-- 投注 -->
                                            <div class="record-table-cell td-orderValue">
                                                <span class="title language_replace">ベット</span>
                                                <span class="data number">995</span>
                                            </div>
                                            <!-- 有效投注 -->
                                            <div class="record-table-cell td-validBet">
                                                <span class="title language_replace">実際ベット</span>
                                                <span class="data number">50090</span>
                                            </div>
                                            <!-- 輸/贏 -->
                                            <div class="record-table-cell td-rewardValue">
                                                <span class="data number">+50000</span>
                                            </div>
                                        </div>
                                        <div class="record-table-cell td-toggle">
                                            <div class="btn-toggle">
                                                <i class="arrow arrow-down"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 下拉明細 -->
                                    <div class="record-table-drop-panel">
                                        <!-- 下拉明細 Header---->
                                        <div class="record-drop-item header">
                                            <div class="record-table-cell cell-gameName">
                                                <span class="language_replace">GAME</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                            <div class="record-table-cell cell-orderValue">
                                                <span class="language_replace">投注</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                            <div class="record-table-cell cell-validBet">
                                                <span class="language_replace">有效投注</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                            <div class="record-table-cell cell-rewardValue">
                                                <span class="language_replace">輸/贏</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                        </div>
                                        <!-- 下拉明細 Item : 贏---->
                                        <div class="record-drop-item win">
                                            <div class="record-drop-item-inner">
                                                <div class="record-drop-item-img record-item">
                                                    <div class="img-wrap">
                                                        <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/126.png">
                                                    </div>
                                                </div>
                                                <div class="record-drop-item-rewardValue record-item">
                                                    <span class="data number">+999</span>
                                                </div>
                                                <div class="record-drop-item-wrapper">
                                                    <div class="record-drop-item-gameName record-item">
                                                        <span class="data language_replace">火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試</span>
                                                    </div>
                                                    <div class="record-drop-item-orderValue record-item">
                                                        <span class="title language_replace">ベット</span>
                                                        <span class="data number">9999</span>
                                                    </div>
                                                    <div class="record-drop-item-validBet record-item">
                                                        <span class="title language_replace">実際ベット</span>
                                                        <span class="data number">9,99999</span>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        <!-- 下拉明細 Item : 輸---->
                                        <div class="record-drop-item lose">
                                            <div class="record-drop-item-inner">
                                                <div class="record-drop-item-img record-item">
                                                    <div class="img-wrap">
                                                        <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/126.png">
                                                    </div>
                                                </div>
                                                <div class="record-drop-item-rewardValue record-item">
                                                    <span class="data number">+999</span>
                                                </div>
                                                <div class="record-drop-item-wrapper">
                                                    <div class="record-drop-item-gameName record-item">
                                                        <span class="data language_replace">火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試</span>
                                                    </div>
                                                    <div class="record-drop-item-orderValue record-item">
                                                        <span class="title language_replace">ベット</span>
                                                        <span class="data number">999</span>
                                                    </div>
                                                    <div class="record-drop-item-validBet record-item">
                                                        <span class="title language_replace">実際ベット</span>
                                                        <span class="data number">9,99999</span>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <!-- 贏 -->
                                <div class="record-table-item lose ">
                                    <div class="record-table-tab">
                                        <div class="record-table-cell td-status">
                                            <div class="data">
                                                <span class="label-status deposit language_replace">勝つ</span>
                                            </div>
                                        </div>

                                        <div class="record-table-wrapper">
                                            <!-- 日期 -->
                                            <div class="record-table-cell td-date">
                                                <span class="date-period">
                                                    <span class="year">2022</span><span class="month">04</span><span class="day">04</span><span
                                                        class="time">13:00</span>
                                                </span>
                                            </div>
                                            <!-- 投注 -->
                                            <div class="record-table-cell td-orderValue">
                                                <span class="title language_replace">ベット</span>
                                                <span class="data number">995</span>
                                            </div>
                                            <!-- 有效投注 -->
                                            <div class="record-table-cell td-validBet">
                                                <span class="title language_replace">実際ベット</span>
                                                <span class="data number">50090</span>
                                            </div>
                                            <!-- 輸/贏 -->
                                            <div class="record-table-cell td-rewardValue">
                                                <span class="data number">+50000</span>
                                            </div>
                                        </div>
                                        <div class="record-table-cell td-toggle">
                                            <div class="btn-toggle">
                                                <i class="arrow arrow-down"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 下拉明細 -->
                                    <div class="record-table-drop-panel">
                                        <!-- 下拉明細 Header---->
                                        <div class="record-drop-item header">
                                            <div class="record-table-cell cell-gameName">
                                                <span class="language_replace">GAME</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                            <div class="record-table-cell cell-orderValue">
                                                <span class="language_replace">投注</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                            <div class="record-table-cell cell-validBet">
                                                <span class="language_replace">有效投注</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                            <div class="record-table-cell cell-rewardValue">
                                                <span class="language_replace">輸/贏</span><span
                                                    class="arrow arrow-up"></span>
                                            </div>
                                        </div>
                                        <!-- 下拉明細 Item : 贏---->
                                        <div class="record-drop-item win">
                                            <div class="record-drop-item-inner">
                                                <div class="record-drop-item-img record-item">
                                                    <div class="img-wrap">
                                                        <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/126.png">
                                                    </div>
                                                </div>
                                                <div class="record-drop-item-rewardValue record-item">
                                                    <span class="data number">+999</span>
                                                </div>
                                                <div class="record-drop-item-wrapper">
                                                    <div class="record-drop-item-gameName record-item">
                                                        <span class="data language_replace">火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試</span>
                                                    </div>
                                                    <div class="record-drop-item-orderValue record-item">
                                                        <span class="title language_replace">ベット</span>
                                                        <span class="data number">9999</span>
                                                    </div>
                                                    <div class="record-drop-item-validBet record-item">
                                                        <span class="title language_replace">実際ベット</span>
                                                        <span class="data number">9,99999</span>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        <!-- 下拉明細 Item : 輸---->
                                        <div class="record-drop-item lose">
                                            <div class="record-drop-item-inner">
                                                <div class="record-drop-item-img record-item">
                                                    <div class="img-wrap">
                                                        <img src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/CHT/126.png">
                                                    </div>
                                                </div>
                                                <div class="record-drop-item-rewardValue record-item">
                                                    <span class="data number">+999</span>
                                                </div>
                                                <div class="record-drop-item-wrapper">
                                                    <div class="record-drop-item-gameName record-item">
                                                        <span class="data language_replace">火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試火樹贏花測試</span>
                                                    </div>
                                                    <div class="record-drop-item-orderValue record-item">
                                                        <span class="title language_replace">ベット</span>
                                                        <span class="data number">999</span>
                                                    </div>
                                                    <div class="record-drop-item-validBet record-item">
                                                        <span class="title language_replace">実際ベット</span>
                                                        <span class="data number">9,99999</span>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>




                            </div>
                        </div>

                    </section>

                </div>
            </section>


        </div>
    </main>
    <footer class="footer"></footer>
    <!-- Modal - Game Info for Mobile Device-->
    <div class="modal fade no-footer popupGameInfo " id="popupGameInfo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="game-info-mobile-wrapper gameinfo-pack-bg">
                        <div class="game-item">
                            <div class="game-item-inner">
                                <div class="game-item-focus">
                                    <div class="game-item-img">
                                        <span class="game-item-link"></span>
                                        <div class="img-wrap">
                                            <img src="http://ewin.dev.mts.idv.tw/Files/GamePlatformPic/PG/PC/JPN/101.png">
                                        </div>
                                    </div>
                                    <div class="game-item-info-detail open">
                                        <div class="game-item-info-detail-wrapper">
                                            <div class="game-item-info-detail-moreInfo">
                                                <ul class="moreInfo-item-wrapper">
                                                    <li class="moreInfo-item brand">
                                                        <span class="title">メーカー</span>
                                                        <span class="value">PG</span>
                                                    </li>
                                                    <li class="moreInfo-item RTP">
                                                        <span class="title">RTP</span>
                                                        <span class="value number">96.66</span>
                                                    </li>
                                                    <li class="moreInfo-item gamecode">
                                                        <span class="title">NO.</span>
                                                        <span class="value number">00976</span>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="game-item-info-detail-indicator">
                                                <div class="game-item-info-detail-indicator-inner">
                                                    <div class="info">
                                                        <h3 class="game-item-name">バタフライブロッサム</h3>
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
    <!--===========JS========-->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/vendor/bootstrap/bootstrap.min.js"></script>
    <script src="js/vendor/swiper/js/swiper-bundle.min.js"></script>
    <script src="js/theme.js"></script>
</body>

</html>
