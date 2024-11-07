class Para {
  final int? id;
  final String name;
  final String audit;
  final String group;
  final String dayOfWeek;
  final String Time;
  final String week;
  Para(
      {this.id,
      required this.name,
      required this.audit,
      required this.group,
      required this.dayOfWeek,
      required this.Time,
      required this.week});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'audit': audit,
      'paraGroup': group,
      'dayOfWeek': dayOfWeek,
      'Time': Time,
      'week': week
    };
  }

  factory Para.fromMap(Map<String, dynamic> map) {
    return Para(
        id: map['id'],
        name: map['name'] ?? '',
        audit: map['audit'] ?? '',
        group: map['paraGroup'] ?? '',
        dayOfWeek: map['dayOfWeek'] ?? '',
        Time: map['Time'] ?? '',
        week: map['week'] ?? '');
  }
}
