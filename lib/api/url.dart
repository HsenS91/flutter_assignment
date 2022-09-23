class Urls{
  static const String BASE_URL = 'http://apidev.tabkha.online/api/';
  static const String AUTH = 'auth/';
  static const String USER = 'user/';

  static const String LOGIN = AUTH + 'login';
  static const String RESET_PASSWORD_FORM = AUTH + 'reset-password-form';
  static const String RESET_PASSWORD = AUTH + 'reset-password';

  static const String GET_WORK_BY_ID = 'get-work-by-id';
  static const String GET_WORK_BY_USER_ID = USER + 'get-work-by-user-id';
  static const String CREATE_WORK = USER + 'create-work';
  static const String UPDATE_WORK = 'update-work';
  static const String DELETE_WORK = 'delete-work';
}