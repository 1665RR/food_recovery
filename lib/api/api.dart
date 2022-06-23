class BaseAPI {
  static String api = "http://10.0.2.2:8080";
  var signupPath = api + "/signup";
  var signinPath = api + "/signin";
  var logoutPath = api + "/logout";
// more routes
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}
