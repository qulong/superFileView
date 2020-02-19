class UrlApi {
  static const String BaseHost = 'http://authservice.rc.saas.dyrs.cn:8080';
  static const String SERVICE =
      BaseHost + '/com-dyrs-mtsp-mopbackendservice/mopbackendservice';
//新获取短信验证码
  static const String GETSECURITYCODE =
      SERVICE + "/security/getSecurityCode/api";
  //新登录
  static const String GETLOGIN = SERVICE + "/security/login/api";
}
