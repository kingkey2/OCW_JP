<%@ WebService Language="C#" Class="MgmtAPI" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Linq;
using System.Threading.Tasks;
//using SendGrid;
//using SendGrid.Helpers.Mail;
using System.Threading.Tasks;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
[System.ComponentModel.ToolboxItem(false)]
[System.Web.Script.Services.ScriptService]
public class MgmtAPI : System.Web.Services.WebService {

    //[WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public string GetUserAccountSummary2(string a)
    //{
    //    return EWinWeb.GetToken();
    //}

    [WebMethod]
    public void RefreshRedis(string password) {
        if (CheckPassword(password)) {
            System.Data.DataTable DT;
            RedisCache.PaymentCategory.UpdatePaymentCategory();
            RedisCache.PaymentMethod.UpdatePaymentMethodByCategory("Paypal");
            RedisCache.PaymentMethod.UpdatePaymentMethodByCategory("Crypto");

            DT = EWinWebDB.PaymentMethod.GetPaymentMethod();

            if (DT != null) {
                if (DT.Rows.Count > 0) {
                    for (int i = 0; i < DT.Rows.Count; i++) {
                        RedisCache.PaymentMethod.UpdatePaymentMethodByID((int)DT.Rows[i]["PaymentMethodID"]);
                    }
                }
            }


            EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
            var R = lobbyAPI.GetCompanyGameCode(EWinWeb.GetToken(), System.Guid.NewGuid().ToString());
            RedisCache.Company.UpdateCompanyGameCode(Newtonsoft.Json.JsonConvert.SerializeObject(R.GameCodeList));
        }
    }

