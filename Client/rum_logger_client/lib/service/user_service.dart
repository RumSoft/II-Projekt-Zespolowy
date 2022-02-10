import 'dart:math';

import 'package:rum_logger_client/client/user_client.dart';
import 'package:rum_logger_client/model/user.dart';
import 'package:rum_logger_client/model/user_logs.dart';
import 'package:rum_logger_client/view/main_page.dart';

class DataService {
  static Map<int, UserDetails> users = new Map();
}

class UserService {
  Future<List<User>> GetUserList() async {
    var userClient = new UserClient();
    var list = await userClient.GetUserList();
    return list;
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890 ';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<bool> IsUserOnline(int userId, [bool? earlierState]) async {
    if (!DataService.users.containsKey(userId)) return false;
    var lastLogged = DataService.users[userId]?.LastLogged ?? DateTime.now();
    var span = DateTime.now().difference(lastLogged).inSeconds;
    if (span > 60)
      return false;
    else
      return true;
  }

  Future<UserLogs> GetUserLogs(int userId, [String? description]) async {
    var userClient = new UserClient();
    var user = await userClient.GetUserDetails(userId);

    if (user == null)
      return new UserLogs(userId.toString() + getRandomString(10), "");

    DataService.users[userId] = user;
    return new UserLogs(user.Logs, user.FilteredLogs);
  }

  Future<void> AddNewKeyWordss(String text) async {
    if (text == "") return;
    var userClient = new UserClient();
    await userClient.AddNewKeyWords(text);
  }
}
