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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