    [WebMethod]
    public UserAccountSummaryResult GetUserAccountSummary(string password, string LoginAccount, DateTime SummaryDate) {

        UserAccountSummaryResult R = new UserAccountSummaryResult() { Result = enumResult.ERR };
        System.Data.DataTable DT;
        if (CheckPassword(password)) {
            DT = RedisCache.UserAccountSummary.GetUserAccountSummary(LoginAccount, SummaryDate);
            if (DT != null && DT.Rows.Count > 0) {
                R.SummaryGUID = (string)DT.Rows[0]["SummaryGUID"];
                R.SummaryDate = (DateTime)DT.Rows[0]["SummaryDate"];
                R.LoginAccount = (string)DT.Rows[0]["LoginAccount"];
                R.DepositCount = (int)DT.Rows[0]["DepositCount"];
                R.DepositRealAmount = (decimal)DT.Rows[0]["DepositRealAmount"];
                R.DepositAmount = (decimal)DT.Rows[0]["DepositAmount"];
                R.WithdrawalCount = (int)DT.Rows[0]["WithdrawalCount"];
                R.WithdrawalRealAmount = (decimal)DT.Rows[0]["WithdrawalRealAmount"];
                R.WithdrawalAmount = (decimal)DT.Rows[0]["WithdrawalAmount"];
                R.Result = enumResult.OK;
            } else {
                SetResultException(R, "NoData");
            }
        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public UserAccountTotalSummaryResult GetUserAccountTotalSummary(string password, string LoginAccount) {

        UserAccountTotalSummaryResult R = new UserAccountTotalSummaryResult() { Result = enumResult.ERR };
        System.Data.DataTable DT;
        if (CheckPassword(password)) {
            DT = RedisCache.UserAccountTotalSummary.GetUserAccountTotalSummaryByLoginAccount(LoginAccount);
            if (DT != null && DT.Rows.Count > 0) {
                R.LoginAccount = (string)DT.Rows[0]["LoginAccount"];
                R.LastDepositDate = (DateTime)DT.Rows[0]["LastDepositDate"];
                R.LastWithdrawalDate = (DateTime)DT.Rows[0]["LastWithdrawalDate"];
                R.LoginAccount = (string)DT.Rows[0]["LoginAccount"];
                R.DepositCount = (int)DT.Rows[0]["DepositCount"];
                R.DepositRealAmount = (decimal)DT.Rows[0]["DepositRealAmount"];
                R.DepositAmount = (decimal)DT.Rows[0]["DepositAmount"];
                R.WithdrawalCount = (int)DT.Rows[0]["WithdrawalCount"];
                R.WithdrawalRealAmount = (decimal)DT.Rows[0]["WithdrawalRealAmount"];
                R.WithdrawalAmount = (decimal)DT.Rows[0]["WithdrawalAmount"];
                R.FingerPrint = (string)DT.Rows[0]["FingerPrint"];
                R.Result = enumResult.OK;
            } else {
                SetResultException(R, "NoData");
            }
        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult OpenSite(string Password) {
        APIResult R = new APIResult() { Result = enumResult.ERR };

        dynamic o = null;
        string Filename;

        if (CheckPassword(Password)) {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/Setting.json");

            if (System.IO.File.Exists(Filename)) {
                string SettingContent;

                SettingContent = System.IO.File.ReadAllText(Filename);

                if (string.IsNullOrEmpty(SettingContent) == false) {
                    try {
                        o = Newtonsoft.Json.JsonConvert.DeserializeObject(SettingContent);
                        o.InMaintenance = 0;

                        System.IO.File.WriteAllText(Filename, Newtonsoft.Json.JsonConvert.SerializeObject(o));
                        R.Result = enumResult.OK;
                    } catch (Exception ex) { }
                }
            }

        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult MaintainSite(string Password, string Message) {
        APIResult R = new APIResult() { Result = enumResult.ERR };

        dynamic o = null;
        string Filename;

        if (CheckPassword(Password)) {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/Setting.json");

            if (System.IO.File.Exists(Filename)) {
                string SettingContent;

                SettingContent = System.IO.File.ReadAllText(Filename);

                if (string.IsNullOrEmpty(SettingContent) == false) {
                    try {
                        o = Newtonsoft.Json.JsonConvert.DeserializeObject(SettingContent);
                        o.InMaintenance = 1;

                        if (string.IsNullOrEmpty(Message) == false) {
                            o.MaintainMessage = Message;
                        }

                        System.IO.File.WriteAllText(Filename, Newtonsoft.Json.JsonConvert.SerializeObject(o));

                        var allSID = RedisCache.SessionContext.ListAllSID();
                        foreach (var item in allSID) {
                            RedisCache.SessionContext.ExpireSID(item);
                        }

                        R.Result = enumResult.OK;
                    } catch (Exception ex) { }
                }
            }

        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult EnableWithdrawlTemporaryMaintenance(string Password) {
        APIResult R = new APIResult() { Result = enumResult.ERR };

        dynamic o = null;
        string Filename;

        if (CheckPassword(Password)) {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/Setting.json");

            if (System.IO.File.Exists(Filename)) {
                string SettingContent;

                SettingContent = System.IO.File.ReadAllText(Filename);

                if (string.IsNullOrEmpty(SettingContent) == false) {
                    try {
                        o = Newtonsoft.Json.JsonConvert.DeserializeObject(SettingContent);
                        o.WithdrawlTemporaryMaintenance = 1;

                        System.IO.File.WriteAllText(Filename, Newtonsoft.Json.JsonConvert.SerializeObject(o));
                        R.Result = enumResult.OK;
                    } catch (Exception ex) { }
                }
            }

        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult DisableWithdrawlTemporaryMaintenance(string Password) {
        APIResult R = new APIResult() { Result = enumResult.ERR };

        dynamic o = null;
        string Filename;

        if (CheckPassword(Password)) {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/Setting.json");

            if (System.IO.File.Exists(Filename)) {
                string SettingContent;

                SettingContent = System.IO.File.ReadAllText(Filename);

                if (string.IsNullOrEmpty(SettingContent) == false) {
                    try {
                        o = Newtonsoft.Json.JsonConvert.DeserializeObject(SettingContent);
                        o.WithdrawlTemporaryMaintenance = 0;

                        System.IO.File.WriteAllText(Filename, Newtonsoft.Json.JsonConvert.SerializeObject(o));
                        R.Result = enumResult.OK;
                    } catch (Exception ex) { }
                }
            }

        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult UpdateAnnouncement(string Password, string Title, string Announcement) {
        APIResult R = new APIResult() { Result = enumResult.ERR };

        dynamic o = null;
        string Filename;

        if (CheckPassword(Password)) {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/Setting.json");

            if (System.IO.File.Exists(Filename)) {
                string SettingContent;

                SettingContent = System.IO.File.ReadAllText(Filename);

                if (string.IsNullOrEmpty(SettingContent) == false) {
                    try {
                        o = Newtonsoft.Json.JsonConvert.DeserializeObject(SettingContent);
                        o.LoginMessage["Title"] = Title;
                        o.LoginMessage["Message"] = Announcement;
                        o.LoginMessage["Version"] = (decimal)o.LoginMessage["Version"] + 1;

                        System.IO.File.WriteAllText(Filename, Newtonsoft.Json.JsonConvert.SerializeObject(o));
                        R.Result = enumResult.OK;
                    } catch (Exception ex) { }
                }
            }

        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public PaymentValueReslut CalculatePaymentValue(string Password, string PaymentSerial) {
        PaymentValueReslut R = new PaymentValueReslut() { Result = enumResult.ERR };

        if (CheckPassword(Password)) {
            System.Data.DataTable DT = EWinWebDB.UserAccountPayment.GetPaymentByPaymentSerial(PaymentSerial);


            if (DT != null && DT.Rows.Count > 0) {
                var row = DT.Rows[0];

                if ((int)row["FlowStatus"] != 0) {
                    decimal totalThresholdValue = 0;
                    decimal totalPointValue = 0;
                    string paymentDesc = "";
                    List<string> activityStrs = new List<string>();
                    string activityDataStr = (string)row["ActivityData"];

                    if (!string.IsNullOrEmpty(activityDataStr)) {
                        Newtonsoft.Json.Linq.JArray activityDatas = Newtonsoft.Json.Linq.JArray.Parse(activityDataStr);

                        foreach (var item in activityDatas) {
                            string desc = item["ActivityName"].ToString() + "_BnousValue_" + ((decimal)item["BonusValue"]).ToString() + "_ThresholdValue_" + ((decimal)item["ThresholdValue"]).ToString();
                            totalThresholdValue += (decimal)item["ThresholdValue"];
                            //totalPointValue += (decimal)item["BonusValue"];
                            activityStrs.Add(desc);
                        }
                    }



                    paymentDesc = "ThresholdValue=" + ((decimal)row["ThresholdValue"]).ToString() + ",ThresholdRate=" + ((decimal)row["ThresholdRate"]).ToString();

                    totalThresholdValue += (decimal)row["ThresholdValue"];
                    totalPointValue = (decimal)row["PointValue"];

                    R.TotalThresholdValue = totalThresholdValue;
                    R.TotalPointValue = totalPointValue;
                    R.LoginAccount = (string)row["LoginAccount"];
                    R.Amount = (decimal)row["Amount"];
                    R.PaymentSerial = (string)row["PaymentSerial"];
                    R.PaymentCode = (string)row["PaymentCode"];
                    R.PaymentDescription = paymentDesc;
                    R.ActivityDescription = activityStrs;
                    R.Result = enumResult.OK;
                } else {
                    SetResultException(R, "StatusError");
                }
            } else {
                SetResultException(R, "NoData");
            }
        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult UpdateBulletinBoardState(string Password, int BulletinBoardID, int State) {
        APIResult R = new APIResult() { Result = enumResult.ERR };
        string SS;
        System.Data.SqlClient.SqlCommand DBCmd;
        int RetValue = 0;

        if (CheckPassword(Password)) {

            SS = " UPDATE BulletinBoard WITH (ROWLOCK) SET State=@State " +
                      " WHERE BulletinBoardID=@BulletinBoardID";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@State", System.Data.SqlDbType.Int).Value = State;
            DBCmd.Parameters.Add("@BulletinBoardID", System.Data.SqlDbType.Int).Value = BulletinBoardID;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            if (RetValue > 0) {
                RedisCache.BulletinBoard.UpdateBulletinBoard();
                R.Result = enumResult.OK;
            }
        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult InsertBulletinBoard(string Password, string BulletinTitle, string BulletinContent) {
        APIResult R = new APIResult() { Result = enumResult.ERR };
        string SS;
        System.Data.SqlClient.SqlCommand DBCmd;
        int RetValue = 0;

        if (CheckPassword(Password)) {

            SS = " INSERT INTO BulletinBoard (BulletinTitle, BulletinContent) " +
                      " VALUES (@BulletinTitle, @BulletinContent) ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@BulletinTitle", System.Data.SqlDbType.NVarChar).Value = BulletinTitle;
            DBCmd.Parameters.Add("@BulletinContent", System.Data.SqlDbType.NVarChar).Value = BulletinContent;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            if (RetValue > 0) {
                RedisCache.BulletinBoard.UpdateBulletinBoard();
                R.Result = enumResult.OK;
            }
        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public APIResult InsertUserAccountNotify(string Password, string LoginAccount, string Title, string NotifyContent, string URL) {
        APIResult R = new APIResult() { Result = enumResult.ERR };
        string SS;
        System.Data.SqlClient.SqlCommand DBCmd;
        int RetValue = 0;
        int NotifyMsgID = 0;

        if (CheckPassword(Password)) {

            NotifyMsgID = EWinWebDB.NotifyMsg.InsertNotifyMsg(Title, NotifyContent, URL);

            if (NotifyMsgID != 0) {
                RetValue = EWinWebDB.UserAccountNotifyMsg.InsertUserAccountNotifyMsg(NotifyMsgID, 0, LoginAccount);

                if (RetValue > 0) {
                    R.Result = enumResult.OK;
                }
            } else {
                SetResultException(R, "InsertNotifyMsgErr");
            }

        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    [WebMethod]
    public System.Data.DataTable GetCompanyCategory(string password) {

        System.Data.DataTable DT = new System.Data.DataTable();
        if (CheckPassword(password)) {
            DT = RedisCache.CompanyCategory.GetCompanyCategory();
        }
        return DT;
    }

    [WebMethod]
    public APIResult UpdateCompanyCategoryState(string Password, int CompanyCategoryID, int State) {
        APIResult R = new APIResult() { Result = enumResult.ERR };
        string SS;
        System.Data.SqlClient.SqlCommand DBCmd;
        int RetValue = 0;

        if (CheckPassword(Password)) {

            SS = " UPDATE CompanyCategory WITH (ROWLOCK) SET State=@State " +
                      " WHERE CompanyCategoryID=@CompanyCategoryID";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@State", System.Data.SqlDbType.Int).Value = State;
            DBCmd.Parameters.Add("@CompanyCategoryID", System.Data.SqlDbType.Int).Value = CompanyCategoryID;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            if (RetValue > 0) {
                RedisCache.CompanyCategory.UpdateCompanyCategory();
                R.Result = enumResult.OK;
            }
        } else {
            SetResultException(R, "InvalidPassword");
        }

        return R;
    }

    //[WebMethod]
    //public void AddUserAccountPromotionCollect(string password, string LoginAccount, string ThresholdValue, string BonusValue, string ActivityName) {

    //    if (CheckPassword(password)) {
    //        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
    //        List<EWin.Lobby.PropertySet> PropertySets = new List<EWin.Lobby.PropertySet>();
    //        string description = ActivityName;
    //        string GUID = System.Guid.NewGuid().ToString();

    //        PropertySets.Add(new EWin.Lobby.PropertySet { Name = "ThresholdValue", Value = ThresholdValue.ToString() });
    //        PropertySets.Add(new EWin.Lobby.PropertySet { Name = "PointValue", Value = BonusValue.ToString() });

    //        lobbyAPI.AddPromotionCollect(GetToken(), GUID, LoginAccount, EWinWeb.MainCurrencyType, 1, 90, description, PropertySets.ToArray());
    //        EWinWebDB.UserAccountEventSummary.UpdateUserAccountEventSummary(LoginAccount, description, 1, decimal.Parse(ThresholdValue), decimal.Parse(BonusValue));
    //    }
    //}

    public string GetToken() {
        string Token;
        int RValue;
        Random R = new Random();
        RValue = R.Next(100000, 9999999);
        Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

        return Token;
    }

    //[WebMethod]
    //public void SendMail() {
    //    string Subject = string.Empty;
    //    string SendBody = string.Empty;
    //    string EMail = string.Empty;
    //    var f = "['oidon.s+maharaja@gmail.com','renya1979@icloud.com','mammothkoh3zoh3@yahoo.co.jp','grow7002@gmail.com','o8026370695@gmail.com','usako.to.chibiusa.2@gmail.com','shimiyan84@gmail.com','shinkigyo@gmail.com','yomachi8810@gmail.com','nana.yo.0909@gmail.com','catmineko@gmail.com','taira4119a@gmail.com','volvo.960.1981@gmail.com','sakayumi2014@gmail.com','nsys81118@gmail.com','ma9satoru25ko@gmail.com','kuniaki.tsukamoto.0107@gmail.com','hana.3.3@icloud.com','wsr.goto@gmail.com','makuri3713@gmail.com','emi_miyakita@yahoo.co.jp','youko1212tide526@gmail.com','t.t.toshiki@gmail.com','kayoko1904@icloud.com','panorama.19791115@gmail.com','Kurumaya.hisa@gmail.com','tomo16yuka24@gmail.com','dasmarudas@gmail.com','junko51716@gmail.com','trust.358@water.ocn.ne.jp','yaeko847@gmail.com','michiko.hana.2615@gmail.com','kaitai7647@gmail.com','a9725051@gmail.com','xingyilangguao@gmail.com','hibiki20020117@au.com','ehp55te@yahoo.co.jp','yasu-abu9@docomo.ne.jp','fumie.ema@gmail.com','good6700jp@gmail.com','Wakka0902@yahoo.co.jp','s-_-t.2003-1214@docomo.ne.jp','oi.michie@icloud.com','soratsuba.11@gmal.com','usuk.0830.mycn18@gmail.com','marrrrbe@yahoo.co.jp','enjya.sy@gmail.com','qcktj741@gmail.com','etarnity3450ctm@gmail.com','kaori4901@outlook.jp','corp.jandj3588@gmail.com','civic5557788@gmail.com','yujipost@gmail.com','manataro.0208@gmail.com','mior.vkmz@gmail.com','q9epade5u10j7an6qvz0@docomo.ne.jp','tkurodamail@gmail.com','yuuji.37.16@gmail.com','yuuji.37.16+3@gmail.com','atsumouri0303@gmail.com','mikiyuki.1234.mikiyuki@gmail.com','maeda4837@au.com','kaizinnopera@gmail.com','jeffmasutaka@gmail.com','tatsuo1234515@gmail.com','Erictse44@gmail.com','zard111jp@gmail.com','sumibi410@gmail.com','take.take.sasaki10@gmail.com','takkumi333@icloud.com','irifune1950m@gmail.com','cockroach0723@gmail.com','jun71106.21@gmail.com','fuji2811k@gmail.com','rabuyuma@gmail.com','tamariba.mochiken@gmail.com','nasu.oneoff@gmail.com','navy511058@gmail.com','luna_uf@yahoo.co.jp','katsuya0319@icloud.com','mba.realization2020@gmail.com','aigold.8376@gmail.com','mineko.3166@gmail.com','akimichu1005@yahoo.co.jp','asa1127@me.com','otsuka@akimitsu.tokyo','bangkok9z.pc@gmail.com','kyasarin20160411@gmail.com','yu.ryo.mo@icioud.com','mizuharu.8282@gmail.com','luxurious.cat@gmail.com','Harufu7788@gmail.com','risette.no2@gmail.com','t.marimari0321@gmail.com','sakamaki0130@gmail.com','Seitatakuya@gmail.com','shuji5hama@gmail.com','akamine888@gmail.com','yamaha-hatsujo-ki.4d9@i.softbank.jp','nongsnk81@gmail.com','yasuhiro.tamatsu@ezweb.ne.jp','ksoda.mobile@gmail.com','kazukino.adoresu@i.softbank.jp','soratsuba.11@gmail.com','bigtreeokinawa@gmail.com','noboru.1323@gmail.com','kimiko126ja@gmail.com','hiron.f3810@gmail.com','hirokazu.nakanishi@gmail.com','hamamatsu.aikido@gmail.com','yamamotoseitai@gmail.com','kakkonntou_nomisugi@yahoo.co.jp','fivefourkato@gmail.com','uchihiko48@gmail.com','termkh1874@gmail.com','goldjackal777@gmail.com','queenkellys8448@gmail.com','0825tomiko@gmail.com','sgr-s11g88@i.softbank.jp','kuritaku.tigers.4123@gmail.com','moppy77777@gmail.com','h4506h0423@gmail.com','ryou1213@yahoo.com','nagaoka.t1169@gmail.com','imc88@dolphin.ocn.ne.jp','service@99play.com','handmade_rin1977@yahoo.co.jp','yuyamam31@gmail.com','ian@kingkey.com.tw','koala19580928@gmail.com','sky3100604@gmail.com','enh6nsa6pm@i.softbank.jp','y.s-todo1.12@i.softbank.jp','ichita724@gmail.com','syan88@hotmail.co.jp','astus391@gmail.com','rsimacddmi@yahoo.co.jp','ganesha.ayur@gmail.com','nobu49774977@gmail.com','superogihara@yahoo.co.jp','p.man8p.man8@icloud.com','kumstaka@gmail.com','Zhengxingbaomu77@gmail.com','jdabc-destiny7@ezweb.ne.jp','kazukoku0@gmail.com','yoshiko@fushiki-arch.jp','hatsumi0011@i.softbank.jp','shunpei.yaguchi0326@gmail.com','qq3682sd@yahoo.co.jp','eikou1236@gmail.com','1703.1214.akr47@gmail.com','yunamaeda@gmail.com','0406yamamoto@mtc.biglobe.ne.jp','michikomining622@gmail.com','kazuie6677suzuki@gmail.com','youis5720@gmail.com','aikoinagaki1899@gmail.com','saitou19700929@gmail.com','ichikawa296@gmail.com','exile610@icloud.com','case4418@gmail.com','mimori_japan@yahoo.co.jp','nishigaki@global-invest.jp','toshiko10450921@gmail.com','n7321ri@gmail.com','toshie2741@gmail.com','rurumeru1102@gmail.com','n.sho19920523@gmail.com','yo.zi.0201@gmail.com','watagumomura15@gmail.com','miyaoka.8879@gmail.com','rinns1990@gmail.com','souwa.shimizu.kazutaka@gmail.com','krgn000@gmail.com','ko.ko1127@icloud.com','kimiyama72@gmail.com','shion.omijya@gmail.com','sin509a@gmail.com','odaiba0825@gmail.com','hiro2sweet2@gmail.com','skks.rh@gmail.com','o8019047617@gmail.com','superbookers@gmail.com','y.takeya0506@gmail.com','harada@dorisapo.jp','kekusafe-amam@yahoo.co.jp','mizukei1201@icloud.com','toriton0714@softbank.ne.jp','laetitia21shanke@gmail.com','ktu56tkhr@gmail.com','kanarie7@yahoo.co.jp','highaverage5@gmail.com','kojikibi2@yahoo.co.jp','husark@nifty.com','kazumasakagawa@gmail.com','an0825m@gmail.com','tiphareth2020@gmail.com','shigekatsu2038@gmail.com','ai.h.k314@gmail.com','momo-ryu-ura@simaenaga.com','atlifekochi@yahoo.co.jp','masa05221001@gmail.com','reichan1717.0717@gmail.com','Yo.chi.shyu.mama1109@gmail.com','nagatonoken@yahoo.co.jp','takemoto12201220@gmail.com','yu.haya.19982001@icloud.com','canzunori@gmail.com','fujinomiya.kobayashi@docomo.ne.jp','sachi-0416@docomo.ne.jp','subciety5@ezweb.ne.jp','akito1abcde1@gmail.com','bit.premium2020@gmail.com','tsuyoshi.k.hamamatsu@docomo.ne.jp','kozman2372@gmail.com','yuji0914gs@yahoo.co.jp','nobu461@gmail.com','mediagive@gaia.eonet.ne.jp','ishii@erwzs.com','gotojun2365@yahoo.co.jp','kimodo@i.softbank.jp','lovesan358@gmail.com','beatnikalk@icloud.com','taka.achan5@gmail.com','wind8tao@gmail.com','ken-zi428@docomo.ne.jp','satellite696@gmail.com','daisuke2804@gmail.com','fujimailaddress@yahoo.co.jp','tamtam10jp@yahoo.co.jp','m.sakaguchi@hotmail.co.jp','iwakumajj505050@gmail.com','info@qolmedia.online','tynoyk57@gmail.com','info@meike-home.com','pcdos2006@gmail.com','mizuhiro68@gmail.com','shinobu125125@gmail.com','hidekazuhata@gmail.com','gin43166@gmail.com','murofushi1124@docomo.ne.jp','kusunoki626@gmail.com','essencefimin@gmail.com','matsumura.9614@gmail.com','akemi.sumita@icloud.com','bunta0929ah@gmail.com','naokisonic85@gmail.com','test0328@gmail.com','Test5678@gmail.com','yachie1997@icloud.com','kabukimono_info@yahoo.co.jp','eve441211@gmail.com','livmitueasanosanpo@docomo.ne.jp','aoboshi32@gmail.com','rira3588@gmail.com','hikaru.wkym@gmail.com','xmasakix0001@icloud.com','pl.gakuen.60@gmail.com','yuchaco88628@i.softbank.jp','akirada0126@gamil.com','kimi0520.kimi@gmail.com','yellowsun0582@gmail.com','soulmate.marian@gmail.com']";
    //    Newtonsoft.Json.Linq.JArray gg = Newtonsoft.Json.Linq.JArray.Parse(f);
    //    SendBody = CodingControl.GetEmailTemp1();
    //    Subject = "カジノマハラジャ、プレオープンから 4週間での衝撃発表!!!!";

    //    for (int i = 0; i < gg.Count; i++) {
    //        EMail = (string)gg[i];
    //        CodingControl.SendMail("smtp.gmail.com", new System.Net.Mail.MailAddress("Service <service@casino-maharaja.com>"), new System.Net.Mail.MailAddress(EMail), Subject, SendBody, "service@casino-maharaja.com", "wncvssewbduekawc", "utf-8", true);
    //    }

    //    //mailtest();

    //}

    //[WebMethod]
    //public void SendMail() {
    //    mailtest();
    //}

    //private static void mailtest() {
    //    SendEmailAsync().Wait();
    //}

    //public static async Task SendEmailAsync() {
    //    string SendBody = CodingControl.GetEmailTemp2();
    //    var client = new SendGridClient("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");
    //    var from = new EmailAddress("edm@casino-maharaja.com", "maharaja");
    //    var subject = "maharaja";
    //    var htmlContent = SendBody;

    //    var f = "['h2zo.ceo@gmail.com','imanori2012@gmail.com','takako8888niji@icloud.com','hmasae330909@yahoo.co.jp','kimodo@marusen-gr.com','piropiro0122@gmail.com','onodera@eternallink.co.jp','iwars1953@gmail.com','yumaphon@gmail.com','wadaikosuperwassyoi@i.softbank.jp','L3test@gmail.com','service2@99play.com','test@gmail.com','rtest1@gggmail.com','ysj9388@gmail.com','fwxng555@yahoo.co.jp','rita@kingkey.com.tw','fujeep516516@gmail.com','sean@kingkey.com.tw','meteor950187@gmail.com','kevin@kingkey.com','erica@kingkey.com','minamikakita27@gmail.com','erica77727@hotmail.com','test2@1.com','eddiechen@kingkey.com.tw','joy@kingkey.com.tw','richardhsieh80002@gmail.com','92ninetwo.cafe@gmail.com','y.honjo@daityo.com','teruyukidoi101@gmail.com','kbs790911@gmail.com','rakuou@muc.biglobe.ne.jp','13@maztake.com','airi718.takuma211@gmail.com','k2seach@gmail.com','medical_kirara@yahoo.co.jp','sugiura@pullaround.com','k2seach@gmail.com','asa1127@me.com','rm.0306@i.softbank.jp','iwasaki.koji2@gmail.com','yumi-1226-50n1y-15@softbank.ne.jp','tamuhata8888@gmail.com','jhakase58@gmail.com','n_hotsonic@yahoo.co.jp','320hgl@gmail.com','ddsbc353@gmail.com','tomiko3144@gmail.com','megumin330602@gmail.com','japan8710@gmail.com','ny_rosoo@yahoo.co.jp','toramitsu2021@gmail.com','t.horikiri55@gmail.com','mdt.mari.1230@gmail.com','emocoron2@gmail.com','suinnsera@gmail.com','sakurasaku.rieko@ezweb.ne.jp','t.matsunami385@gmail.com','y.asai0426@gmail.com','maron_85_ss@yahoo.co.jp','rakuou.m.k@softbank.be.jp','mkitamura3712@yahoo.co.jp','kkanda@newsightjapan.com','officeclover@gmail.com','kiyotokanda@gmail.com','katsujo9@gmail.com','shirao0806@gmail.com','Ksks0301@gmail.com','teamlink.yamashita@yahoo.co.jp','tikamasa2015@gmail.com','e.siroishi@gmail.com','n.tougou89@gmail.com','miyoo.3140@gmail.com','baruto0312@gmail.com','evankei6719@gmail.com','z325z225z@gmail.com','z325z225z@gmail.com','tomo-sahroaksuhni.0713@ezweb.ne.jp','farmerken1@yahoo.co.jp','hirotan_729@yahoo.co.jp','mayu.33388@gmail.con','tomoyan452004@gmail.com','toki7539sg@gmail.com','win10win18win@gmail.com','kinji.0005@gmail.com','svyrr67714@yahoo.co.jp','yuzuan1128@gmail.com','mitsugu.04t@gmail.com','fumitomoft@gmail.com','28mittyann@gmail.com','kai-ryu-_-k8-suki@au.com','norimaron0@gmail.com','yuriko6853@gmail.com','Pallmallyc@gmail.com','358tisato@gmail.com','avance-j@docomo.ne.jp','2412greenfujii@yahoo.co.jp','shinobu2525@gmail.com','star7ruby6@gmail.com','kyoko.s.egao@gmail.com','77ikukin@gmail.com','kaizinnopera@gmail.com','t.ikumi.19960920@gmail.com','haiji.etsuko.63.m@gmail.com','aooki4913@gmail.com','heat3954@gmail.com','ringong311@outlook.jp','kumikoichi0315@gmail.com','rikusui1950@gmail.com','toshiko0526.i@softbank.ne.jp','fwxng555@yahoo.co.jp','y.yonekura0423@gmail.com','tkrpn567@gmail.com','ia052963@gmail.com','tsu6na@gmail.com','corozou3387@gmail.com','sachiko3201@gmail.com','noppo222555@gmail.com','kuma722000@gmail.com','fyoshioka1945@yahoo.co.jp','kimiko.otao@gmail.com','ruruka5448@gmail.com','yk0913.com@docomo.ne.jp','kokkolv_227@icloud.com','takako21jp@gmail.com','soratsuba.11@icloud.com','ikuko123@uqmobile.jp','youko.1955.miwa@gmail.com','koko_niko4611@yahoo.co.jp','oomoto410121@gmail.com','inotomo.jtk1105@gmail.com','m.h.0358.1947@gmaiI.com','hearnet22@gmail.com','chieko19570207@gmail.com','taka.19840131@gmail.com','haruru.m0413@icloud.com','0725lerve@gmail.com','masato0895@gmail.com','ks.curtain@icloud.com','ia052963@yahoo.co.jp','etsujin0909@gmail.com','tae2377t@gmail.com','hina23218@gmail.com','peka.gako.777.bigchance@gmail.com','kazue1217.hana@gmail.com','takerin543488@yahoo.co.jp','ribra2525@gmail.com','mayumi.etoile11@gmail.com','sy07700688@gmail.com','Biken.urakawa1527@gmail.com','keep94su31@gmail.com','nobuko250203@gmail.com','nobujin0407@gmail.com','ken1lowww@yahoo.co.jp','laxmi.fuku@gmail.com','expart9@gmail.com','makuri3783@gmail.com','kuniko.tuboi0628@gmail.com','okamoto3893@yahoo.co.jp','chika.ken7026@docomo.ne.jp','seiyan.nao.1129@gmail.com','izumi.okaasan1004@gmail.com','kzs.19971115@gmail.com','taitai4511hajime@au.com','allcookforyou@gmail.com','happycheers2006@yahoo.co.jp','tatumi21jp@gmail.com','kurotare8822@gmail.com','azumaya.nkmy@icloud.com','tyutyumasamasa@gmail.com','youkid3000@gmail.com','black.face0008@gmail.com','unify1010@gmail.com','fumiyo10891001@gmail.com','yuuko201764@yahoo.co.jp','benextjp197011@gmail.com','mitsuko308219@gmail.com','yoyaku@tabataya.net','m.imugem2@gmail.com','1hideboss@gmail.com','2hideboss@gmail.com','kaori5061@gmail.com','m.hideki321@gmail.com','fukuyuki5813@gmail.com','s99.taichou@gmail.com','tomo0131@gmail.com','hima12pu3@gmail.com','mu11161117@gmail.com','love07ch-peace@yahoo.co.jp','rs99@softbank.ne.jp','keep.it.real60@gmail.com','the.moon.in.the.sky.0427@gmail.com','pinkydianne1008070505@ezweb.ne.jp','figaro319@gmail.com','kameguti@icloud.com','sugimoto1984@yahoo.co.jp','papatora320@yahoo.co.jp','aiko@dai-8.co.jp','uci121627@gmail.com','game.hama2451@gmail.com','emico.pinkrose@icloud.com','luc888oru@gmail.com','q4119013@gmail.com','k.family-0823@ezweb.ne.jp','th907040@gmail.com','hime08056133267@yahoo.co.jp','kosumos.eco@gmail.com','popontadayo3@gmail.com','seiichi.s19550528@gmail.com','tmtmoojp@gmail.com','snoopys124@yahoo.co.jp','masato.shida@icloud.com','isaomahara@gmail.com','tkrpn567@gmail.com','e0001528@yahoo.co.jp','junju.1516@gmail.com','tsk@freeman.style','an.kyjn8755@gmail.com','yamanouchi2261@gmail.com','knknckmm.6744@gmail.com','ysj9388@gmail.com','nb44.773@gmail.com','krtrsn@yahoo.co.jp','333kou777@gmail.com','ama.kai.0321@gmail.com','elma@kingkey.com.tw','dajg.tm.atw@gmail.com','ucfcelsior.1@gmail.com','zeuse7667@gmail.com','abcdef@i.softbank.jp','batako.kao@gmail.com','shigerii12345@gmail.com','irc2.nabe@gmail.com','2010aquario@gmail.com','kabukipearl@yahoo.co.jp','yuyahands@gmail.com','ktchengem50nkgrynzo@yahoo.co.jp','koshitatsumi@gmail.com','shimizu.i1003@gmail.com','kusini.k12@docomo.ne.jp','win10win18@gmail.com','mundo42.mitsui@gmail.com','lavande0429@gmail.com','giga19751228@gmail.com','yk420913@gmail.com','sendai.312.8888@gmail.com','yotom1618@gmail.com','ichita724@icloud.com','kazushimi1850@gmail.com','mainao2016@yahoo.co.jp','ash.necessities@gmail.com','cocoverde0818@gmail.com','miyuki3124@gmail.com','a35316035@gmail.com','miosanaka55@gmail.com','remonchan1106@gmail.com','matsumoto@gentry-trust.com','tawpdg.gajt-kueo-kira.o@i.softbank.jp','mat2s3966@gmail.com','marikoga0328@gmail.com','1026ky@gmail.com','sakuramomoko1992@gmail.com','hopdhope3279@gmail.com','umezawa.0407@gmail.com','hideki.w0106@icloud.com','oidon.s+maharaja@gmail.com','renya1979@icloud.com','mammothkoh3zoh3@yahoo.co.jp','grow7002@gmail.com','o8026370695@gmail.com','usako.to.chibiusa.2@gmail.com','shimiyan84@gmail.com','shinkigyo@gmail.com','yomachi8810@gmail.com','nana.yo.0909@gmail.com','catmineko@gmail.com','taira4119a@gmail.com','volvo.960.1981@gmail.com','sakayumi2014@gmail.com','nsys81118@gmail.com','ma9satoru25ko@gmail.com','kuniaki.tsukamoto.0107@gmail.com','hana.3.3@icloud.com','wsr.goto@gmail.com','makuri3713@gmail.com','emi_miyakita@yahoo.co.jp','youko1212tide526@gmail.com','t.t.toshiki@gmail.com','kayoko1904@icloud.com','panorama.19791115@gmail.com','Kurumaya.hisa@gmail.com','tomo16yuka24@gmail.com','dasmarudas@gmail.com','junko51716@gmail.com','trust.358@water.ocn.ne.jp','yaeko847@gmail.com','michiko.hana.2615@gmail.com','kaitai7647@gmail.com','a9725051@gmail.com','xingyilangguao@gmail.com','hibiki20020117@au.com','ehp55te@yahoo.co.jp','yasu-abu9@docomo.ne.jp','fumie.ema@gmail.com','good6700jp@gmail.com','Wakka0902@yahoo.co.jp','s-_-t.2003-1214@docomo.ne.jp','oi.michie@icloud.com','soratsuba.11@gmal.com','usuk.0830.mycn18@gmail.com','marrrrbe@yahoo.co.jp','enjya.sy@gmail.com','qcktj741@gmail.com','etarnity3450ctm@gmail.com','kaori4901@outlook.jp','corp.jandj3588@gmail.com','civic5557788@gmail.com','yujipost@gmail.com','manataro.0208@gmail.com','mior.vkmz@gmail.com','q9epade5u10j7an6qvz0@docomo.ne.jp','tkurodamail@gmail.com','yuuji.37.16@gmail.com','yuuji.37.16+3@gmail.com','atsumouri0303@gmail.com','mikiyuki.1234.mikiyuki@gmail.com','maeda4837@au.com','kaizinnopera@gmail.com','jeffmasutaka@gmail.com','tatsuo1234515@gmail.com','Erictse44@gmail.com','zard111jp@gmail.com','sumibi410@gmail.com','take.take.sasaki10@gmail.com','takkumi333@icloud.com','irifune1950m@gmail.com','cockroach0723@gmail.com','jun71106.21@gmail.com','fuji2811k@gmail.com','rabuyuma@gmail.com','tamariba.mochiken@gmail.com','nasu.oneoff@gmail.com','navy511058@gmail.com','luna_uf@yahoo.co.jp','katsuya0319@icloud.com','mba.realization2020@gmail.com','aigold.8376@gmail.com','mineko.3166@gmail.com','akimichu1005@yahoo.co.jp','asa1127@me.com','otsuka@akimitsu.tokyo','bangkok9z.pc@gmail.com','kyasarin20160411@gmail.com','yu.ryo.mo@icioud.com','mizuharu.8282@gmail.com','luxurious.cat@gmail.com','Harufu7788@gmail.com','risette.no2@gmail.com','t.marimari0321@gmail.com','sakamaki0130@gmail.com','Seitatakuya@gmail.com','shuji5hama@gmail.com','akamine888@gmail.com','yamaha-hatsujo-ki.4d9@i.softbank.jp','nongsnk81@gmail.com','yasuhiro.tamatsu@ezweb.ne.jp','ksoda.mobile@gmail.com','kazukino.adoresu@i.softbank.jp','soratsuba.11@gmail.com','bigtreeokinawa@gmail.com','noboru.1323@gmail.com','kimiko126ja@gmail.com','hiron.f3810@gmail.com','hirokazu.nakanishi@gmail.com','hamamatsu.aikido@gmail.com','yamamotoseitai@gmail.com','kakkonntou_nomisugi@yahoo.co.jp','fivefourkato@gmail.com','uchihiko48@gmail.com','termkh1874@gmail.com','goldjackal777@gmail.com','queenkellys8448@gmail.com','0825tomiko@gmail.com','sgr-s11g88@i.softbank.jp','kuritaku.tigers.4123@gmail.com','moppy77777@gmail.com','h4506h0423@gmail.com','ryou1213@yahoo.com','nagaoka.t1169@gmail.com','imc88@dolphin.ocn.ne.jp','service@99play.com','handmade_rin1977@yahoo.co.jp','yuyamam31@gmail.com','ian@kingkey.com.tw','koala19580928@gmail.com','sky3100604@gmail.com','enh6nsa6pm@i.softbank.jp','y.s-todo1.12@i.softbank.jp','ichita724@gmail.com','syan88@hotmail.co.jp','astus391@gmail.com','rsimacddmi@yahoo.co.jp','ganesha.ayur@gmail.com','nobu49774977@gmail.com','superogihara@yahoo.co.jp','p.man8p.man8@icloud.com','kumstaka@gmail.com','Zhengxingbaomu77@gmail.com','jdabc-destiny7@ezweb.ne.jp','kazukoku0@gmail.com','yoshiko@fushiki-arch.jp','hatsumi0011@i.softbank.jp','shunpei.yaguchi0326@gmail.com','qq3682sd@yahoo.co.jp','eikou1236@gmail.com','1703.1214.akr47@gmail.com','yunamaeda@gmail.com','0406yamamoto@mtc.biglobe.ne.jp','michikomining622@gmail.com','kazuie6677suzuki@gmail.com','youis5720@gmail.com','aikoinagaki1899@gmail.com','saitou19700929@gmail.com','ichikawa296@gmail.com','exile610@icloud.com','case4418@gmail.com','mimori_japan@yahoo.co.jp','nishigaki@global-invest.jp','toshiko10450921@gmail.com','n7321ri@gmail.com','toshie2741@gmail.com','rurumeru1102@gmail.com','n.sho19920523@gmail.com','yo.zi.0201@gmail.com','watagumomura15@gmail.com','miyaoka.8879@gmail.com','rinns1990@gmail.com','souwa.shimizu.kazutaka@gmail.com','krgn000@gmail.com','ko.ko1127@icloud.com','kimiyama72@gmail.com','shion.omijya@gmail.com','sin509a@gmail.com','odaiba0825@gmail.com','hiro2sweet2@gmail.com','skks.rh@gmail.com','o8019047617@gmail.com','superbookers@gmail.com','y.takeya0506@gmail.com','harada@dorisapo.jp','kekusafe-amam@yahoo.co.jp','mizukei1201@icloud.com','toriton0714@softbank.ne.jp','laetitia21shanke@gmail.com','ktu56tkhr@gmail.com','kanarie7@yahoo.co.jp','highaverage5@gmail.com','kojikibi2@yahoo.co.jp','husark@nifty.com','kazumasakagawa@gmail.com','an0825m@gmail.com','tiphareth2020@gmail.com','shigekatsu2038@gmail.com','ai.h.k314@gmail.com','momo-ryu-ura@simaenaga.com','atlifekochi@yahoo.co.jp','masa05221001@gmail.com','reichan1717.0717@gmail.com','Yo.chi.shyu.mama1109@gmail.com','nagatonoken@yahoo.co.jp','takemoto12201220@gmail.com','yu.haya.19982001@icloud.com','canzunori@gmail.com','fujinomiya.kobayashi@docomo.ne.jp','sachi-0416@docomo.ne.jp','subciety5@ezweb.ne.jp','akito1abcde1@gmail.com','bit.premium2020@gmail.com','tsuyoshi.k.hamamatsu@docomo.ne.jp','kozman2372@gmail.com','yuji0914gs@yahoo.co.jp','nobu461@gmail.com','mediagive@gaia.eonet.ne.jp','ishii@erwzs.com','gotojun2365@yahoo.co.jp','kimodo@i.softbank.jp','lovesan358@gmail.com','beatnikalk@icloud.com','taka.achan5@gmail.com','wind8tao@gmail.com','ken-zi428@docomo.ne.jp','satellite696@gmail.com','daisuke2804@gmail.com','fujimailaddress@yahoo.co.jp','tamtam10jp@yahoo.co.jp','m.sakaguchi@hotmail.co.jp','iwakumajj505050@gmail.com','info@qolmedia.online','tynoyk57@gmail.com','info@meike-home.com','pcdos2006@gmail.com','mizuhiro68@gmail.com','shinobu125125@gmail.com','hidekazuhata@gmail.com','gin43166@gmail.com','murofushi1124@docomo.ne.jp','kusunoki626@gmail.com','essencefimin@gmail.com','matsumura.9614@gmail.com','akemi.sumita@icloud.com','bunta0929ah@gmail.com','naokisonic85@gmail.com','test0328@gmail.com','Test5678@gmail.com','yachie1997@icloud.com','kabukimono_info@yahoo.co.jp','eve441211@gmail.com','livmitueasanosanpo@docomo.ne.jp','aoboshi32@gmail.com','rira3588@gmail.com','hikaru.wkym@gmail.com','xmasakix0001@icloud.com','pl.gakuen.60@gmail.com','yuchaco88628@i.softbank.jp','akirada0126@gamil.com','kimi0520.kimi@gmail.com','yellowsun0582@gmail.com','soulmate.marian@gmail.com']";
    //    //var f = "['tony800517@hotmail.com']";
    //    Newtonsoft.Json.Linq.JArray gg = Newtonsoft.Json.Linq.JArray.Parse(f);

    //    for (int i = 0; i < gg.Count; i++) {
    //        var to = new EmailAddress((string)gg[i]);
    //        var msg = MailHelper.CreateSingleEmail(from, to, subject, null, htmlContent);
    //        var response = await client.SendEmailAsync(msg);
    //    }
    //}

    [WebMethod]
    public APIResult kevintest(string SID) {
        APIResult R = new APIResult();
        RedisCache.SessionContext.SIDInfo SI;
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.OrderSummaryResult callResult = new EWin.Lobby.OrderSummaryResult();
        List<a> k = new List<a>();

        SI = RedisCache.SessionContext.GetSIDInfo(SID);

        if (SI != null && !string.IsNullOrEmpty(SI.EWinSID)) {
            DateTime currentTime = DateTime.Now;
            int week = Convert.ToInt32(currentTime.DayOfWeek);
            week = week == 0 ? 7 : week;
            DateTime start;
            DateTime end;

            if (week > 4) {
                start = currentTime.AddDays(5 - week);        //這禮拜5
                end = currentTime;
            } else {
                start = currentTime.AddDays(5 - week - 7); //上禮拜5
                end = currentTime.AddDays(4 - week);  //這禮拜4
            }

            TimeSpan ts = end.Subtract(start); //兩時間天數相減

            int dayCount = ts.Days+1; //相距天數

            for (int i = 0; i < dayCount; i++) {
                a aa = new a();
                aa.Date = start.AddDays(i).ToString("yyyy-MM-dd");
                aa.Value = 0;
                k.Add(aa);
            }

            callResult = lobbyAPI.GetGameOrderSummaryHistory(GetToken(), SI.EWinSID, System.Guid.NewGuid().ToString(), start.ToString("yyyy-MM-dd 00:00:00"), end.ToString("yyyy-MM-dd 00:00:00"));


            if (callResult.Result == EWin.Lobby.enumResult.OK) {

                var GameOrderList = callResult.SummaryList.GroupBy(x => new { x.CurrencyType, x.SummaryDate }, x => x, (key, sum) => new EWin.Lobby.OrderSummary {
                    TotalValidBetValue = sum.Sum(y => y.TotalValidBetValue),
                    CurrencyType = key.CurrencyType,
                    SummaryDate = key.SummaryDate
                }).ToList();

                for (int i = 0; i < k.Count; i++) {
                    for (int j = 0; j < GameOrderList.Count; j++) {
                        if (k[i].Date == GameOrderList[j].SummaryDate) {
                            k[i].Value = GameOrderList[j].TotalValidBetValue;
                        }
                    }
                }

                R.Result = enumResult.OK;
                //R.Message = Newtonsoft.Json.JsonConvert.SerializeObject(GameOrderList);
                R.Message = Newtonsoft.Json.JsonConvert.SerializeObject(k);

            } else {
                SetResultException(R, "NotEligible");
            }

        } else {
            SetResultException(R, "InvalidWebSID");
        }

        return R;
    }

    public class a {
        public string Date { get; set; }
        public decimal Value { get; set; }
    }

    private bool CheckPassword(string Hash) {
        string key = EWinWeb.PrivateKey;

        bool Ret = false;
        int index = Hash.IndexOf('_');
        string tempStr1 = Hash.Substring(0, index);
        string tempStr2 = Hash.Substring(index + 1);
        string checkHash = "";
        DateTime CreateTime;
        DateTime TargetTime;
        if (index > 0) {
            if (DateTime.TryParse(tempStr1, out CreateTime)) {
                if (CreateTime.AddMinutes(15) >= DateTime.Now.AddSeconds(1)) {
                    TargetTime = RoundUp(CreateTime, TimeSpan.FromMinutes(15));
                    checkHash = CodingControl.GetMD5(TargetTime.ToString("yyyy/MM/dd HH:mm:ss") + key, false).ToLower();
                    if (checkHash.ToLower() == tempStr2) {
                        Ret = true;
                    }
                }
            }
        }

        return Ret;

    }

    private DateTime RoundUp(DateTime dt, TimeSpan d) {
        return new DateTime((dt.Ticks + d.Ticks - 1) / d.Ticks * d.Ticks, dt.Kind);
    }

    private void SetResultException(APIResult R, string Msg) {
        if (R != null) {
            R.Result = enumResult.ERR;
            R.Message = Msg;
        }
    }

    public class APIResult {
        public enumResult Result { get; set; }
        public string GUID { get; set; }
        public string Message { get; set; }
    }

    public enum enumResult {
        OK = 0,
        ERR = 1
    }

    public class PaymentValueReslut : APIResult {
        public string LoginAccount { get; set; }
        public string PaymentCode { get; set; }
        public string PaymentSerial { get; set; }
        public decimal Amount { get; set; }
        public decimal TotalPointValue { get; set; }
        public decimal TotalThresholdValue { get; set; }
        public List<string> ActivityDescription { get; set; }
        public string PaymentDescription { get; set; }
    }

    public class UserAccountSummaryResult : APIResult {
        public string SummaryGUID { get; set; }
        public DateTime SummaryDate { get; set; }
        public string LoginAccount { get; set; }
        public int DepositCount { get; set; }
        public decimal DepositRealAmount { get; set; }
        public decimal DepositAmount { get; set; }
        public int WithdrawalCount { get; set; }
        public decimal WithdrawalRealAmount { get; set; }
        public decimal WithdrawalAmount { get; set; }
    }

    public class UserAccountTotalSummaryResult : APIResult {
        public string LoginAccount { get; set; }
        public int DepositCount { get; set; }
        public decimal DepositRealAmount { get; set; }
        public decimal DepositAmount { get; set; }
        public int WithdrawalCount { get; set; }
        public decimal WithdrawalRealAmount { get; set; }
        public decimal WithdrawalAmount { get; set; }
        public DateTime LastDepositDate { get; set; }
        public DateTime LastWithdrawalDate { get; set; }
        public string FingerPrint { get; set; }
    }

    public class BulletinBoardResult : APIResult {
        public int BulletinBoardID { get; set; }
        public string BulletinTitle { get; set; }
        public string BulletinContent { get; set; }
        public DateTime CreateDate { get; set; }
        public int State { get; set; }

    }

    public class CompanyCategoryResult : APIResult {
        public int CompanyCategoryID { get; set; }
        public int CategoryType { get; set; }
        public string CategoryName { get; set; }
        public int SortIndex { get; set; }
        public int State { get; set; }
    }
}