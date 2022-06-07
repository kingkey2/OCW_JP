using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


/// <summary>
/// CryptoExpand 的摘要描述
/// </summary>
public static class ActivityExpand
{
    public static class Deposit
    {
        public static ActivityCore.ActResult<ActivityCore.DepositActivity> OpenBonusDeposit(string DetailPath, decimal Amount, string PaymentCode, string LoginAccount)
        {
            ActivityCore.ActResult<ActivityCore.DepositActivity> R = new ActivityCore.ActResult<ActivityCore.DepositActivity>() { Result = ActivityCore.enumActResult.ERR, Data = new ActivityCore.DepositActivity() };
            JObject ActivityDetail;
            System.Data.DataTable UserAccountTotalValueDT;
            int DepositCount = 0;

            ActivityDetail = GetActivityDetail(DetailPath);

            UserAccountTotalValueDT = RedisCache.UserAccountEventSummary.GetUserAccountEventSummaryByLoginAccountAndActivityName(LoginAccount, ActivityDetail["Name"].ToString());

            if (UserAccountTotalValueDT != null && UserAccountTotalValueDT.Rows.Count > 0)
            {
                DepositCount = (int)UserAccountTotalValueDT.Rows[0]["JoinCount"];
            }
            else
            {
                DepositCount = 0;
            }

            if (ActivityDetail != null)
            {
                DateTime StartDate = DateTime.Parse(ActivityDetail["StartDate"].ToString());
                DateTime EndDate = DateTime.Parse(ActivityDetail["EndDate"].ToString());
                bool IsPaymentCodeSupport = false;
                decimal BonusRate = 0;
                decimal ThresholdRate = 0;
                decimal ReceiveValueMaxLimit = 0;

                if ((int)ActivityDetail["State"] == 0)
                {
                    if (DateTime.Now >= StartDate && DateTime.Now < EndDate)
                    {
                        if (DepositCount == 0)
                        {
                            foreach (var item in ActivityDetail["Rate1"])
                            {
                                if (item["PaymentCode"].ToString().ToUpper() == PaymentCode.ToString().ToUpper())
                                {
                                    IsPaymentCodeSupport = true;
                                    BonusRate = (decimal)item["BonusRate"];
                                    ThresholdRate = (decimal)item["ThresholdRate"];
                                    ReceiveValueMaxLimit = (decimal)item["ReceiveValueMaxLimit"];

                                    break;
                                }
                            }

                            if (IsPaymentCodeSupport)
                            {
                                R.Result = ActivityCore.enumActResult.OK;
                                R.Data.Amount = Amount;
                                R.Data.PaymentCode = PaymentCode;
                                R.Data.BonusRate = BonusRate;
                                R.Data.BonusValue = Amount * BonusRate;

                                if (R.Data.BonusValue > ReceiveValueMaxLimit)
                                {
                                    R.Data.BonusValue = ReceiveValueMaxLimit;
                                }

                                R.Data.ThresholdRate = ThresholdRate;
                                R.Data.ThresholdValue = R.Data.BonusValue * ThresholdRate;
                                R.Data.Title = ActivityDetail["Title"].ToString();
                                R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
                                R.Data.JoinCount = 1;
                            }
                            else
                            {
                                SetResultException(R, "PaymentCodeNotSupport");
                            }
                        }
                        else if (DepositCount == 1)
                        {
                            foreach (var item in ActivityDetail["Rate2"])
                            {
                                if (item["PaymentCode"].ToString().ToUpper() == PaymentCode.ToString().ToUpper())
                                {
                                    IsPaymentCodeSupport = true;
                                    BonusRate = (decimal)item["BonusRate"];
                                    ThresholdRate = (decimal)item["ThresholdRate"];
                                    ReceiveValueMaxLimit = (decimal)item["ReceiveValueMaxLimit"];

                                    break;
                                }
                            }

                            if (IsPaymentCodeSupport)
                            {
                                R.Result = ActivityCore.enumActResult.OK;
                                R.Data.Amount = Amount;
                                R.Data.PaymentCode = PaymentCode;
                                R.Data.BonusRate = BonusRate;
                                R.Data.BonusValue = Amount * BonusRate;

                                if (R.Data.BonusValue > ReceiveValueMaxLimit)
                                {
                                    R.Data.BonusValue = ReceiveValueMaxLimit;
                                }

                                R.Data.ThresholdRate = ThresholdRate;
                                R.Data.ThresholdValue = R.Data.BonusValue * ThresholdRate;
                                R.Data.Title = ActivityDetail["Title"].ToString();
                                R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
                                R.Data.JoinCount = 2;
                            }
                            else
                            {
                                SetResultException(R, "PaymentCodeNotSupport");
                            }
                        }
                        else
                        {
                            foreach (var item in ActivityDetail["Rate3"])
                            {
                                if (item["PaymentCode"].ToString().ToUpper() == PaymentCode.ToString().ToUpper())
                                {
                                    IsPaymentCodeSupport = true;
                                    BonusRate = (decimal)item["BonusRate"];
                                    ThresholdRate = (decimal)item["ThresholdRate"];
                                    ReceiveValueMaxLimit = (decimal)item["ReceiveValueMaxLimit"];

                                    break;
                                }
                            }

                            if (IsPaymentCodeSupport)
                            {
                                R.Result = ActivityCore.enumActResult.OK;
                                R.Data.Amount = Amount;
                                R.Data.PaymentCode = PaymentCode;
                                R.Data.BonusRate = BonusRate;
                                R.Data.BonusValue = Amount * BonusRate;

                                if (R.Data.BonusValue > ReceiveValueMaxLimit)
                                {
                                    R.Data.BonusValue = ReceiveValueMaxLimit;
                                }

                                R.Data.ThresholdRate = ThresholdRate;
                                R.Data.ThresholdValue = R.Data.BonusValue * ThresholdRate;
                                R.Data.Title = ActivityDetail["Title"].ToString();
                                R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
                                R.Data.JoinCount = 3;
                            }
                            else
                            {
                                SetResultException(R, "PaymentCodeNotSupport");
                            }
                        }
                    }
                    else
                    {
                        SetResultException(R, "ActivityIsExpired");
                    }
                }
                else
                {
                    SetResultException(R, "ActivityIsExpired");
                }
            }
            else
            {
                SetResultException(R, "ActivityIsExpired");
            }

            return R;
        }

