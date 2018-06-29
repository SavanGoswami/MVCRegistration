using System.Linq;
using System.Web.Mvc;
using MVCRegistration.BusinessAccess.Common;
using MVCRegistration.BusinessAccess.Factory.IService;
using MVCRegistration.BusinessAccess.Factory.Service;
using MVCRegistration.BusinessAccess.Factory.ViewModel;
using System.Web;
using System.IO;
using System;


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
        /// Index page display user list (Paging , Sorting ,Filtering)
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(string sortOrder, string currentFilter, string searchString, int? page)
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.FirstnameSortParm = String.IsNullOrEmpty(sortOrder) ? "Firstname_desc" : "";
            ViewBag.LastnameSortParm = sortOrder == "Lastname" ? "Lastname_desc" : "Lastname";


            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;

            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(_objUserService.GetUserList(sortOrder, searchString, pageNumber, pageSize));
        }

        /// <summary>
        /// Get user detail by id for editing the details
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult ManageUser(int? id)
        {
            UserModel model = new UserModel();
            if (id != 0)
            {
                var user = _objUserService.GetUserByID(id ?? 0);
                if (user.Id == 0)
                {
                    return RedirectToAction("Error", "Error");
                }
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
        /// Insert / Update user details
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
                if (_objUserService.AddEditUser(model))
                {
                    TempData["SuccessMessage"] = Messages.UserSaveUpdateFail;
                }
                else
                {
                    TempData["ErrorMessage"] = Messages.UserSaveUpdateFail;
                }
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
        public JsonResult Delete(int id)
        {
            if (_objUserService.DeleteUser(id))
            {
                TempData["SuccessMessage"] = Messages.UserDelete;
                return Json(new { status = SystemEnum.MessageType.success.ToString() }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                TempData["ErrorMessage"] = Messages.UserDeleteFail;
                return Json(new { status = SystemEnum.MessageType.danger.ToString() }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region HelperMethod
        /// <summary>
        /// Method use to save files
        /// </summary>
        /// <param name="PhotoUrl"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Use to fill city dropdpwn accordingly country
        /// </summary>
        /// <param name="countryId"></param>
        /// <returns></returns>
        public ActionResult GetCityListByCountry(int? countryId)
        {
            var cities = _objUserService.GetCityListByCountry(countryId ?? 0);
            return Json(cities, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// This is error page for any kind of exception occured
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Error()
        {
            return View("Error");
        }
        #endregion
    }
}
