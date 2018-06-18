using MVCRegistration.BusinessAccess.Factory.ViewModel;
using PagedList;
using System.Collections.Generic;
using System.Web.Mvc;

namespace MVCRegistration.BusinessAccess.Factory.IService
{
    public interface IUserService
    {
        bool AddEditUser(UserModel user);
        IPagedList<UserModel> GetUserList(string sortOrder, string searchString,int pageNumber,int pageSize);
        UserModel GetUserByID(int id);
        bool DeleteUser(int id);

        IEnumerable<SelectListItem> CountryList();
        IEnumerable<SelectListItem> GetCityListByCountry(int Id);
        List<HobbyModel> GetHobbyList(int UserId);
    }
}
