
import 'package:test_firbase_project/features/auth/domain/entity.dart';

class UserModel extends AuthenticatedUser {
   
   UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.image
   });

   factory UserModel.fromMap (Map<String, dynamic> json){ 
     return UserModel(
      uid: json["uid"] ?? "",
      email: json["email"] ?? "",
      name: json["name"] ?? '',
      image: json["image"] ?? ''
      );
   }

    Map<String, dynamic> toMap () {

      return {
        "uid" : uid,
        "email" : email,
      };
    }
}