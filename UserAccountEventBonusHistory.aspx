<%@ Page Language="C#" %>

<%string Version = EWinWeb.Version; %>
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

</head>
<script src="Scripts/OutSrc/lib/jquery/jquery.min.js"></script>
<script src="Scripts/OutSrc/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/DateExtension.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript">      
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var c = new common();
    var ui = new uiControl();
    var p;
    var mlp;
    var lang;
    var WebInfo;
    var nowRecordStatus = -1;
    var isDepositeOrWithdrawal = -1;
    var v = "<%:Version%>";

    function updateBaseInfo() {
        setSearchDate(0);
    }

    function switchtRecordStatus(recordStatus) {
        var Text;
        if (recordStatus == -1) {
            Text = mlp.getLanguageKey('全部');
        } else if (recordStatus == 0) {
            Text = mlp.getLanguageKey('儲值活動');
        } else if (recordStatus == 1) {
            Text = mlp.getLanguageKey('登入活動');
        } else {
            recordStatus == -1;
            Text = mlp.getLanguageKey('全部');
        }

        nowRecordStatus = recordStatus;

        $('.dropdown-selector-tab span').text(Text);
        $('.dropdown-selector').removeClass('cur');
        updateUserAccountEventBonusHistory();
    }

    function setSearchDate(step) {
        var idSearchYear = document.getElementById("idSearchYear");
        var idSearchMonth = document.getElementById("idSearchMonth");
        var targetDate;

        switch (step) {
            case 0:
                targetDate = new Date();
                //targetDate.setHours(0,0,0,0);
                break;
            case 1:
                var nowDate = new Date();
                nowDate.setHours(0, 0, 0, 0);

                var targetDate = new Date(Number(idSearchYear.dataset.date), Number(idSearchMonth.dataset.date), 1);

                if (nowDate < targetDate) {
                    var modal = new bootstrap.Modal(document.getElementById("alertLastMonth"));
                    modal.show()
                    return;
                }

                break;
            case -1:
                var targetDate = new Date(Number(idSearchYear.dataset.date), Number(idSearchMonth.dataset.date) - 2, 1);
                break;

        }

        idSearchYear.dataset.date = targetDate.getFullYear();
        idSearchYear.innerText = targetDate.getFullYear();
        idSearchMonth.dataset.date = targetDate.getMonth() + 1;
        idSearchMonth.innerText = targetDate.toLocaleString('en-US', { month: 'long' });


        updateUserAccountEventBonusHistory();
    }

    function copyText(tag) {

        var copyText = $(tag).parent().find('.inputPaymentSerial')[0];

        copyText.select();
        copyText.setSelectionRange(0, 99999);

        navigator.clipboard.writeText(copyText.value).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
    }

    function updateUserAccountEventBonusHistory() {
        //var dateType = document.querySelector('input[name="record-type"]:checked').value;
        var idSearchYear = document.getElementById("idSearchYear");
        var idSearchMonth = document.getElementById("idSearchMonth");
        var basicDate = new Date(Number(idSearchYear.dataset.date), Number(idSearchMonth.dataset.date), 0);
        var startDate = basicDate.format("yyyy/MM") + "/01";
        var endDate = basicDate.format("yyyy/MM/dd");

        //減1小時進ewin做搜尋
        startDate = c.addHours(startDate + " 00:00", -1).format("yyyy/MM/dd");

        var ParentMain = document.getElementById("idRecordContent");
        ParentMain.innerHTML = "";


        p.GetUserAccountEventBonusHistoryByLoginAccount(WebInfo.SID, Math.uuid(), startDate, endDate, function (success, o) {
            if (success) {
               
                if (o.Result == 0) {
                    if (o.UserAccountEventBonusHistorys.length > 0) {
                        var RecordDom;
                        let BonusValue;
                        //var numGameTotalValidBetValue = new BigNumber(0);
                        for (var i = 0; i < o.UserAccountEventBonusHistorys.length; i++) {
                            var record = o.UserAccountEventBonusHistorys[i];
                            if (nowRecordStatus == 0) {
                                if (record.EventType != 0) {
                                    return;
                                }
                            } else if (nowRecordStatus == 1) {
                                if (record.EventType != 1) {
                                    return;
                                }
                            }
                            RecordDom = c.getTemplate("temRecordItem");

                            //ewin資料存GMT+8，取出後改+9看是否該資料符合搜尋區間
                            var strSearchMonthDate;
                            if (idSearchMonth.dataset.date.length == 1) {
                                strSearchMonthDate = "0" + idSearchMonth.dataset.date;
                            } else {
                                strSearchMonthDate = idSearchMonth.dataset.date;
                            }

                            if (c.addHours(record.CreateDate, 1).format("MM") == strSearchMonthDate) {
                                var recordDate = new Date(c.addHours(record.CreateDate, 1));
                                var paymentRecordStatus
                                var paymentRecordText;
                                var BasicType;

                                //金額處理
                                var countDom = RecordDom.querySelector(".BonusValue");
                                if (BonusValue >= 0) {
                                    countDom.classList.add("positive");
                                    countDom.innerText = "+ " + new BigNumber(Math.abs(BonusValue)).toFormat();
                                } else {
                                    countDom.classList.add("negative");
                                    countDom.innerText = "- " + new BigNumber(Math.abs(BonusValue)).toFormat();
                                }
                                
                                c.setClassText(RecordDom, "month", null, recordDate.toLocaleString('en-US', { month: 'short' }).toUpperCase());
                                c.setClassText(RecordDom, "date2", null, recordDate.toLocaleString('en-US', { day: 'numeric' }).toUpperCase());
                                c.setClassText(RecordDom, "FinishDate", null, c.addHours(record.CreateDate, 1).format("yyyy/MM/dd"));
                                c.setClassText(RecordDom, "FinishTime", null, c.addHours(record.CreateDate, 1).format("hh:mm:ss"));
                                c.setClassText(RecordDom, "EventType", null, record.EventType == 0 ?mlp.getLanguageKey("儲值活動"):mlp.getLanguageKey("登入活動"));
                                c.setClassText(RecordDom, "PaymentSerial", null, record.RelationID);
                                c.setClassText(RecordDom, "BonusValue", null, record.BonusValue);
                                c.setClassText(RecordDom, "ThresholdValue", null, record.ThresholdValue);

                                $(RecordDom).find('.inputPaymentSerial').val(record.RelationID);
                                ParentMain.appendChild(RecordDom);
                                if ($(ParentMain).length == 0) {
                                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                                }
                            }
                        }
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                }
            } else {
                // 忽略 timeout 
            }
        });
    }

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetPaymentAPI();
        lang = window.parent.API_GetLang();

        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();
            updateBaseInfo()
        }, "PaymentAPI");

        // dropdown-selector
        $('[data-click-btn="toggle-dropdown"]').click(function () {
            $(this).parent().toggleClass('cur');
        });

        document.getElementById("idWalletAmount").innerText = new BigNumber(WebInfo.UserInfo.WalletList.find(x => x.CurrencyType == window.parent.API_GetCurrency()).PointValue).toFormat();
        document.getElementById("idUserName").innerText = WebInfo.UserInfo.RealName;
        changeAvatar(getCookie("selectAvatar"));
    }

    function changeAvatar(avatar) {
        if (avatar) {
            document.getElementById("avatarImg").src = "images/assets/avatar/" + avatar + ".jpg"
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

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":

                break;
            case "BalanceChange":
                break;

            case "SetLanguage":
                var lang = param;

                mlp.loadLanguage(lang, function () {
                    window.parent.API_LoadingEnd();
                });
                break;
        }
    }


    window.onload = init;
