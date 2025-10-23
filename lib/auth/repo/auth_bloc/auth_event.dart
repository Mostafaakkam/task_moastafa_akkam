abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  int id;
  String username, email, password;

  RegisterEvent({
    required this.password,
    required this.email,
    required this.username,
    required this.id,
  });
}

class LoginEvent extends AuthEvent {
  String username, password;

  LoginEvent({required this.username, required this.password});
}

class LogoutEvent extends AuthEvent {}
