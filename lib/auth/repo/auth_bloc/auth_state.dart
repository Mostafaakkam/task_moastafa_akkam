import '../../model/auth_model.dart';

class AuthState {
  Status? authStatus;
  AuthModel? user;

  AuthState({this.authStatus, this.user});

  AuthState copyWith({
    Status? authStatus,
    AuthModel? user,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
      );
}

enum Status { init, error, success, loading }