        public static ActivityCore.ActResult<ActivityCore.DepositActivity> OpenIntroBonus(string DetailPath, decimal Amount, string PaymentCode, string LoginAccount)
        {
            ActivityCore.ActResult<ActivityCore.DepositActivity> R = new ActivityCore.ActResult<ActivityCore.DepositActivity> { Result = ActivityCore.enumActResult.ERR, Data = new ActivityCore.DepositActivity() };
            JObject ActivityDetail;
            System.Data.DataTable UserAccountTotalValueDT;
            int DepositCount = 0;

            ActivityDetail = GetActivityDetail(DetailPath);

            UserAccountTotalValueDT = RedisCache.UserAccountEventSummary.GetUserAccountEventSummaryByLoginAccountAndActivityName(LoginAccount, ActivityDetail["Name"].ToString());

            if (UserAccountTotalValueDT != null && UserAccountTotalValueDT.Rows.Count > 0)
            {
                DepositCount = (int)UserAccountTotalValueDT.Rows[0]["JoinCount"];
            }
            else
            {
                DepositCount = 0;
            }

            if (ActivityDetail != null)
            {
                DateTime StartDate = DateTime.Parse(ActivityDetail["StartDate"].ToString());
                DateTime EndDate = DateTime.Parse(ActivityDetail["EndDate"].ToString());

                if ((int)ActivityDetail["State"] == 0)
                {
                    if (DateTime.Now >= StartDate && DateTime.Now < EndDate)
                    {
                        if (DepositCount == 0)
                        {
                            R.Data.Amount = Amount;
                            R.Data.PaymentCode = PaymentCode;
                            R.Data.BonusRate = 1;
                            R.Data.BonusValue = (decimal)ActivityDetail["Self"]["BonusValue"];
                            R.Data.ThresholdRate = 1;
                            R.Data.ThresholdValue = (decimal)ActivityDetail["Self"]["ThresholdValue"];
                            R.Data.Title = ActivityDetail["Title"].ToString();
                            R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
                            R.Data.JoinCount = 1;

                            R.Result = ActivityCore.enumActResult.OK;
                        }
                        else
                        {
                            SetResultException(R, "ActivityIsExpired");
                        }
                    }
                    else
                    {
                        SetResultException(R, "ActivityIsExpired");
                    }
                }
                else
                {
                    SetResultException(R, "ActivityIsExpired");
                }
            }
            else
            {
                SetResultException(R, "ActivityIsExpired");
            }

            return R;
        }
    }

