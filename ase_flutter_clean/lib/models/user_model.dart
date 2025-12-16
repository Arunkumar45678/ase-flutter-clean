class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String gender;
  final String district;
  final String mandal;
  final String village;
  final bool termsAccepted;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.gender,
    required this.district,
    required this.mandal,
    required this.village,
    required this.termsAccepted,
  });

  /// Create UserModel from API JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      district: json['district'] ?? '',
      mandal: json['mandal'] ?? '',
      village: json['village'] ?? '',
      termsAccepted: json['terms_accepted'] == 1 ||
          json['terms_accepted'] == true,
    );
  }

  /// Convert UserModel to JSON (for API POST)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'gender': gender,
      'district': district,
      'mandal': mandal,
      'village': village,
      'terms_accepted': termsAccepted ? 1 : 0,
    };
  }
}
