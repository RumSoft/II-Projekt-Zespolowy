import 'package:http/http.dart' as http;
import 'package:rum_logger_client/model/user.dart';
import 'dart:convert';

class UserClient {
  Future<List<User>> GetUserList() async {
    var client = http.Client();
    List<User> list = [];
    try {
      var response = await client.get(
          Uri.parse('https://rumlogger.azurewebsites.net/api/User/GetUserList'),
          headers: {"Access-Control-Allow-Origin": "*"});
      var result = json.decode(response.body);
      result.forEach((value) => list.add(User.fromJson(value)));

      return list;
    } catch (e) {
      return [
        User(1, "first user"),
        User(2, "second user"),
        User(3, "third user"),
        User(4, "next user"),
      ];
    } finally {
      client.close();
    }
  }

  Future<UserDetails?> GetUserDetails(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.parse('https://rumlogger.azurewebsites.net/api/User/GetUser?id=' +
              id.toString()),
          headers: {"Access-Control-Allow-Origin": "*"});
      var result = json.decode(response.body);
      var user = UserDetails.fromJson(result);

      return user;
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  Future<void> AddNewKeyWords(String text) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse(
              'https://rumlogger.azurewebsites.net/api/User/AddNewKeywords?text=' +
                  text.toString()),
          headers: {"Access-Control-Allow-Origin": "*"});
      var result = json.decode(response.body);
    } catch (e) {
    } finally {
      client.close();
    }
  }
}
