class Skip {
  final int? id;
  final String time_of;
  final String nm;
  Skip({this.id, required this.time_of, required this.nm});
  Map<String, dynamic> toMap() {
    return {'id': id, 'time_of': time_of, 'nm': nm};
  }

  factory Skip.fromMap(Map<String, dynamic> map) {
    return Skip(id: map['id'], time_of: map['time_of'], nm: map['nm']);
  }
}
