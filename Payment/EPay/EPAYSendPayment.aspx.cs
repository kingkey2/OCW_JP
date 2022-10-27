﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Payment_EPay_EPAYSendPayment : System.Web.UI.Page
{
    public static string SettingFile = "EPaySetting.json";

    private static dynamic LoadSetting()
    {
        dynamic o = null;
        string Filename;

        if (EWinWeb.IsTestSite)
        {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/EPay/Test_" + SettingFile);
        }
        else
        {
            Filename = HttpContext.Current.Server.MapPath("/App_Data/EPay/Formal_" + SettingFile);
        }

        if (System.IO.File.Exists(Filename))
        {
            string SettingContent;

            SettingContent = System.IO.File.ReadAllText(Filename);

            if (string.IsNullOrEmpty(SettingContent) == false)
            {
                try { o = Newtonsoft.Json.JsonConvert.DeserializeObject(SettingContent); } catch (Exception ex) { }
            }
        }

        return o;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        RedisCache.SessionContext.SIDInfo SI;
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        var amount = decimal.Parse(Request.Params["amount"]);
        var orderNumber = Request.Params["orderNumber"];
        var WebSID = Request.Params["webSID"];
        var UserName = Request.Params["UserName"];
        var Type = Request.Params["Type"];
        var ContactPhoneNumber = Request.Params["ContactPhoneNumber"];
        SI = RedisCache.SessionContext.GetSIDInfo(WebSID);
        if (SI != null && !string.IsNullOrEmpty(SI.EWinSID))
        {

            if (Type == "EPayJKC")
            {
                var userInfoResult = lobbyAPI.GetUserInfo(GetToken(), SI.EWinSID, System.Guid.NewGuid().ToString());
                if (userInfoResult.Result == EWin.Lobby.enumResult.OK)
                {
                    SendPayment(amount, orderNumber, UserName, Type, userInfoResult.ContactPhoneNumber);
                }
            }
            else
            {
                SendPayment(amount, orderNumber, UserName, Type, "");
            }
        }
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

    public void SendPayment(decimal amount, string orderNumber, string UserName, string Type, string ContactPhoneNumber)
    {
        dynamic EPAYSetting = LoadSetting();
        var CompanyCode = (string)EPAYSetting.CompanyCode;
        var CurrencyType = (string)EPAYSetting.CyrrencyType;
        var ServiceType = (string)EPAYSetting.ServiceType;
        var CompanyKey = (string)EPAYSetting.ApiKey;
        var OrderID = orderNumber;
        var OrderDate = DateTime.Now;
        var OrderAmount = amount;
        var ReturnURL = "";
        string Sign;
        decimal JPYRate = 0;
        var URL = (string)EPAYSetting.ApiUrl + "RequirePaying";
        System.Data.DataTable DT = new System.Data.DataTable();

        if (Type== "TigerPay")
        {
            ServiceType = "JOOB05";
        }

        if (Type == "GASH") {
            ServiceType = "JOOB04";
        }

        if (Type == "EPayJKC")
        {
            DT = RedisCache.PaymentMethod.GetPaymentMethodByCategory("EPAYJKC");
            var MultiCurrencyInfo = (string)DT.Select("PaymentCategoryCode='" + "EPAYJKC" + "'")[0]["MultiCurrencyInfo"];
            Newtonsoft.Json.Linq.JArray MultiCurrency = Newtonsoft.Json.Linq.JArray.Parse(MultiCurrencyInfo);
            for (int i = 0; i < MultiCurrency.Count; i++)
            {
                if ((string)MultiCurrency[i]["Currency"] == "JPY")
                {
                    JPYRate = (decimal)MultiCurrency[i]["Rate"];
                }
            }
            ReturnURL = EWinWeb.CasinoWorldUrl + "/Payment/EPay/JKCPaymentCallback.aspx";
        }
        else
        {
            ReturnURL = EWinWeb.CasinoWorldUrl + "/Payment/EPay/PaymentCallback.aspx";
        }

        System.Collections.Specialized.NameValueCollection data = new System.Collections.Specialized.NameValueCollection();
        data.Add("ManageCode", CompanyCode);
        data.Add("Currency", CurrencyType);
        data.Add("Service", ServiceType);
        data.Add("CustomerIP", CodingControl.GetUserIP());
        data.Add("OrderID", OrderID);
        data.Add("OrderDate", OrderDate.ToString("yyyy-MM-dd HH:mm:ss"));
        if (Type == "EPayJKC")
        {
            Sign = GetGPaySign(OrderID, OrderAmount * JPYRate, OrderDate, ServiceType, CurrencyType, CompanyCode, CompanyKey);
            data.Add("OrderAmount", (OrderAmount * JPYRate).ToString("#.##"));
        }
        else
        {
            Sign = GetGPaySign(OrderID, OrderAmount, OrderDate, ServiceType, CurrencyType, CompanyCode, CompanyKey);
            data.Add("OrderAmount", OrderAmount.ToString("#.##"));
        }

        data.Add("RevolveURL", ReturnURL);
        data.Add("UserName", UserName);
        data.Add("State", ContactPhoneNumber);
        data.Add("Sign", Sign);

        RedirectAndPOST(this.Page, URL, data);
    }

    public static void RedirectAndPOST(System.Web.UI.Page page, string destinationUrl,
                                    System.Collections.Specialized.NameValueCollection data)
    {
        //Prepare the Posting form
        string strForm = PreparePOSTForm(destinationUrl, data);
        //Add a literal control the specified page holding 
        //the Post Form, this is to submit the Posting form with the request.
        page.Controls.Add(new System.Web.UI.LiteralControl(strForm));
    }

    private static String PreparePOSTForm(string url, System.Collections.Specialized.NameValueCollection data)
    {
        //Set a name for the form
        string formID = "PostForm";
        //Build the form using the specified data to be posted.
        System.Text.StringBuilder strForm = new System.Text.StringBuilder();
        strForm.Append("<form id=\"" + formID + "\" name=\"" +
                        formID + "\" action=\"" + url +
                        "\" method=\"POST\">");

        foreach (string key in data)
        {
            strForm.Append("<input type=\"hidden\" name=\"" + key +
                            "\" value=\"" + data[key] + "\">");
        }

        strForm.Append("</form>");
        //Build the JavaScript which will do the Posting operation.
        System.Text.StringBuilder strScript = new System.Text.StringBuilder();
        strScript.Append("<script language='javascript'>");
        strScript.Append("var v" + formID + " = document." +
                            formID + ";");
        strScript.Append("v" + formID + ".submit();");
        strScript.Append("</script>");
        //Return the form and the script concatenated.
        //(The order is important, Form then JavaScript)
        return strForm.ToString() + strScript.ToString();
    }

    public static string GetSHA256(string DataString, bool Base64Encoding = true)
    {
        return GetSHA256(System.Text.Encoding.UTF8.GetBytes(DataString), Base64Encoding);
    }

    public static string GetSHA256(byte[] Data, bool Base64Encoding = true)
    {
        System.Security.Cryptography.SHA256 SHA256Provider = new System.Security.Cryptography.SHA256CryptoServiceProvider();
        byte[] hash;
        System.Text.StringBuilder RetValue = new System.Text.StringBuilder();

        hash = SHA256Provider.ComputeHash(Data);
        SHA256Provider = null;

        if (Base64Encoding)
        {
            RetValue.Append(System.Convert.ToBase64String(hash));
        }
        else
        {
            foreach (byte EachByte in hash)
            {
                // => .ToString("x2")
                string ByteStr = EachByte.ToString("x");

                ByteStr = new string('0', 2 - ByteStr.Length) + ByteStr;
                RetValue.Append(ByteStr);
            }
        }


        return RetValue.ToString();
    }

    public static string GetGPaySign(string OrderID, decimal OrderAmount, DateTime OrderDateTime, string ServiceType, string CurrencyType, string CompanyCode, string CompanyKey)
    {
        string sign;
        string signStr = "ManageCode=" + CompanyCode;
        signStr += "&Currency=" + CurrencyType;
        signStr += "&Service=" + ServiceType;
        signStr += "&OrderID=" + OrderID;
        signStr += "&OrderAmount=" + OrderAmount.ToString("#.##");
        signStr += "&OrderDate=" + OrderDateTime.ToString("yyyy-MM-dd HH:mm:ss");
        signStr += "&CompanyKey=" + CompanyKey;

        sign = GetSHA256(signStr, false).ToUpper();

        return sign;
    }

}