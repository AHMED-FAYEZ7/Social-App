class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  late String uId;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.cover,
    this.image,
    this.bio,
    this.isEmailVerified,
    required this.uId,
  });

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'bio':bio,
      'phone':phone,
      'cover':cover,
      'image':image,
      'isEmailVerified':isEmailVerified,
      'uId':uId,
    };
  }
}