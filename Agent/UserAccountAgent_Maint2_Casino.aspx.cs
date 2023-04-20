using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class UserAccountAgent_Maint2_Casino : System.Web.UI.Page {

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.GroupAgentResult GetUserAccountSummary(string AID, int TargetUserAccountID, DateTime QueryBeginDate, DateTime QueryEndDate, string CurrencyType, int Page) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        return api.GetGroupAgent(AID, TargetUserAccountID, QueryBeginDate, QueryEndDate, CurrencyType, Page);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.GroupAgentResult GetUserAccountSummaryBySearch(string AID, string TargetLoginAccount, DateTime QueryBeginDate, DateTime QueryEndDate, string CurrencyType) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        return api.GetGroupBySearch(AID, TargetLoginAccount, QueryBeginDate, QueryEndDate, CurrencyType);
    }
}