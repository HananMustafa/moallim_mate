import 'package:flutter/widgets.dart';
import 'package:moallim_mate/repository/connect_moellim_repository.dart';
import 'package:moallim_mate/utils/utils.dart';

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
        .then((value) {
          setLoading(false);
          print(value.toString());
          Utils.flushbarSuccessMessages(value.toString(), context);
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
