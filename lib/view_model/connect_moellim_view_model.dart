import 'package:flutter/widgets.dart';
import 'package:moallim_mate/repository/connect_moellim_repository.dart';
import 'package:moallim_mate/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectMoellimViewModel with ChangeNotifier {
  final _myRepo = ConnectMoellimRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _getEventLoading = false;
  bool get getEventLoading => _getEventLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setGetEventLoading(bool value) {
    _getEventLoading = value;
    notifyListeners();
  }

  Future<void> ConnectMoellimApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo
        .connectMoellim(data)
        .then((value) async {
          setLoading(false);
          print(value.toString());
          Utils.flushbarSuccessMessages(value.toString(), context);

          //Look an eye on raasta-flutter, after signup, where exactly i am saving user data in shared preferences
          //I guess, its viewmodel, where i am saving it
          //confirm from there, then save user token in shared preferences below!

          String token = value['token'];
          String username = value['username'];
          String password = value['password'];

          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('token', token.toString());
          sp.setString('username', username.toString());
          sp.setString('password', password.toString());
        })
        .onError((error, stackTrace) {
          setLoading(false);
          Utils.flushbarErrorMessages(error.toString(), context);
        });
  }

  Future<void> GetEventsApi(dynamic data, BuildContext context) async {
    setGetEventLoading(true);
    _myRepo
        .getEvents(data)
        .then((value) {
          setGetEventLoading(false);
          print(value.toString());
          Utils.flushbarSuccessMessages(value.toString(), context);
        })
        .onError((error, stackTrace) {
          setGetEventLoading(false);
          Utils.flushbarErrorMessages(error.toString(), context);
        });
  }
}
