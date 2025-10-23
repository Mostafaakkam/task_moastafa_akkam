import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_event.dart';
import 'package:task_moastafa_akkam/auth/repo/auth_bloc/auth_state.dart';

import '../auth_repo.dart';
import '../../model/auth_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthState()) {
    on<RegisterEvent>(_register);
    on<LoginEvent>(_login);
    on<LogoutEvent>(_logout);
  }

  Future<void> _register(RegisterEvent event, Emitter emit) async {
    emit(state.copyWith(authStatus: Status.loading));
    try {
      final response = await authRepo.register(
        id: event.id,
        username: event.username,
        email: event.email,
        password: event.password,
      );
      // Include user so other screens (e.g., Profile) can read it.
      emit(state.copyWith(authStatus: Status.success, user: response));
    } catch (e) {
      emit(state.copyWith(authStatus: Status.error));
      print(e.toString());
    }
  }

  Future<void> _login(LoginEvent event, Emitter emit) async {
    emit(state.copyWith(authStatus: Status.loading));
    try {
      final response = await authRepo.login(
        username: event.username,
        password: event.password,
      );
      // Fakestore login returns only a token; attach the username used to login.
      final user = AuthModel(
        username: event.username,
        token: response.token,
      );
      emit(state.copyWith(authStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(authStatus: Status.error));
      print(e.toString());
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter emit) async {
    // Clear current user and reset status to init
    emit(state.copyWith(user: null, authStatus: Status.init));
  }
}
