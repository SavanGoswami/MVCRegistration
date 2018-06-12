using MVCRegistration.DataAccess;

namespace MVCRegistration.BusinessAccess.Generic
{
    public class UnitOfWork : BusinessBase
    {
        #region Private
        private GenericUnit<User> _User;
        private GenericUnit<ErrorLog> _ErrorLog;
        #endregion

        #region Public
        public GenericUnit<User> UserRepository
        {
            get
            {
                if (this._User == null)
                {
                    this._User = new GenericUnit<User>(DB);
                }
                return _User;
            }
        }

        public GenericUnit<ErrorLog> ErrorLogRepository
        {
            get
            {
                if (this._ErrorLog == null)
                {
                    this._ErrorLog = new GenericUnit<ErrorLog>(DB);
                }
                return _ErrorLog;
            }
        }

        #endregion
    }
}

