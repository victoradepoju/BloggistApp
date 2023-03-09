class UserInfoModel {
  final int? id;
  final String? name;
  final String? image;
  final String? email;
  final String? token;
  const UserInfoModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.token,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      token: json['token'],
    );
  }
}
