using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using MVCRegistration.BusinessAccess;
using MVCRegistration.BusinessAccess.Factory.IService;
using MVCRegistration.BusinessAccess.Factory.Service;
using MVCRegistration.BusinessAccess.Factory.ViewModel;
using System.Web;
using System.IO;
using System.Drawing;
using System.Collections.Generic;

namespace MVCRegistration.Controllers
{
    public class UsersController : Controller
    {
        #region Properties
        private IUserService _objUserService;
        #endregion

        #region Cstr
        public UsersController()
            : this(new UserService())
        {
        }

        public UsersController(IUserService objService)
        {
            this._objUserService = objService;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Index page display user list
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View(_objUserService.GetUserList());
        }

        public ActionResult ManageUser(int? id)
        {
            UserModel model = new UserModel();
            if (id != 0)
            {
                model = _objUserService.GetUserByID(id ?? 0);
                ViewBag.CountryId = new SelectList(_objUserService.CountryList(), "Value", "Text", model.CountryId);
                ViewBag.CityId = new SelectList(_objUserService.GetCityListByCountry(model.CountryId ?? 0), "Value", "Text", model.CityId);
                model.HobbyList = _objUserService.GetHobbyList(id ?? 0);
            }
            else
            {
                ViewBag.CountryId = new SelectList(_objUserService.CountryList(), "Value", "Text", model.CountryId);
                ViewBag.CityId = new SelectList(_objUserService.GetCityListByCountry(model.CountryId ?? 0), "Value", "Text", model.CityId);
                model.HobbyList = _objUserService.GetHobbyList(id ?? 0);
            }
            return View(model);
        }

        /// <summary>
        /// Save / Update user
        /// </summary>
        /// <param name="model"></param>
        /// <param name="PhotoUrl"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ManageUser(UserModel model, HttpPostedFileBase PhotoUrl)
        {
            if (ModelState.IsValid)
            {
                if (PhotoUrl != null)
                {
                    if (SaveFile(PhotoUrl))
                    {
                        model.PhotoUrl = "~\\UploadFile\\" + Path.GetFileName(PhotoUrl.FileName);
                    }
                }
                 _objUserService.AddEditUser(model);
                TempData["SuccessMessage"] = "User Has been Added / Updated Succsessfully!";
                    return RedirectToAction("Index");
            }
            model.HobbyList = _objUserService.GetHobbyList(model.Id);
            ViewBag.CountryId = new SelectList(_objUserService.CountryList(), "Value", "Text", model.CountryId);
            ViewBag.CityId = new SelectList(_objUserService.GetCityListByCountry(model.CountryId ?? 0), "Value", "Text", model.CityId);
            return View(model);
        }
        
        /// <summary>
        /// Delete user
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            _objUserService.DeleteUser(id);
            TempData["SuccessMessage"] = "User Has been Deleted Succsessfully!";
            return Json(new { status = "success", message = "Record Has been Deleted Succsessfully" }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region HelperMethod
        public bool SaveFile(HttpPostedFileBase PhotoUrl)
        {
            try
            {
                var allowedExtensions = new[] { ".Jpg", ".png", ".jpg", "jpeg" };
                var fileName = Path.GetFileName(PhotoUrl.FileName);
                var ext = Path.GetExtension(PhotoUrl.FileName);
                if (allowedExtensions.Contains(ext))
                {
                    string name = Path.GetFileName(fileName);
                    var path = Path.Combine(Server.MapPath("~/UploadFile"), name);
                    PhotoUrl.SaveAs(path);
                }
                return true;
            }
            catch (System.Exception)
            {
                return false;
            }
        }

        public ActionResult GetCityListByCountry(int? countryId)
        {
            var cities = _objUserService.GetCityListByCountry(countryId ?? 0);
            return Json(cities, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public ActionResult Error()
        {
            return View("Error");
        }
        #endregion
    }
}
