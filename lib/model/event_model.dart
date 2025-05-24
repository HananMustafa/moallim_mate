class EventItem {
  final String name;
  final String description;
  final String modulename;
  final int timestart;
  final String coursefullname;

  EventItem({
    required this.name,
    required this.description,
    required this.modulename,
    required this.timestart,
    required this.coursefullname,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      modulename: json['modulename'] ?? '',
      timestart: json['timestart'] ?? 0,
      coursefullname: json['coursefullname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'modulename': modulename,
      'timestart': timestart,
      'coursefullname': coursefullname,
    };
  }
}

class EventModel {
  final List<EventItem> json;

  EventModel({required this.json});

  factory EventModel.fromJson(Map<String, dynamic> map) {
    var list = map['json'] as List;
    List<EventItem> items =
        list.map((item) => EventItem.fromJson(item)).toList();
    return EventModel(json: items);
  }

  Map<String, dynamic> toJson() {
    return {'json': json.map((item) => item.toJson()).toList()};
  }
}
