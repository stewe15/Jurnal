class User {
  final int? id;
  final String username;
  final String group;

  User({this.id, required this.username, required this.group});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'userGroup': group};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      group: map['userGroup'],
    );
  }

  User copyWith({int? id, String? username, String? group}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      group: group ?? this.group,
    );
  }
}
