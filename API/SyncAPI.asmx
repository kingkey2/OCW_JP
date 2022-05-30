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



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult HeartBeat(string GUID, string Echo)
    {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

        return lobbyAPI.HeartBeat(GUID, Echo);
    }

    public EWin.Lobby.APIResult UpdateCompanyCategoryByStatistics()
    {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.GameCodeRTPResult gameCodeRTPResult;
        List<EWin.Lobby.GameCodeRTP> day3_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> month1_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> day7_gameCodeRTP;
        List<EWin.Lobby.GameCodeRTP> yesterday_gameCodeRTP;
        List<CompanyGameCode> AllCompanyGameCodeResult;
        int SlotMaxBetCount3DayCategoryID = 0;
        int SlotMaxBetCount30DayCategoryID = 0;
        int SlotMaxWinValue7DayCategoryID = 0;
        int SlotMaxWinValueYesterdayCategoryID = 0;
        int SlotMaxWinRate7DayCategoryID = 0;
        int SlotMaxWinRateYesterdayCategoryID = 0;
        int SlotMaxRTPYesterdayCategoryID = 0;
        EWin.Lobby.CompanyCategoryResult OCWcompanyCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

        System.Data.DataTable CompanyCategoryDT = null;
        int InsertCompanyCategoryReturn;
        int InsertCompanyGameCodeReturn;

        string Location = "GameList_Slot";
        int ShowType = 0;
        string StrAllCompanyGameCodeData;
        #region 設定Ocw自定義分類
        OCWcompanyCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount3Day",CompanyCategoryID = 0,SortIndex = 99
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxBetCount30Day",CompanyCategoryID = 0,SortIndex = 99
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValue7Day",CompanyCategoryID = 0,SortIndex =99
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinValueYesterday",CompanyCategoryID = 0,SortIndex = 99
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRate7Day",CompanyCategoryID = 0,SortIndex = 99
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxWinRateYesterday",CompanyCategoryID = 0,SortIndex = 99
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "SlotMaxRTPYesterday",CompanyCategoryID = 0,SortIndex = 99
        }};

        for (int i = 0; i < OCWcompanyCategoryResult.CategoryList.Length; i++)
        {
            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyCategoryResult.CategoryList[i].CompanyCategoryID, 1, OCWcompanyCategoryResult.CategoryList[i].CategoryName, OCWcompanyCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
        }
        #endregion

        CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
        if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0)
        {
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
                var SlotMaxBetCount3DayResult = (from p in day3_gameCodeRTP
                                                 group p by new { p.GameCode } into g
                                                 select new { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20);

                //maharaja最多轉30day
                var SlotMaxBetCount30DayResult = (from p in month1_gameCodeRTP
                                                  group p by new { p.GameCode } into g
                                                  select new { GameCode = g.Key.GameCode, QTY = g.Sum(p => p.BetCount) }).OrderByDescending(o => o.QTY).Take(20);

                //7天內最大開獎
                var SlotMaxWinValue7DayResult = (from p in day7_gameCodeRTP
                                                 group p by new { p.GameCode } into g
                                                 select new { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20);
                //前天最大開獎
                var SlotMaxWinValueYesterdayResult = (from p in yesterday_gameCodeRTP
                                                      group p by new { p.GameCode } into g
                                                      select new { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinValue) }).OrderByDescending(o => o.QTY).Take(20);
                //7天內最大倍率
                var SlotMaxWinRate7DayResult = (from p in day7_gameCodeRTP
                                                group p by new { p.GameCode } into g
                                                select new { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20);
                //前天最大倍率
                var SlotMaxWinRateYesterdayResult = (from p in yesterday_gameCodeRTP
                                                     group p by new { p.GameCode } into g
                                                     select new { GameCode = g.Key.GameCode, QTY = g.Max(m => m.MaxWinRate) }).OrderByDescending(o => o.QTY).Take(20);
                //前天最高RTP
                var SlotMaxRTPYesterdayResult = (from p in yesterday_gameCodeRTP
                                                 select new { GameCode = p.GameCode, QTY = (1 + (p.RewardValue / p.OrderValue))*100 }).OrderByDescending(o => o.QTY).Take(20);


                StrAllCompanyGameCodeData = RedisCache.CompanyGameCode.GetAllCompanyGameCode();
                if (!string.IsNullOrEmpty(StrAllCompanyGameCodeData))
                {
                    AllCompanyGameCodeResult = Newtonsoft.Json.JsonConvert.DeserializeObject<List<CompanyGameCode>>(StrAllCompanyGameCodeData);
                    if (AllCompanyGameCodeResult != null && AllCompanyGameCodeResult.Count > 0)
                    {
                        foreach (var data in AllCompanyGameCodeResult)
                        {
                            if (SlotMaxBetCount3DayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxBetCount3DayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxBetCount3DayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }

                            if (SlotMaxBetCount30DayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxBetCount30DayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxBetCount30DayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }

                            if (SlotMaxWinValue7DayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxWinValue7DayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinValue7DayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }

                            if (SlotMaxWinValueYesterdayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxWinValueYesterdayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinValueYesterdayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }

                            if (SlotMaxWinRate7DayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxWinRate7DayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinRate7DayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }

                            if (SlotMaxWinRateYesterdayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxWinRateYesterdayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxWinRateYesterdayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }

                            if (SlotMaxRTPYesterdayResult.Where(w => w.GameCode == data.GameCode).Count() > 0)
                            {
                                var QTY= SlotMaxRTPYesterdayResult.Where(w => w.GameCode == data.GameCode).First().QTY;
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(SlotMaxRTPYesterdayCategoryID, data.BrandCode, data.GameName, QTY.ToString(), data.GameID, data.GameCategoryCode, data.GameCategorySubCode,data.AllowDemoPlay, data.RTPInfo, data.IsHot, data.IsNew,string.IsNullOrEmpty(data.Tag)?"":data.Tag,0);
                            }
                        }
                    }
                    else
                    {
                        R.Message = "Get AllCompanyGameCodeData Count=0";
                    }
                }
                else
                {
                    R.Message = "Get AllCompanyGameCodeData Error";
                }
            }
            else
            {
                R.Message = "Get GameCodeRTPResult Error";
            }
        }
        else
        {
            R.Message = "Get CompanyCategoryDT Count=0";
        }
        return R;
    }

    private string ParseLocation(string LocationCode)
    {
        string ret = "GameList_All";
        switch (LocationCode)
        {
            case "01":
                ret = "GameList_All";
                break;
            case "02":
                ret = "GameList_Slot";
                break;
            case "03":
                ret = "GameList_Electron";
                break;
            case "04":
                ret = "GameList_Live";
                break;
            case "05":
                ret = "GameList_Other";
                break;
            case "06":
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
            default:
                ret = 0;
                break;
        }
        return ret;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult UpdateCompanyCategory()
    {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.CompanyGameCodeResult companyGameCodeResult;
        EWin.Lobby.CompanyCategoryResult companyCategoryResult;
        EWin.Lobby.CompanyCategoryResult OCWcompanyCategoryResult = new EWin.Lobby.CompanyCategoryResult();
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

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
        System.Data.DataRow DataRow;
        int MaxGameID = 0;
        string GameBrand;
        string GameCategoryCode;
        string GameCategorySubCode;
        string Location = "";
        string Tag;
        int ShowType = 0;
        #region 設定Ocw自定義分類
        OCWcompanyCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "Hot",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "New",CompanyCategoryID = 0,SortIndex = 0
        } };

        Location = "GameList_All";
        ShowType = 0;
        for (int i = 0; i < OCWcompanyCategoryResult.CategoryList.Length; i++)
        {
            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyCategoryResult.CategoryList[i].CompanyCategoryID, 2, OCWcompanyCategoryResult.CategoryList[i].CategoryName, OCWcompanyCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);
        }
        #endregion

        companyCategoryResult = lobbyAPI.GetCompanyCategory(GetToken(), Guid.NewGuid().ToString());
        if (companyCategoryResult.Result == EWin.Lobby.enumResult.OK)
        {
            if (companyCategoryResult.CategoryList.Length > 0)
            {
                EWinWebDB.CompanyCategory.DeleteCompanyCategory(0);
                for (int i = 0; i < companyCategoryResult.CategoryList.Length; i++)
                {
                    if (companyCategoryResult.CategoryList[i].Tag.Length == 4)
                    {
                        Location = ParseLocation(companyCategoryResult.CategoryList[i].Tag.Substring(0, 2));
                        ShowType = ParseShowType(companyCategoryResult.CategoryList[i].Tag.Substring(2, 2));
                        InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertCompanyCategory(companyCategoryResult.CategoryList[i].CompanyCategoryID, 0, companyCategoryResult.CategoryList[i].CategoryName, companyCategoryResult.CategoryList[i].SortIndex, 0, Location, ShowType);

                        if (InsertCompanyCategoryReturn <= 0)
                        {
                            R.Message = "InsertCompanyCategory Error EWinCompanyCategoryID=" + companyCategoryResult.CategoryList[i].CompanyCategoryID;
                        }

                    }
                }

                CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();

                if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0)
                {
                    IsHotCompanyCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "Hot" + "'")[0]["CompanyCategoryID"];
                    IsNewCompanyCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "New" + "'")[0]["CompanyCategoryID"];

                    companyGameCodeResult = lobbyAPI.GetCompanyGameCode(GetToken(), Guid.NewGuid().ToString());
                    if (companyGameCodeResult.Result == EWin.Lobby.enumResult.OK)
                    {
                        EWinWebDB.CompanyGameCode.DeleteCompanyGameCode();
                        for (int i = 0; i < companyGameCodeResult.GameCodeList.Length; i++)
                        {
                            if (MaxGameID<companyGameCodeResult.GameCodeList[i].GameID)
                            {
                                MaxGameID = companyGameCodeResult.GameCodeList[i].GameID;
                            }

                            Tag = companyGameCodeResult.GameCodeList[i].Tag == null ? "" : Newtonsoft.Json.JsonConvert.SerializeObject(companyGameCodeResult.GameCodeList[i].Tag);
                            GameBrand = companyGameCodeResult.GameCodeList[i].GameCode.Split('.')[0];
                            GameCategoryCode = companyGameCodeResult.GameCodeList[i].GameCategoryCode;
                            GameCategorySubCode = companyGameCodeResult.GameCodeList[i].GameCategorySubCode;

                            #region 熱門遊戲
                            if (companyGameCodeResult.GameCodeList[i].IsHot == 1)
                            {
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsHotCompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew,Tag,0);
                                if (InsertCompanyGameCodeReturn == 0)
                                {
                                    R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsHotCompanyCategoryID;
                                    //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                }
                            }
                            #endregion

                            #region 最新遊戲
                            if (companyGameCodeResult.GameCodeList[i].IsNew == 1)
                            {
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsNewCompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew,Tag,0);
                                if (InsertCompanyGameCodeReturn == 0)
                                {
                                    R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsNewCompanyCategoryID;
                                    //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                }
                            }
                            #endregion

                            #region 廠牌分類

                            Location = "GameList_All";
                            ShowType = 0;

                            if (CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'").Length == 0)
                            {
                                InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 3, GameBrand, 99, 0, Location, ShowType);
                                if (InsertCompanyCategoryReturn > 0)
                                {
                                    CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                                }

                            }

                            IsGameBrandCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'")[0]["CompanyCategoryID"];
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsGameBrandCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew,Tag,0);
                            if (InsertCompanyGameCodeReturn == 0)
                            {
                                R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsGameBrandCategoryID;
                                //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                            }
                            #endregion

                            #region 遊戲類型分類

                            ShowType = 0;
                            if (GameCategoryCode == "Live" || GameCategoryCode == "Electron")
                            {
                                if (GameCategoryCode == "Electron")
                                {
                                    Location = "GameList_Electron";
                                }
                                else
                                {
                                    Location = "GameList_Live";
                                }

                                if (CompanyCategoryDT.Select("CategoryName='" + GameCategorySubCode + "'").Length == 0)
                                {
                                    InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 4, GameCategorySubCode, 0, 0, Location, ShowType);
                                    if (InsertCompanyCategoryReturn > 0)
                                    {
                                        CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                                    }
                                }

                                IsCategoryCodeCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + GameCategorySubCode + "'")[0]["CompanyCategoryID"];
                            }
                            else
                            {
                                Location = "GameList_Other";
                                if (CompanyCategoryDT.Select("CategoryName='" + "Other" + "'").Length == 0)
                                {
                                    InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 4, "Other", 0, 0, Location, ShowType);
                                    if (InsertCompanyCategoryReturn > 0)
                                    {
                                        CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();
                                    }
                                }

                                IsCategoryCodeCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "Other" + "'")[0]["CompanyCategoryID"];
                            }

                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsCategoryCodeCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew,Tag,0);
                            if (InsertCompanyGameCodeReturn == 0)
                            {
                                R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsCategoryCodeCategoryID;
                                //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                            }
                            #endregion


                            if (!string.IsNullOrEmpty(companyGameCodeResult.GameCodeList[i].CompanyCategoryTag))
                            {
                                companyCategoryTags = companyGameCodeResult.GameCodeList[i].CompanyCategoryTag.Split(',');
                                if (companyCategoryTags.Length > 0)
                                {
                                    foreach (var companyCategoryTag in companyCategoryTags)
                                    {
                                        CompanyCategoryRow = CompanyCategoryDT.Select("CategoryName='" + companyCategoryTag.Trim() + "'");
                                        if (CompanyCategoryRow.Length > 0)
                                        {
                                            CompanyCategoryID = (int)CompanyCategoryRow[0]["CompanyCategoryID"];

                                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(CompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew,Tag,0);
                                            if (InsertCompanyGameCodeReturn == 0)
                                            {
                                                R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID;
                                                //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        R= UpdateCompanyCategoryByStatistics();
                        RedisCache.CompanyGameCode.UpdateMaxGameID(MaxGameID);
                        RedisCache.CompanyGameCode.UpdateCompanyGameCode();

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
                R.Message = "Get CompanyCategoryResult Count=0";
                //Console.WriteLine("Get CompanyCategoryResult Count=0");
            }
            R.Result = EWin.Lobby.enumResult.OK;
        }
        else
        {
            R.Message = "Get CompanyCategoryResult Error";
            //Console.WriteLine("Get CompanyCategoryResult Error");
        }
        return R;
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
}