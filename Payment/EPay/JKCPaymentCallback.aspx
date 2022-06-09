<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Common.cs" Inherits="Common" %>

<%
    string PostBody;
    string InIP;
    string DetailData;
    string Filename;
    string PhoneNumber;
    decimal BeforeAmount=0;
    decimal DelAmount;
    bool IsDeleteAmount = false;
    System.Collections.ArrayList iSyncRoot = new System.Collections.ArrayList();
    using (System.IO.StreamReader reader = new System.IO.StreamReader(Request.InputStream)) {
        PostBody = reader.ReadToEnd();
    };

    System.Data.DataTable PaymentOrderDT;
    APIResult R = new APIResult() { ResultState = APIResult.enumResultCode.ERR };

    if (!string.IsNullOrEmpty(PostBody)) {
        dynamic RequestData =Common.ParseData(PostBody);

        //InIP= CodingControl.GetUserIP();
        if (RequestData != null)
        {
            //if (Common.CheckInIP(InIP))
            //{
            if (Common.CheckSign(RequestData))
            {
                PaymentOrderDT = EWinWebDB.UserAccountPayment.GetPaymentByPaymentSerial((string)RequestData.OrderID);

                R.ResultState = APIResult.enumResultCode.ERR;
                R.Message = (string)RequestData.OrderID;
                PhoneNumber=(string)RequestData.State;
                if (PaymentOrderDT != null && PaymentOrderDT.Rows.Count > 0)
                {
                    if ((string)RequestData.PayingStatus == "0")
                    {
                        if ((int)PaymentOrderDT.Rows[0]["FlowStatus"] == 1)
                        {
                            DetailData = (string)PaymentOrderDT.Rows[0]["DetailData"];
                            if (!string.IsNullOrEmpty(DetailData))
                            {
                                var jsonDetailData = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(DetailData);
                                Newtonsoft.Json.Linq.JObject jo = jsonDetailData.Children<Newtonsoft.Json.Linq.JObject>().FirstOrDefault(o => o["TokenCurrencyType"] != null && o["TokenCurrencyType"].ToString() == "JKC");
                                DelAmount = ((decimal)PaymentOrderDT.Rows[0]["Amount"] * (decimal)jo["PartialRate"]);
                                EWin.Payment.PaymentAPI paymentAPI = new EWin.Payment.PaymentAPI();

                                if (EWinWeb.IsTestSite)
                                {
                                    Filename = HttpContext.Current.Server.MapPath("/App_Data/EPay/Test_" + "UserJKCData.json");
                                }
                                else
                                {
                                    Filename = HttpContext.Current.Server.MapPath("/App_Data/EPay/Formal_" + "UserJKCData.json");
                                }

                                Newtonsoft.Json.Linq.JArray jArray = null;

                                if (System.IO.File.Exists(Filename))
                                {
                                    string SettingContent;

                                    SettingContent = System.IO.File.ReadAllText(Filename);

                                    if (string.IsNullOrEmpty(SettingContent) == false)
                                    {
                                        try { jArray = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(SettingContent); } catch (Exception ex) { }
                                        if (jArray != null && jArray.Count > 0)
                                        {
                                            foreach (Newtonsoft.Json.Linq.JObject parsedObject in jArray.Children<Newtonsoft.Json.Linq.JObject>())
                                            {
                                                if ((string)parsedObject["Name"] == PhoneNumber)
                                                {
                                                    BeforeAmount = (decimal)parsedObject["Value"];
                                                    if (BeforeAmount != 0 && BeforeAmount >= DelAmount)
                                                    {
                                                        var finishResult = paymentAPI.FinishedPayment(EWinWeb.GetToken(), System.Guid.NewGuid().ToString(), (string)PaymentOrderDT.Rows[0]["PaymentSerial"]);

                                                        if (finishResult.ResultStatus == EWin.Payment.enumResultStatus.OK)
                                                        {
                                                            R.ResultState = APIResult.enumResultCode.OK;
                                                            parsedObject["Value"] = (BeforeAmount - DelAmount);
                                                            R.Message = "SUCCESS";

                                                            byte[] ContentArray = System.Text.Encoding.UTF8.GetBytes(jArray.ToString());
                                                            Exception throwEx = null;
                                                            for (var i = 0; i < 3; i++)
                                                            {
                                                                lock (iSyncRoot)
                                                                {
                                                                    try
                                                                    {
                                                                        System.IO.File.WriteAllText(Filename, jArray.ToString());
                                                                        throwEx = null;
                                                                        break;
                                                                    }
                                                                    catch (Exception ex)
                                                                    {
                                                                        throwEx = ex;
                                                                    }
                                                                }

                                                                System.Threading.Thread.Sleep(100);
                                                            }
                                                        }
                                                        else
                                                        {
                                                            R.ResultState = APIResult.enumResultCode.ERR;
                                                            R.Message = "Finished Fail";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        R.ResultState = APIResult.enumResultCode.ERR;
                                                        R.Message = "Amount Not Enough";
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        else
                                        {
                                            R.ResultState = APIResult.enumResultCode.ERR;
                                            R.Message = "UserJKCData File Not Exist";
                                        }
                                    }
                                    else
                                    {
                                        R.ResultState = APIResult.enumResultCode.ERR;
                                        R.Message = "UserJKCData File Not Exist";
                                    }
                                }
                                else
                                {
                                    R.ResultState = APIResult.enumResultCode.ERR;
                                    R.Message = "UserJKCData File Not Exist";
                                }


                            }
                            else
                            {
                                R.ResultState = APIResult.enumResultCode.ERR;
                                R.Message = "Get JKC Rate Fail";
                            }
                        }
                        else
                        {
                            R.ResultState = APIResult.enumResultCode.ERR;
                            R.Message = "FlowStatus Error";
                        }


                    }
                    else {
                        R.ResultState = APIResult.enumResultCode.ERR;
                        R.Message = "Status Fail";
                    }
                }
                else
                {
                    R.ResultState = APIResult.enumResultCode.ERR;
                    R.Message = "OtherOrderNumberNotFound";
                }
            }
            else
            {
                R.ResultState = APIResult.enumResultCode.ERR;
                R.Message = "Sign Fail";
            }
            //}
            //else
            //{
            //    R.ResultState = APIResult.enumResultCode.ERR;
            //    R.Message = "IP Fail:" + InIP;
            //}
        }
        else
        {
            R.ResultState = APIResult.enumResultCode.ERR;
            R.Message = "Parse Data Fail";
        }

    } else {
        R.ResultState = APIResult.enumResultCode.ERR;
        R.Message = "No Data";
    }

    Response.Write(R.Message);
    Response.Flush();
    Response.End();
%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="pragma" content="no-cache" />
    <title></title>
</head>
<script>
<%--    var Url = "<%:RedirectUrl%>";

    if (self == top) {
        window.location.href = Url;
    } else {
        window.top.API_LoadPage("PayPal", Url);
    }--%>

</script>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>

