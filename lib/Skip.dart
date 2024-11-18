class Skip {
  final int? id;
  final String time_of;
  final String nm;
  final String type;
  Skip({this.id, required this.time_of, required this.nm, required this.type});
  Map<String, dynamic> toMap() {
    return {'id': id, 'time_of': time_of, 'nm': nm, 'type': type};
  }

  factory Skip.fromMap(Map<String, dynamic> map) {
    return Skip(id: map['id'], time_of: map['time_of'], nm: map['nm'], type: map['type']);
  }
}
