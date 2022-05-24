<%@ WebService Language="C#" Class="SynAPI" %>

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
public class SynAPI : System.Web.Services.WebService {



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult HeartBeat(string GUID, string Echo) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

        return lobbyAPI.HeartBeat(GUID, Echo);
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
        System.Data.DataRow DataRow;
        string GameBrand;
        #region 設定Ocw自定義分類
        OCWcompanyCategoryResult.CategoryList = new EWin.Lobby.CompanyCategory[] { new EWin.Lobby.CompanyCategory() {
        CategoryName = "熱門",CompanyCategoryID = 0,SortIndex = 0
        },new EWin.Lobby.CompanyCategory() {
        CategoryName = "最新",CompanyCategoryID = 0,SortIndex = 0
        } };

        for (int i = 0; i < OCWcompanyCategoryResult.CategoryList.Length; i++)
        {
            InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(OCWcompanyCategoryResult.CategoryList[i].CompanyCategoryID, 2, OCWcompanyCategoryResult.CategoryList[i].CategoryName, OCWcompanyCategoryResult.CategoryList[i].SortIndex, 0);
        }
        #endregion

        companyCategoryResult = lobbyAPI.GetCompanyCategory(GetToken(), Guid.NewGuid().ToString());
        if (companyCategoryResult.Result == EWin.Lobby.enumResult.OK)
        {
            if (companyCategoryResult.CategoryList.Length > 0)
            {
                for (int i = 0; i < companyCategoryResult.CategoryList.Length; i++)
                {
                    InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertCompanyCategory(companyCategoryResult.CategoryList[i].CompanyCategoryID, 0, companyCategoryResult.CategoryList[i].CategoryName, companyCategoryResult.CategoryList[i].SortIndex, 0);

                    if (InsertCompanyCategoryReturn <= 0)
                    {
                        R.Message = "InsertCompanyCategory Error EWinCompanyCategoryID=" + companyCategoryResult.CategoryList[i].CompanyCategoryID;
                    }
                }

                CompanyCategoryDT = RedisCache.CompanyCategory.GetCompanyCategory();

                if (CompanyCategoryDT != null && CompanyCategoryDT.Rows.Count > 0)
                {
                    IsHotCompanyCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "熱門" + "'")[0]["CompanyCategoryID"];
                    IsNewCompanyCategoryID = (int)CompanyCategoryDT.Select("CategoryName='" + "最新" + "'")[0]["CompanyCategoryID"];

                    companyGameCodeResult = lobbyAPI.GetCompanyGameCode(GetToken(), Guid.NewGuid().ToString());
                    if (companyGameCodeResult.Result == EWin.Lobby.enumResult.OK)
                    {
                        EWinWebDB.CompanyGameCode.DeleteCompanyGameCode();
                        for (int i = 0; i < companyGameCodeResult.GameCodeList.Length; i++)
                        {

                            GameBrand = companyGameCodeResult.GameCodeList[i].GameCode.Split('.')[0];
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
                            
                            if (CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'").Length == 0)
                            {
                                InsertCompanyCategoryReturn = EWinWebDB.CompanyCategory.InsertOcwCompanyCategory(0, 2, GameBrand, 0, 0);
                                if (InsertCompanyCategoryReturn > 0)
                                {
                                    CompanyCategoryDT= RedisCache.CompanyCategory.GetCompanyCategory();
                                }

                            }

                            IsGameBrandCategoryID= (int)CompanyCategoryDT.Select("CategoryName='" + GameBrand + "'")[0]["CompanyCategoryID"];
                            InsertCompanyGameCodeReturn = EWinWebDB.CompanyGameCode.InsertCompanyGameCode(IsGameBrandCategoryID, GameBrand, companyGameCodeResult.GameCodeList[i].GameName, "", companyGameCodeResult.GameCodeList[i].GameID, companyGameCodeResult.GameCodeList[i].GameCategoryCode, companyGameCodeResult.GameCodeList[i].GameCategorySubCode, companyGameCodeResult.GameCodeList[i].AllowDemoPlay, companyGameCodeResult.GameCodeList[i].RTPInfo, companyGameCodeResult.GameCodeList[i].IsHot, companyGameCodeResult.GameCodeList[i].IsNew);
                            if (InsertCompanyGameCodeReturn == 0)
                            {
                                R.Message = "InsertCompanyGameCode Error CompanyCategoryID=" + IsNewCompanyCategoryID;
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
                                        else {
                                            R.Message = "CompanyCategoryRow=" + 0;
                                            //Console.WriteLine("CompanyCategoryRow=" + 0);
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