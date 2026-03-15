class SignUpRequestModel {
  final String name;
  final String email;
  final String password;
  final String age;
  final String gender;

  SignUpRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "age": age,
    "gender": gender,
  };
}
