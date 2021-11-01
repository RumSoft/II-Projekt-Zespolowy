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

  Future<String> GetUserLogs(int userId) async {
    var log = """
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
