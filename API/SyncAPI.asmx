<%@ WebService Language="C#" Class="SyncAPI" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Linq;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
[System.ComponentModel.ToolboxItem(false)]
[System.Web.Script.Services.ScriptService]
public class SyncAPI : System.Web.Services.WebService
{
    //[WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public EWin.Lobby.APIResult CreateJKCUserAccount()
    //{ 
    //    string Filename;
    //    EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
    //    if (EWinWeb.IsTestSite)
    //    {
    //        Filename = HttpContext.Current.Server.MapPath("/App_Data/EPay/Test_" + "UserJKCData.json");
    //    }
    //    else
    //    {
    //        Filename = HttpContext.Current.Server.MapPath("/App_Data/EPay/Formal_" + "UserJKCData.json");
    //    }

    //    Newtonsoft.Json.Linq.JArray jArray = null;

    //    if (System.IO.File.Exists(Filename))
    //    {
    //        string SettingContent;

    //        SettingContent = System.IO.File.ReadAllText(Filename);

    //        if (string.IsNullOrEmpty(SettingContent) == false)
    //        {
    //            try { jArray = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(SettingContent); } catch (Exception ex) { }
    //            if (jArray != null && jArray.Count > 0)
    //            {
    //                foreach (Newtonsoft.Json.Linq.JObject parsedObject in jArray.Children<Newtonsoft.Json.Linq.JObject>())
    //                {
    //                    EWinWebDB.JKCDeposit.InsertJKCDepositByContactPhoneNumber((string)parsedObject["Name"], (decimal)parsedObject["Value"]);
    //                }
    //            }

    //        }
    //    }

    //    return R;
    //}

    //[WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public EWin.Lobby.APIResult UpdateJKCUserAccount(string ContactPhoneNumber, decimal Amount)
    //{

    //    EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };

    //    var retVal = EWinWebDB.JKCDeposit.UpdateJKCDepositByContactPhoneNumber2(ContactPhoneNumber, Amount);
    //    if (retVal == 0)
    //    {
    //        R.Result = EWin.Lobby.enumResult.OK;
    //    }

    //    return R;
    //}

    //[WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public EWin.Lobby.APIResult InsertJKCUserAccountByContactPhoneNumber(string ContactPhoneNumber, decimal Amount)
    //{

    //    EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };

    //    var retVal = EWinWebDB.JKCDeposit.InsertJKCDepositByContactPhoneNumber(ContactPhoneNumber, Amount);
    //    if (retVal > 0)
    //    {
    //        R.Result = EWin.Lobby.enumResult.OK;
    //    }

    //    return R;
    //}

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult HeartBeat(string GUID, string Echo)
    {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

        return lobbyAPI.HeartBeat(GUID, Echo);
    }

    private string ParseLocation(string LocationCode)
    {
        string ret = "GameList_All";
        switch (LocationCode)
        {
            case "01":
                ret = "GameList_Hot";
                break;
            case "02":
                ret = "GameList_Favo";
                break;
            case "03":
                ret = "GameList_Live";
                break;
            case "04":
                ret = "GameList_Slot";
                break;
            case "05":
                ret = "GameList_Other";
                break;
            case "06":
                ret = "GameList_Brand";
                break;
            case "07":
                ret = "Home";
                break;
            default:
                break;
        }
        return ret;
    }

