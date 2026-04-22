class UserModel {
  final String name;
  final String email;
  final String? token;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? visa;

  UserModel({
    required this.name,
    required this.email,
    this.token,
    this.image,
    this.address,
    this.phoneNumber,
    this.visa,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      token: json['token'] ?? null,
      image: json['image'] ?? "",
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      visa: json['Visa'] ?? "",
    );
  }
}
