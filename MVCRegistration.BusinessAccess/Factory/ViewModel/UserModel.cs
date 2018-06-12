using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace MVCRegistration.BusinessAccess.Factory.ViewModel
{
    public class UserModel
    {
        public int Id { get; set; }

        [Display(Name ="First Name")]
        [MaxLength(50)]
        [Required]
        public string Firstname { get; set; }

        [MaxLength(50)]
        [Required]
        [Display(Name = "Last Name")]
        public string Lastname { get; set; }

        [MinLength(10)]
        [Phone]
        [Required]
        public string Phone { get; set; }

        [Display(Name = "Email")]
        [EmailAddress]
        [MaxLength(50)]
        [Required]
        public string EmailId { get; set; }

        [Display(Name = "Country")]
        [Required]
        public Nullable<int>  CountryId { get; set; }

        [Display(Name = "City")]
        [Required]
        public Nullable<int> CityId { get; set; }

        [Required]
        public string Gender { get; set; }

        public string Hobby { get; set; }

        [Display(Name = "Image")]
        public string PhotoUrl { get; set; }


        [Display(Name = "Country")]
        public string CountryName { get; set; }

        [Display(Name = "City")]
        public string CityName { get; set; }

        public string hdnPhotoUrl { get; set; }

        public List<HobbyModel> HobbyList { get; set; }
    }

    public class HobbyModel
    {
        public int Id { get; set; }
        public string Name{ get; set; }
        public bool IsSelected{ get; set; }
    }
}
