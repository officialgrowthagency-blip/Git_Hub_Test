
import 'package:test_firbase_project/features/auth/domain/entity.dart';

class UserModel extends AuthenticatedUser {
   
   UserModel({
    required super.uid,
    required super.email,
   });

   factory UserModel.fromMap (Map<String, dynamic> json){ 
     return UserModel(
      uid: json["uid"] ?? "",
      email: json["email"] ?? "",
      );
   }

    Map<String, dynamic> toMap () {

      return {
        "uid" : uid,
        "email" : email,
      };
    }
}