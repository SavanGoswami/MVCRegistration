using MVCRegistration.BusinessAccess.Factory.IService;
using MVCRegistration.BusinessAccess.Factory.ViewModel;
using MVCRegistration.BusinessAccess.Generic;
using MVCRegistration.DataAccess;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;

namespace MVCRegistration.BusinessAccess.Factory.Service
{
    public class UserService : IUserService
    {
        #region CRUD Methods
        public void AddEditUser(UserModel model)
        {
            User entity = new User();
            try
            {
                entity.Id = model.Id;
                entity.Firstname = model.Firstname;
                entity.Lastname = model.Lastname;
                entity.Phone = model.Phone;
                entity.EmailId = model.EmailId;
                entity.CountryId = model.CountryId;
                entity.CityId = model.CityId;
                entity.Gender = model.Gender;
                entity.Hobbies = string.Join(",", model.HobbyList.Where(x => x.IsSelected == true).Select(x => x.Id));
                if (model.PhotoUrl != null)
                {
                    entity.PhotoUrl = model.PhotoUrl;
                }
                else
                {
                    entity.PhotoUrl = model.hdnPhotoUrl;
                }
                using (UnitOfWork db = new UnitOfWork())
                {
                    if (model.Id > 0)
                    {
                        db.UserRepository.Update(entity);
                    }
                    else
                    {
                        db.UserRepository.Insert(entity);
                    }
                }
            }
            catch (Exception ex)
            {
                string InputData = string.Format(CultureInfo.InvariantCulture, "client_id: {0}", model.Id);
                ErrorLogService.LogErrorOccured("Error", "AddEditUser", InputData, ex.Message, 0, "UserService", ex.ToString());
            }
        }

        public List<UserModel> GetUserList()
        {
            List<UserModel> result = new List<UserModel>();
            try
            {
                using (UnitOfWork db = new UnitOfWork())
                {
                    result = db.UserRepository.GetAll().OrderBy(a => a.Firstname).ToList().ConvertAll(x => new UserModel
                    {
                        Id = x.Id,
                        Firstname = x.Firstname,
                        Lastname = x.Lastname,
                        Phone = x.Phone,
                        EmailId = x.EmailId,
                        CountryName = db.DB.Countries.Find(x.CountryId).CountryName,
                        CityName = db.DB.Cities.Find(x.CityId).CityName,
                        Gender = x.Gender,
                        PhotoUrl = x.PhotoUrl,
                        Hobby =db.DB.GetHobbyList(x.Id).FirstOrDefault()
                    }).ToList();
                }
            }
            catch (Exception ex)
            {
                ErrorLogService.LogErrorOccured("Error", "GetUserList", "", ex.Message, 0, "UserService", ex.ToString());
            }
            return result;
        }

        public UserModel GetUserByID(int id)
        {
            UserModel result = new UserModel();
            try
            {
                using (UnitOfWork db = new UnitOfWork())
                {
                    var item = db.UserRepository.GetById(id);
                    if (item != null)
                    {
                        result.Id = item.Id;
                        result.Firstname = item.Firstname;
                        result.Lastname = item.Lastname;
                        result.Phone = item.Phone;
                        result.EmailId = item.EmailId;
                        result.CountryId = item.CountryId;
                        result.CityId = item.CityId;
                        result.CountryName = db.DB.Countries.Find(item.CountryId).CountryName;
                        result.CityName = db.DB.Cities.Find(item.CityId).CityName;
                        result.Gender = item.Gender;
                        result.hdnPhotoUrl = item.PhotoUrl;
                    }
                }
            }
            catch (Exception)
            {
                //Erro Log code should be  here
            }
            return result;
        }

        public void DeleteUser(int id)
        {
            try
            {
                using (UnitOfWork db = new UnitOfWork())
                {
                    db.UserRepository.Delete(id);
                }
            }
            catch (Exception ex)
            {
                string InputData = string.Format(CultureInfo.InvariantCulture, "client_id: {0}", id);
                ErrorLogService.LogErrorOccured("Error", "DeleteUser", InputData, ex.Message, 0, "UserService", ex.ToString());
            }
        }
        #endregion


        #region DropDown and CheckBox Filling
        public IEnumerable<SelectListItem> CountryList()
        {
            List<SelectListItem> countries = new List<SelectListItem>();
            try
            {
                using (UnitOfWork db = new UnitOfWork())
                {
                    countries = db.DB.Countries.AsNoTracking()
                        .OrderBy(n => n.CountryName)
                            .Select(n =>
                            new SelectListItem
                            {
                                Value = n.CountryId.ToString(),
                                Text = n.CountryName
                            }).ToList();

                    var countrytip = new SelectListItem()
                    {
                        Value = null,
                        Text = "select country"
                    };

                    countries.Insert(0, countrytip);
                    return new SelectList(countries, "Value", "Text");
                }
            }
            catch (Exception)
            {
                //Erro Log code should be  here
            }
            return countries;
        }

        public IEnumerable<SelectListItem> GetCityListByCountry(int Id)
        {
            List<SelectListItem> Cities = new List<SelectListItem>();
            try
            {
                using (UnitOfWork db = new UnitOfWork())
                {
                    Cities = db.DB.Cities.AsNoTracking()
                        .OrderBy(n => n.CityName)
                        .Where(n => n.CountryId == Id)
                            .Select(n =>
                            new SelectListItem
                            {
                                Value = n.CityId.ToString(),
                                Text = n.CityName
                            }).ToList();
                    var citytip = new SelectListItem()
                    {
                        Value = null,
                        Text = "select city"
                    };

                    Cities.Insert(0, citytip);
                    return new SelectList(Cities, "Value", "Text");
                }
            }
            catch (Exception)
            {
                //Erro Log code should be  here
            }
            return Cities;
        }

        public List<HobbyModel> GetHobbyList(int UserId)
        {
            List<HobbyModel> result = new List<HobbyModel>();
            try
            {
                using (UnitOfWork db = new UnitOfWork())
                {
                    var HobbiesList = db.DB.Users.Where(m => m.Id == UserId).Select(m => m.Hobbies);
                    if (UserId == 0)
                    {
                        result = db.DB.Hobbies.AsNoTracking()
                       .OrderBy(n => n.Name)
                       .Select(n =>
                       new HobbyModel
                       {
                           Id = n.ID,
                           Name = n.Name,
                           IsSelected = false
                       }).ToList();
                    }
                    else
                    {
                        result = db.DB.GetHobbyListByIDForEdit(UserId)
                     .Select(n =>
                     new HobbyModel
                     {
                         Id = n.ID,
                         Name = n.Name,
                         IsSelected = n.isSelected??false
                     }).ToList();
                    }
                }
            }
            catch (Exception)
            {
                //Erro Log code should be  here
            }
            return result;
        }
        #endregion
    }
}
