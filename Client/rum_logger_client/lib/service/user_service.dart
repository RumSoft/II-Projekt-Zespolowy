import 'dart:math';

import 'package:rum_logger_client/model/user.dart';

class UserService {
  Future<List<User>> GetUserList() async {
    var list = [
      User(1, "first user"),
      User(2, "second user"),
      User(3, "third user"),
      User(4, "next user"),
    ];
    return list;
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890 ';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<bool> IsUserOnline(int user, [bool? earlierState]) async {
    if (earlierState != null) return !earlierState;
    return true;
  }

  Future<String> GetUserLogs(int userId, [String? description]) async {
    if (description != null) return description + getRandomString(5);

    var log = userId.toString() +
        """
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 
    jhsjhd djhdsds dkjhsdk dabhdjds dsdsjhjds 

    """;
    return log;
  }
}
