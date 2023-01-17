final String userTable = 'user';

class Userfield {
  static final String username = 'username';
  static final String email = 'email';
  static final String password = 'password';
  static final List<String> allfields = [username, email, password];
}

class User {
  User({
    required this.username,
    required this.email,
    required this.password,
  });
  final String username;
  final String email;
  final String password;

  Map<String, Object?> toJson() => {
        Userfield.username: username,
        Userfield.email: email,
        Userfield.password: password,
      };

  static User fromJson(Map<String, Object?> json) => User(
        username: json[Userfield.username] as String,
        email: json[Userfield.email] as String,
        password: json[Userfield.password] as String,
      );
}