    public static class DepositJoinCheck
    {
        //任何無法參加之原因皆要傳回
        public static ActivityCore.ActResult<ActivityCore.ActJoinCheck> OpenBonusDeposit(string DetailPath, decimal Amount, string PaymentCode, string LoginAccount)
        {
            ActivityCore.ActResult<ActivityCore.ActJoinCheck> R = new ActivityCore.ActResult<ActivityCore.ActJoinCheck>() { Data = new ActivityCore.ActJoinCheck() { IsCanJoin = false } };
            JObject ActivityDetail;
            System.Data.DataTable UserAccountTotalValueDT;
            int DepositCount = 0;

            ActivityDetail = GetActivityDetail(DetailPath);

            UserAccountTotalValueDT = RedisCache.UserAccountEventSummary.GetUserAccountEventSummaryByLoginAccountAndActivityName(LoginAccount, ActivityDetail["Name"].ToString());

            if (UserAccountTotalValueDT != null && UserAccountTotalValueDT.Rows.Count > 0)
            {
                DepositCount = (int)UserAccountTotalValueDT.Rows[0]["JoinCount"];
            }
            else
            {
                DepositCount = 0;
            }

            if (ActivityDetail != null)
            {
                DateTime StartDate = DateTime.Parse(ActivityDetail["StartDate"].ToString());
                DateTime EndDate = DateTime.Parse(ActivityDetail["EndDate"].ToString());
                bool IsPaymentCodeSupport = false;

                if ((int)ActivityDetail["State"] == 0)
                {
                    if (DateTime.Now >= StartDate && DateTime.Now < EndDate)
                    {
                        if (DepositCount == 0)
                        {
                            foreach (var item in ActivityDetail["Rate1"])
                            {
                                if (item["PaymentCode"].ToString().ToUpper() == PaymentCode.ToString().ToUpper())
                                {
                                    IsPaymentCodeSupport = true;

                                    break;
                                }
                            }
                        }
                        else if (DepositCount == 1)
                        {
                            foreach (var item in ActivityDetail["Rate2"])
                            {
                                if (item["PaymentCode"].ToString().ToUpper() == PaymentCode.ToString().ToUpper())
                                {
                                    IsPaymentCodeSupport = true;

                                    break;
                                }
                            }
                        }
                        else
                        {
                            foreach (var item in ActivityDetail["Rate3"])
                            {
                                if (item["PaymentCode"].ToString().ToUpper() == PaymentCode.ToString().ToUpper())
                                {
                                    IsPaymentCodeSupport = true;

                                    break;
                                }
                            }
                        }

                        if (IsPaymentCodeSupport)
                        {
                            R.Data.ActivityName = ActivityDetail["Name"].ToString();
                            R.Data.Title = ActivityDetail["Title"].ToString();
                            R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
                            R.Data.IsCanJoin = true;
                        }
                        else
                        {
                            R.Data.IsCanJoin = false;
                            R.Data.CanNotJoinDescription = "PaymentCodeNotSupport";
                        }
                    }
                    else
                    {
                        R.Data.IsCanJoin = false;
                        R.Data.CanNotJoinDescription = "ActivityIsExpired";
                    }
                }
                else
                {
                    R.Data.IsCanJoin = false;
                    R.Data.CanNotJoinDescription = "ActivityIsExpired";
                }
            }
            else
            {
                R.Data.IsCanJoin = false;
                R.Data.CanNotJoinDescription = "ActivityNotExist";
            }

            return R;
        }
    }

    public static class ParentBonusAfterDeposit
    {
        public static ActivityCore.ActResult<ActivityCore.IntroActivity> OpenIntroBonusToParent(string DetailPath, string LoginAccount)
        {
            ActivityCore.ActResult<ActivityCore.IntroActivity> R = new ActivityCore.ActResult<ActivityCore.IntroActivity>() { Result = ActivityCore.enumActResult.ERR };
            EWin.OCW.OCW ocwAPI = new EWin.OCW.OCW();
            var ocwResult = ocwAPI.GetParentUserAccountInfo(EWinWeb.GetToken(), LoginAccount);

            if (ocwResult.ResultState == EWin.OCW.enumResultState.OK)
            {
                JObject ActivityDetail;
                System.Data.DataTable UserAccountTotalValueDT;
                int DepositCount = 0;

                ActivityDetail = GetActivityDetail(DetailPath);

                UserAccountTotalValueDT = RedisCache.UserAccountEventSummary.GetUserAccountEventSummaryByLoginAccountAndActivityName(LoginAccount, ActivityDetail["Name"].ToString());

                if (UserAccountTotalValueDT != null && UserAccountTotalValueDT.Rows.Count > 0)
                {
                    DepositCount = (int)UserAccountTotalValueDT.Rows[0]["JoinCount"];
                }
                else
                {
                    DepositCount = 0;
                }


                if (ActivityDetail != null)
                {
                    DateTime StartDate = DateTime.Parse(ActivityDetail["StartDate"].ToString());
                    DateTime EndDate = DateTime.Parse(ActivityDetail["EndDate"].ToString());


                    if ((int)ActivityDetail["State"] == 0)
                    {
                        if (DepositCount == 0)
                        {
                            if (DateTime.Now >= StartDate && DateTime.Now < EndDate)
                            {
                                var RetData = new ActivityCore.IntroActivity()
                                {
                                    BonusValue = (decimal)ActivityDetail["Parent"]["BonusValue"],
                                    ThresholdValue = (decimal)ActivityDetail["Parent"]["ThresholdValue"],
                                    LoginAccount = LoginAccount,
                                    ParentLoginAccount = ocwResult.ParentLoginAccount,
                                    ActivityName = ActivityDetail["Name"].ToString()
                            };

                                R.Data = RetData;
                                R.Result = ActivityCore.enumActResult.OK;
                            }
                            else
                            {
                                SetResultException(R, "ActivityIsExpired");
                            }
                        }
                        else
                        {
                            SetResultException(R, "ActivityIsExpired");
                        }
                    }
                    else
                    {
                        SetResultException(R, "ActivityIsExpired");
                    }
                }
                else
                {
                    SetResultException(R, "ActivityIsExpired");
                }
            }
            else
            {
                SetResultException(R, ocwResult.Message);
            }

            return R;
        }
    }

