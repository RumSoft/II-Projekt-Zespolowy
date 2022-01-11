class User {
  final int Id;
  final String Name;

  User(this.Id, this.Name);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['name'] as String,
    );
  }
}

class UserDetails {
  final int Id;
  final String Name;
  final String Logs;
  final String FilteredLogs;
  final DateTime LastLogged;

  UserDetails(
      this.Id, this.Name, this.Logs, this.FilteredLogs, this.LastLogged);

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      json['id'] as int,
      json['name'] as String,
      json['logs'] as String,
      json['filteredLogs'] as String,
      DateTime.parse(json['lastLogged']),
    );
  }
}
