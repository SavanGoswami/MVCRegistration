using MVCRegistration.BusinessAccess.Factory.ViewModel;
using System.Collections.Generic;
using System.Web.Mvc;

namespace MVCRegistration.BusinessAccess.Factory.IService
{
    public interface IUserService
    {
        void AddEditUser(UserModel user);
        List<UserModel> GetUserList();
        UserModel GetUserByID(int id);
        void DeleteUser(int id);
        IEnumerable<SelectListItem> CountryList();
        List<HobbyModel> GetHobbyList(int UserId);
        IEnumerable<SelectListItem> GetCityListByCountry(int Id);
    }
}
