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
public class SyncAPI : System.Web.Services.WebService {



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult HeartBeat(string GUID, string Echo) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

        return lobbyAPI.HeartBeat(GUID, Echo);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult UpdateCompanyCategoryByStatistics()
    {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.CompanyGameCodeResult companyGameCodeResult;
        EWin.Lobby.GameCodeRTPResult gameCodeRTPResult;
        EWin.Lobby.CompanyCategory CompanyCategory;
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
        System.Data.DataRow DataRow;
        string GameBrand;
        string Location = "GameList_All";
        int ShowType = 0;
        #region 設定Ocw自定義分類
        OCWcompanyCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "老虎機最多轉72hour",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "maharaja最多轉30day",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "7天內最大開獎",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "前天最大開獎",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "7天內最大倍率",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "前天最大倍率",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "前天最高RTP",CompanyCategoryID = 0,SortIndex = 0
        }};

        for (int i = 0; i < OCWcompanyCategoryResult.CategoryList.Length; i++)
        {
            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyCategoryResult.CategoryList[i].CompanyCategoryID, 1, OCWcompanyCategoryResult.CategoryList[i].CategoryName, OCWcompanyCategoryResult.CategoryList[i].SortIndex, 0,Location,ShowType);
        }
        #endregion


        gameCodeRTPResult = lobbyAPI.GetGameCodeRTP(GetToken(), Guid.NewGuid().ToString(),DateTime.Now.ToString("yyyy-MM-dd"),DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd"));
        if (gameCodeRTPResult.Result == EWin.Lobby.enumResult.OK)
        {
            if (gameCodeRTPResult.RTPList.Length > 0)
            {
                for (int i = 0; i < gameCodeRTPResult.RTPList.Length; i++)
                {
                        
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

    private string ParseLocation(string LocationCode)
    {
        string ret = "GameList_All";
        switch (LocationCode)
        {
            case "00":
                ret = "GameList_All";
                break;
            case "01":
                ret = "GameList_Solt";
                break;
            case "02":
                ret = "GameList_Electron";
                break;
            case "03":
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
            case "00":
                ret = 0;
                break;
            case "01":
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
    public EWin.Lobby.APIResult UpdateCompanyCategory() {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        EWin.Lobby.CompanyGameCodeResult companyGameCodeResult;
        EWin.Lobby.CompanyCategoryResult companyCategoryResult;
        EWin.Lobby.CompanyCategory CompanyCategory;
        EWin.Lobby.CompanyCategoryResult OCWcompanyCategoryResult=new EWin.Lobby.CompanyCategoryResult();
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
        int IsCategoryCodeCategoryID=0;
        System.Data.DataRow DataRow;
        string GameBrand;
        string GameCategoryCode;
        string GameCategorySubCode;
        string Location="";
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
            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyCategoryResult.CategoryList[i].CompanyCategoryID, 2, OCWcompanyCategoryResult.CategoryList[i].CategoryName, OCWcompanyCategoryResult.CategoryList[i].SortIndex, 0,Location,ShowType);
        }
        #endregion

        companyCategoryResult = lobbyAPI.GetCompanyCategory(GetToken(), Guid.NewGuid().ToString());
        if (companyCategoryResult.Result == EWin.Lobby.enumResult.OK)
        {
            if (companyCategoryResult.CategoryList.Length > 0)
            {
                for (int i = 0; i < companyCategoryResult.CategoryList.Length; i++)
                {
                    if (companyCategoryResult.CategoryList[i].Tag.Length == 4)
                    {
                        Location = ParseLocation(companyCategoryResult.CategoryList[i].Tag.Substring(0, 2));
                        ShowType = ParseShowType(companyCategoryResult.CategoryList[i].Tag.Substring(2, 2));
                        InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertCompanyCategory(companyCategoryResult.CategoryList[i].CompanyCategoryID, 0, companyCategoryResult.CategoryList[i].CategoryName, companyCategoryResult.CategoryList[i].SortIndex, 0,Location,ShowType);

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
                            GameBrand = companyGameCodeResult.GameCodeList[i].GameCode.Split('.')[0];
                            GameCategoryCode = companyGameCodeResult.GameCodeList[i].GameCategoryCode;
                            GameCategorySubCode = companyGameCodeResult.GameCodeList[i].GameCategorySubCode;
                            #region 熱門遊戲
                            if (companyGameCodeResult.GameCodeList[i].IsHot == 1)
                            {
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsHotCompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew);
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
                                InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsNewCompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew);
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
                                InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 3, GameBrand, 99, 0,Location,ShowType);
                                if (InsertCompanyCategoryReturn > 0)
                                {
                                    CompanyCategoryDT= RedisCache.CompanyCategory.GetCompanyCategory();
                                }

                            }

                            IsGameBrandCategoryID= (int)CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'")[0]["CompanyCategoryID"];
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsGameBrandCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew);
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

                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsCategoryCodeCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew);
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

                                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(CompanyCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "",companyGameCodeResult.GameCodeList[i].GameID,companyGameCodeResult.GameCodeList[i].GameCategoryCode,companyGameCodeResult.GameCodeList[i].GameCategorySubCode,companyGameCodeResult.GameCodeList[i].AllowDemoPlay,companyGameCodeResult.GameCodeList[i].RTPInfo,companyGameCodeResult.GameCodeList[i].IsHot,companyGameCodeResult.GameCodeList[i].IsNew);
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
                        RedisCache.CompanyGameCode.UpdateCompanyGameCode();
                        RedisCache.CompanyGameCode.UpdateAllCompanyGameCode(Newtonsoft.Json.JsonConvert.SerializeObject(companyGameCodeResult));
                    }
                    else
                    {
                        R.Message = "Get CompanyGameCodeResult Error";
                        //Console.WriteLine("Get CompanyGameCodeResult Error");
                    }
                }
                else {
                    R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID;
                    //Console.WriteLine("InsertCompanyGameCode Error CompanyCategoryID=" + CompanyCategoryID);
                }

            }
            else {
                R.Message = "Get CompanyCategoryResult Count=0";
                //Console.WriteLine("Get CompanyCategoryResult Count=0");
            }
            R.Result = EWin.Lobby.enumResult.OK;
        }
        else {
            R.Message = "Get CompanyCategoryResult Error";
            //Console.WriteLine("Get CompanyCategoryResult Error");
        }
        return R;
    }

    private string GetToken() {
        string Token;
        int RValue;
        Random R = new Random();
        RValue = R.Next(100000, 9999999);
        Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

        return Token;
    }
}