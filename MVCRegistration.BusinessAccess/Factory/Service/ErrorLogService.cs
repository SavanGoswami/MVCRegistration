using MVCRegistration.DataAccess;

namespace MVCRegistration.BusinessAccess.Factory.Service
{
    public class ErrorLogService  
    {
        /// <summary>
        /// To log the error or exception occurred.
        /// </summary>
        /// <param name="Type"></param>
        /// <param name="FunctionName"></param>
        /// <param name="InputData"></param>
        /// <param name="OutputData"></param>
        /// <param name="CallStatus"></param>
        /// <param name="UserID"></param>
        /// <param name="GroupType"></param>
        /// <param name="FullErrorDescription"></param>
        public static void LogErrorOccured(string Type, string FunctionName, string InputData, string OutputData, int UserID, string GroupType, string FullErrorDescription)
        {
            using (HotelDBEntities DB = new HotelDBEntities())
            {
                DB.LogErrorOccured(Type, FunctionName, InputData, OutputData, UserID, GroupType, FullErrorDescription);
            }
        }
    }
}
