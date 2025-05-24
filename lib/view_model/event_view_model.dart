import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:moallim_mate/model/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventViewModel with ChangeNotifier {
  static const String eventKey = 'event_json';

  Future<bool> saveEvent(EventModel event) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(event.toJson());
    await sp.setString(eventKey, encodedData);
    notifyListeners();
    return true;
  }

  Future<EventModel?> getEvent() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? jsonStr = sp.getString(eventKey);
    if (jsonStr == null) return null;
    Map<String, dynamic> map = jsonDecode(jsonStr);
    return EventModel.fromJson(map);
  }

  Future<bool> removeEvent() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(eventKey);
    notifyListeners();
    return true;
  }
}
