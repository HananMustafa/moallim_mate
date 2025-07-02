import 'package:moallim_mate/view_model/user_view_model.dart';

class CheckSharedPreferences {
  static Future<Map<String, String>> checkCredentialsStatus() async {
    UserViewModel userVM = UserViewModel();
    final user = await userVM.getUser();

    if (user.token == null || user.token == '' || user.token == 'null') {
      return {'username': 'Not available'};
    } else {
      return {
        'username': user.username ?? 'Not available',
        'password': user.password ?? '**',
      };
    }
  }
}
