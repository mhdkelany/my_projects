class SocialUserModel
{
  String? name;
  String? phone;
  String? email;
  String? uId;

  SocialUserModel({
    required this.name,
    required this.uId,
    required this.email,
    required this.phone,
});
  SocialUserModel.fromJson(dynamic json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uid'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'uid':uId,
      'phone':phone,
    };
  }
}