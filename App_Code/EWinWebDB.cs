using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// EWin 的摘要描述
/// </summary>
public static class EWinWebDB {
    public static class CompanyCategory
    {
        public static int DeleteCompanyCategory(int CategoryType)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int CategoryCount = 0;

            SS = " DELETE FROM CompanyCategory " +
                 " WHERE  CategoryType=@CategoryType";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@CategoryType", System.Data.SqlDbType.Int).Value = CategoryType;
            CategoryCount = Convert.ToInt32(DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd));

            RedisCache.CompanyCategory.DeleteCompanyCategory();

            return CategoryCount;
        }

        public static int InsertCompanyCategory(int EwinCompanyCategoryID, int CategoryType, string CategoryName, int SortIndex, int State, string Location, int ShowType)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int CompanyCategoryID = 0;
            int CategoryCount = 0;

            //SS = " SELECT COUNT(*) FROM CompanyCategory " +
            //     " WHERE EwinCompanyCategoryID=@EwinCompanyCategoryID And CategoryType=0";
            //DBCmd = new System.Data.SqlClient.SqlCommand();
            //DBCmd.CommandText = SS;
            //DBCmd.CommandType = System.Data.CommandType.Text;
            //DBCmd.Parameters.Add("@EwinCompanyCategoryID", System.Data.SqlDbType.Int).Value = EwinCompanyCategoryID;
            //DBCmd.Parameters.Add("@CategoryType", System.Data.SqlDbType.Int).Value = CategoryType;
            //DBCmd.Parameters.Add("@CategoryName", System.Data.SqlDbType.NVarChar).Value = CategoryName;
            //DBCmd.Parameters.Add("@SortIndex", System.Data.SqlDbType.Int).Value = SortIndex;
            //DBCmd.Parameters.Add("@State", System.Data.SqlDbType.Int).Value = State;
            //CategoryCount = Convert.ToInt32(DBAccess.GetDBValue(EWinWeb.DBConnStr, DBCmd));


            //if (CategoryCount == 0)
            //{
                SS = "INSERT INTO CompanyCategory (EwinCompanyCategoryID, CategoryType, CategoryName,SortIndex,State,Location,ShowType) " +
               "                VALUES (@EwinCompanyCategoryID, @CategoryType, @CategoryName,@SortIndex,@State,@Location,@ShowType) " +
               " SELECT @@IDENTITY";
                DBCmd = new System.Data.SqlClient.SqlCommand();
                DBCmd.CommandText = SS;
                DBCmd.CommandType = System.Data.CommandType.Text;
                DBCmd.Parameters.Add("@EwinCompanyCategoryID", System.Data.SqlDbType.Int).Value = EwinCompanyCategoryID;
                DBCmd.Parameters.Add("@CategoryType", System.Data.SqlDbType.Int).Value = CategoryType;
                DBCmd.Parameters.Add("@CategoryName", System.Data.SqlDbType.NVarChar).Value = CategoryName;
                DBCmd.Parameters.Add("@SortIndex", System.Data.SqlDbType.Int).Value = SortIndex;
                DBCmd.Parameters.Add("@State", System.Data.SqlDbType.Int).Value = State;
                DBCmd.Parameters.Add("@Location", System.Data.SqlDbType.VarChar).Value = Location;
                DBCmd.Parameters.Add("@ShowType", System.Data.SqlDbType.Int).Value = ShowType;
                CompanyCategoryID = Convert.ToInt32(DBAccess.GetDBValue(EWinWeb.DBConnStr, DBCmd));
            //}
            //else
            //{
            //    SS = "UPDATE CompanyCategory SET CategoryType=@CategoryType,CategoryName=@CategoryName,SortIndex=@SortIndex,Location=@Location,ShowType=@ShowType " +
            //   "  WHERE EwinCompanyCategoryID=@EwinCompanyCategoryID";
            //    DBCmd = new System.Data.SqlClient.SqlCommand();
            //    DBCmd.CommandText = SS;
            //    DBCmd.CommandType = System.Data.CommandType.Text;
            //    DBCmd.Parameters.Add("@EwinCompanyCategoryID", System.Data.SqlDbType.Int).Value = EwinCompanyCategoryID;
            //    DBCmd.Parameters.Add("@CategoryType", System.Data.SqlDbType.Int).Value = CategoryType;
            //    DBCmd.Parameters.Add("@CategoryName", System.Data.SqlDbType.NVarChar).Value = CategoryName;
            //    DBCmd.Parameters.Add("@SortIndex", System.Data.SqlDbType.Int).Value = SortIndex;
            //    DBCmd.Parameters.Add("@Location", System.Data.SqlDbType.VarChar).Value = Location;
            //    DBCmd.Parameters.Add("@ShowType", System.Data.SqlDbType.Int).Value = ShowType;
            //    CompanyCategoryID = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
            //}
            RedisCache.CompanyCategory.UpdateCompanyCategory();

            return CompanyCategoryID;
        }

        public static int InsertOcwCompanyCategory(int EwinCompanyCategoryID, int CategoryType, string CategoryName, int SortIndex, int State, string Location, int ShowType)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int CompanyCategoryID = 0;
      
            SS = "INSERT INTO CompanyCategory (EwinCompanyCategoryID, CategoryType, CategoryName,SortIndex,State,Location,ShowType) " +
            "                VALUES (@EwinCompanyCategoryID, @CategoryType, @CategoryName,@SortIndex,@State,@Location,@ShowType) " +
            " SELECT @@IDENTITY";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@EwinCompanyCategoryID", System.Data.SqlDbType.Int).Value = EwinCompanyCategoryID;
            DBCmd.Parameters.Add("@CategoryType", System.Data.SqlDbType.Int).Value = CategoryType;
            DBCmd.Parameters.Add("@CategoryName", System.Data.SqlDbType.NVarChar).Value = CategoryName;
            DBCmd.Parameters.Add("@SortIndex", System.Data.SqlDbType.Int).Value = SortIndex;
            DBCmd.Parameters.Add("@State", System.Data.SqlDbType.Int).Value = State;
            DBCmd.Parameters.Add("@Location", System.Data.SqlDbType.VarChar).Value = Location;
            DBCmd.Parameters.Add("@ShowType", System.Data.SqlDbType.Int).Value = ShowType;
            CompanyCategoryID = Convert.ToInt32(DBAccess.GetDBValue(EWinWeb.DBConnStr, DBCmd));
     
            RedisCache.CompanyCategory.UpdateCompanyCategory();

            return CompanyCategoryID;
        }


        public static System.Data.DataTable GetCompanyCategory()
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT * FROM CompanyCategory ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }
    }

    public static class CompanyGameCode
    {
        public static int InsertCompanyGameCode(int forCompanyCategoryID, string GameBrand, string GameName, string Info,int GameID,string GameCategoryCode,string GameCategorySubCode,int AllowDemoPlay,string RTPInfo,int IsHot,int IsNew,string Tag,int SortIndex)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int insertCount = 0;

            SS = "INSERT INTO CompanyGameCode (forCompanyCategoryID,GameBrand, GameName, Info,GameID,GameCategoryCode,GameCategorySubCode,AllowDemoPlay,RTPInfo,IsHot,IsNew,Tag,SortIndex) " +
            "                VALUES (@forCompanyCategoryID,@GameBrand, @GameName, @Info,@GameID,@GameCategoryCode,@GameCategorySubCode,@AllowDemoPlay,@RTPInfo,@IsHot,@IsNew,@Tag,@SortIndex) ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@forCompanyCategoryID", System.Data.SqlDbType.Int).Value = forCompanyCategoryID;
            DBCmd.Parameters.Add("@GameBrand", System.Data.SqlDbType.VarChar).Value = GameBrand;
            DBCmd.Parameters.Add("@GameName", System.Data.SqlDbType.VarChar).Value = GameName;
            DBCmd.Parameters.Add("@Info", System.Data.SqlDbType.NVarChar).Value = Info;
            DBCmd.Parameters.Add("@GameID", System.Data.SqlDbType.Int).Value = GameID;
            DBCmd.Parameters.Add("@GameCategoryCode", System.Data.SqlDbType.VarChar).Value = GameCategoryCode;
            DBCmd.Parameters.Add("@GameCategorySubCode", System.Data.SqlDbType.VarChar).Value = GameCategorySubCode;
            DBCmd.Parameters.Add("@AllowDemoPlay", System.Data.SqlDbType.Int).Value = AllowDemoPlay;
            DBCmd.Parameters.Add("@RTPInfo", System.Data.SqlDbType.VarChar).Value = RTPInfo;
            DBCmd.Parameters.Add("@IsHot", System.Data.SqlDbType.Int).Value = IsHot;
            DBCmd.Parameters.Add("@IsNew", System.Data.SqlDbType.Int).Value = IsNew;
            DBCmd.Parameters.Add("@SortIndex", System.Data.SqlDbType.Int).Value = SortIndex;
            DBCmd.Parameters.Add("@Tag", System.Data.SqlDbType.NVarChar).Value = Tag;
            insertCount = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);


            return insertCount;
        }

        public static int DeleteCompanyGameCode()
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int DeleteCount = 0;
            System.Data.DataTable DT = null;

            SS = "SELECT * FROM CompanyCategory WITH (NOLOCK)";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);
            if (DT.Rows.Count > 0)
            {
                for (int i = 0; i < DT.Rows.Count; i++)
                { 
                    RedisCache.CompanyGameCode.DeleteCompanyGameCode((int)DT.Rows[i]["CompanyCategoryID"]);
                }
            }

            SS = " DELETE FROM CompanyGameCode ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DeleteCount = Convert.ToInt32(DBAccess.GetDBValue(EWinWeb.DBConnStr, DBCmd));

            

            return DeleteCount;
        }
    }

    public static class JKCDeposit
    {
        public static int UpdateJKCDepositByContactPhoneNumber(string ContactPhoneNumber, decimal Amount)
        {
            //Type: 0=Collect/1=Join
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int ReturnValue = -1;
            SS = "spUpdateJKCDepositByContactPhoneNumber";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.StoredProcedure;
            DBCmd.Parameters.Add("@ContactPhoneNumber", System.Data.SqlDbType.VarChar).Value = ContactPhoneNumber;
            DBCmd.Parameters.Add("@JKCCoin", System.Data.SqlDbType.Decimal).Value = Amount;
      
            DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
            ReturnValue = Convert.ToInt32(DBCmd.Parameters["@RETURN"].Value);

            if (ReturnValue == 0)
            {
                RedisCache.JKCDeposit.UpdateJKCDepositByContactPhoneNumber(ContactPhoneNumber);
            }

            return ReturnValue;
        }

        public static int InsertJKCDepositByContactPhoneNumber(string ContactPhoneNumber, decimal Amount)
        {
            //Type: 0=Collect/1=Join
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int ReturnValue = -1;
            SS = " INSERT INTO JKCDeposit (ContactPhoneNumber, JKCCoin, DepositCount, DepositTotalAmount) " +
                 " VALUES (@ContactPhoneNumber, @JKCCoin, 0, 0)";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@ContactPhoneNumber", System.Data.SqlDbType.VarChar).Value = ContactPhoneNumber;
            DBCmd.Parameters.Add("@JKCCoin", System.Data.SqlDbType.Decimal).Value = Amount;
            try
            {
                ReturnValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
            }
            catch (Exception)
            {

           
            }
        
            if (ReturnValue == 1)
            {
                RedisCache.JKCDeposit.UpdateJKCDepositByContactPhoneNumber(ContactPhoneNumber);
            }

            return ReturnValue;
        }

    }

    public static class UserAccountEventSummary
    {
        public static int UpdateUserAccountEventSummary(string LoginAccount, string ActivityName, int Type, decimal ThresholdValue, decimal BonusValue)
        {
            //Type: 0=Collect/1=Join
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int ReturnValue = -1;
            SS = "spUpdateUserAccountEventSummary";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.StoredProcedure;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@ActivityName", System.Data.SqlDbType.VarChar).Value = ActivityName;
            DBCmd.Parameters.Add("@Type", System.Data.SqlDbType.Int).Value = Type;
            DBCmd.Parameters.Add("@ThresholdValue", System.Data.SqlDbType.Decimal).Value = ThresholdValue;
            DBCmd.Parameters.Add("@BonusValue", System.Data.SqlDbType.Decimal).Value = BonusValue;
            DBCmd.Parameters.Add("@RETURN", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.ReturnValue;
            DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
            ReturnValue = Convert.ToInt32(DBCmd.Parameters["@RETURN"].Value);

            if (ReturnValue==0)
            {
                RedisCache.UserAccountEventSummary.UpdateUserAccountEventSummaryByLoginAccount(LoginAccount);
                RedisCache.UserAccountEventSummary.UpdateUserAccountEventSummaryByLoginAccountAndActivityName(LoginAccount, ActivityName);
            }
            
            return ReturnValue;
        }

    }

    public static class UserAccountPayment
    {
        public enum FlowStatus
        {
            Create = 0,
            InProgress = 1,
            Success = 2,
            Cancel = 3,
            Reject = 4,
            Accept = 5
        }

        public static int InsertPayment(string OrderNumber, int PaymentType, int BasicType, string LoginAccount, decimal Amount, decimal HandingFeeRate, int HandingFeeAmount, decimal ThresholdRate, decimal ThresholdValue, int forPaymentMethodID, string FromInfo, string ToInfo, string DetailData, int ExpireSecond)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;

            SS = "INSERT INTO UserAccountPayment (OrderNumber, PaymentType, BasicType, LoginAccount, Amount, HandingFeeRate, HandingFeeAmount, ThresholdRate, ThresholdValue, forPaymentMethodID, FromInfo, ToInfo, DetailData, ExpireSecond) " +
                 "                VALUES (@OrderNumber, @PaymentType, @BasicType, @LoginAccount, @Amount, @HandingFeeRate, @HandingFeeAmount, @ThresholdRate, @ThresholdValue, @forPaymentMethodID, @FromInfo, @ToInfo, @DetailData, @ExpireSecond)";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@PaymentType", System.Data.SqlDbType.Int).Value = PaymentType;
            DBCmd.Parameters.Add("@BasicType", System.Data.SqlDbType.Int).Value = BasicType;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@FlowStatus", System.Data.SqlDbType.Int).Value = 0;
            DBCmd.Parameters.Add("@Amount", System.Data.SqlDbType.Decimal).Value = Amount;
            DBCmd.Parameters.Add("@HandingFeeRate", System.Data.SqlDbType.Decimal).Value = HandingFeeRate;
            DBCmd.Parameters.Add("@HandingFeeAmount", System.Data.SqlDbType.Decimal).Value = HandingFeeAmount;
            DBCmd.Parameters.Add("@ThresholdRate", System.Data.SqlDbType.Decimal).Value = ThresholdRate;
            DBCmd.Parameters.Add("@ThresholdValue", System.Data.SqlDbType.Decimal).Value = ThresholdValue;
            DBCmd.Parameters.Add("@forPaymentMethodID", System.Data.SqlDbType.Int).Value = forPaymentMethodID;
            DBCmd.Parameters.Add("@FromInfo", System.Data.SqlDbType.NVarChar).Value = FromInfo;
            DBCmd.Parameters.Add("@ToInfo", System.Data.SqlDbType.NVarChar).Value = ToInfo;
            DBCmd.Parameters.Add("@DetailData", System.Data.SqlDbType.NVarChar).Value = DetailData;
            DBCmd.Parameters.Add("@ExpireSecond", System.Data.SqlDbType.Int).Value = ExpireSecond;

            return DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
        }

        public static System.Data.DataTable GetPaymentByOtherOrderNumber(string OtherOrderNumber)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = "SELECT P.*, PC.CategoryName, PM.PaymentCode, PaymentName , PM.PaymentMethodID, PM.EWinCryptoWalletType " +
               "FROM UserAccountPayment AS P WITH (NOLOCK) " +
               "LEFT JOIN PaymentMethod AS PM WITH (NOLOCK) ON P.forPaymentMethodID = PM.PaymentMethodID " +
               "LEFT JOIN PaymentCategory AS PC WITH (NOLOCK) ON PM.PaymentCategoryCode = PC.PaymentCategoryCode " +
               "WHERE P.OtherOrderNumber=@OtherOrderNumber";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OtherOrderNumber", System.Data.SqlDbType.VarChar).Value = OtherOrderNumber;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static System.Data.DataTable UpdateOtherOrderNumberByOrderNumber(string OrderNumber, string OtherOrderNumber)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " UPDATE UserAccountPayment WITH (ROWLOCK) SET OtherOrderNumber=@OtherOrderNumber " +
                      " WHERE OrderNumber=@OrderNumber";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@OtherOrderNumber", System.Data.SqlDbType.VarChar).Value = OtherOrderNumber;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static System.Data.DataTable GetPaymentByPaymentSerial(string PaymentSerial)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = "SELECT P.*, PC.CategoryName, PM.PaymentCode, PaymentName  , PM.PaymentMethodID, PM.EWinCryptoWalletType " +
                 "FROM UserAccountPayment AS P WITH (NOLOCK) " +
                 "LEFT JOIN PaymentMethod AS PM WITH (NOLOCK) ON P.forPaymentMethodID = PM.PaymentMethodID " +
                 "LEFT JOIN PaymentCategory AS PC WITH (NOLOCK) ON PM.PaymentCategoryCode = PC.PaymentCategoryCode " +
                 "WHERE P.PaymentSerial=@PaymentSerial";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@PaymentSerial", System.Data.SqlDbType.VarChar).Value = PaymentSerial;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static System.Data.DataTable GetPaymentByOrderNumber(string OrderNumber)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = "SELECT P.*, PC.CategoryName, PM.PaymentCode, PaymentName, PM.PaymentMethodID, PM.EWinCryptoWalletType " +
               "FROM UserAccountPayment AS P WITH (NOLOCK) " +
               "LEFT JOIN PaymentMethod AS PM WITH (NOLOCK) ON P.forPaymentMethodID = PM.PaymentMethodID " +
               "LEFT JOIN PaymentCategory AS PC WITH (NOLOCK) ON PM.PaymentCategoryCode = PC.PaymentCategoryCode " +
               "WHERE P.OrderNumber=@OrderNumber";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }


        public static System.Data.DataTable GetPaymentByNonFinishedByLoginAccount(string LoginAccount)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = "SELECT P.*, PC.CategoryName, PM.PaymentCode, PaymentName, PM.PaymentMethodID, PM.EWinCryptoWalletType " +
               "FROM UserAccountPayment AS P WITH (NOLOCK) " +
               "LEFT JOIN PaymentMethod AS PM WITH (NOLOCK) ON P.forPaymentMethodID = PM.PaymentMethodID " +
               "LEFT JOIN PaymentCategory AS PC WITH (NOLOCK) ON PM.PaymentCategoryCode = PC.PaymentCategoryCode " +
               "WHERE P.LoginAccount=@LoginAccount AND P.FlowStatus =1 AND DATEADD(ss,PM.ExpireSecond,CreateDate) > GETDATE() ";

            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static int ConfirmPayment(string OrderNumber, string ToInfo)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;

            SS = "UPDATE UserAccountPayment WITH (ROWLOCK) SET FlowStatus=@FlowStatus, ToInfo=@ToInfo " +
                 "         WHERE  OrderNumber=@OrderNumber AND FlowStatus=0  ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@FlowStatus", System.Data.SqlDbType.Int).Value = 1;
            DBCmd.Parameters.Add("@ToInfo", System.Data.SqlDbType.NVarChar).Value = ToInfo;

            return DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
        }

        public static int ConfirmPayment(string OrderNumber, string ToInfo, string PaymentSerial, decimal PointValue, string ActivityData)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;

            SS = "UPDATE UserAccountPayment WITH (ROWLOCK) SET FlowStatus=@FlowStatus, ToInfo=@ToInfo, PaymentSerial=@PaymentSerial, PointValue=@PointValue, ActivityData=@ActivityData " +
                 "         WHERE  OrderNumber=@OrderNumber AND FlowStatus=0  ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@FlowStatus", System.Data.SqlDbType.Int).Value = 1;
            DBCmd.Parameters.Add("@PointValue", System.Data.SqlDbType.Decimal).Value = PointValue;
            DBCmd.Parameters.Add("@ToInfo", System.Data.SqlDbType.NVarChar).Value = ToInfo;
            DBCmd.Parameters.Add("@PaymentSerial", System.Data.SqlDbType.VarChar).Value = PaymentSerial;

            if (string.IsNullOrEmpty(ActivityData)) {
                DBCmd.Parameters.Add("@ActivityData", System.Data.SqlDbType.VarChar).Value = "";
            } else {
                DBCmd.Parameters.Add("@ActivityData", System.Data.SqlDbType.VarChar).Value = ActivityData;
            }
           

            return DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
        }

        public static int ConfirmPayment(string OrderNumber, string ToInfo, string PaymentSerial, string OtherOrderNumber, decimal PointValue, string ActivityData)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;

            SS = "UPDATE UserAccountPayment WITH (ROWLOCK) SET FlowStatus=@FlowStatus, ToInfo=@ToInfo, PaymentSerial=@PaymentSerial, OtherOrderNumber=@OtherOrderNumber, PointValue=@PointValue, ActivityData=@ActivityData " +
                 "         WHERE  OrderNumber=@OrderNumber AND FlowStatus=0  ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@FlowStatus", System.Data.SqlDbType.Int).Value = 1;
            DBCmd.Parameters.Add("@PointValue", System.Data.SqlDbType.Decimal).Value = PointValue;
            DBCmd.Parameters.Add("@ToInfo", System.Data.SqlDbType.NVarChar).Value = ToInfo;
            DBCmd.Parameters.Add("@PaymentSerial", System.Data.SqlDbType.VarChar).Value = PaymentSerial;
            DBCmd.Parameters.Add("@OtherOrderNumber", System.Data.SqlDbType.VarChar).Value = OtherOrderNumber;
            DBCmd.Parameters.Add("@ActivityData", System.Data.SqlDbType.VarChar).Value = ActivityData;

            return DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);
        }

        public static int FinishPaymentFlowStatus(string OrderNumber, FlowStatus FlowStatus, string PaymentSerial)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;

            SS = "spSetPaymentFlowStatus";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.StoredProcedure;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@FlowStatus", System.Data.SqlDbType.Int).Value = FlowStatus;
            DBCmd.Parameters.Add("@PaymentSerial", System.Data.SqlDbType.VarChar).Value = PaymentSerial;
            DBCmd.Parameters.Add("@RETURN", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.ReturnValue;
            DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return Convert.ToInt32(DBCmd.Parameters["@RETURN"].Value);
        }

        public static int ResumePaymentFlowStatus(string OrderNumber, string PaymentSerial)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;

            SS = "spSetPaymentFlowStatusByResume";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.StoredProcedure;
            DBCmd.Parameters.Add("@OrderNumber", System.Data.SqlDbType.VarChar).Value = OrderNumber;
            DBCmd.Parameters.Add("@FlowStatus", System.Data.SqlDbType.Int).Value = 1;
            DBCmd.Parameters.Add("@PaymentSerial", System.Data.SqlDbType.VarChar).Value = PaymentSerial;
            DBCmd.Parameters.Add("@RETURN", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.ReturnValue;
            DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return Convert.ToInt32(DBCmd.Parameters["@RETURN"].Value);
        }

        /// <summary>
        /// 取得當天進行中與完成的訂單
        /// </summary>
        /// <param name="LoginAccount"></param>
        /// <param name="PaymentType"></param>
        /// <returns></returns>
        public static System.Data.DataTable GetTodayPaymentByLoginAccount(string LoginAccount, int PaymentType) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT * " +
                      " FROM   UserAccountPayment " +
                      " WHERE  LoginAccount = @LoginAccount " +
                      "        AND CreateDate >= dbo.Getreportdate(Getdate()) " +
                      "        AND CreateDate < dbo.Getreportdate(Dateadd (day, 1, Getdate())) " +
                      "        AND FlowStatus IN ( 1, 2 ) " +
                      "        AND PaymentType = @PaymentType ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@PaymentType", System.Data.SqlDbType.Int).Value = PaymentType;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static System.Data.DataTable GetInProgressPaymentByLoginAccount(string LoginAccount, int PaymentType) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT *, convert(varchar,CreateDate,120) CreateDate1  " +
                      " FROM   UserAccountPayment " +
                      " WHERE  LoginAccount = @LoginAccount " +
                      "        AND FlowStatus = 1 " +
                      "        AND PaymentType = @PaymentType ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@PaymentType", System.Data.SqlDbType.Int).Value = PaymentType;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static System.Data.DataTable GetInProgressPaymentByLoginAccountPaymentMethodID(string LoginAccount, int PaymentType, int PaymentMethodID) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT *, convert(varchar,CreateDate,126) CreateDate1  " +
                      " FROM   UserAccountPayment " +
                      " WHERE  LoginAccount = @LoginAccount " +
                      "        AND FlowStatus = 1 " +
                      "        AND PaymentType = @PaymentType " +
                      "        AND forPaymentMethodID = @PaymentMethodID ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@PaymentType", System.Data.SqlDbType.Int).Value = PaymentType;
            DBCmd.Parameters.Add("@PaymentMethodID", System.Data.SqlDbType.Int).Value = PaymentMethodID;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }
    }

    public static class UserAccountTotalSummary{
        public static int UpdateFingerPrint(string FingerPrints, string LoginAccount)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int RetValue = 0;

            SS = " UPDATE UserAccountTotalSummary WITH (ROWLOCK) SET FingerPrints=@FingerPrints " +
                      " WHERE LoginAccount=@LoginAccount";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@FingerPrints", System.Data.SqlDbType.VarChar).Value = FingerPrints;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return RetValue;
        }

        public static int InsertUserAccountTotalSummary(string FingerPrints, string LoginAccount)
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int RetValue = 0;

            SS = " INSERT INTO UserAccountTotalSummary (LoginAccount, FingerPrints) " +
                      " VALUES (@LoginAccount, @FingerPrints) ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@FingerPrints", System.Data.SqlDbType.VarChar).Value = FingerPrints;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return RetValue;
        }

    }

    public static class BulletinBoard
    {
        public static System.Data.DataTable GetBulletinBoard()
        {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = "SELECT * " +
               "FROM BulletinBoard AS BB WITH (NOLOCK) " +
               "WHERE BB.State=0";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);
     
            return DT;
        }
    }

    public static class PaymentMethod {

        public static System.Data.DataTable GetPaymentMethod() {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = "SELECT * " +
                      "FROM PaymentMethod ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }
    }

    public static class UserAccountEventBonusHistory {

        public enum EventType {
            Deposit = 0,
            Login = 1,
            Register = 2 
        }

        public static int InsertEventBonusHistory( string LoginAccount, string ActivityName, string RelationID, decimal BonusRate, decimal BonusValue, decimal ThresholdRate, decimal ThresholdValue, EventType EventType) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int EventBonusHistoryID = 0;

            SS = "INSERT INTO UserAccountEventBonusHistory (LoginAccount, BonusRate, BonusValue, ThresholdRate, ThresholdValue, ActivityName, RelationID, EventType) " +
                 "                VALUES (@LoginAccount, @BonusRate, @BonusValue, @ThresholdRate, @ThresholdValue, @ActivityName, @RelationID, @EventType)" +
                " SELECT @@IDENTITY";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@BonusRate", System.Data.SqlDbType.Decimal).Value = BonusRate;
            DBCmd.Parameters.Add("@BonusValue", System.Data.SqlDbType.Decimal).Value = BonusValue;
            DBCmd.Parameters.Add("@ThresholdRate", System.Data.SqlDbType.Decimal).Value = ThresholdRate;
            DBCmd.Parameters.Add("@ThresholdValue", System.Data.SqlDbType.Decimal).Value = ThresholdValue;
            DBCmd.Parameters.Add("@ActivityName", System.Data.SqlDbType.VarChar).Value = ActivityName;
            DBCmd.Parameters.Add("@RelationID", System.Data.SqlDbType.VarChar).Value = RelationID;
            DBCmd.Parameters.Add("@EventType", System.Data.SqlDbType.Int).Value = EventType;

            EventBonusHistoryID = Convert.ToInt32(DBAccess.GetDBValue(EWinWeb.DBConnStr, DBCmd));
            return EventBonusHistoryID;
        }

        public static System.Data.DataTable GetBonusHistoryByLoginAccountActivityName(string LoginAccount, string ActivityName) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT * " +
                      " FROM   UserAccountEventBonusHistory " +
                      " WHERE  LoginAccount = @LoginAccount " +
                      "     AND ActivityName = @ActivityName ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@ActivityName", System.Data.SqlDbType.VarChar).Value = ActivityName;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

    }

    public static class UserAccountFingerprint {
        public static System.Data.DataTable GetUserAccountFingerprintByLoginAccount(string LoginAccount) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT * " +
                      " FROM   UserAccountFingerprint " +
                      " WHERE  LoginAccount = @LoginAccount ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static System.Data.DataTable GetUserAccountFingerprintByLoginAccountFingerprintID(string LoginAccount,string FingerprintID) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT * " +
                      " FROM   UserAccountFingerprint " +
                      " WHERE  LoginAccount = @LoginAccount " +
                      "     AND FingerprintID = @FingerprintID ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@FingerprintID", System.Data.SqlDbType.VarChar).Value = FingerprintID;
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }

        public static int InsertUserAccountFingerprint(string LoginAccount, string FingerprintID, string UserAgent) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int RetValue = 0;

            SS = " INSERT INTO UserAccountFingerprint (LoginAccount, FingerprintID, UserAgent) " +
                      " VALUES (@LoginAccount, @FingerprintID, @UserAgent) ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@FingerprintID", System.Data.SqlDbType.VarChar).Value = FingerprintID;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@UserAgent", System.Data.SqlDbType.VarChar).Value = UserAgent;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return RetValue;
        }

    }

    public static class NotifyMsg {
        public static int InsertNotifyMsg(string Title, string NotifyContent, string URL) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int NotifyMsgID = 0;

            SS = "INSERT INTO NotifyMsg (Title, NotifyContent, URL) " +
                      "                VALUES (@Title, @NotifyContent, @URL) " +
                      " SELECT @@IDENTITY";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@Title", System.Data.SqlDbType.NVarChar).Value = Title;
            DBCmd.Parameters.Add("@NotifyContent", System.Data.SqlDbType.NVarChar).Value = NotifyContent;
            DBCmd.Parameters.Add("@URL", System.Data.SqlDbType.VarChar).Value = URL;
            NotifyMsgID = Convert.ToInt32(DBAccess.GetDBValue(EWinWeb.DBConnStr, DBCmd));

            return NotifyMsgID;
        }
    }

    public static class UserAccountNotifyMsg {
        public static int InsertUserAccountNotifyMsg(int NotifyMsgID, int MessageReadStatus, string LoginAccount) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int RetValue = 0;

            SS = " INSERT INTO UserAccountNotifyMsg (forNotifyMsgID, LoginAccount, MessageReadStatus) " +
                                  " VALUES (@forNotifyMsgID, @LoginAccount, @MessageReadStatus) ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@forNotifyMsgID", System.Data.SqlDbType.Int).Value = NotifyMsgID;
            DBCmd.Parameters.Add("@MessageReadStatus", System.Data.SqlDbType.Int).Value = MessageReadStatus;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return RetValue;
        }

        public static int UpdateUserAccountNotifyMsgStatus(int forNotifyMsgID, string LoginAccount,int MessageReadStatus) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            int RetValue = 0;

            SS = " UPDATE UserAccountNotifyMsg WITH (ROWLOCK) SET MessageReadStatus=@MessageReadStatus " +
                      " WHERE LoginAccount=@LoginAccount AND forNotifyMsgID=@forNotifyMsgID";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@forNotifyMsgID", System.Data.SqlDbType.Int).Value = forNotifyMsgID;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@MessageReadStatus", System.Data.SqlDbType.Int).Value = MessageReadStatus;
            RetValue = DBAccess.ExecuteDB(EWinWeb.DBConnStr, DBCmd);

            return RetValue;
        }
    }

    public static class UserAccountSummary {
        public static System.Data.DataTable GetUserAccountPaymentSummaryData(string LoginAccount, string StartDate, string EndDate) {
            string SS;
            System.Data.SqlClient.SqlCommand DBCmd;
            System.Data.DataTable DT;

            SS = " SELECT ISNULL(Sum(DepositAmount),0)  DepositAmount, " +
                      "                ISNULL(Sum(WithdrawalAmount),0) WithdrawalAmount " +
                      " FROM   UserAccountSummary " +
                      " WHERE  LoginAccount = @LoginAccount " +
                      "        AND SummaryDate >= @StartDate " +
                      "        AND SummaryDate < @EndDate  ";
            DBCmd = new System.Data.SqlClient.SqlCommand();
            DBCmd.CommandText = SS;
            DBCmd.CommandType = System.Data.CommandType.Text;
            DBCmd.Parameters.Add("@LoginAccount", System.Data.SqlDbType.VarChar).Value = LoginAccount;
            DBCmd.Parameters.Add("@StartDate", System.Data.SqlDbType.DateTime).Value = DateTime.Parse(StartDate);
            DBCmd.Parameters.Add("@EndDate", System.Data.SqlDbType.DateTime).Value = DateTime.Parse(EndDate);
            DT = DBAccess.GetDB(EWinWeb.DBConnStr, DBCmd);

            return DT;
        }
    }
}