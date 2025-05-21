import 'package:flutter/widgets.dart';
import 'package:moallim_mate/repository/connect_moellim_repository.dart';
import 'package:moallim_mate/utils/utils.dart';

class ConnectMoellimViewModel with ChangeNotifier {
  final _myRepo = ConnectMoellimRepository();

  Future<void> ConnectMoellimApi(dynamic data, BuildContext context) async {
    _myRepo
        .connectMoellim(data)
        .then((value) {
          print(value.toString());
          Utils.flushbarErrorMessages(value.toString(), context);
        })
        .onError((error, stackTrace) {});
  }
}