</script>
<body>
    <div class="page-container">
        <!-- Heading-Top -->
        <div id="heading-top">
            <header class="heading-top-container">
                <div class="heading-top-inner">
                    <div class="heading-user-info row justify-content-between">
                        <div class="col d-flex align-items-center">
                            <div class="avatar">
                                <img id="avatarImg" src="images/assets/avatar/avatar-01.jpg">
                            </div>
                            <div class="basic-info">
                                <div class="name"><span id="idUserName">Yamada Taro</span><span>'s</span></div>
                                <%--          <div class="language_replace">錢包</div>--%>
                            </div>
                        </div>
                        <div class="col d-flex">
                            <div class="balance-info">
                                <div class="balance-info-title" style="display: none;">
                                    <i class="icon-coin"></i>
                                    <div>SUFFY</div>
                                </div>
                                <div id="idWalletAmount" class="amount">9,999</div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
        </div>

        <div class="page-content">
            <section class="section-wrap">
                <!-- 頁面標題 -->
                <div class="page-title-container">
                    <div class="page-title-wrap">
                        <div class="page-title-inner">
                            <h3 class="title language_replace">活動領取紀錄</h3>
                        </div>
                    </div>
                </div>

                <!-- 紀錄列表 -->
                <div class="record-table-container payment-record">
                    <!--  日期選擇 -->
                    <div class="record-table-date-select">
                        <div class="wrap-box">
                            <div class="desc">
                                <span class="month" data-date="10" id="idSearchMonth">October</span>
                                <span class="year" data-date="2021" id="idSearchYear">2021</span>
                            </div>
                            <div class="btn-container">
                                <button class="btn btn-icon" onclick="setSearchDate(-1)">
                                    <i class="icon-arrow-left"></i>
                                </button>
                                <button class="btn btn-icon" onclick="setSearchDate(1)">
                                    <i class="icon-arrow-right"></i>
                                </button>
                            </div>
                        </div>
                        <!--  下拉加入 class="cur" -->
                        <div class="dropdown-selector">
                            <div class="dropdown-selector-tab" data-click-btn="toggle-dropdown">
                                <span class="language_replace">全部</span>
                            </div>
                            <div class="dropdown-selector-panel">
                                <div class="btn-wrap btn-radio-wrap">
                                    <div class="btn-radio">
                                        <input type="radio" name="recordStatus" id="type_All" onclick="switchtRecordStatus(-1)" checked>
                                        <label class="btn btn-outline-primary btn-sm" for="type_All">
                                            <span class="language_replace">全部</span>
                                        </label>
                                    </div>
                                    <div class="btn-radio">
                                        <input type="radio" name="recordStatus" id="type_0" onclick="switchtRecordStatus(0)">
                                        <label class="btn btn-outline-primary btn-sm" for="type_0">
                                            <span class="language_replace">儲值活動</span>
                                        </label>
                                    </div>
                                    <div class="btn-radio">
                                        <input type="radio" name="recordStatus" id="type_1" onclick="switchtRecordStatus(1)">
                                        <label class="btn btn-outline-primary btn-sm" for="type_1">
                                            <span class="language_replace">登入活動</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="record-table payment-record">
                        <div class="record-table-item header">
                            <div class="record-table-cell date"><span class="language_replace">日期</span></div>
                            <div class="record-table-cell count"><span class="language_replace">獎勵</span></div>
                            <div class="record-table-cell count"><span class="language_replace">出款門檻</span></div>
                            <%--<div class="record-table-cell status"><span class="language_replace">狀態</span></div>--%>
                        </div>
                        <div id="idRecordContent">
                        </div>
                    </div>
                </div>
            </section>
            <div class="notice-container mt-5 is-hide">
                <div class="notice-item">
                    <i class="icon-info_circle_outline"></i>
                    <div class="text-wrap">
                        <p class="title language_replace">注意</p>
                        <p class="language_replace">主動取消、審核拒絕訂單，如有疑問請與客服聯繫。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertLastMonth" aria-hidden="true" id="alertLastMonth">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <div class="text-wrap">
                            <p class="language_replace">已經是最新月份了!</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                </div>

            </div>
        </div>
    </div>
    <div id="temRecordItem" class="is-hide">
        <div class="record-table-item" data-record-type="diposit">
            <div class="record-table-tab">
                <div class="record-table-cell date">
                    <div class="data-date">
                        <div class="month">OCT</div>
                        <div class="date date2">10</div>
                    </div>
                </div>
                <div class="record-table-cell count">
                    <div class="count positive BonusValue">+9,999</div>
                </div>
                <div class="record-table-cell count">
                    <div class="count positive ThresholdValue">+9,999</div>
                </div>
                <%-- <div class="record-table-cell status">
                    <span class="data-status PaymentStatus language_replace">已完成</span>
                </div>--%>
            </div>

            <!-- 明細 -->
            <div class="record-table-drop-panel">
                <table class="table table-sm">
                    <tbody>
                        <tr>
                            <th class="title language_replace">訂單編號</th>
                            <td><span class="PaymentSerial"></span>
                                <input class="inputPaymentSerial is-hide" />
                                <i class="icon-copy" onclick="copyText(this)" style="display: inline;"></i>
                            </td>
                        </tr>
                        <tr>
                            <th class="title language_replace">獎勵取得方式</th>
                            <td class="EventType">XXXX-XXXX-XXXXXXXX</td>
                        </tr>
                        <tr>
                            <th class="title language_replace">完成日期</th>
                            <td class="FinishDate">XXXX-XXXX-XXXXXXXX</td>
                        </tr>
                        <tr>
                            <th class="title language_replace">完成時間</th>
                            <td class="FinishTime">XXXX-XXXX-XXXXXXXX</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</body>
</html>
