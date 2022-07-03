

class BaseAPI {
  static String api = "http://10.0.2.2:8080";
  var signupPath = api + "/signup";
  var signinPath = api + "/signin";
  var logoutPath = api + "/logout";
  var categoriesPath = api + "/categories";
  var searchCategoriesPath = api + "/search-providers-by-category";
  var providersPath = api + "/providers";
  var detailsPath = api + "/providers";
  var postOrdersPath = api + "/orders";
  var getOrdersPath = api + "/orders";


  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

}


