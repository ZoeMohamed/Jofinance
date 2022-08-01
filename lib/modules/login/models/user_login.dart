class Userauth {
  final String username;
  final String userid;
  final String email;
  final String password;
  Userauth(
      {required this.username,
      required this.userid,
      required this.email,
      required this.password});
  static Userauth fromJson(Map<String, dynamic> json) {
    return Userauth(
        username: json['username'],
        userid: json['user_id'],
        email: json['email'],
        password: json['password']);
  }
}
