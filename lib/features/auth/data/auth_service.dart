  import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

   static String signUpEmail = "sign-email";


    static Future<void> saveEmail (String email) async {

     final prefs = await SharedPreferences.getInstance();

      prefs.setString(signUpEmail, email);
    }

    static Future<String?> getEmail () async {
     
      final prefs = await SharedPreferences.getInstance();

      return prefs.getString(signUpEmail);
    }
     
    static Future<void> removeEmail () async{
     
     final prefs = await SharedPreferences.getInstance();
      
      prefs.remove(signUpEmail);
       
    }
  }