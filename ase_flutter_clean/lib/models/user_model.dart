class UserModel {
  final String email;
  final String name;
  final String phone;
  final String gender;
  final String district;
  final String mandal;
  final String village;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.gender,
    required this.district,
    required this.mandal,
    required this.village,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "phone": phone,
      "gender": gender,
      "district": district,
      "mandal": mandal,
      "village": village,
    };
  }
}
