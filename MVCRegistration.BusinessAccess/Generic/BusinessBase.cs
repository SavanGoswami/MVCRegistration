using MVCRegistration.DataAccess;

namespace MVCRegistration.BusinessAccess.Generic
{
    public class BusinessBase : ClsDispose
    {
        public HotelDBEntities DB;

        public BusinessBase()
        {
                DB = new HotelDBEntities();
        }
    }
}
