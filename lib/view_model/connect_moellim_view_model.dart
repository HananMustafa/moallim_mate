import 'package:flutter/widgets.dart';
import 'package:moallim_mate/model/event_model.dart';
import 'package:moallim_mate/repository/connect_moellim_repository.dart';
import 'package:moallim_mate/utils/utils.dart';
import 'package:moallim_mate/view_model/event_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

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
          if (error is TimeoutException) {
            Utils.flushbarErrorMessages(
              'Timed Out! Please try again later',
              context,
            );
          } else {
            Utils.flushbarErrorMessages(error.toString(), context);
          }
        });
  }

  Future<void> GetEventsApi(dynamic data, BuildContext context) async {
    try {
      setGetEventLoading(true);

      // Check if token exists and is not null
      if (data['token'] == null || data['token'].toString().isEmpty) {
        throw Exception('no_token');
      }

      // Await the API call
      final value = await _myRepo.getEvents(data);

      // Parse the JSON to EventModel
      EventModel eventModel = EventModel.fromJson(value);

      // Await saving to SharedPreferences
      await Provider.of<EventViewModel>(
        context,
        listen: false,
      ).saveEvent(eventModel);

      Utils.flushbarSuccessMessages('Events Loaded Successfully!', context);
    } catch (error) {
      String message;

      if (error is TimeoutException) {
        message = 'Timed Out! Please try again later';
      } else if (error.toString().contains('no_token') ||
          error.toString().contains(
            "type 'Null' is not a subtype of type 'String'",
          )) {
        message = 'Connect Moellim first!';
      } else {
        message = 'Something went wrong!';
      }

      Utils.flushbarErrorMessages(message, context);
    } finally {
      setGetEventLoading(false);
    }
  }
}