    public static class Register
    {
        //任何無法參加之原因皆要傳回
        public static ActivityCore.ActResult<ActivityCore.Activity> RegisterBouns(string DetailPath, string LoginAccount)
        {
            ActivityCore.ActResult<ActivityCore.Activity> R = new ActivityCore.ActResult<ActivityCore.Activity>() { Result = ActivityCore.enumActResult.ERR, Data = new ActivityCore.Activity() };
            JObject ActivityDetail;
            System.Data.DataTable DT;
            string ActivityName = string.Empty;

            ActivityDetail = GetActivityDetail(DetailPath);

            if (ActivityDetail != null)
            {
                DateTime StartDate = DateTime.Parse(ActivityDetail["StartDate"].ToString());
                DateTime EndDate = DateTime.Parse(ActivityDetail["EndDate"].ToString());

                if ((int)ActivityDetail["State"] == 0)
                {
                    if (DateTime.Now >= StartDate && DateTime.Now < EndDate)
                    {
                        ActivityName = (string)ActivityDetail["Name"];

                        DT = EWinWebDB.UserAccountEventBonusHistory.GetBonusHistoryByLoginAccountActivityName(LoginAccount, ActivityName);

                        if (DT != null && DT.Rows.Count > 0)
                        {
                            SetResultException(R, "ActivityIsAlreadyJoin");
                        }
                        else
                        {
                            R.Data.ActivityName = ActivityDetail["Name"].ToString();
                            R.Data.Title = ActivityDetail["Title"].ToString();
                            R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
                            R.Data.BonusRate = 1;
                            R.Data.BonusValue = (decimal)ActivityDetail["Self"]["BonusValue"];
                            R.Data.ThresholdRate = 1;
                            R.Data.ThresholdValue = (decimal)ActivityDetail["Self"]["ThresholdValue"];
                            R.Result = ActivityCore.enumActResult.OK;
                        }

                    }
                    else
                    {
                        SetResultException(R, "ActivityIsExpired");
                    }
                }
                else
                {
                    SetResultException(R, "ActivityIsExpired");
                }
            }
            else
            {
                SetResultException(R, "ActivityNotExist");
            }

            return R;
        }
    }

    public static class Basic
    {
        //任何無法參加之原因皆要傳回
        public static ActivityCore.ActResult<ActivityCore.ActivityInfo> GetActInfo(string DetailPath)
        {
            ActivityCore.ActResult<ActivityCore.ActivityInfo> R = new ActivityCore.ActResult<ActivityCore.ActivityInfo>() { Data=new ActivityCore.ActivityInfo() };
            JObject ActivityDetail;



            ActivityDetail = GetActivityDetail(DetailPath);

            R.Data.ActivityName = ActivityDetail["Name"].ToString();
            R.Data.Title = ActivityDetail["Title"].ToString();
            R.Data.SubTitle = ActivityDetail["SubTitle"].ToString();
            return R;
        }
    }

    private static JObject GetActivityDetail(string Path)
    {
        JObject o = null;
        string Filename;

        Filename = HttpContext.Current.Server.MapPath(Path);

        if (System.IO.File.Exists(Filename))
        {
            string SettingContent;

            SettingContent = System.IO.File.ReadAllText(Filename);

            if (string.IsNullOrEmpty(SettingContent) == false)
            {
                try { o = JObject.Parse(SettingContent); } catch (Exception ex) { }
            }
        }

        return o;
    }

    private static void SetResultException<T>(ActivityCore.ActResult<T> R, string Msg)
    {
        if (R != null)
        {
            R.Result = ActivityCore.enumActResult.ERR;
            R.Message = Msg;
        }
    }
}