 class Validator {

  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

   static String? validName (String? value) {
      
       if(value == null || value.isEmpty){
         return "Please Enter Full Name";
       }
        else {
           return null;
        }
   }

   static String? validEmail (String? value) {

      if(value!.trim().isEmpty){
        return "Please Enter Email";
      }
       else if(!emailRegExp.hasMatch(value)) {
         return "Wrong Email Address";
       }
        else {
           return null;
        }
   }

   static String? passwordValidator (String? value) {
      if(value == null || value.isEmpty) {
        return "Please Enter Password";
      }
       else if(value.length<8){
         return "Password Length Must 8 Digit";
       }
        else {
           return null;
        }
   }

   
}
