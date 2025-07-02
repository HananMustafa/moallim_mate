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

  String _username = 'Not available';
  String get username => _username;

  bool _isPlaceholder = true;
  bool get isPlaceholder => _isPlaceholder;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setGetEventLoading(bool value) {
    _getEventLoading = value;
    notifyListeners();
  }

  Future<void> loadUserCredentials() async {
    final sp = await SharedPreferences.getInstance();
    final name = sp.getString('username') ?? 'Not available';
    _username = name;
    _isPlaceholder = name == 'Not available';
    notifyListeners();
  }

  Future<void> connectMoellimApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo
        .connectMoellim(data)
        .then((value) async {
          setLoading(false);
          if (!context.mounted) return;
          Utils.flushbarSuccessMessages('Credentials Saved!', context);

          String token = value['token'];
          String username = value['username'];
          String password = value['password'];

          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('token', token.toString());
          sp.setString('username', username.toString());
          sp.setString('password', password.toString());

          // Update provider values
          _username = username;
          _isPlaceholder = false;
          notifyListeners();

          // Navigator.of(context).pop(); // close dialog
        })
        .onError((error, stackTrace) {
          setLoading(false);
          if (error is TimeoutException) {
            if (!context.mounted) return;
            Utils.flushbarErrorMessages(
              'Timed Out! Please try again later',
              context,
            );
          } else {
            if (!context.mounted) return;
            Utils.flushbarErrorMessages(error.toString(), context);
          }
        });
  }

  Future<void> getEventsApi(dynamic data, BuildContext context) async {
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
      if (!context.mounted) return;
      await Provider.of<EventViewModel>(
        context,
        listen: false,
      ).saveEvent(eventModel);

      if (!context.mounted) return;
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
