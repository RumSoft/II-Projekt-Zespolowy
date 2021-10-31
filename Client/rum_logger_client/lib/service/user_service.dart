import 'package:rum_logger_client/model/user.dart';

class UserService {
  Future<List<User>> GetUserList() async {
    var list = [
      User(1, "first poor user"),
      User(2, "second poor user"),
      User(3, "third poor user"),
      User(4, "next poor user"),
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
