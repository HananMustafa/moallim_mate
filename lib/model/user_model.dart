class UserModel {
  bool? success;
  String? message;
  String? token;
  String? username;
  String? password;

  UserModel({
    this.success,
    this.message,
    this.token,
    this.username,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'token': token,
    'username': username,
    'password': password,
  };
}
