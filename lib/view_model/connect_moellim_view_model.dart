import 'package:flutter/widgets.dart';
import 'package:moallim_mate/model/event_model.dart';
import 'package:moallim_mate/repository/connect_moellim_repository.dart';
import 'package:moallim_mate/utils/utils.dart';
import 'package:moallim_mate/view_model/event_view_model.dart';
import 'package:provider/provider.dart';
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
          Utils.flushbarSuccessMessages('Credentials Saved!', context);

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
          Utils.flushbarErrorMessages('Something went wrong!', context);
        });
  }

  Future<void> GetEventsApi(dynamic data, BuildContext context) async {
    try {
      setGetEventLoading(true);

      // Await the API call
      final value = await _myRepo.getEvents(data);

      // Parse the JSON to EventModel
      EventModel eventModel = EventModel.fromJson(value);

      // Await saving to SharedPreferences
      await Provider.of<EventViewModel>(
        context,
        listen: false,
      ).saveEvent(eventModel);

      print('Saved EventModel: ${eventModel.toJson()}');

      Utils.flushbarSuccessMessages('Events Loaded Successfully!', context);
    } catch (error) {
      Utils.flushbarErrorMessages('Something went wrong!', context);
    } finally {
      setGetEventLoading(false);
    }

    // setGetEventLoading(true);
    // _myRepo
    //     .getEvents(data)
    //     .then((value) async {
    //       setGetEventLoading(false);

    //       // Parse the JSON to EventModel
    //       EventModel eventModel = EventModel.fromJson(value);

    //       // Save to shared preferences using EventViewModel
    //       await Provider.of<EventViewModel>(
    //         context,
    //         listen: false,
    //       ).saveEvent(eventModel);

    //       // Print for debug
    //       print('Saved EventModel: ${eventModel.toJson()}');

    //       Utils.flushbarSuccessMessages(
    //         'Events Saved to SharedPreferences',
    //         context,
    //       );
    //     })
    //     .onError((error, stackTrace) {
    //       setGetEventLoading(false);
    //       Utils.flushbarErrorMessages(error.toString(), context);
    //     });
  }
}
