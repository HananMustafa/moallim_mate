import 'package:flutter/widgets.dart';
import 'package:moallim_mate/repository/connect_moellim_repository.dart';
import 'package:moallim_mate/utils/utils.dart';

class ConnectMoellimViewModel with ChangeNotifier {
  final _myRepo = ConnectMoellimRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
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
}
