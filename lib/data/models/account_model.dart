class UserModel {
  String ?fullName;
  String? phoneNumber;
  String ?email;

  UserModel({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['name'];
    phoneNumber = json['phone'];
    email = json['email'];
  }
}
