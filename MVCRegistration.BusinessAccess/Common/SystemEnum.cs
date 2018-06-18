using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVCRegistration.BusinessAccess.Common
{
    public class SystemEnum
    {
        /// <summary>
        /// Message Type Enum
        /// </summary>
        public enum MessageType
        {
            /// <summary>
            /// for Success message Class
            /// </summary>
            success,

            /// <summary>
            /// for error message Class
            /// </summary>
            danger,

            /// <summary>
            /// for Warning message Class
            /// </summary>
            warning
        }
    }
}
