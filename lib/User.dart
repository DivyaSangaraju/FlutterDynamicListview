class User{
  final String username;
  final String email;
  const User({
    required this.username,
    required this.email,
});

  static User fromJson(json)=>User(
      username:json['username'] ,
      email: json['email']);
}