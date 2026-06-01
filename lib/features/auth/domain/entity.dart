class UserEntity {
  final String email;

  final String password;

  UserEntity({required this.email, required this.password});
}

class AuthenticatedUser {
  final String uid;
  final String email;
  final String name;
  final String image;
  final String? provider;


  AuthenticatedUser(
    {
      required this.uid, 
      required this.email,
      required this.name,
      required this.image,
      this.provider,
      }
    );
}
