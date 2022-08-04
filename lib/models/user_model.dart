class UserModel {
  String? name;
  String? email;
  String? phone;
  bool? isEmailVerified;
  late String uId;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.isEmailVerified,
    required this.uId,
  });

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVerified = json['isEmailVerified'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'isEmailVerified':isEmailVerified,
      'uId':uId,
    };
  }
}