    private int ParseShowType(string ShowType)
    {
        int ret = 0;
        switch (ShowType)
        {
            case "01":
                ret = 0;
                break;
            case "02":
                ret = 1;
                break;
            case "03":
                ret = 2;
                break;
            case "04":
                ret = 3;
                break;
            default:
                ret = 0;
                break;
        }
        return ret;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult UpdateStatisticsCompanyCategory(string Key)
    {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.CompanyGameCodeResult companyGameCodeResult;
        EWin.Lobby.CompanyCategoryResult companyCategoryResult;
        EWin.Lobby.CompanyCategoryResult OCWcompanyCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.CompanyCategoryResult OCWcompanyStatisticsCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.GameCodeRTPResult gameCodeRTPResult;
        List<EWin.Lobby.GameCodeRTP> day3_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> month1_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> day7_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> yesterday_gameCodeRTP;
        int SlotMaxBetCount3DayCategoryID = 0;
        int SlotMaxBetCount30DayCategoryID = 0;
        int SlotMaxWinValue7DayCategoryID = 0;
        int SlotMaxWinValueYesterdayCategoryID = 0;
        int SlotMaxWinRate7DayCategoryID = 0;
        int SlotMaxWinRateYesterdayCategoryID = 0;
        int SlotMaxRTPYesterdayCategoryID = 0;

        System.Data.DataTable CompanyCategoryDT = null;
        int InsertCompanyCategoryReturn;
        int InsertCompanyGameCodeReturn;
        int CompanyCategoryID = 0;
        int MaxGameID = 0;
        string GameBrand;
        string GameCode;
        string GameCategoryCode;
        string GameCategorySubCode;
        string Location = "";
        string Tag;

        List<OcwCompanyGameCode> AllGameCodeData = new List<OcwCompanyGameCode>();
        int ShowType = 0;
        int SortIndex = 0;
        List<CompanyCategoryByStatistics> SlotMaxBetCount3DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxBetCount30DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinValue7DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinValueYesterdayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinRate7DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinRateYesterdayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxRTPYesterdayResult = new List<CompanyCategoryByStatistics>();
        Dictionary<int, int> CategoryGameCodeCount = new Dictionary<int, int>();
        //if (true) {
        if (CheckPassword(Key))
        {
            EWinWebDB.CompanyGameCode.DeleteCompanyGameCode();

            CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();


            #region 統計值

            Location = "GameList_Slot";
            ShowType = 0;

            OCWcompanyStatisticsCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount3Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount30Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValue7Day",CompanyCategoryID = 0,SortIndex =89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValueYesterday",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRate7Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRateYesterday",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxRTPYesterday",CompanyCategoryID = 0,SortIndex = 89
        }};

            for (int i = 0; i < OCWcompanyStatisticsCategoryResult.CategoryList.Length; i++)
            {
                if (CompanyCategoryDT.Select("CategoryName='" + OCWcompanyStatisticsCategoryResult.CategoryList[i].CategoryName + "' And CategoryType=1").Length == 0)
                {
                    InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyStatisticsCategoryResult.CategoryList[i].CompanyCategoryID, 1, OCWcompanyStatisticsCategoryResult.CategoryList[i].CategoryName, OCWcompanyStatisticsCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
                    if (InsertCompanyCategoryReturn > 0)
                    {
                        CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                    }
                }

            }

            SlotMaxBetCount3DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxBetCount3Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
            SlotMaxBetCount30DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxBetCount30Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
            SlotMaxWinValue7DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinValue7Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
            SlotMaxWinValueYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinValueYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];
            SlotMaxWinRate7DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinRate7Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
            SlotMaxWinRateYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinRateYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];
            SlotMaxRTPYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxRTPYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];

            gameCodeRTPResult = lobbyAPI.GetGameCodeRTP(GetToken(), Guid.NewGuid().ToString(), DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"), DateTime.Now.ToString("yyyy-MM-dd"));
            if (gameCodeRTPResult != null && gameCodeRTPResult.RTPList.Length > 0)
            {
                month1_gameCodeRTP = gameCodeRTPResult.RTPList.Where(w => w.GameCategoryCode == "Slot").ToList();
                day7_gameCodeRTP = month1_gameCodeRTP.Where(w => Convert.ToDateTime(w.SummaryDate) <= Convert.ToDateTime(DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")) && Convert.ToDateTime(w.SummaryDate) >= Convert.ToDateTime(DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd"))).ToList();
                day3_gameCodeRTP = day7_gameCodeRTP.Where(w => Convert.ToDateTime(w.SummaryDate) <= Convert.ToDateTime(DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")) && Convert.ToDateTime(w.SummaryDate) >= Convert.ToDateTime(DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd"))).ToList();
                yesterday_gameCodeRTP = day3_gameCodeRTP.Where(w => w.SummaryDate == DateTime.Now.AddDays(-2).ToString("yyyy-MM-dd")).ToList();

                //老虎機最多轉72hour
                SlotMaxBetCount3DayResult = (from p in day3_gameCodeRTP
                                             group p by new { p.GameCode } into g
                                             select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                //maharaja最多轉30day
                SlotMaxBetCount30DayResult = (from p in month1_gameCodeRTP
                                              group p by new { p.GameCode } into g
                                              select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                //7天內最大開獎
                SlotMaxWinValue7DayResult = (from p in day7_gameCodeRTP
                                             group p by new { p.GameCode } into g
                                             select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                //前天最大開獎
                SlotMaxWinValueYesterdayResult = (from p in yesterday_gameCodeRTP
                                                  group p by new { p.GameCode } into g
                                                  select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                //7天內最大倍率
                SlotMaxWinRate7DayResult = (from p in day7_gameCodeRTP
                                            group p by new { p.GameCode } into g
                                            select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                //前天最大倍率
                SlotMaxWinRateYesterdayResult = (from p in yesterday_gameCodeRTP
                                                 group p by new { p.GameCode } into g
                                                 select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                //前天最高RTP
                SlotMaxRTPYesterdayResult = (from p in yesterday_gameCodeRTP
                                             select new CompanyCategoryByStatistics { GameCode = p.GameCode, QTY =  (p.OrderValue == 0 ? 0 : (1 + (p.RewardValue / p.OrderValue)) * 100) }).OrderByDescending(o => o.QTY).Take(20).ToList();

            }

            #endregion

            if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0)
            {
                companyGameCodeResult = lobbyAPI.GetCompanyGameCode(GetToken(), Guid.NewGuid().ToString());
                if (companyGameCodeResult.Result == EWin.Lobby.enumResult.OK)
                {
                    companyGameCodeResult.GameCodeList = companyGameCodeResult.GameCodeList.OrderByDescending(o => o.SortIndex).ToArray();
                    for (int i = 0; i < companyGameCodeResult.GameCodeList.Length; i++)
                    {   //建立全部GameCode資料

                        //取得最大GameID
                        if (MaxGameID < companyGameCodeResult.GameCodeList[i].GameID)
                        {
                            MaxGameID = companyGameCodeResult.GameCodeList[i].GameID;
                        }

                        Tag = companyGameCodeResult.GameCodeList[i].Tag == null ? "" : Newtonsoft.Json.JsonConvert.SerializeObject(companyGameCodeResult.GameCodeList[i].Tag);
                        GameBrand = companyGameCodeResult.GameCodeList[i].GameCode.Split('.')[0];
                        GameCode = companyGameCodeResult.GameCodeList[i].GameCode;
                        GameCategoryCode = companyGameCodeResult.GameCodeList[i].GameCategoryCode;
                        GameCategorySubCode = companyGameCodeResult.GameCodeList[i].GameCategorySubCode;
                        SortIndex = companyGameCodeResult.GameCodeList[i].SortIndex;
                        OcwCompanyGameCode ocwGameCode = new OcwCompanyGameCode()
                        {
                            GameID = companyGameCodeResult.GameCodeList[i].GameID,
                            GameBrand = GameBrand,
                            GameCode = GameCode,
                            GameName = companyGameCodeResult.GameCodeList[i].GameName,
                            GameCategoryCode = GameCategoryCode,
                            GameCategorySubCode = GameCategorySubCode,
                            AllowDemoPlay = companyGameCodeResult.GameCodeList[i].AllowDemoPlay,
                            RTPInfo = companyGameCodeResult.GameCodeList[i].RTPInfo,
                            IsHot = companyGameCodeResult.GameCodeList[i].IsHot,
                            IsNew = companyGameCodeResult.GameCodeList[i].IsNew,
                            SortIndex = companyGameCodeResult.GameCodeList[i].SortIndex
                        };

                        AllGameCodeData.Add(ocwGameCode);
                        if (SlotMaxBetCount3DayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxBetCount3DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxBetCount3DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }

                        if (SlotMaxBetCount30DayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxBetCount30DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxBetCount30DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }

                        if (SlotMaxWinValue7DayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxWinValue7DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinValue7DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }

                        if (SlotMaxWinValueYesterdayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxWinValueYesterdayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinValueYesterdayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }

                        if (SlotMaxWinRate7DayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxWinRate7DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinRate7DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }

                        if (SlotMaxWinRateYesterdayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxWinRateYesterdayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinRateYesterdayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }

                        if (SlotMaxRTPYesterdayResult.Where(w => w.GameCode == GameCode).Count() > 0)
                        {
                            var QTY = SlotMaxRTPYesterdayResult.Where(w => w.GameCode == GameCode).First().QTY;
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxRTPYesterdayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                        }
                    }

                    RedisCache.CompanyGameCode.UpdateSyncData(MaxGameID);
                    RedisCache.CompanyGameCode.UpdateCompanyGameCode();
                    RedisCache.CompanyGameCode.UpdateAllCompanyGameCode(Newtonsoft.Json.JsonConvert.SerializeObject(AllGameCodeData));

                }
                else
                {
                    R.Message = "Get CompanyGameCodeResult Error";
                    //Console.WriteLine("Get CompanyGameCodeResult Error");
                }
            }
            else
            {
                R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID;
                //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
            }
        }
        else
        {
            R.Message = "Invalid Key";
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult UpdateCompanyCategory(string Key) {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.CompanyGameCodeResult companyGameCodeResult;
        EWin.Lobby.CompanyCategoryResult companyCategoryResult;
        EWin.Lobby.CompanyCategoryResult OCWcompanyCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.CompanyCategoryResult OCWcompanyStatisticsCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.GameCodeRTPResult gameCodeRTPResult;
        List<EWin.Lobby.GameCodeRTP> day3_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> month1_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> day7_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> yesterday_gameCodeRTP;
        int SlotMaxBetCount3DayCategoryID = 0;
        int SlotMaxBetCount30DayCategoryID = 0;
        int SlotMaxWinValue7DayCategoryID = 0;
        int SlotMaxWinValueYesterdayCategoryID = 0;
        int SlotMaxWinRate7DayCategoryID = 0;
        int SlotMaxWinRateYesterdayCategoryID = 0;
        int SlotMaxRTPYesterdayCategoryID = 0;

        System.Data.DataTable CompanyCategoryDT = null;
        int InsertCompanyCategoryReturn;
        int InsertCompanyGameCodeReturn;
        int CompanyCategoryID = 0;
        string[] companyCategoryTags;
        System.Data.DataRow[] CompanyCategoryRow;
        int IsHotCompanyCategoryID;
        int IsNewCompanyCategoryID;
        int IsGameBrandCategoryID;
        int IsCategoryCodeCategoryID = 0;
        int MaxGameID = 0;
        string GameBrand;
        string GameCode;
        string GameCategoryCode;
        string GameCategorySubCode;
        string Location = "";
        string Tag;

        List<OcwCompanyGameCode> AllGameCodeData = new List<OcwCompanyGameCode>();
        int ShowType = 0;
        int CategoryGameCodeCountID = 0;
        int SortIndex = 0;
        List<CompanyCategoryByStatistics> SlotMaxBetCount3DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxBetCount30DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinValue7DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinValueYesterdayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinRate7DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinRateYesterdayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxRTPYesterdayResult = new List<CompanyCategoryByStatistics>();
        Dictionary<int, int> CategoryGameCodeCount = new Dictionary<int, int>();
        if (CheckPassword(Key)) {
            companyCategoryResult = lobbyAPI.GetCompanyCategory(GetToken(), Guid.NewGuid().ToString());
            if (companyCategoryResult.Result == EWin.Lobby.enumResult.OK) {
                if (companyCategoryResult.CategoryList.Length > 0) {
                    EWinWebDB.CompanyGameCode.DeleteCompanyGameCode();
                    EWinWebDB.CompanyCategory.DeleteCompanyCategory(0);

                    for (int i = 0; i < companyCategoryResult.CategoryList.Length; i++) {
                        if (companyCategoryResult.CategoryList[i].Tag.Length == 4) {
                            Location = ParseLocation(companyCategoryResult.CategoryList[i].Tag.Substring(0, 2));
                            ShowType = ParseShowType(companyCategoryResult.CategoryList[i].Tag.Substring(2, 2));
                            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertCompanyCategory(companyCategoryResult.CategoryList[i].CompanyCategoryID, 0, companyCategoryResult.CategoryList[i].CategoryName, companyCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);

                            if (InsertCompanyCategoryReturn <= 0) {
                                R.Message = "InsertCompanyCategory Error EWinCompanyCategoryID=" + companyCategoryResult.CategoryList[i].CompanyCategoryID;
                            }

                        }
                    }

                    CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();


                    #region 統計值

                    Location = "GameList_Slot";
                    ShowType = 0;

                    OCWcompanyStatisticsCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount3Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount30Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValue7Day",CompanyCategoryID = 0,SortIndex =89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValueYesterday",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRate7Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRateYesterday",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxRTPYesterday",CompanyCategoryID = 0,SortIndex = 89
        }};

                    for (int i = 0; i < OCWcompanyStatisticsCategoryResult.CategoryList.Length; i++) {
                        if (CompanyCategoryDT.Select("CategoryName='" + OCWcompanyStatisticsCategoryResult.CategoryList[i].CategoryName + "' And CategoryType=1").Length == 0) {
                            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyStatisticsCategoryResult.CategoryList[i].CompanyCategoryID, 1, OCWcompanyStatisticsCategoryResult.CategoryList[i].CategoryName, OCWcompanyStatisticsCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
                            if (InsertCompanyCategoryReturn > 0) {
                                CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                            }
                        }

                    }

                    #endregion

                    #region 設定Ocw自定義分類
                    OCWcompanyCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "Hot",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "New",CompanyCategoryID = 0,SortIndex = 0
        } };

                    Location = "GameList_All";
                    ShowType = 0;
                    for (int i = 0; i < OCWcompanyCategoryResult.CategoryList.Length; i++) {
                        if (CompanyCategoryDT.Select("CategoryName='" + OCWcompanyCategoryResult.CategoryList[i].CategoryName + "'" + "  And CategoryType=2 And Location='GameList_All'").Length == 0) {
                            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyCategoryResult.CategoryList[i].CompanyCategoryID, 2, OCWcompanyCategoryResult.CategoryList[i].CategoryName, OCWcompanyCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
                            if (InsertCompanyCategoryReturn > 0) {
                                CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                            }
                        }
                    }
                    #endregion

                    for (int i = 0; i < CompanyCategoryDT.Rows.Count; i++) {
                        CategoryGameCodeCount.Add((int)CompanyCategoryDT.Rows[i]["CompanyCategoryID"], 0);
                    }
                    if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0) {
                        SlotMaxBetCount3DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxBetCount3Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                        SlotMaxBetCount30DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxBetCount30Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                        SlotMaxWinValue7DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinValue7Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                        SlotMaxWinValueYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinValueYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                        SlotMaxWinRate7DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinRate7Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                        SlotMaxWinRateYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinRateYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                        SlotMaxRTPYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxRTPYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];

                        gameCodeRTPResult = lobbyAPI.GetGameCodeRTP(GetToken(), Guid.NewGuid().ToString(), DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"), DateTime.Now.ToString("yyyy-MM-dd"));
                        if (gameCodeRTPResult != null && gameCodeRTPResult.RTPList.Length > 0) {
                            month1_gameCodeRTP = gameCodeRTPResult.RTPList.Where(w => w.GameCategoryCode == "Slot").ToList();
                            day7_gameCodeRTP = month1_gameCodeRTP.Where(w => Convert.ToDateTime(w.SummaryDate) <= Convert.ToDateTime(DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")) && Convert.ToDateTime(w.SummaryDate) >= Convert.ToDateTime(DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd"))).ToList();
                            day3_gameCodeRTP = day7_gameCodeRTP.Where(w => Convert.ToDateTime(w.SummaryDate) <= Convert.ToDateTime(DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")) && Convert.ToDateTime(w.SummaryDate) >= Convert.ToDateTime(DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd"))).ToList();
                            yesterday_gameCodeRTP = day3_gameCodeRTP.Where(w => w.SummaryDate == DateTime.Now.AddDays(-2).ToString("yyyy-MM-dd")).ToList();

                            //老虎機最多轉72hour
                            SlotMaxBetCount3DayResult = (from p in day3_gameCodeRTP
                                                         group p by new { p.GameCode } into g
                                                         select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                            //maharaja最多轉30day
                            SlotMaxBetCount30DayResult = (from p in month1_gameCodeRTP
                                                          group p by new { p.GameCode } into g
                                                          select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                            //7天內最大開獎
                            SlotMaxWinValue7DayResult = (from p in day7_gameCodeRTP
                                                         group p by new { p.GameCode } into g
                                                         select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                            //前天最大開獎
                            SlotMaxWinValueYesterdayResult = (from p in yesterday_gameCodeRTP
                                                              group p by new { p.GameCode } into g
                                                              select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                            //7天內最大倍率
                            SlotMaxWinRate7DayResult = (from p in day7_gameCodeRTP
                                                        group p by new { p.GameCode } into g
                                                        select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                            //前天最大倍率
                            SlotMaxWinRateYesterdayResult = (from p in yesterday_gameCodeRTP
                                                             group p by new { p.GameCode } into g
                                                             select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20).ToList();
                            //前天最高RTP
                            SlotMaxRTPYesterdayResult = (from p in yesterday_gameCodeRTP
                                                         select new CompanyCategoryByStatistics { GameCode = p.GameCode, QTY =  (p.OrderValue == 0 ? 0 : (1 + (p.RewardValue / p.OrderValue)) * 100) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                        }

                        IsHotCompanyCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "Hot" + "'" + " And Location='GameList_All'")[0]["CompanyCategoryID"];
                        IsNewCompanyCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "New" + "'" + " And Location='GameList_All'")[0]["CompanyCategoryID"];

                        companyGameCodeResult = lobbyAPI.GetCompanyGameCode(GetToken(), Guid.NewGuid().ToString());
                        if (companyGameCodeResult.Result == EWin.Lobby.enumResult.OK) {
                            companyGameCodeResult.GameCodeList = companyGameCodeResult.GameCodeList.OrderByDescending(o => o.SortIndex).ToArray();
                            for (int i = 0; i < companyGameCodeResult.GameCodeList.Length; i++) {   //建立全部GameCode資料

                                //取得最大GameID
                                if (MaxGameID < companyGameCodeResult.GameCodeList[i].GameID) {
                                    MaxGameID = companyGameCodeResult.GameCodeList[i].GameID;
                                }

                                Tag = companyGameCodeResult.GameCodeList[i].Tag == null ? "" : Newtonsoft.Json.JsonConvert.SerializeObject(companyGameCodeResult.GameCodeList[i].Tag);
                                GameBrand = companyGameCodeResult.GameCodeList[i].GameCode.Split('.')[0];
                                GameCode = companyGameCodeResult.GameCodeList[i].GameCode;
                                GameCategoryCode = companyGameCodeResult.GameCodeList[i].GameCategoryCode;
                                GameCategorySubCode = companyGameCodeResult.GameCodeList[i].GameCategorySubCode;
                                SortIndex = companyGameCodeResult.GameCodeList[i].SortIndex;
                                OcwCompanyGameCode ocwGameCode = new OcwCompanyGameCode() {
                                    GameID = companyGameCodeResult.GameCodeList[i].GameID,
                                    GameBrand = GameBrand,
                                    GameCode = GameCode,
                                    GameName = companyGameCodeResult.GameCodeList[i].GameName,
                                    GameCategoryCode = GameCategoryCode,
                                    GameCategorySubCode = GameCategorySubCode,
                                    AllowDemoPlay = companyGameCodeResult.GameCodeList[i].AllowDemoPlay,
                                    RTPInfo = companyGameCodeResult.GameCodeList[i].RTPInfo,
                                    IsHot = companyGameCodeResult.GameCodeList[i].IsHot,
                                    IsNew = companyGameCodeResult.GameCodeList[i].IsNew,
                                    SortIndex = companyGameCodeResult.GameCodeList[i].SortIndex
                                };

                                AllGameCodeData.Add(ocwGameCode);
                                if (SlotMaxBetCount3DayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxBetCount3DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxBetCount3DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                if (SlotMaxBetCount30DayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxBetCount30DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxBetCount30DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                if (SlotMaxWinValue7DayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxWinValue7DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinValue7DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                if (SlotMaxWinValueYesterdayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxWinValueYesterdayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinValueYesterdayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                if (SlotMaxWinRate7DayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxWinRate7DayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinRate7DayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                if (SlotMaxWinRateYesterdayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxWinRateYesterdayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinRateYesterdayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                if (SlotMaxRTPYesterdayResult.Where(w => w.GameCode == GameCode).Count() > 0) {
                                    var QTY = SlotMaxRTPYesterdayResult.Where(w => w.GameCode == GameCode).First().QTY;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxRTPYesterdayCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, QTY.ToString(), companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                }

                                #region 熱門遊戲
                                if (companyGameCodeResult.GameCodeList[i].IsHot == 1) {
                                    if (CategoryGameCodeCount.TryGetValue(IsHotCompanyCategoryID, out CategoryGameCodeCountID)) {

                                        if (CategoryGameCodeCount[IsHotCompanyCategoryID] < 20) {
                                            CategoryGameCodeCount[IsHotCompanyCategoryID] = CategoryGameCodeCount[IsHotCompanyCategoryID] + 1;
                                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsHotCompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                            if (InsertCompanyGameCodeReturn == 0) {
                                                R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsHotCompanyCategoryID;
                                                //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                            }
                                        }
                                    }
                                }
                                #endregion

                                #region 最新遊戲
                                if (companyGameCodeResult.GameCodeList[i].IsNew == 1) {

                                    if (CategoryGameCodeCount[IsNewCompanyCategoryID] < 20) {
                                        CategoryGameCodeCount[IsNewCompanyCategoryID] = CategoryGameCodeCount[IsNewCompanyCategoryID] + 1;
                                        InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsNewCompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                        if (InsertCompanyGameCodeReturn == 0) {
                                            R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsNewCompanyCategoryID;
                                            //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                        }
                                    }
                                }
                                #endregion

                                #region 廠牌分類

                                Location = "GameList_All";
                                ShowType = 0;

                                if (CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'" + " And Location='" + Location + "'").Length == 0) {
                                    InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 3, GameBrand, 99, 0, Location, ShowType);
                                    if (InsertCompanyCategoryReturn > 0) {
                                        CategoryGameCodeCount.Add(InsertCompanyCategoryReturn, 0);
                                        CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                                    }
                                }

                                IsGameBrandCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'" + " And Location='" + Location + "'")[0]["CompanyCategoryID"];


                                if (CategoryGameCodeCount[IsGameBrandCategoryID] < 20) {
                                    CategoryGameCodeCount[IsGameBrandCategoryID] = CategoryGameCodeCount[IsGameBrandCategoryID] + 1;
                                    switch (GameBrand)
                                    {
                                        case "MG":
                                            SortIndex = 90;
                                            break;
                                        case "BBIN":
                                            SortIndex = 91;
                                            break;
                                        case "GMW":
                                            SortIndex = 92;
                                            break;
                                        case "HB":
                                            SortIndex = 93;
                                            break;
                                        case "NE":
                                            SortIndex = 94;
                                            break;
                                        case "RT":
                                            SortIndex = 95;
                                            break;
                                        default:
                                            break;
                                    }

                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsGameBrandCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                    if (InsertCompanyGameCodeReturn == 0) {
                                        R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsGameBrandCategoryID;
                                        //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                    }
                                }

                                #endregion

                                #region 遊戲類型分類

                                ShowType = 0;
                                if (GameCategoryCode == "Live" || GameCategoryCode == "Electron") {
                                    if (GameCategoryCode == "Electron") {
                                        Location = "GameList_Electron";
                                    } else {
                                        Location = "GameList_Live";
                                    }

                                    if (CompanyCategoryDT.Select("CategoryName='" + GameCategorySubCode + "' And Location='" + Location + "'").Length == 0) {
                                        InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 4, GameCategorySubCode, 0, 0, Location, ShowType);
                                        if (InsertCompanyCategoryReturn > 0) {
                                            CategoryGameCodeCount.Add(InsertCompanyCategoryReturn, 0);
                                            CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                                        }
                                    }

                                    IsCategoryCodeCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + GameCategorySubCode + "' And Location='" + Location + "'")[0]["CompanyCategoryID"];

                                } else {
                                    Location = "GameList_Other";
                                    if (CompanyCategoryDT.Select("CategoryName='" + "Other" + "'" + " And Location='" + Location + "'").Length == 0) {
                                        InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 4, "Other", 0, 0, Location, ShowType);
                                        if (InsertCompanyCategoryReturn > 0) {
                                            CategoryGameCodeCount.Add(InsertCompanyCategoryReturn, 0);
                                            CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                                        }
                                    }

                                    IsCategoryCodeCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "Other" + "'" + " And Location='" + Location + "'")[0]["CompanyCategoryID"];

                                }


                                if (CategoryGameCodeCount[IsCategoryCodeCategoryID] < 20) {
                                    CategoryGameCodeCount[IsCategoryCodeCategoryID] = CategoryGameCodeCount[IsCategoryCodeCategoryID] + 1;
                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsCategoryCodeCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                    if (InsertCompanyGameCodeReturn == 0) {
                                        R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsCategoryCodeCategoryID;
                                        //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                    }
                                }

                                #endregion


                                if (!string.IsNullOrEmpty(companyGameCodeResult.GameCodeList[i].CompanyCategoryTag)) {
                                    companyCategoryTags = companyGameCodeResult.GameCodeList[i].CompanyCategoryTag.Split(',');
                                    if (companyCategoryTags.Length > 0) {
                                        foreach (var companyCategoryTag in companyCategoryTags) {
                                            CompanyCategoryRow = CompanyCategoryDT.Select("CategoryName='" + companyCategoryTag.Trim() + "'");
                                            if (CompanyCategoryRow.Length > 0) {
                                                CompanyCategoryID = (int)CompanyCategoryRow[0]["CompanyCategoryID"];
                                                if (CategoryGameCodeCount[CompanyCategoryID] < 20) {
                                                    CategoryGameCodeCount[CompanyCategoryID] = CategoryGameCodeCount[CompanyCategoryID] + 1;
                                                    InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(CompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew, Tag, SortIndex);
                                                    if (InsertCompanyGameCodeReturn == 0) {
                                                        R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID;
                                                        //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                                    }
                                                }

                                            }
                                        }
                                    }
                                }
                            }

                            RedisCache.CompanyGameCode.UpdateSyncData(MaxGameID);
                            RedisCache.CompanyGameCode.UpdateCompanyGameCode();
                            RedisCache.CompanyGameCode.UpdateAllCompanyGameCode(Newtonsoft.Json.JsonConvert.SerializeObject(AllGameCodeData));

                        } else {
                            R.Message = "Get CompanyGameCodeResult Error";
                            //Console.WriteLine("Get CompanyGameCodeResult Error");
                        }
                    } else {
                        R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID;
                        //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                    }

                } else {
                    R.Message = "Get CompanyCategoryResult Count=0";
                    //Console.WriteLine("Get CompanyCategoryResult Count=0");
                }
                R.Result = EWin.Lobby.enumResult.OK;
            } else {
                R.Message = "Get CompanyCategoryResult Error";
                //Console.WriteLine("Get CompanyCategoryResult Error");
            }
        } else {
            R.Message = "Invalid Key";
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult TestUpdateCompanyCategory(string Key) {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.CompanyGameCodeResult companyGameCodeResult;
        EWin.Lobby.CompanyCategoryResult companyCategoryResult;
        EWin.Lobby.CompanyCategoryResult OCWcompanyCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.CompanyCategoryResult OCWcompanyStatisticsCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.GameCodeRTPResult gameCodeRTPResult;
        List<EWin.Lobby.GameCodeRTP> day3_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> month1_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> day7_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> yesterday_gameCodeRTP;
        int SlotMaxBetCount3DayCategoryID = 0;
        int SlotMaxBetCount30DayCategoryID = 0;
        int SlotMaxWinValue7DayCategoryID = 0;
        int SlotMaxWinValueYesterdayCategoryID = 0;
        int SlotMaxWinRate7DayCategoryID = 0;
        int SlotMaxWinRateYesterdayCategoryID = 0;
        int SlotMaxRTPYesterdayCategoryID = 0;
        Newtonsoft.Json.Linq.JObject SettingData;
        long UpdateTimestamp = 0;
        int GameID = 0;
        string GameCode = "";
        System.Data.DataTable CompanyCategoryDT = null;
        System.Data.DataRow[] CustomizeCompanyCategoryRows = null;
        int InsertCompanyCategoryReturn;
        int CompanyCategoryID = 0;
        string[] companyCategoryTags;
        System.Data.DataRow[] CompanyCategoryRow;
        string Location = "";
        List<OcwCompanyGameCode> AllGameCodeData = new List<OcwCompanyGameCode>();
        int ShowType = 0;
        List<CompanyCategoryByStatistics> SlotMaxBetCount3DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxBetCount30DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinValue7DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinValueYesterdayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinRate7DayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxWinRateYesterdayResult = new List<CompanyCategoryByStatistics>();
        List<CompanyCategoryByStatistics> SlotMaxRTPYesterdayResult = new List<CompanyCategoryByStatistics>();
        Dictionary<int, int> CategoryGameCodeCount = new Dictionary<int, int>();

        SettingData = EWinWeb.GetCompanyGameCodeSettingJObj();


        if (true) {
            //if (CheckPassword(Key)) {
            CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();

            #region 統計值
            if (SettingData["LastSyncStatisticsByDay"].ToString() != DateTime.Now.ToString("yyyy/MM/dd"))
            {
                SettingData["LastSyncStatisticsByDay"] = DateTime.Now.ToString("yyyy/MM/dd");
                Location = "GameList_Slot";
                ShowType = 0;

                OCWcompanyStatisticsCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount3Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount30Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValue7Day",CompanyCategoryID = 0,SortIndex =89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValueYesterday",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRate7Day",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRateYesterday",CompanyCategoryID = 0,SortIndex = 89
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxRTPYesterday",CompanyCategoryID = 0,SortIndex = 89
        }};

                for (int i = 0; i < OCWcompanyStatisticsCategoryResult.CategoryList.Length; i++)
                {
                    if (CompanyCategoryDT.Select("CategoryName='" + OCWcompanyStatisticsCategoryResult.CategoryList[i].CategoryName + "' And CategoryType=1").Length == 0)
                    {
                        InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyStatisticsCategoryResult.CategoryList[i].CompanyCategoryID, 1, OCWcompanyStatisticsCategoryResult.CategoryList[i].CategoryName, OCWcompanyStatisticsCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
                        if (InsertCompanyCategoryReturn > 0)
                        {
                            CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                        }
                    }
                }

                SlotMaxBetCount3DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxBetCount3Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                SlotMaxBetCount30DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxBetCount30Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                SlotMaxWinValue7DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinValue7Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                SlotMaxWinValueYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinValueYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                SlotMaxWinRate7DayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinRate7Day" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                SlotMaxWinRateYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxWinRateYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];
                SlotMaxRTPYesterdayCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "SlotMaxRTPYesterday" + "' And CategoryType=1")[0]["CompanyCategoryID"];

                gameCodeRTPResult = lobbyAPI.GetGameCodeRTP(GetToken(), Guid.NewGuid().ToString(), DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"), DateTime.Now.ToString("yyyy-MM-dd"));

                if (gameCodeRTPResult != null && gameCodeRTPResult.RTPList.Length > 0)
                {
                    month1_gameCodeRTP = gameCodeRTPResult.RTPList.Where(w => w.GameCategoryCode == "Slot").ToList();
                    day7_gameCodeRTP = month1_gameCodeRTP.Where(w => Convert.ToDateTime(w.SummaryDate) <= Convert.ToDateTime(DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")) && Convert.ToDateTime(w.SummaryDate) >= Convert.ToDateTime(DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd"))).ToList();
                    day3_gameCodeRTP = day7_gameCodeRTP.Where(w => Convert.ToDateTime(w.SummaryDate) <= Convert.ToDateTime(DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")) && Convert.ToDateTime(w.SummaryDate) >= Convert.ToDateTime(DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd"))).ToList();
                    yesterday_gameCodeRTP = day3_gameCodeRTP.Where(w => w.SummaryDate == DateTime.Now.AddDays(-2).ToString("yyyy-MM-dd")).ToList();

                    //老虎機最多轉72hour
                    SlotMaxBetCount3DayResult = (from p in day3_gameCodeRTP
                                                 group p by new { p.GameCode } into g
                                                 select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxBetCount3DayCategoryID);
                    for (int i = 0; i < SlotMaxBetCount3DayResult.Count; i++)
                    {
                        var data = SlotMaxBetCount3DayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxBetCount3DayCategoryID, data.GameCode);
                    }
                    //maharaja最多轉30day
                    SlotMaxBetCount30DayResult = (from p in month1_gameCodeRTP
                                                  group p by new { p.GameCode } into g
                                                  select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxBetCount30DayCategoryID);
                    for (int i = 0; i < SlotMaxBetCount30DayResult.Count; i++)
                    {
                        var data = SlotMaxBetCount30DayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxBetCount30DayCategoryID, data.GameCode);
                    }
                    //7天內最大開獎
                    SlotMaxWinValue7DayResult = (from p in day7_gameCodeRTP
                                                 group p by new { p.GameCode } into g
                                                 select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxWinValue7DayCategoryID);
                    for (int i = 0; i < SlotMaxWinValue7DayResult.Count; i++)
                    {
                        var data = SlotMaxWinValue7DayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxWinValue7DayCategoryID, data.GameCode);
                    }
                    //前天最大開獎
                    SlotMaxWinValueYesterdayResult = (from p in yesterday_gameCodeRTP
                                                      group p by new { p.GameCode } into g
                                                      select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxWinValueYesterdayCategoryID);
                    for (int i = 0; i < SlotMaxWinValueYesterdayResult.Count; i++)
                    {
                        var data = SlotMaxWinValueYesterdayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxWinValueYesterdayCategoryID, data.GameCode);
                    }
                    //7天內最大倍率
                    SlotMaxWinRate7DayResult = (from p in day7_gameCodeRTP
                                                group p by new { p.GameCode } into g
                                                select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxWinRate7DayCategoryID);
                    for (int i = 0; i < SlotMaxWinRate7DayResult.Count; i++)
                    {
                        var data = SlotMaxWinRate7DayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxWinRate7DayCategoryID, data.GameCode);
                    }
                    //前天最大倍率
                    SlotMaxWinRateYesterdayResult = (from p in yesterday_gameCodeRTP
                                                     group p by new { p.GameCode } into g
                                                     select new CompanyCategoryByStatistics { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxWinRateYesterdayCategoryID);
                    for (int i = 0; i < SlotMaxWinRateYesterdayResult.Count; i++)
                    {
                        var data = SlotMaxWinRateYesterdayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxWinRateYesterdayCategoryID, data.GameCode);
                    }
                    //前天最高RTP
                    SlotMaxRTPYesterdayResult = (from p in yesterday_gameCodeRTP
                                                 select new CompanyCategoryByStatistics { GameCode = p.GameCode, QTY = (p.OrderValue == 0 ? 0 : (1 + (p.RewardValue / p.OrderValue)) * 100) }).OrderByDescending(o => o.QTY).Take(20).ToList();

                    EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID(SlotMaxRTPYesterdayCategoryID);
                    for (int i = 0; i < SlotMaxRTPYesterdayResult.Count; i++)
                    {
                        var data = SlotMaxRTPYesterdayResult[i];
                        EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(SlotMaxRTPYesterdayCategoryID, data.GameCode);
                    }
                }
            }

            #endregion


            companyCategoryResult = lobbyAPI.GetCompanyCategory(GetToken(), Guid.NewGuid().ToString());
            if (companyCategoryResult.Result == EWin.Lobby.enumResult.OK) {
                if (companyCategoryResult.CategoryList.Length > 0) {

                    #region 當Ocw存在 Category,EWIN不存在Category(從Ocw刪除)
                    if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0)
                    {
                        CustomizeCompanyCategoryRows = CompanyCategoryDT.Select("CategoryType=0");
                        if (CustomizeCompanyCategoryRows.Length > 0)
                        {
                            for (int i = 0; i < CustomizeCompanyCategoryRows.Length; i++)
                            {
                                //OCW存在EWIN不存在)
                                if (companyCategoryResult.CategoryList.Where(w => w.CompanyCategoryID == (int)CustomizeCompanyCategoryRows[i]["EwinCompanyCategoryID"]).FirstOrDefault() == null)
                                {
                                    //刪除Category
                                    if (EWinWebDB.CompanyCategory.DeleteCompanyCategoryByCompanyCategoryID2((int)CustomizeCompanyCategoryRows[i]["CompanyCategoryID"]) > 0)
                                    {  //刪除Category底下的GameCode
                                        EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByCategoryID((int)CustomizeCompanyCategoryRows[i]["CompanyCategoryID"]);
                                    }
                                }
                            }
                        }
                    }
                    #endregion

                    CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                    for (int i = 0; i < companyCategoryResult.CategoryList.Length; i++) {
                        //@隱性分類不顯示,故不處理
                        if (!companyCategoryResult.CategoryList[i].CategoryName.Contains("@"))
                        {
                            if (companyCategoryResult.CategoryList[i].Tag.Length == 4)
                            {
                                Location = ParseLocation(companyCategoryResult.CategoryList[i].Tag.Substring(0, 2));
                                ShowType = ParseShowType(companyCategoryResult.CategoryList[i].Tag.Substring(2, 2));

                                if (CompanyCategoryDT.Select("EwinCompanyCategoryID='" + companyCategoryResult.CategoryList[i].CompanyCategoryID + "' And CategoryType=0").Length == 0)
                                {
                                    EWinWebDB.CompanyCategory.InsertCompanyCategory(companyCategoryResult.CategoryList[i].CompanyCategoryID, 0, companyCategoryResult.CategoryList[i].CategoryName, companyCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
                                }
                            }
                        }

                    }

                    CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();

                    if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0) {

                        if (SettingData != null) {
                            UpdateTimestamp = int.Parse(SettingData["UpdateTimestamp"].ToString());
                            GameID = int.Parse(SettingData["GameID"].ToString());
                        }

                        while (true)
                        {
                            companyGameCodeResult = lobbyAPI.GetCompanyGameCodeByUpdateTimestamp(GetToken(), Guid.NewGuid().ToString(), UpdateTimestamp, GameID);

                            if (companyGameCodeResult.Result == EWin.Lobby.enumResult.OK&&companyGameCodeResult.GameCodeList!=null&&companyGameCodeResult.GameCodeList.Length>0)
                            {
                                for (int i = 0; i < companyGameCodeResult.GameCodeList.Length; i++)
                                {   //建立全部GameCode資料
                                    GameID = companyGameCodeResult.GameCodeList[i].GameID;
                                    UpdateTimestamp = companyGameCodeResult.GameCodeList[i].UpdateTimestamp;
                                    GameCode=companyGameCodeResult.GameCodeList[i].GameCode;
                                    SettingData["UpdateTimestamp"] = UpdateTimestamp;
                                    SettingData["GameID"] = GameID;
                                    if (companyGameCodeResult.GameCodeList[i].GameStatus == EWin.Lobby.enumGameCodeStatus.GameOpen)
                                    {
                                        if (!string.IsNullOrEmpty(companyGameCodeResult.GameCodeList[i].CompanyCategoryTag))
                                        {
                                            companyCategoryTags = companyGameCodeResult.GameCodeList[i].CompanyCategoryTag.Split(',');
                                            if (companyCategoryTags.Length > 0)
                                            {
                                                foreach (var companyCategoryTag in companyCategoryTags)
                                                {
                                                    //@隱性分類不顯示,故不處理
                                                    if (!companyCategoryTag.Trim().Contains("@"))
                                                    {
                                                        CompanyCategoryRow = CompanyCategoryDT.Select("CategoryName='" + companyCategoryTag.Trim() + "'");
                                                        if (CompanyCategoryRow.Length > 0)
                                                        {
                                                            CompanyCategoryID = (int)CompanyCategoryRow[0]["CompanyCategoryID"];
                                                            EWinWebDB.CompanyCategoryGameCode.InsertCompanyCategoryGameCode(CompanyCategoryID, GameCode);

                                                        }
                                                    }

                                                }
                                            }
                                        }
                                    }
                                    else {
                                        EWinWebDB.CompanyCategoryGameCode.DeleteCompanyCategoryGameCodeByGameCode(GameCode);
                                    }

                                }
                            }
                            else
                            {
                                string  Filename = HttpContext.Current.Server.MapPath("/App_Data/CompanyGameCodeSetting.json");

                                WriteAllText(Filename,SettingData.ToString());
                                RedisCache.CompanyCategoryGameCode.UpdateCompanyGameCode();
                                break;
                            }
                        }
                    } else {
                        R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID;
                        //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                    }

                } else {
                    R.Message = "Get CompanyCategoryResult Count=0";
                    //Console.WriteLine("Get CompanyCategoryResult Count=0");
                }
                R.Result = EWin.Lobby.enumResult.OK;
            } else {
                R.Message = "Get CompanyCategoryResult Error";
                //Console.WriteLine("Get CompanyCategoryResult Error");
            }
        } else {
            R.Message = "Invalid Key";
        }

        return R;
    }

    static System.Collections.ArrayList iSyncRoot = new System.Collections.ArrayList();

    private static void WriteAllText(string Filename, string Content)
    {
        byte[] ContentArray = System.Text.Encoding.UTF8.GetBytes(Content);
        Exception throwEx = null;

        for (var i = 0; i < 3; i++) {
            lock (iSyncRoot) {
                try {
                    System.IO.File.WriteAllText(Filename, Content);
                    throwEx = null;
                    break;
                } catch (Exception ex) {
                    throwEx = ex;
                }
            }

            System.Threading.Thread.Sleep(100);
        }

        if (throwEx != null)
            throw new Exception(throwEx.ToString() + "\r\n" + "  Filename:" + Filename);
    }

    private string GetToken()
    {
        string Token;
        int RValue;
        Random R = new Random();
        RValue = R.Next(100000, 9999999);
        Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

        return Token;
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

    public class CompanyCategoryByStatistics
    {
        public string GameCode { get; set; }
        public decimal QTY { get; set; }
    }

    public class CompanyGameCode
    {
        public string BrandCode { get; set; }
        public string GameCode { get; set; }
        public int GameID { get; set; }
        public string GameName { get; set; }
        public string GameCategoryCode { get; set; }
        public string GameCategorySubCode { get; set; }
        public int AllowDemoPlay { get; set; }
        public string GameAccountingCode { get; set; }
        public string RTPInfo { get; set; }
        public int IsNew { get; set; }
        public int IsHot { get; set; }
        public string CompanyCategoryTag { get; set; }
        public string Tag { get; set; }
    }

    public class OcwCompanyGameCode
    {
        public int forCompanyCategoryID { get; set; }
        public int GameID { get; set; }
        public string GameCode { get; set; }
        public string GameBrand { get; set; }
        public string GameName { get; set; }
        public string GameCategoryCode { get; set; }
        public string GameCategorySubCode { get; set; }
        public int AllowDemoPlay { get; set; }
        public string RTPInfo { get; set; }
        public string Info { get; set; }
        public int IsHot { get; set; }
        public int IsNew { get; set; }
        public int SortIndex { get; set; }
        public string Tag { get; set; }
    }
}