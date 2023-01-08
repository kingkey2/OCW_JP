﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class GetAgentTotalDepositeSummary_Casino : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.AgentTotalSummaryResult GetAgentTotalOrderSummary(string AID, string LoginAccount, DateTime QueryBeginDate, DateTime QueryEndDate, string CurrencyType) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.AgentTotalSummaryResult RetValue = new EWin.OcwAgent.AgentTotalSummaryResult();

        RetValue = api.GetAgentTotalOrderDepositeSummary(AID, LoginAccount, QueryBeginDate, QueryEndDate, CurrencyType);

        return RetValue;
    }
}