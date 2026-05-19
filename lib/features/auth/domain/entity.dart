class UserEntity {
  final String email;

  final String password;

  UserEntity({required this.email, required this.password});
}

class AuthenticatedUser {
  final String uid;

  final String email;

  AuthenticatedUser({required this.uid, required this.email});
}
