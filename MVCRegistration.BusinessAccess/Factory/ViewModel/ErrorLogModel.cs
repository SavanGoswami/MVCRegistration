using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MVCRegistration.BusinessAccess.Factory.ViewModel
{
    [Table("ErrorLog")]
    public sealed class ErrorLogModel
    {
        #region Properties

        /// <summary>
        /// Gets or sets the ErrorLogId value.
        /// </summary>
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ErrorLogId { get; set; }

        /// <summary>
        /// Gets or sets the ErrorDate value.
        /// </summary>
        public DateTime? ErrorDate { get; set; }

        /// <summary>
        /// Gets or sets the UserId value.
        /// </summary>
        public int? LoginID { get; set; }

        /// <summary>
        /// Gets or sets the IPAddress value.
        /// </summary>
        [StringLength(20, ErrorMessage = "*")]
        public string IPAddress { get; set; }

        /// <summary>
        /// Gets or sets the ClientBrowser value.
        /// </summary>
        [StringLength(50, ErrorMessage = "*")]
        public string ClientBrowser { get; set; }

        /// <summary>
        /// Gets or sets the URL value.
        /// </summary>
        [StringLength(500, ErrorMessage = "*")]
        public string URL { get; set; }

        /// <summary>
        /// Gets or sets the UrlReferrer value.
        /// </summary>
        [StringLength(500, ErrorMessage = "*")]
        public string UrlReferrer { get; set; }

        /// <summary>
        /// Gets or sets the ErrorMessage value.
        /// </summary>
        [StringLength(500, ErrorMessage = "*")]
        public string ErrorMessage { get; set; }

        /// <summary>
        /// Gets or sets the ErrorStackTrace value.
        /// </summary>
        public string ErrorStackTrace { get; set; }

        /// <summary>
        /// Gets or sets the ErrorSource value.
        /// </summary>
        [StringLength(500, ErrorMessage = "*")]
        public string ErrorSource { get; set; }

        /// <summary>
        /// Gets or sets the ErrorTargetSite value.
        /// </summary>
        [StringLength(500, ErrorMessage = "*")]
        public string ErrorTargetSite { get; set; }

        /// <summary>
        /// Gets or sets the QueryString value.
        /// </summary>
        [StringLength(500, ErrorMessage = "*")]
        public string QueryString { get; set; }

        /// <summary>
        /// Gets or sets the PostData value.
        /// </summary>
        public string PostData { get; set; }

        /// <summary>
        /// Gets or sets the SessionInfo value.
        /// </summary>
        public string SessionInfo { get; set; }

        #endregion
    }
}
