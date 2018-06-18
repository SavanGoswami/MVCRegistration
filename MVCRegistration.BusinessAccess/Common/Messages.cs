using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVCRegistration.BusinessAccess.Common
{
    public class Messages
    {
        #region Common Messages
        public static readonly string DeleteConfirn = "Are you sure you want to delete?";
        public static readonly string titleConfirmation = "Confirmation";
        public static readonly string error = "Somethong Went wrong.. ";
        #endregion Common Messages

        #region User
        public static readonly string UserSaveUpdate = "User Details has been saved successfully.";
        public static readonly string UserSaveUpdateFail = "There are problem while updating User details, Please try again!";
        public static readonly string UserDelete = "User Details has been removed successfully.";
        public static readonly string UserDeleteFail = "There are problem while deleting User details, Please try again!";
        #endregion
    }
}
