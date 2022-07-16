class Userauth {
  final String bio;
  Userauth({required this.bio});
  static Userauth fromJson(Map<String, dynamic> json) {
    return Userauth(bio: json['username']);
  }
}
